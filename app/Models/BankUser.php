<?php
// app/Models/BankUser.php

require_once __DIR__ . '/BaseModel.php';

class BankUser extends BaseModel {
    protected $table = 'bank_users';
    // Primary key is 'id' (auto-increment) as per DATABASE_DOCUMENTATION.md for bank_users
    protected $primaryKey = 'id';

    public function __construct() {
        parent::__construct();
    }

    /**
     * Find a specific bank account by its ID.
     * @param int $accountId
     * @return array|false
     */
    public function findByAccountId($accountId) {
        return $this->find($accountId);
    }

    /**
     * Find all bank accounts for a specific user identifier (Steam ID).
     * A user might have multiple bank accounts if 'name' (bank location) varies.
     * @param string $userIdentifier (Steam ID)
     * @return array
     */
    public function findBankAccountsByUserIdentifier($userIdentifier) {
        return $this->findAll(['identifier' => $userIdentifier], 'name ASC');
    }

    /**
     * Find a bank account for a specific character at a specific bank location (name).
     * Assumes a character has at most one account per bank location.
     * @param int $charIdentifier
     * @param string $bankName (e.g., 'main_bank', 'blackwater_bank') - Corresponds to 'name' column
     * @return array|false
     */
    public function findAccountByCharacterAndBankName($charIdentifier, $bankName) {
        $conditions = [
            'charidentifier' => $charIdentifier,
            'name' => $bankName
        ];
        $result = $this->findAll($conditions, '', 1); // Expect at most 1
        return $result ? $result[0] : false;
    }

    /**
     * Get all bank accounts associated with a specific character identifier.
     * A character might have accounts at different bank locations.
     * @param int $charIdentifier
     * @return array
     */
    public function getBankAccountsByCharIdentifier($charIdentifier) {
        return $this->findAll(['charidentifier' => $charIdentifier], 'name ASC');
    }


    /**
     * Update the balance (money or gold) for a specific bank account ID.
     * @param int $accountId
     * @param float $newMoneyBalance (optional)
     * @param float $newGoldBalance (optional)
     * @return bool True on success, false on failure.
     */
    public function updateBalance($accountId, $newMoneyBalance = null, $newGoldBalance = null) {
        $dataToUpdate = [];
        if ($newMoneyBalance !== null) {
            $dataToUpdate['money'] = (float)$newMoneyBalance;
        }
        if ($newGoldBalance !== null) {
            $dataToUpdate['gold'] = (float)$newGoldBalance;
        }

        if (empty($dataToUpdate)) {
            return true; // Nothing to update
        }

        // Ensure balances don't go negative if that's a rule
        if (isset($dataToUpdate['money']) && $dataToUpdate['money'] < 0) {
            // error_log("Attempted to set negative money balance for account ID: $accountId");
            // return false; // Or throw exception
            // For now, allow it, game logic should handle this if it's an issue.
        }
        if (isset($dataToUpdate['gold']) && $dataToUpdate['gold'] < 0) {
            // error_log("Attempted to set negative gold balance for account ID: $accountId");
            // return false;
        }

        return $this->update($accountId, $dataToUpdate);
    }

    /**
     * Adjust balance by a certain amount (deposit/withdraw).
     * @param int $accountId
     * @param float $moneyAdjustment (can be negative for withdrawal)
     * @param float $goldAdjustment (can be negative for withdrawal)
     * @return bool True on success, false on failure or if resulting balance is negative (optional check).
     */
    public function adjustBalance($accountId, $moneyAdjustment = 0.0, $goldAdjustment = 0.0) {
        $account = $this->findByAccountId($accountId);
        if (!$account) {
            return false; // Account not found
        }

        $newMoney = $account['money'] + (float)$moneyAdjustment;
        $newGold = $account['gold'] + (float)$goldAdjustment;

        // Optional: Prevent negative balances through adjustment
        // if ($newMoney < 0 || $newGold < 0) {
        //     $_SESSION['error_message'] = 'Transaction would result in a negative balance.';
        //     return false;
        // }

        return $this->updateBalance($accountId, $newMoney, $newGold);
    }

    /**
     * Create a new bank account for a character.
     * @param array $data Must include 'identifier', 'charidentifier', 'name' (bank location).
     *                    Optional: 'money', 'gold', 'items', 'invspace'.
     * @return string|false Account ID or false on failure.
     */
    public function createBankAccount($data) {
        if (!isset($data['identifier']) || !isset($data['charidentifier']) || !isset($data['name'])) {
            error_log("BankUser createBankAccount error: Missing required fields (identifier, charidentifier, name).");
            return false;
        }

        // Check if an account for this character at this bank already exists
        if ($this->findAccountByCharacterAndBankName($data['charidentifier'], $data['name'])) {
            error_log("BankUser createBankAccount error: Account already exists for this character at bank '{$data['name']}'.");
            // Depending on game rules, this might be an error or might allow multiple accounts with different IDs.
            // The current findAccountByCharacterAndBankName assumes one.
            return false;
        }

        $defaults = [
            'money' => 0.00,
            'gold' => 0.00,
            'items' => '[]', // Default empty JSON array for items
            'invspace' => $data['invspace'] ?? 0 // Default inventory space if not provided
        ];
        $data = array_merge($defaults, $data);

        return $this->create($data);
    }

    /**
     * Get total money and gold across all bank accounts.
     * @return array ['total_money' => float, 'total_gold' => float]
     */
    public function getTotalBankWealth() {
        try {
            $stmt = $this->db->query("SELECT SUM(money) as total_money, SUM(gold) as total_gold FROM {$this->table}");
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            return [
                'total_money' => (float)($result['total_money'] ?? 0.0),
                'total_gold' => (float)($result['total_gold'] ?? 0.0)
            ];
        } catch (PDOException $e) {
            error_log("Error in BankUser getTotalBankWealth: " . $e->getMessage());
            return ['total_money' => 0.0, 'total_gold' => 0.0];
        }
    }
}
