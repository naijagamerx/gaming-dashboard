<?php
// app/Models/Posse.php

require_once __DIR__ . '/BaseModel.php';

class Posse extends BaseModel {
    // `posse` table
    // `id` int(11) NOT NULL AUTO_INCREMENT (Primary Key)
    // `identifier` varchar(50) DEFAULT '0' (Leader's User SteamID)
    // `characterid` varchar(50) DEFAULT '0' (Leader's Character ID - type consistency with `characters` table is important)
    // `possename` varchar(50) DEFAULT NULL
    protected $table = 'posse';
    protected $primaryKey = 'id';

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a posse by its unique ID.
     * @param int $posseId
     * @return array|false
     */
    public function findByPosseId($posseId) {
        return $this->find($posseId);
    }

    /**
     * Find a posse by its name. Assumes posse names are unique.
     * @param string $posseName
     * @return array|false
     */
    public function findByPosseName($posseName) {
        $result = $this->findAll(['possename' => $posseName], '', 1);
        return $result ? $result[0] : false;
    }

    /**
     * Find posses led by a specific character ID.
     * @param string $leaderCharId (Type should match `posse.characterid` column)
     * @return array
     */
    public function findPossesByLeaderCharId($leaderCharId) {
        return $this->findAll(['characterid' => $leaderCharId]);
    }

    /**
     * Find posses led by a specific user identifier (SteamID).
     * @param string $leaderUserIdentifier (SteamID)
     * @return array
     */
    public function findPossesByLeaderUserIdentifier($leaderUserIdentifier) {
        return $this->findAll(['identifier' => $leaderUserIdentifier]);
    }

    /**
     * Get the posse a specific character belongs to.
     * This relies on `characters.posseid` FK pointing to `posse.id`.
     * @param int $charPosseId The posse ID stored in the character's record.
     * @return array|false
     */
    public function getCharacterPosseInfo($charPosseId) {
        if (empty($charPosseId) || $charPosseId == 0) {
            return false;
        }
        return $this->findByPosseId($charPosseId);
    }

    /**
     * Get all members of a specific posse.
     * This queries the `characters` table for characters whose `posseid` matches.
     * @param int $posseId
     * @return array
     */
    public function getPosseMembers($posseId) {
        if (empty($posseId)) return [];
        try {
            // Assuming CharacterModel is not directly accessible here, write a direct query
            $stmt = $this->db->prepare("SELECT charidentifier, firstname, lastname, identifier as user_steam_id
                                        FROM characters
                                        WHERE posseid = :posseId
                                        ORDER BY lastname, firstname");
            $stmt->bindParam(':posseId', $posseId, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Posse getPosseMembers: " . $e->getMessage());
            return [];
        }
    }


    /**
     * Get all posses with pagination and optional search (by posse name or leader charid/identifier).
     * Joins with characters table to get leader's name.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm
     * @return array
     */
    public function getAllPosses($limit = 20, $offset = 0, $searchTerm = '') {
        // `posse.characterid` is leader's charid. `posse.identifier` is leader's user steamid.
        $sql = "SELECT p.*, c.firstname as leader_firstname, c.lastname as leader_lastname
                FROM {$this->table} p
                LEFT JOIN characters c ON p.characterid = c.charidentifier"; // Assuming posse.characterid is int and matches characters.charidentifier

        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(p.possename LIKE :searchTerm OR p.characterid LIKE :searchTermCharId OR p.identifier LIKE :searchTermSteamId OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermCharId'] = $searchTerm . '%'; // For exact char ID match
            $params[':searchTermSteamId'] = $searchTerm . '%'; // For exact steam ID match
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        $sql .= " ORDER BY p.possename ASC, p.{$this->primaryKey} ASC LIMIT :limit OFFSET :offset";

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
            error_log("Error in Posse getAllPosses: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total posses, optionally filtered by search term.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalPosseCount($searchTerm = '') {
        $sql = "SELECT COUNT(p.{$this->primaryKey})
                FROM {$this->table} p
                LEFT JOIN characters c ON p.characterid = c.charidentifier";
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(p.possename LIKE :searchTerm OR p.characterid LIKE :searchTermCharId OR p.identifier LIKE :searchTermSteamId OR c.firstname LIKE :searchTerm OR c.lastname LIKE :searchTerm)";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
            $params[':searchTermCharId'] = $searchTerm . '%';
            $params[':searchTermSteamId'] = $searchTerm . '%';
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
            error_log("Error in Posse getTotalPosseCount: " . $e->getMessage());
            return 0;
        }
    }

    // For Phase 3, focusing on read-only. CRUD for posses would involve more game logic.
    // public function createPosse($data) { ... }
    // public function updatePosse($posseId, $data) { ... }
    // public function deletePosse($posseId) { ... } // And handle characters.posseid updates
}
