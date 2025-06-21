<?php
// app/Models/BaseModel.php

require_once __DIR__ . '/../Config/database.php';

abstract class BaseModel {
    protected $db;
    protected $table;
    protected $primaryKey = 'id'; // Default primary key

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function find($id) {
        try {
            $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$this->primaryKey} = :id");
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in BaseModel find: " . $e->getMessage());
            return false;
        }
    }

    public function findAll($conditions = [], $orderBy = '', $limit = null, $offset = 0) {
        try {
            $sql = "SELECT * FROM {$this->table}";
            $params = [];

            if (!empty($conditions)) {
                $whereClause = [];
                foreach ($conditions as $field => $value) {
                    // Basic LIKE support: if value ends with %, use LIKE
                    if (is_string($value) && substr($value, -1) === '%') {
                        $whereClause[] = "{$field} LIKE :{$field}";
                    } else {
                        $whereClause[] = "{$field} = :{$field}";
                    }
                    $params[":{$field}"] = $value;
                }
                $sql .= " WHERE " . implode(' AND ', $whereClause);
            }

            if (!empty($orderBy)) {
                $sql .= " ORDER BY {$orderBy}";
            }

            if ($limit !== null) {
                $sql .= " LIMIT :limit OFFSET :offset";
                // Bind limit and offset as integers
            }

            $stmt = $this->db->prepare($sql);

            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }

            if ($limit !== null) {
                $stmt->bindValue(':limit', (int) $limit, PDO::PARAM_INT);
                $stmt->bindValue(':offset', (int) $offset, PDO::PARAM_INT);
            }

            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in BaseModel findAll: " . $e->getMessage());
            return [];
        }
    }

    public function create($data) {
        try {
            $fields = array_keys($data);
            $placeholders = array_map(function($field) { return ":{$field}"; }, $fields);

            $sql = "INSERT INTO {$this->table} (" . implode(', ', $fields) . ")
                    VALUES (" . implode(', ', $placeholders) . ")";

            $stmt = $this->db->prepare($sql);

            foreach ($data as $field => $value) {
                $stmt->bindValue(":{$field}", $value);
            }

            $stmt->execute();

            // Return last insert ID if primary key is auto-increment
            // If primary key is not auto-increment (like 'identifier' in users), this might not be relevant
            // or might need to return the identifier itself if it was part of $data.
            if (is_numeric($this->db->lastInsertId()) && $this->db->lastInsertId() > 0) {
                return $this->db->lastInsertId();
            }
            // If the PK is not auto-incrementing, but part of $data (e.g. 'identifier')
            if (isset($data[$this->primaryKey])) {
                return $data[$this->primaryKey];
            }
            return true; // Or handle as appropriate for non-auto-increment PKs
        } catch (PDOException $e) {
            error_log("Error in BaseModel create: " . $e->getMessage());
            return false;
        }
    }

    public function update($id, $data) {
        try {
            $fieldsToUpdate = [];
            $params = [':primary_key_id' => $id];

            foreach ($data as $field => $value) {
                $fieldsToUpdate[] = "{$field} = :{$field}";
                $params[":{$field}"] = $value;
            }

            if (empty($fieldsToUpdate)) {
                return false; // Nothing to update
            }

            $sql = "UPDATE {$this->table} SET " . implode(', ', $fieldsToUpdate) .
                   " WHERE {$this->primaryKey} = :primary_key_id";

            $stmt = $this->db->prepare($sql);

            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }

            return $stmt->execute();
        } catch (PDOException $e) {
            error_log("Error in BaseModel update: " . $e->getMessage());
            return false;
        }
    }

    public function delete($id) {
        try {
            $stmt = $this->db->prepare("DELETE FROM {$this->table} WHERE {$this->primaryKey} = :id");
            $stmt->bindParam(':id', $id);
            return $stmt->execute();
        } catch (PDOException $e) {
            error_log("Error in BaseModel delete: " . $e->getMessage());
            return false;
        }
    }

    public function count($conditions = []) {
        try {
            $sql = "SELECT COUNT(*) FROM {$this->table}";
            $params = [];

            if (!empty($conditions)) {
                $whereClause = [];
                foreach ($conditions as $field => $value) {
                     if (is_string($value) && substr($value, -1) === '%') {
                        $whereClause[] = "{$field} LIKE :{$field}";
                    } else {
                        $whereClause[] = "{$field} = :{$field}";
                    }
                    $params[":{$field}"] = $value;
                }
                $sql .= " WHERE " . implode(' AND ', $whereClause);
            }

            $stmt = $this->db->prepare($sql);
            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }
            $stmt->execute();
            return (int) $stmt->fetchColumn();
        } catch (PDOException $e) {
            error_log("Error in BaseModel count: " . $e->getMessage());
            return 0;
        }
    }

    // Helper to get the PDO connection directly if needed by services or complex queries
    public function getDbConnection() {
        return $this->db;
    }
}
