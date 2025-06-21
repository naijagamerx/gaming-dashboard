<?php
// app/Controllers/AnimalController.php

require_once __DIR__ . '/../Models/PlayerHorse.php';
require_once __DIR__ . '/../Models/Character.php'; // To get character lists for forms
require_once __DIR__ . '/../Services/AuthService.php';

class AnimalController {
    private $playerHorseModel;
    private $characterModel;
    private $authService;

    public function __construct() {
        $this->playerHorseModel = new PlayerHorse();
        $this->characterModel = new Character(); // For populating owner dropdowns
        $this->authService = new AuthService();

        // Animal management generally an admin function, or user viewing their own.
        // For now, controller actions will have specific checks.
        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to manage animals.';
            header('Location: index.php?action=showLogin');
            exit;
        }
    }

    /**
     * List all player horses (admin view).
     * Can be filtered by character ID or user (SteamID).
     */
    public function listHorses() {
        if (!$this->authService->hasPermission('admin')) { // Basic admin check
            $_SESSION['error_message'] = 'You do not have permission to view all player horses.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10; // Horses per page
        $offset = ($page - 1) * $limit;

        $searchTerm = $_GET['search'] ?? '';
        $charIdFilter = $_GET['charid'] ?? null;
        $userIdentifierFilter = $_GET['identifier'] ?? null;


        $horses = $this->playerHorseModel->getAllPlayerHorses($limit, $offset, $searchTerm, $charIdFilter, $userIdentifierFilter);
        $totalHorses = $this->playerHorseModel->getTotalPlayerHorseCount($searchTerm, $charIdFilter, $userIdentifierFilter);
        $totalPages = ceil($totalHorses / $limit);

        $viewData = [
            'horses' => $horses,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'charIdFilter' => $charIdFilter,
            'userIdentifierFilter' => $userIdentifierFilter,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Player Horse Management';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/animals/horses_index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * View details of a specific horse.
     */
    public function viewHorse($horseId) {
        $horse = $this->playerHorseModel->findByHorseId($horseId);
        if (!$horse) {
            $_SESSION['error_message'] = 'Horse not found.';
            header('Location: index.php?action=horseList');
            exit;
        }

        // Permission: Admin or owner of the character who owns the horse.
        $ownerCharacter = $this->characterModel->findByCharIdentifier($horse['charid']);
        $isOwner = ($ownerCharacter && $ownerCharacter['identifier'] === $this->authService->getCurrentUserId());

        if (!$this->authService->hasPermission('admin') && !$isOwner) {
            $_SESSION['error_message'] = 'You do not have permission to view this horse.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $viewData = [
            'horse' => $horse,
            'ownerCharacter' => $ownerCharacter, // For displaying owner info
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'View Horse: ' . htmlspecialchars($horse['name']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/animals/horse_view.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Show form to create a new player horse (admin).
     */
    public function createHorse() {
        if (!$this->authService->hasPermission('admin')) {
            $_SESSION['error_message'] = 'You do not have permission to create horses.';
            header('Location: index.php?action=dashboard');
            exit;
        }
        // Fetch characters to populate owner dropdown
        $characters = $this->characterModel->getAllCharacters(1000, 0, '', null);


        $viewData = [
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? [],
            'characters' => $characters
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Add New Player Horse';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/animals/horse_create.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Store a newly created player horse (admin).
     */
    public function storeHorse() {
        if (!$this->authService->hasPermission('admin')) { /* ... permission error ... */ header('Location: index.php?action=dashboard'); exit; }
        if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'Invalid request or CSRF token mismatch.';
            header('Location: index.php?action=horseList'); exit;
        }

        $charId = $_POST['charid'] ?? null;
        $character = $this->characterModel->findByCharIdentifier($charId);
        if (!$character) {
            $_SESSION['error_message'] = 'Selected owner character not found.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=horseCreate'); exit;
        }

        $data = [
            'identifier' => $character['identifier'], // User SteamID from the selected character
            'charid' => $charId,
            'name' => $_POST['name'] ?? null,
            'model' => $_POST['model'] ?? null,
            'gender' => $_POST['gender'] ?? 'male',
            'xp' => isset($_POST['xp']) ? (int)$_POST['xp'] : 0,
            'health' => isset($_POST['health']) ? (int)$_POST['health'] : 50,
            'stamina' => isset($_POST['stamina']) ? (int)$_POST['stamina'] : 50,
            'components' => $_POST['components'] ?? '{}',
            'selected' => isset($_POST['selected']) ? 1 : 0,
            'dead' => isset($_POST['dead']) ? 1 : 0,
        ];

        if (empty($data['name']) || empty($data['model'])) {
            $_SESSION['error_message'] = 'Horse Name and Model are required.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=horseCreate'); exit;
        }

        if ($this->playerHorseModel->createPlayerHorse($data)) {
            $_SESSION['success_message'] = 'Player horse added successfully.';
            header('Location: index.php?action=horseList');
        } else {
            $_SESSION['error_message'] = 'Failed to add player horse.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=horseCreate');
        }
        exit;
    }

    /**
     * Show form to edit an existing player horse (admin).
     */
    public function editHorse($horseId) {
        if (!$this->authService->hasPermission('admin')) { /* ... */  header('Location: index.php?action=dashboard'); exit;}

        $horse = $this->playerHorseModel->findByHorseId($horseId);
        if (!$horse) {
            $_SESSION['error_message'] = 'Horse not found.';
            header('Location: index.php?action=horseList'); exit;
        }

        // No need to fetch all characters here, as owner charid/identifier shouldn't be changed in edit form
        // If owner change is allowed, then fetch characters. For now, assume owner is fixed.
        $ownerCharacter = $this->characterModel->findByCharIdentifier($horse['charid']);


        $viewData = [
            'horse' => $horse,
            'ownerCharacterName' => $ownerCharacter ? ($ownerCharacter['firstname'] . ' ' . $ownerCharacter['lastname']) : 'N/A',
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? $horse
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Edit Player Horse: ' . htmlspecialchars($horse['name']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/animals/horse_edit.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Update an existing player horse (admin).
     */
    public function updateHorse($horseId) {
        if (!$this->authService->hasPermission('admin')) { /* ... */ header('Location: index.php?action=dashboard'); exit; }
        if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
             $_SESSION['error_message'] = 'Invalid request or CSRF token mismatch.';
             header('Location: index.php?action=horseList'); exit;
        }

        $horse = $this->playerHorseModel->findByHorseId($horseId);
        if (!$horse) { /* ... horse not found ... */ header('Location: index.php?action=horseList'); exit; }

        $data = [
            'name' => $_POST['name'] ?? $horse['name'],
            'model' => $_POST['model'] ?? $horse['model'],
            'gender' => $_POST['gender'] ?? $horse['gender'],
            'xp' => isset($_POST['xp']) ? (int)$_POST['xp'] : $horse['xp'],
            'health' => isset($_POST['health']) ? (int)$_POST['health'] : $horse['health'],
            'stamina' => isset($_POST['stamina']) ? (int)$_POST['stamina'] : $horse['stamina'],
            'components' => $_POST['components'] ?? $horse['components'],
            'selected' => isset($_POST['selected']) ? 1 : 0,
            'dead' => isset($_POST['dead']) ? 1 : 0,
            // charid and identifier are not changed here.
        ];

        if (empty($data['name']) || empty($data['model'])) {
            $_SESSION['error_message'] = 'Horse Name and Model are required.';
            $_SESSION['form_data'] = array_merge($horse, $_POST); // Preserve attempt
            header('Location: index.php?action=horseEdit&id=' . urlencode($horseId)); exit;
        }

        if ($this->playerHorseModel->updatePlayerHorse($horseId, $data)) {
            $_SESSION['success_message'] = 'Player horse updated successfully.';
            header('Location: index.php?action=horseView&id=' . urlencode($horseId));
        } else {
            $_SESSION['error_message'] = 'Failed to update player horse.';
            $_SESSION['form_data'] = array_merge($horse, $_POST);
            header('Location: index.php?action=horseEdit&id=' . urlencode($horseId));
        }
        exit;
    }

    /**
     * Delete a player horse (admin).
     */
    public function deleteHorse($horseId) {
        if (!$this->authService->hasPermission('admin')) { /* ... */  header('Location: index.php?action=dashboard'); exit; }
        if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'Invalid request or CSRF token mismatch.';
            header('Location: index.php?action=horseList'); exit;
        }

        if ($this->playerHorseModel->deletePlayerHorse($horseId)) {
            $_SESSION['success_message'] = 'Player horse deleted successfully.';
        } else {
            $_SESSION['error_message'] = 'Failed to delete player horse.';
        }
        header('Location: index.php?action=horseList');
        exit;
    }

    // Methods for Pets and Wagons can be added later, following similar patterns.
}
