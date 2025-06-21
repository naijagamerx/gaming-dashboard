<?php
// app/Controllers/EconomyController.php

require_once __DIR__ . '/../Models/Character.php';
require_once __DIR__ . '/../Models/BankUser.php';
require_once __DIR__ . '/../Services/AuthService.php';

class EconomyController {
    private $characterModel;
    private $bankUserModel;
    private $authService;

    public function __construct() {
        $this->characterModel = new Character();
        $this->bankUserModel = new BankUser();
        $this->authService = new AuthService();

        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to view economy details.';
            header('Location: index.php?action=showLogin');
            exit;
        }
    }

    /**
     * Display economy overview for a specific character.
     * This includes their pocket money/gold and bank account(s) balances.
     * This method is designed to be called to provide data for another view,
     * such as the Character view, or its own dedicated view.
     *
     * For now, this won't render a full page itself but prepares data.
     * The actual display will be integrated into app/Views/characters/view.php
     * or a new app/Views/economy/character_economy.php if desired.
     *
     * To make it simple for this step, we'll assume it's fetched by CharacterController::view
     * and data is passed to characters/view.php. So this controller might not be directly
     * routed in index.php for a standalone page yet.
     *
     * Alternatively, can create a simple view for it. Let's do that for clarity of this step.
     */
    public function viewCharacterEconomy($charIdentifier) {
        $character = $this->characterModel->findByCharIdentifier($charIdentifier);

        if (!$character) {
            $_SESSION['error_message'] = 'Character not found.';
            header('Location: index.php?action=characterList'); // Or dashboard
            exit;
        }

        // Permission check: Admin can see any. User can see their own.
        $currentUserIdentifier = $this->authService->getCurrentUserId();
        $isOwner = ($character['identifier'] === $currentUserIdentifier);
        $isAdmin = $this->authService->hasPermission('admin') || $this->authService->hasPermission('super_admin');

        if (!$isAdmin && !$isOwner) {
            $_SESSION['error_message'] = 'You do not have permission to view this character\'s economy.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $bankAccounts = $this->bankUserModel->getBankAccountsByCharIdentifier($charIdentifier);

        $viewData = [
            'character' => $character, // Contains pocket money/gold
            'bankAccounts' => $bankAccounts,
            'csrfToken' => $this->authService->getCsrfToken() // For potential future forms on this page
        ];

        $GLOBALS['pageTitle'] = 'Economy for ' . htmlspecialchars($character['firstname'] . ' ' . $character['lastname']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/economy/character_economy.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Admin function: Adjust a character's pocket money/gold or bank balance.
     * This is a more advanced function, placeholder for now or basic implementation.
     */
    public function adjustBalanceForm($charIdentifier) {
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to adjust balances.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $character = $this->characterModel->findByCharIdentifier($charIdentifier);
        if (!$character) {
            $_SESSION['error_message'] = 'Character not found.';
            header('Location: index.php?action=characterList');
            exit;
        }
        $bankAccounts = $this->bankUserModel->getBankAccountsByCharIdentifier($charIdentifier);

        $viewData = [
            'character' => $character,
            'bankAccounts' => $bankAccounts,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Adjust Balances for ' . htmlspecialchars($character['firstname']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/economy/adjust_balance.php';
        $GLOBALS['viewData'] = $viewData;
    }

    public function processAdjustBalance() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?action=dashboard'); // Or appropriate redirect
            exit;
        }
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to perform this action.';
            header('Location: index.php?action=dashboard');
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch.';
            // Consider redirecting back to form or a safe page
            $charIdForRedirect = $_POST['charidentifier'] ?? null;
            if ($charIdForRedirect) {
                 header('Location: index.php?action=economyAdjustBalanceForm&charidentifier=' . urlencode($charIdForRedirect));
            } else {
                header('Location: index.php?action=characterList');
            }
            exit;
        }

        $charIdentifier = $_POST['charidentifier'] ?? null;
        $balanceType = $_POST['balance_type'] ?? null; // 'pocket' or 'bank'
        $currencyType = $_POST['currency_type'] ?? null; // 'money' or 'gold'
        $adjustmentAmount = isset($_POST['adjustment_amount']) ? (float)$_POST['adjustment_amount'] : 0.0;
        $bankAccountId = $_POST['bank_account_id'] ?? null;
        $actionType = $_POST['action_type'] ?? 'set'; // 'set' or 'add'

        if (!$charIdentifier || !$balanceType || !$currencyType) {
            $_SESSION['error_message'] = 'Missing required fields for balance adjustment.';
            header('Location: index.php?action=economyAdjustBalanceForm&charidentifier=' . urlencode($charIdentifier));
            exit;
        }

        $success = false;
        $character = $this->characterModel->findByCharIdentifier($charIdentifier);
        if (!$character) {
             $_SESSION['error_message'] = 'Character not found.';
             header('Location: index.php?action=characterList');
             exit;
        }

        if ($balanceType === 'pocket') {
            $currentValue = (float)($character[$currencyType] ?? 0.0);
            $newValue = ($actionType === 'add') ? $currentValue + $adjustmentAmount : $adjustmentAmount;
            if ($newValue < 0) $newValue = 0; // Prevent negative pocket money/gold

            $success = $this->characterModel->updateCharacter($charIdentifier, [$currencyType => $newValue]);
        } elseif ($balanceType === 'bank' && $bankAccountId) {
            $bankAccount = $this->bankUserModel->findByAccountId($bankAccountId);
            if ($bankAccount && $bankAccount['charidentifier'] == $charIdentifier) { // Verify ownership
                $currentValue = (float)($bankAccount[$currencyType] ?? 0.0);
                $newValue = ($actionType === 'add') ? $currentValue + $adjustmentAmount : $adjustmentAmount;
                 // Bank accounts might be allowed to go negative depending on rules, or clamp here:
                 // if ($newValue < 0) $newValue = 0;
                $success = $this->bankUserModel->updateBalance($bankAccountId,
                    ($currencyType === 'money' ? $newValue : null),
                    ($currencyType === 'gold' ? $newValue : null)
                );
            } else {
                $_SESSION['error_message'] = 'Invalid bank account selected or ownership mismatch.';
            }
        } else {
            $_SESSION['error_message'] = 'Invalid balance type or missing bank account ID.';
        }

        if ($success) {
            $_SESSION['success_message'] = ucfirst($currencyType) . ' balance adjusted successfully.';
        } else {
            if (!isset($_SESSION['error_message'])) { // Avoid overwriting specific errors
                 $_SESSION['error_message'] = 'Failed to adjust ' . $currencyType . ' balance.';
            }
        }
        header('Location: index.php?action=economyAdjustBalanceForm&charidentifier=' . urlencode($charIdentifier));
        exit;
    }


}
