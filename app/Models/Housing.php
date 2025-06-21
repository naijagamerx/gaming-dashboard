<?php
// app/Models/Housing.php

require_once __DIR__ . '/BaseModel.php';

class Housing extends BaseModel {
    // Based on DATABASE_DOCUMENTATION.md, `bcchousing` is the main housing system.
    // `houseid` is int(11) NOT NULL AUTO_INCREMENT (Primary Key)
    // `charidentifier` varchar(50) NOT NULL (Owner's character ID - this seems to be a varchar, careful with type)
    // The `characters` table has `charidentifier` as int(11). This might be an inconsistency in docs or schema.
    // Assuming `bcchousing.charidentifier` should actually be an INT to match `characters.charidentifier`.
    // If it's truly VARCHAR, queries need to reflect that. For now, assume it's an ID that matches.
    protected $table = 'bcchousing';
    protected $primaryKey = 'houseid';

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a house by its unique houseid.
     * @param int $houseId
     * @return array|false
     */
    public function findByHouseId($houseId) {
        return $this->find($houseId); // Uses BaseModel's find
    }

    /**
     * Find all houses owned by a specific character identifier.
     * @param string $charIdentifier (Owner's character ID - ensure type matches DB column)
     * @return array
     */
    public function findHousesByOwnerCharId($charIdentifier) {
        // If bcchousing.charidentifier is VARCHAR, no change needed here for param binding.
        // If it's INT and $charIdentifier is string, PDO might handle it or cast might be needed.
        return $this->findAll(['charidentifier' => $charIdentifier], $this->primaryKey . ' ASC');
    }

    /**
     * Get all houses with pagination and optional search.
     * Search can be by houseid, owner's charidentifier, or uniqueName.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm
     * @return array
     */
    public function getAllHouses($limit = 20, $offset = 0, $searchTerm = '') {
        // Joins with characters table to get owner's name for display might be useful here.
        // For now, direct query on bcchousing.
        $sql = "SELECT h.*, c.firstname as owner_firstname, c.lastname as owner_lastname
                FROM {$this->table} h
                LEFT JOIN characters c ON h.charidentifier = c.charidentifier"; // Assuming charidentifier is consistent type for join
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(h.houseid LIKE :searchTermInt OR h.charidentifier LIKE :searchTerm OR h.uniqueName LIKE :searchTerm OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermInt'] = $searchTerm . '%'; // For houseid if it's numeric
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        $sql .= " ORDER BY h.{$this->primaryKey} ASC LIMIT :limit OFFSET :offset";

        try {
            $stmt = $this->db->prepare($sql);
            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }
            $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
            $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Housing getAllHouses: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total houses, optionally filtered by search term.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalHouseCount($searchTerm = '') {
        $sql = "SELECT COUNT(h.{$this->primaryKey})
                FROM {$this->table} h
                LEFT JOIN characters c ON h.charidentifier = c.charidentifier";
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(h.houseid LIKE :searchTermInt OR h.charidentifier LIKE :searchTerm OR h.uniqueName LIKE :searchTerm OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermInt'] = $searchTerm . '%';
        }
         if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        try {
            $stmt = $this->db->prepare($sql);
            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }
            $stmt->execute();
            return (int) $stmt->fetchColumn();
        } catch (PDOException $e) {
            error_log("Error in Housing getTotalHouseCount: " . $e->getMessage());
            return 0;
        }
    }

    /**
     * Create a new house entry.
     * @param array $data House data. Must include 'charidentifier', 'house_coords', 'house_radius_limit', 'uniqueName'.
     * @return string|false The houseid of the created house or false on failure.
     */
    public function createHouse($data) {
        if (!isset($data['charidentifier']) || !isset($data['house_coords']) || !isset($data['house_radius_limit']) || !isset($data['uniqueName'])) {
            error_log("Housing createHouse error: Missing required fields.");
            return false;
        }

        // Check for uniqueness of uniqueName if it's a constraint
        $existing = $this->findAll(['uniqueName' => $data['uniqueName']]);
        if (!empty($existing)) {
            error_log("Housing createHouse error: uniqueName '{$data['uniqueName']}' already exists.");
            return false;
        }

        // Default values for some fields from schema if not provided
        $data['furniture'] = $data['furniture'] ?? 'none'; // Or '{}' if JSON
        $data['doors'] = $data['doors'] ?? 'none';     // Or '{}'
        $data['allowed_ids'] = $data['allowed_ids'] ?? 'none'; // Or '[]'
        $data['invlimit'] = $data['invlimit'] ?? '200';
        $data['player_source_spawnedfurn'] = $data['player_source_spawnedfurn'] ?? 'none';
        $data['taxes_collected'] = $data['taxes_collected'] ?? 'false'; // Schema default
        $data['ledger'] = $data['ledger'] ?? 0;
        $data['tax_amount'] = $data['tax_amount'] ?? 0;
        $data['tpInt'] = $data['tpInt'] ?? 0;
        $data['tpInstance'] = $data['tpInstance'] ?? 0;
        $data['ownershipStatus'] = $data['ownershipStatus'] ?? 'purchased'; // Schema default

        return $this->create($data); // Uses BaseModel's create, returns lastInsertId (houseid)
    }

    /**
     * Update an existing house's details.
     * @param int $houseId
     * @param array $data Data to update.
     * @return bool True on success, false on failure.
     */
    public function updateHouse($houseId, $data) {
        // Prevent changing primary key or potentially owner charidentifier easily unless intended
        if (isset($data[$this->primaryKey])) {
            unset($data[$this->primaryKey]);
        }
        // if (isset($data['charidentifier'])) { // Allow changing owner if needed by admin
        //     unset($data['charidentifier']);
        // }
        if (isset($data['uniqueName'])) { // If uniqueName is changed, check for uniqueness
            $existing = $this->findAll(['uniqueName' => $data['uniqueName']]);
            if (!empty($existing) && $existing[0][$this->primaryKey] != $houseId) {
                 error_log("Housing updateHouse error: uniqueName '{$data['uniqueName']}' already exists for another house.");
                 return false;
            }
        }


        if (empty($data)) {
            return true; // Nothing to update
        }
        return $this->update($houseId, $data); // Uses BaseModel's update
    }

    /**
     * Delete a house by its houseid.
     * @param int $houseId
     * @return bool
     */
    public function deleteHouse($houseId) {
        // Consider implications: what happens to items inside, owner status, etc.
        // This is a direct DB delete. Game logic might require more steps.
        return $this->delete($houseId);
    }

    // Interactions with other housing related tables like bcchousinghotels, bcchousing_transactions
    // can be added here or in their respective models if they become complex.
    // For example:
    // public function getHouseTransactions($houseId) { ... }
    // public function getHotelRoomsForHouse($houseId) { ... }
}
