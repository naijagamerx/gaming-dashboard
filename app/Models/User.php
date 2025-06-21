<?php
// app/Models/User.php

require_once __DIR__ . '/BaseModel.php';
require_once __DIR__ . '/../Services/AuthService.php'; // For password hashing

class User extends BaseModel {
    protected $table = 'users';
    protected $primaryKey = 'identifier'; // As per the SQL schema for 'users' table

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a user by their identifier (Steam ID).
     * @param string $identifier
     * @return array|false
     */
    public function findByIdentifier($identifier) {
        return $this->find($identifier); // Uses BaseModel's find with correct primaryKey
    }

    /**
     * Get all users with pagination and optional search.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm
     * @return array
     */
    public function getAllUsers($limit = 20, $offset = 0, $searchTerm = '') {
        $conditions = [];
        if (!empty($searchTerm)) {
            // Assuming search is on 'identifier' or 'group'
            // This is a simplified search. For more complex search on multiple fields,
            // you might need a custom query.
            // Using LIKE for partial matches.
            // The BaseModel's findAll needs to be adapted or a custom query built here for OR conditions.
            // For now, let's search by identifier or group one at a time or enhance BaseModel
            $conditions['identifier'] = $searchTerm . '%'; // Search by identifier starting with term
            // Or: $conditions['group'] = $searchTerm . '%';
        }
        // Example: return $this->findAll($conditions, "{$this->primaryKey} ASC", $limit, $offset);
        // For more flexible search (e.g., identifier LIKE %term% OR group LIKE %term%)
        // a more custom query in this model might be better than generic findAll.

        $sql = "SELECT * FROM {$this->table}";
        $params = [];
        if (!empty($searchTerm)) {
            $sql .= " WHERE identifier LIKE :searchTerm OR `group` LIKE :searchTerm";
            $params[':searchTerm'] = '%' . $searchTerm . '%';
        }
        $sql .= " ORDER BY {$this->primaryKey} ASC LIMIT :limit OFFSET :offset";

        try {
            $stmt = $this->db->prepare($sql);
            if (!empty($searchTerm)) {
                $stmt->bindParam(':searchTerm', $params[':searchTerm']);
            }
            $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
            $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in User getAllUsers: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total users, optionally filtered by search term.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalUserCount($searchTerm = '') {
        $conditions = [];
         if (!empty($searchTerm)) {
            // Similar to getAllUsers, this simplified search needs refinement for OR conditions
            // $conditions['identifier'] = $searchTerm . '%';
            $sql = "SELECT COUNT(*) FROM {$this->table} WHERE identifier LIKE :searchTerm OR `group` LIKE :searchTerm";
            try {
                $stmt = $this->db->prepare($sql);
                $param = '%' . $searchTerm . '%';
                $stmt->bindParam(':searchTerm', $param);
                $stmt->execute();
                return (int) $stmt->fetchColumn();
            } catch (PDOException $e) {
                error_log("Error in User getTotalUserCount: " . $e->getMessage());
                return 0;
            }
        }
        return $this->count($conditions); // Uses BaseModel's count
    }


    /**
     * Create a new user.
     * Hashes password before saving.
     * @param array $data User data (must include 'identifier', 'password', 'group')
     * @return string|false The identifier of the created user or false on failure.
     */
    public function createUser($data) {
        if (!isset($data['identifier']) || !isset($data['password']) || !isset($data['group'])) {
            error_log("User createUser error: Missing required fields (identifier, password, group).");
            return false;
        }

        // Hash the password
        $data['password_hash'] = AuthService::hashPassword($data['password']);
        unset($data['password']); // Don't store plain password

        // Ensure other fields from schema are present or have defaults
        $data['warnings'] = $data['warnings'] ?? 0;
        $data['banned'] = $data['banned'] ?? null; // Or 0 if it's not nullable
        $data['banneduntil'] = $data['banneduntil'] ?? 0;
        $data['char'] = $data['char'] ?? 5; // Default from schema

        return $this->create($data); // Uses BaseModel's create
    }

    /**
     * Update an existing user.
     * Optionally hashes password if provided.
     * @param string $identifier User's identifier
     * @param array $data Data to update
     * @return bool True on success, false on failure.
     */
    public function updateUser($identifier, $data) {
        // If password is being updated, hash it
        if (isset($data['password']) && !empty($data['password'])) {
            $data['password_hash'] = AuthService::hashPassword($data['password']);
            unset($data['password']);
        } elseif (isset($data['password']) && empty($data['password'])) {
            unset($data['password']); // Don't update password if it's empty
        }

        // Ensure 'identifier' is not in $data to prevent primary key modification attempts
        if (isset($data['identifier'])) {
            unset($data['identifier']);
        }

        if (empty($data)) {
            return true; // Nothing to update
        }

        return $this->update($identifier, $data); // Uses BaseModel's update
    }

    /**
     * Delete a user by their identifier.
     * @param string $identifier
     * @return bool
     */
    public function deleteUser($identifier) {
        // Consider related data: characters, bank_users etc.
        // Cascading deletes should be set up in DB schema, or handled here.
        return $this->delete($identifier); // Uses BaseModel's delete
    }

    // Add other user-specific methods as needed, e.g.,
    // - findByEmail (if email is stored)
    // - banUser, unbanUser
    // - manageWarnings
}
