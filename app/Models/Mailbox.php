<?php
// app/Models/Mailbox.php

require_once __DIR__ . '/BaseModel.php';

class Mailbox extends BaseModel {
    // `mailbox_mails` table
    // Schema details are not fully provided in DATABASE_DOCUMENTATION.md.
    // Assuming common mail columns: `id (PK AI)`, `sender_charid`, `receiver_charid`, `subject`, `message`, `sent_at`, `is_read`.
    // `IMPLEMENTATION_PROMPT.md` refers to `mailbox_mails` - In-game messaging.
    protected $table = 'mailbox_mails';
    protected $primaryKey = 'id'; // Assuming an auto-incrementing 'id' PK.

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get mails received by a specific character, ordered by most recent.
     * @param string $receiverCharId (Ensure type matches DB column, likely INT)
     * @param int $limit
     * @param int $offset
     * @return array
     */
    public function getReceivedMailsByCharacterId($receiverCharId, $limit = 10, $offset = 0) {
        // Need to join with characters table to get sender's name.
        // Assuming `sender_charid` column stores the sender's character ID.
        $sql = "SELECT mm.*,
                       schar.firstname as sender_firstname, schar.lastname as sender_lastname,
                       rchar.firstname as receiver_firstname, rchar.lastname as receiver_lastname
                FROM {$this->table} mm
                LEFT JOIN characters schar ON mm.sender_charid = schar.charidentifier
                LEFT JOIN characters rchar ON mm.receiver_charid = rchar.charidentifier
                WHERE mm.receiver_charid = :receiverCharId
                ORDER BY mm.sent_at DESC, mm.{$this->primaryKey} DESC";

        $sql .= " LIMIT :limit OFFSET :offset";

        try {
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':receiverCharId', $receiverCharId); // PDO should handle type if $receiverCharId is int
            $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
            $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Mailbox getReceivedMailsByCharacterId: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total mails received by a specific character.
     * @param string $receiverCharId
     * @return int
     */
    public function getTotalReceivedMailsCount($receiverCharId) {
        return $this->count(['receiver_charid' => $receiverCharId]);
    }

    /**
     * Get mails sent by a specific character, ordered by most recent.
     * @param string $senderCharId
     * @param int $limit
     * @param int $offset
     * @return array
     */
    public function getSentMailsByCharacterId($senderCharId, $limit = 10, $offset = 0) {
         $sql = "SELECT mm.*,
                       schar.firstname as sender_firstname, schar.lastname as sender_lastname,
                       rchar.firstname as receiver_firstname, rchar.lastname as receiver_lastname
                FROM {$this->table} mm
                LEFT JOIN characters schar ON mm.sender_charid = schar.charidentifier
                LEFT JOIN characters rchar ON mm.receiver_charid = rchar.charidentifier
                WHERE mm.sender_charid = :senderCharId
                ORDER BY mm.sent_at DESC, mm.{$this->primaryKey} DESC";

        $sql .= " LIMIT :limit OFFSET :offset";

        try {
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':senderCharId', $senderCharId);
            $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
            $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Mailbox getSentMailsByCharacterId: " . $e->getMessage());
            return [];
        }
    }

    /**
     * Count total mails sent by a specific character.
     * @param string $senderCharId
     * @return int
     */
    public function getTotalSentMailsCount($senderCharId) {
        return $this->count(['sender_charid' => $senderCharId]);
    }

    /**
     * Get a specific mail by its ID, including sender/receiver names.
     * @param int $mailId
     * @return array|false
     */
    public function getMailById($mailId) {
        $sql = "SELECT mm.*,
                       schar.firstname as sender_firstname, schar.lastname as sender_lastname,
                       rchar.firstname as receiver_firstname, rchar.lastname as receiver_lastname
                FROM {$this->table} mm
                LEFT JOIN characters schar ON mm.sender_charid = schar.charidentifier
                LEFT JOIN characters rchar ON mm.receiver_charid = rchar.charidentifier
                WHERE mm.{$this->primaryKey} = :mailId";
        try {
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':mailId', $mailId, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error in Mailbox getMailById: " . $e->getMessage());
            return false;
        }
    }

    // For Phase 3, focusing on read-only. Admin functions for mail (e.g., deleting inappropriate mail)
    // or sending system mail would be additional.
    // public function deleteMail($mailId) { ... }
    // public function markAsRead($mailId) { ... }
    // public function sendSystemMail($receiverCharId, $subject, $message) { ... }
}
