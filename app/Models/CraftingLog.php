<?php
// app/Models/CraftingLog.php

require_once __DIR__ . '/BaseModel.php';

class CraftingLog extends BaseModel {
    // `bcc_crafting_log` table
    // `id` int(11) NOT NULL AUTO_INCREMENT (Primary Key)
    // `charidentifier` varchar(50) NOT NULL (Character ID - type consistency with `characters` table is important)
    // `timestamp` bigint(20) NOT NULL (Likely a Unix timestamp)
    protected $table = 'bcc_crafting_log';
    protected $primaryKey = 'id';

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get crafting logs for a specific character, ordered by most recent.
     * @param string $charIdentifier
     * @param int $limit
     * @param int $offset
     * @return array
     */
    public function getLogsByCharacterId($charIdentifier, $limit = 20, $offset = 0) {
        // Assuming timestamp is a Unix timestamp; convert to DATETIME for sorting if needed by DB, or sort by it directly if BIGINT.
        // For display, it will be converted.
        return $this->findAll(['charidentifier' => $charIdentifier], 'timestamp DESC', $limit, $offset);
    }

    /**
     * Count total logs for a specific character.
     * @param string $charIdentifier
     * @return int
     */
    public function getTotalLogCountByCharacterId($charIdentifier) {
        return $this->count(['charidentifier' => $charIdentifier]);
    }

    /**
     * Get all crafting logs with pagination and optional search (e.g., by charID or itemName).
     * This is primarily for admin viewing.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm (searches charidentifier or itemName)
     * @return array
     */
    public function getAllCraftingLogs($limit = 20, $offset = 0, $searchTerm = '') {
        $sql = "SELECT cl.*, c.firstname as char_firstname, c.lastname as char_lastname
                FROM {$this->table} cl
                LEFT JOIN characters c ON cl.charidentifier = c.charidentifier"; // Join to get char name
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            // Search by charidentifier (exact match usually) or item name/label (partial match)
            $whereClauses[] = "(cl.charidentifier = :searchTermCharId OR cl.itemName LIKE :searchTermGeneric OR cl.itemLabel LIKE :searchTermGeneric OR c.firstname LIKE :searchTermGeneric OR c.lastname LIKE :searchTermGeneric)";
            $params[':searchTermCharId'] = $searchTerm; // For exact char ID match
            $params[':searchTermGeneric'] = '%' . $searchTerm . '%'; // For partial matches
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        $sql .= " ORDER BY cl.timestamp DESC, cl.{$this->primaryKey} DESC LIMIT :limit OFFSET :offset";

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
            error_log("Error in CraftingLog getAllCraftingLogs: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total crafting logs, optionally filtered by search term.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalCraftingLogCount($searchTerm = '') {
        $sql = "SELECT COUNT(cl.{$this->primaryKey})
                FROM {$this->table} cl
                LEFT JOIN characters c ON cl.charidentifier = c.charidentifier";
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
           $whereClauses[] = "(cl.charidentifier = :searchTermCharId OR cl.itemName LIKE :searchTermGeneric OR cl.itemLabel LIKE :searchTermGeneric OR c.firstname LIKE :searchTermGeneric OR c.lastname LIKE :searchTermGeneric)";
            $params[':searchTermCharId'] = $searchTerm;
            $params[':searchTermGeneric'] = '%' . $searchTerm . '%';
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
            error_log("Error in CraftingLog getTotalCraftingLogCount: " . $e->getMessage());
            return 0;
        }
    }

    // For this phase, focusing on read-only. Create/Update/Delete for logs are usually not done via dashboard.
    // If needed, they would be simple calls to parent::create(), parent::update(), parent::delete().
}
