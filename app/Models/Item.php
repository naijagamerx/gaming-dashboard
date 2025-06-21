<?php
// app/Models/Item.php

require_once __DIR__ . '/BaseModel.php';

class Item extends BaseModel {
    // The `items` table has `item` (varchar, item code) as its logical primary key in game terms,
    // but also an auto-incrementing `id` (int) which is likely the true PK for DB operations.
    // The `PHP_BOOTSTRAP_IMPLEMENTATION.md` example for CharacterModel uses `charidentifier` (int) as PK.
    // `DATABASE_DOCUMENTATION.md` for `items` table: `item` is PK, `id` is auto_increment. This is unusual.
    // Typically, an auto-increment `id` would be the PK.
    // Let's assume `id` is the operational primary key for BaseModel, and `item` is a unique key.
    protected $table = 'items';
    protected $primaryKey = 'id'; // Using the auto-incrementing integer ID as PK for BaseModel consistency.

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find an item by its auto-incrementing ID.
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        return $this->find($id); // Uses BaseModel's find with $this->primaryKey = 'id'
    }

    /**
     * Find an item by its item code (e.g., 'weapon_revolver_cattleman').
     * The 'item' column is marked as PK in documentation, but also has 'id' as AI.
     * Assuming 'item' is a unique key.
     * @param string $itemCode
     * @return array|false
     */
    public function findByItemCode($itemCode) { // Corrected: Added space
        $result = $this->findAll(['item' => $itemCode], '', 1);
        return $result ? $result[0] : false;
    }

    /**
     * Get all items with pagination and optional search (on label or item code).
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm
     * @return array
     */
    public function getAllItems($limit = 20, $offset = 0, $searchTerm = '') {
        $sql = "SELECT i.*, ig.name as groupName
                FROM {$this->table} i
                LEFT JOIN item_group ig ON i.groupId = ig.id"; // Assuming item_group table and join
        $params = [];

        if (!empty($searchTerm)) {
            $sql .= " WHERE (i.label LIKE :searchTerm OR i.item LIKE :searchTerm OR i.desc LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
        }

        $sql .= " ORDER BY i.label ASC LIMIT :limit OFFSET :offset";

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
            error_log("Error in Item getAllItems: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total items, optionally filtered by search term.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalItemCount($searchTerm = '') {
        $sql = "SELECT COUNT(i.{$this->primaryKey})
                FROM {$this->table} i";
        $params = [];

        if (!empty($searchTerm)) {
            $sql .= " WHERE (i.label LIKE :searchTerm OR i.item LIKE :searchTerm OR i.desc LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
        }

        try {
            $stmt = $this->db->prepare($sql);
             foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }
            $stmt->execute();
            return (int) $stmt->fetchColumn();
        } catch (PDOException $e) {
            error_log("Error in Item getTotalItemCount: " . $e->getMessage());
            return 0;
        }
    }

    /**
     * Create a new item.
     * Assumes 'id' is auto-increment. 'item' (code) must be unique.
     * @param array $data Item data. Must include 'item' (code) and 'label'.
     * @return string|false The ID of the created item or false on failure.
     */
    public function createItem($data) {
        if (!isset($data['item']) || !isset($data['label'])) {
            error_log("Item createItem error: Missing required fields (item code, label).");
            return false;
        }

        // Check if item code already exists, as it should be unique
        if ($this->findByItemCode($data['item'])) {
            error_log("Item createItem error: Item code '{$data['item']}' already exists.");
            return false; // Or handle with specific error message
        }

        $defaults = [
            'limit' => 1,
            'can_remove' => 1,
            'type' => 'item', // general item type
            'usable' => 0,
            'groupId' => 1, // Default group, ensure group ID 1 exists or make nullable
            'metadata' => '{}',
            'desc' => 'A nice item.',
            'degradation' => 0,
            'weight' => 0.25
        ];
        $data = array_merge($defaults, $data);

        return $this->create($data); // Uses BaseModel's create, returns lastInsertId (which is 'id')
    }

    /**
     * Update an existing item by its auto-increment ID.
     * @param int $id Item's auto-increment ID
     * @param array $data Data to update. 'item' (code) should not be changed if it's a logical key.
     * @return bool True on success, false on failure.
     */
    public function updateItem($id, $data) {
        // Prevent changing the 'item' code if it's considered immutable or a unique business key.
        if (isset($data['item'])) {
            // If you allow changing item code, ensure it remains unique.
            $existingByCode = $this->findByItemCode($data['item']);
            if ($existingByCode && $existingByCode['id'] != $id) {
                 error_log("Item updateItem error: New item code '{$data['item']}' already exists for another item.");
                 return false;
            }
            // unset($data['item']); // Or allow it if validation passes
        }
        if (isset($data['id'])) { // Don't allow changing PK
            unset($data['id']);
        }

        if (empty($data)) {
            return true; // Nothing to update
        }
        return $this->update($id, $data); // Uses BaseModel's update
    }

    /**
     * Delete an item by its auto-increment ID.
     * @param int $id
     * @return bool
     */
    public function deleteItem($id) {
        // Consider related data: character_inventories, items_crafted that might reference this item.
        // Foreign key constraints (ON DELETE SET NULL or ON DELETE CASCADE) should be defined in DB.
        // Or, handle cleanup logic here or in a service layer.
        return $this->delete($id);
    }

    // Placeholder for item_group model if needed later
    // public function getAllItemGroups() { ... }
}
