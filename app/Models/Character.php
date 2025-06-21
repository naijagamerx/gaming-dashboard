<?php
// app/Models/Character.php

require_once __DIR__ . '/BaseModel.php';

class Character extends BaseModel {
    protected $table = 'characters';
    protected $primaryKey = 'charidentifier'; // As per the SQL schema

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a character by their unique charidentifier.
     * @param int $charIdentifier
     * @return array|false
     */
    public function findByCharIdentifier($charIdentifier) {
        return $this->find($charIdentifier); // Uses BaseModel's find
    }

    /**
     * Find all characters belonging to a specific user identifier (Steam ID).
     * @param string $userIdentifier (Steam ID)
     * @param string $orderBy Optional order by clause
     * @return array
     */
    public function findByUserIdentifier($userIdentifier, $orderBy = 'charidentifier ASC') {
        return $this->findAll(['identifier' => $userIdentifier], $orderBy);
    }

    /**
     * Get all characters with pagination and optional search.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm (searches firstname, lastname, or charidentifier)
     * @param string $userIdentifier (optional) to filter by user
     * @return array
     */
    public function getAllCharacters($limit = 20, $offset = 0, $searchTerm = '', $userIdentifier = null) {
        $sql = "SELECT c.*, u.identifier as user_steam_id FROM {$this->table} c LEFT JOIN users u ON c.identifier = u.identifier";
        $params = [];
        $whereClauses = [];

        if ($userIdentifier !== null) {
            $whereClauses[] = "c.identifier = :userIdentifier";
            $params[':userIdentifier'] = $userIdentifier;
        }

        if (!empty($searchTerm)) {
            $searchClause = "(c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm OR c.charidentifier LIKE :searchTermNumber OR c.steamname LIKE :searchTerm)";
            if ($userIdentifier !== null) { // if already filtering by user, searchTerm is an AND condition
                $whereClauses[] = $searchClause;
            } else { // if not filtering by user, searchTerm is the main WHERE clause or part of it
                 $whereClauses[] = $searchClause;
            }
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermNumber'] = $searchTerm . '%'; // For charidentifier if it's numeric
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        $sql .= " ORDER BY c.charidentifier ASC LIMIT :limit OFFSET :offset";

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
            error_log("Error in Character getAllCharacters: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total characters, optionally filtered by search term and/or user identifier.
     * @param string $searchTerm
     * @param string $userIdentifier (optional)
     * @return int
     */
    public function getTotalCharacterCount($searchTerm = '', $userIdentifier = null) {
        $sql = "SELECT COUNT(c.{$this->primaryKey}) FROM {$this->table} c";
        $params = [];
        $whereClauses = [];

        if ($userIdentifier !== null) {
            $whereClauses[] = "c.identifier = :userIdentifier";
            $params[':userIdentifier'] = $userIdentifier;
        }

        if (!empty($searchTerm)) {
            $searchClause = "(c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm OR c.charidentifier LIKE :searchTermNumber OR c.steamname LIKE :searchTerm)";
            if ($userIdentifier !== null) {
                $whereClauses[] = $searchClause;
            } else {
                $whereClauses[] = $searchClause;
            }
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermNumber'] = $searchTerm . '%';
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
            error_log("Error in Character getTotalCharacterCount: " . $e->getMessage());
            return 0;
        }
    }

    /**
     * Create a new character.
     * `charidentifier` is expected to be auto-increment or manually managed if not.
     * The schema shows `charidentifier` as INT(11) NOT NULL, but not explicitly AUTO_INCREMENT.
     * If it's not auto_increment, it must be provided in $data.
     * For this model, we assume it's auto-increment as per typical primary key behavior.
     * If it needs to be manually set (e.g., based on user's available slots), the controller logic would handle that.
     * @param array $data Character data. Must include 'identifier' (user's SteamID).
     * @return string|false The charidentifier of the created character or false on failure.
     */
    public function createCharacter($data) {
        if (!isset($data['identifier']) || !isset($data['steamname']) || !isset($data['firstname']) || !isset($data['lastname'])) {
            error_log("Character createCharacter error: Missing required fields.");
            return false;
        }

        // Default values for some fields based on schema and common sense, if not provided
        $data['group'] = $data['group'] ?? 'user';
        $data['money'] = $data['money'] ?? 0.00;
        $data['gold'] = $data['gold'] ?? 0.00;
        $data['rol'] = $data['rol'] ?? 0.00; // As per schema
        $data['xp'] = $data['xp'] ?? 0;
        $data['healthouter'] = $data['healthouter'] ?? 500;
        $data['healthinner'] = $data['healthinner'] ?? 100;
        $data['staminaouter'] = $data['staminaouter'] ?? 100;
        $data['staminainner'] = $data['staminainner'] ?? 100;
        $data['hours'] = $data['hours'] ?? 0;
        $data['LastLogin'] = $data['LastLogin'] ?? null; // Can be set to NOW() upon actual login
        $data['inventory'] = $data['inventory'] ?? '{}'; // Default to empty JSON object or NULL
        $data['slots'] = $data['slots'] ?? 35.0;
        $data['job'] = $data['job'] ?? 'unemployed';
        $data['joblabel'] = $data['joblabel'] ?? 'Unemployed';
        $data['meta'] = $data['meta'] ?? '{}';
        $data['character_desc'] = $data['character_desc'] ?? ' ';
        $data['gender'] = $data['gender'] ?? ' '; // Should be validated (e.g. male/female)
        $data['age'] = $data['age'] ?? 18;
        $data['nickname'] = $data['nickname'] ?? ' ';
        $data['skinPlayer'] = $data['skinPlayer'] ?? '{}'; // Default to empty JSON object
        $data['compPlayer'] = $data['compPlayer'] ?? '{}';
        $data['compTints'] = $data['compTints'] ?? '{}';
        $data['jobgrade'] = $data['jobgrade'] ?? 0;
        $data['coords'] = $data['coords'] ?? '{}';
        $data['status'] = $data['status'] ?? '{}';
        $data['isdead'] = $data['isdead'] ?? 0;
        $data['skills'] = $data['skills'] ?? '{}';
        $data['walk'] = $data['walk'] ?? 'noanim';
        $data['gunsmith'] = $data['gunsmith'] ?? 0.00;
        $data['ammo'] = $data['ammo'] ?? '{}';
        $data['discordid'] = $data['discordid'] ?? '0';
        $data['lastjoined'] = $data['lastjoined'] ?? '[]';
        $data['posseid'] = $data['posseid'] ?? 0;

        // If charidentifier is NOT auto-increment, it must be supplied in $data.
        // If it IS auto-increment, it should NOT be in $data for creation.
        // The current DB schema for `characters` shows `charidentifier int(11) NOT NULL` without AUTO_INCREMENT.
        // This means `charidentifier` must be provided.
        // This logic might need adjustment based on how `charidentifier` is truly managed.
        // For now, assume it must be in $data.
        if (!isset($data['charidentifier'])) {
             // Attempt to get next available charidentifier if not provided.
             // This is a simple approach; a robust system might use sequences or a dedicated table.
            $stmt = $this->db->query("SELECT MAX(charidentifier) as max_id FROM {$this->table}");
            $max_id = $stmt->fetchColumn();
            $data['charidentifier'] = ($max_id ? $max_id : 0) + 1;
        }


        return $this->create($data); // Uses BaseModel's create
    }

    /**
     * Update an existing character.
     * @param int $charIdentifier Character's unique ID
     * @param array $data Data to update. 'identifier' (SteamID) should not be changed here.
     * @return bool True on success, false on failure.
     */
    public function updateCharacter($charIdentifier, $data) {
        // Prevent changing the owner (identifier) or charidentifier itself via this method
        if (isset($data['identifier'])) {
            unset($data['identifier']);
        }
        if (isset($data['charidentifier'])) {
            unset($data['charidentifier']);
        }
        if (isset($data['steamname'])) { // steamname is usually tied to identifier, should not be changed freely
            unset($data['steamname']);
        }


        if (empty($data)) {
            return true; // Nothing to update
        }
        return $this->update($charIdentifier, $data); // Uses BaseModel's update
    }

    /**
     * Delete a character by their charidentifier.
     * @param int $charIdentifier
     * @return bool
     */
    public function deleteCharacter($charIdentifier) {
        // Consider related data: inventories, bank accounts specific to this charidentifier, etc.
        // Cascading deletes should be set up in DB schema, or handled here if necessary.
        return $this->delete($charIdentifier); // Uses BaseModel's delete
    }

    // TODO: Method to fetch character inventory (joins with character_inventories, items_crafted, items)
    // public function getCharacterInventory($charIdentifier) { ... }

    /**
     * Get a character's detailed inventory.
     * Joins character_inventories with items_crafted and items tables.
     * @param int $charIdentifier
     * @param string|null $inventoryType (e.g., 'default', 'wardrobe', 'satchel') - if null, fetches all types
     * @return array
     */
    public function getCharacterInventory($charIdentifier, $inventoryType = null) {
        // Based on schema:
        // character_inventories (character_id, inventory_type, item_crafted_id, amount, degradation, percentage)
        // items_crafted (id, character_id (owner of crafted item), item_id (base item), item_name, metadata)
        // items (id (base item PK), item (item code), label, desc, weight, etc.)

        // Note: items_crafted.character_id is the original crafter/owner of the specific crafted instance.
        // character_inventories.character_id is who currently possesses it. These might be different.
        // For simplicity, we're focusing on what the $charIdentifier possesses.

        $sql = "SELECT
                    ci.inventory_type,
                    ci.amount,
                    ci.degradation,
                    ci.percentage,
                    ic.id as item_crafted_id,
                    ic.item_name as crafted_item_name, -- This is the 'item' code from items table
                    ic.metadata as crafted_item_metadata,
                    i.id as base_item_id,
                    i.item as base_item_code,
                    i.label as base_item_label,
                    i.desc as base_item_description,
                    i.weight as base_item_weight,
                    i.type as base_item_type,
                    ig.name as item_group_name
                FROM character_inventories ci
                JOIN items_crafted ic ON ci.item_crafted_id = ic.id
                JOIN items i ON ic.item_id = i.id  -- items_crafted.item_id links to items.id
                LEFT JOIN item_group ig ON i.groupId = ig.id
                WHERE ci.character_id = :charIdentifier";

        $params = [':charIdentifier' => $charIdentifier];

        if ($inventoryType !== null) {
            $sql .= " AND ci.inventory_type = :inventoryType";
            $params[':inventoryType'] = $inventoryType;
        }

        $sql .= " ORDER BY ci.inventory_type, i.label";

        try {
            $stmt = $this->db->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Character getCharacterInventory: " . $e->getMessage());
            return [];
        }
    }
}
