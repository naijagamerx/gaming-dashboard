<?php
// app/Models/PlayerHorse.php

require_once __DIR__ . '/BaseModel.php';

class PlayerHorse extends BaseModel {
    // `player_horses` table: `id` is int(11) NOT NULL AUTO_INCREMENT (Primary Key)
    // `identifier` is varchar(50) NOT NULL (User's SteamID)
    // `charid` is int(11) NOT NULL (Owner Character's ID)
    protected $table = 'player_horses';
    protected $primaryKey = 'id';

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a specific horse by its unique ID.
     * @param int $horseId
     * @return array|false
     */
    public function findByHorseId($horseId) {
        return $this->find($horseId);
    }

    /**
     * Find all horses owned by a specific character ID.
     * @param int $charId
     * @param string $orderBy
     * @return array
     */
    public function findHorsesByCharId($charId, $orderBy = 'name ASC') {
        return $this->findAll(['charid' => $charId], $orderBy);
    }

    /**
     * Find all horses associated with a user identifier (Steam ID).
     * This could be useful if a user has multiple characters.
     * @param string $userIdentifier (Steam ID)
     * @return array
     */
    public function findHorsesByUserIdentifier($userIdentifier, $orderBy = 'charid ASC, name ASC') {
        return $this->findAll(['identifier' => $userIdentifier], $orderBy);
    }

    /**
     * Get all player horses with pagination and optional search.
     * Search can be by horse name, owner charid, or owner identifier (SteamID).
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm
     * @param int|null $charIdFilter Filter by specific character ID
     * @param string|null $userIdentifierFilter Filter by specific user (SteamID)
     * @return array
     */
    public function getAllPlayerHorses($limit = 20, $offset = 0, $searchTerm = '', $charIdFilter = null, $userIdentifierFilter = null) {
        $sql = "SELECT ph.*, c.firstname as owner_firstname, c.lastname as owner_lastname, c.identifier as owner_steamid
                FROM {$this->table} ph
                LEFT JOIN characters c ON ph.charid = c.charidentifier"; // Assuming charid links to characters.charidentifier

        $params = [];
        $whereClauses = [];

        if ($charIdFilter !== null) {
            $whereClauses[] = "ph.charid = :charIdFilter";
            $params[':charIdFilter'] = $charIdFilter;
        }
        if ($userIdentifierFilter !== null) {
            $whereClauses[] = "ph.identifier = :userIdentifierFilter"; // This is user's SteamID on player_horses table
            $params[':userIdentifierFilter'] = $userIdentifierFilter;
        }

        if (!empty($searchTerm)) {
            // Search horse name, model, or owner's details (firstname, lastname, steamid from characters table)
            $searchConditions = "(ph.name LIKE :searchTerm OR ph.model LIKE :searchTerm OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm OR c.identifier LIKE :searchTerm)";
            if (!empty($whereClauses)) {
                $whereClauses[] = $searchConditions;
            } else {
                $whereClauses[] = $searchConditions;
            }
            $params[':searchTerm'] = '%' . $searchTerm . '%';
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        $sql .= " ORDER BY ph.{$this->primaryKey} ASC LIMIT :limit OFFSET :offset";

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
            error_log("Error in PlayerHorse getAllPlayerHorses: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total player horses, optionally filtered.
     * @param string $searchTerm
     * @param int|null $charIdFilter
     * @param string|null $userIdentifierFilter
     * @return int
     */
    public function getTotalPlayerHorseCount($searchTerm = '', $charIdFilter = null, $userIdentifierFilter = null) {
        $sql = "SELECT COUNT(ph.{$this->primaryKey})
                FROM {$this->table} ph
                LEFT JOIN characters c ON ph.charid = c.charidentifier";
        $params = [];
        $whereClauses = [];

        if ($charIdFilter !== null) {
            $whereClauses[] = "ph.charid = :charIdFilter";
            $params[':charIdFilter'] = $charIdFilter;
        }
        if ($userIdentifierFilter !== null) {
            $whereClauses[] = "ph.identifier = :userIdentifierFilter";
            $params[':userIdentifierFilter'] = $userIdentifierFilter;
        }

        if (!empty($searchTerm)) {
            $searchConditions = "(ph.name LIKE :searchTerm OR ph.model LIKE :searchTerm OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm OR c.identifier LIKE :searchTerm)";
             if (!empty($whereClauses)) {
                $whereClauses[] = $searchConditions;
            } else {
                $whereClauses[] = $searchConditions;
            }
            $params[':searchTerm'] = '%' . $searchTerm . '%';
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
            error_log("Error in PlayerHorse getTotalPlayerHorseCount: " . $e->getMessage());
            return 0;
        }
    }

    /**
     * Create a new player horse entry.
     * @param array $data Horse data. Must include 'identifier' (User SteamID), 'charid' (Owner CharID), 'name', 'model'.
     * @return string|false The ID of the created horse or false on failure.
     */
    public function createPlayerHorse($data) {
        if (!isset($data['identifier']) || !isset($data['charid']) || !isset($data['name']) || !isset($data['model'])) {
            error_log("PlayerHorse createPlayerHorse error: Missing required fields (identifier, charid, name, model).");
            return false;
        }

        // Default values from schema if not provided
        $data['selected'] = $data['selected'] ?? 0;
        $data['components'] = $data['components'] ?? '{}'; // JSON
        $data['gender'] = $data['gender'] ?? 'male'; // Enum('male','female')
        $data['xp'] = $data['xp'] ?? 0;
        $data['captured'] = $data['captured'] ?? 0; // Assuming 0 for not captured/wild, 1 for player owned through capture/purchase
        $data['born'] = $data['born'] ?? date('Y-m-d H:i:s'); // Defaults to now
        $data['health'] = $data['health'] ?? 50;
        $data['stamina'] = $data['stamina'] ?? 50;
        $data['writhe'] = $data['writhe'] ?? 0; // Unclear field, default 0
        $data['dead'] = $data['dead'] ?? 0;

        // Validate gender enum
        if (!in_array($data['gender'], ['male', 'female'])) {
            error_log("PlayerHorse createPlayerHorse error: Invalid gender value '{$data['gender']}'. Must be 'male' or 'female'.");
            return false;
        }

        return $this->create($data); // Returns lastInsertId (horse 'id')
    }

    /**
     * Update an existing player horse's details.
     * @param int $horseId
     * @param array $data Data to update.
     * @return bool True on success, false on failure.
     */
    public function updatePlayerHorse($horseId, $data) {
        if (isset($data[$this->primaryKey])) { // 'id'
            unset($data[$this->primaryKey]);
        }
        // Owner 'identifier' (User SteamID) and 'charid' (Owner CharID) are usually not changed post-creation.
        // If they need to be changeable (e.g. horse transfer), ensure game logic handles it.
        if (isset($data['identifier'])) unset($data['identifier']);
        if (isset($data['charid'])) unset($data['charid']);

        // Validate gender if provided
        if (isset($data['gender']) && !in_array($data['gender'], ['male', 'female'])) {
            error_log("PlayerHorse updatePlayerHorse error: Invalid gender value '{$data['gender']}'.");
            return false; // Or remove $data['gender'] to prevent update of this field
        }

        if (empty($data)) {
            return true; // Nothing to update
        }
        return $this->update($horseId, $data);
    }

    /**
     * Delete a player horse by its ID.
     * @param int $horseId
     * @return bool
     */
    public function deletePlayerHorse($horseId) {
        // Consider if there are related records, e.g., in `horse_complements` that need handling.
        return $this->delete($horseId);
    }
}
