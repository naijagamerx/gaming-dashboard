<?php
// app/Models/CraftingProgress.php

require_once __DIR__ . '/BaseModel.php';

class CraftingProgress extends BaseModel {
    // `bcc_craft_progress` table
    // This table seems to be a 1:1 with characters, storing their crafting skill/XP.
    // The schema is not fully detailed in DATABASE_DOCUMENTATION.md for this specific table's columns.
    // Assuming it has a `charidentifier` (FK to characters) and columns for various crafting skills/XP.
    // Let's assume `charidentifier` is the primary key or at least a unique key for lookup.
    // If it has its own auto-increment PK, that would be $primaryKey.
    // The `IMPLEMENTATION_PROMPT.md` mentions `bcc_craft_progress` - Player skill progression.
    // Let's assume a structure like: `id (PK, AI)`, `charidentifier (UNIQUE, FK)`, `skill_name`, `xp`, `level`.
    // Or, if it's one row per character with multiple skill columns: `charidentifier (PK)`, `skill1_xp`, `skill1_level`, ...
    // For simplicity, assuming one row per character per skill, or one row per character with JSON skills.
    // Let's go with a more flexible approach: `charidentifier` and a `skills_data` (JSON) column.
    // Or, if the table `bcc_craft_progress` is just `charidentifier` and `xp`, `level` for a *general* crafting skill.

    // Based on `PHP_BOOTSTRAP_IMPLEMENTATION.md` -> `bcc_craft_progress` - Player crafting levels
    // It's vague. Let's assume a simple structure for now:
    // `charidentifier` (PK or UNIQUE KEY)
    // `crafting_xp` INT
    // `crafting_level` INT
    // `skills_json` TEXT (for specific skill progressions if any)

    protected $table = 'bcc_craft_progress';
    // Assuming charidentifier is the key to link to a character. If it's not the PK of this table, adjust.
    // If `id` is PK and `charidentifier` is separate:
    // protected $primaryKey = 'id';
    // For now, let's assume `charidentifier` is the effective lookup key and might be the PK.
    // The `DATABASE_DOCUMENTATION.md` doesn't list `bcc_craft_progress` in detail.
    // The `IMPLEMENTATION_PROMPT.md` mentions `bcc_craft_progress` - Player skill progression
    // Let's assume it has a `charidentifier` column that is unique and links to `characters.charidentifier`.
    // And other columns like `xp` and `level` or a JSON field.
    // For this model, we'll treat `charidentifier` as the lookup key.
    // If the table has its own auto-increment `id` as PK, this model would need minor adjustments
    // for `create/update/delete` if those were to be implemented. Read-only is simpler.

    // Let's assume for now the table structure is:
    // id (PK AI), charidentifier (INT, FK), general_xp INT, general_level INT, specific_skills TEXT (JSON)
    // And we'll primarily fetch by charidentifier.
     protected $primaryKey = 'id'; // Assuming it has an auto-increment ID.

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get crafting progress for a specific character.
     * @param string $charIdentifier
     * @return array|false Returns the single row of progress, or false if not found.
     */
    public function getProgressByCharacterId($charIdentifier) {
        $result = $this->findAll(['charidentifier' => $charIdentifier], '', 1);
        return $result ? $result[0] : false;
    }

    // If there are multiple progress entries per character (e.g. for different skills in different rows)
    // public function getAllProgressEntriesByCharacterId($charIdentifier) {
    //    return $this->findAll(['charidentifier' => $charIdentifier]);
    // }

    /**
     * Get all crafting progress entries (e.g., for an admin overview).
     * Includes character names for easier viewing.
     * @param int $limit
     * @param int $offset
     * @param string $searchTerm (searches charidentifier or character name)
     * @return array
     */
    public function getAllCraftingProgressData($limit = 20, $offset = 0, $searchTerm = '') {
        $sql = "SELECT cp.*, c.firstname as char_firstname, c.lastname as char_lastname
                FROM {$this->table} cp
                LEFT JOIN characters c ON cp.charidentifier = c.charidentifier";
        $params = [];
        $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(cp.charidentifier = :searchTermCharId OR c.firstname LIKE :searchTermGeneric OR c.lastname LIKE :searchTermGeneric)";
            $params[':searchTermCharId'] = $searchTerm; // For exact char ID match
            $params[':searchTermGeneric'] = '%' . $searchTerm . '%';
        }

        if (!empty($whereClauses)){
            $sql .= " WHERE " . implode(' AND ', $whereClauses);
        }

        // Assuming there's an 'id' or some other column to sort by, or by charidentifier
        $sql .= " ORDER BY cp.charidentifier ASC LIMIT :limit OFFSET :offset";

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
            error_log("Error in CraftingProgress getAllCraftingProgressData: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total crafting progress entries, optionally filtered.
     * @param string $searchTerm
     * @return int
     */
    public function getTotalCraftingProgressCount($searchTerm = '') {
        $sql = "SELECT COUNT(cp.charidentifier)  -- or cp.id if that's the PK
                FROM {$this->table} cp
                LEFT JOIN characters c ON cp.charidentifier = c.charidentifier";
        $params = [];
         $whereClauses = [];

        if (!empty($searchTerm)) {
            $whereClauses[] = "(cp.charidentifier = :searchTermCharId OR c.firstname LIKE :searchTermGeneric OR c.lastname LIKE :searchTermGeneric)";
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
            error_log("Error in CraftingProgress getTotalCraftingProgressCount: " . $e->getMessage());
            return 0;
        }
    }

    // Create/Update methods would be needed if admins can adjust crafting XP/levels.
    // For this phase (viewing only), these are not implemented.
    // Example:
    // public function updateCharacterProgress($charIdentifier, $data) {
    //     $existing = $this->getProgressByCharacterId($charIdentifier);
    //     if ($existing) {
    //         return $this->update($existing[$this->primaryKey], $data); // Assumes 'id' is PK
    //     } else {
    //         $data['charidentifier'] = $charIdentifier;
    //         return $this->create($data);
    //     }
    // }
}
