<?php
// app/Controllers/CharacterController.php

require_once __DIR__ . '/../Models/Character.php';
require_once __DIR__ . '/../Models/User.php'; // To check if user identifier exists
require_once __DIR__ . '/../Services/AuthService.php';

class CharacterController {
    private $characterModel;
    private $userModel;
    private $authService;

    public function __construct() {
        $this->characterModel = new Character();
        $this->userModel = new User(); // For validating user identifier
        $this->authService = new AuthService();

        // Most character management actions require login.
        // Specific permissions (e.g., admin vs owner) will be checked per action.
        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to manage characters.';
            header('Location: index.php?action=showLogin');
            exit;
        }
    }

    /**
     * List characters.
     * Admins see all characters. Regular users might see their own (if implemented).
     * For now, primarily for admin use.
     */
    public function index() {
        // Permission: Only admins/super_admins should see the full list by default.
        // A regular user might see a list of their own characters.
        // Let's assume this is an admin function for now.
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to view all characters.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10; // Characters per page
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';
        $userIdentifierFilter = $_GET['user_identifier'] ?? null;


        $characters = $this->characterModel->getAllCharacters($limit, $offset, $searchTerm, $userIdentifierFilter);
        $totalCharacters = $this->characterModel->getTotalCharacterCount($searchTerm, $userIdentifierFilter);
        $totalPages = ceil($totalCharacters / $limit);

        // Data for the view
        $viewData = [
            'characters' => $characters,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'userIdentifierFilter' => $userIdentifierFilter,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Character Management';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/characters/index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Display a single character's details.
     */
    public function view($charIdentifier) {
        $character = $this->characterModel->findByCharIdentifier($charIdentifier);

        if (!$character) {
            $_SESSION['error_message'] = 'Character not found.';
            header('Location: index.php?action=characterList');
            exit;
        }

        // Permission: Admin can see any. User can see their own.
        $currentUserIdentifier = $this->authService->getCurrentUserId();
        if (!($this->authService->hasPermission('admin') || $this->authService->hasPermission('super_admin')) &&
            $character['identifier'] !== $currentUserIdentifier) {
            $_SESSION['error_message'] = 'You do not have permission to view this character.';
            header('Location: index.php?action=dashboard'); // Or a list of their own characters
            exit;
        }

        // TODO: Fetch and pass inventory, bank balance etc. later
        $inventory = $this->characterModel->getCharacterInventory($charIdentifier);
        // Fetch bank accounts using BankUserModel (instantiated in constructor or create new instance)
        $bankUserModel = new BankUser(); // Or use $this->bankUserModel if initialized in constructor
        $bankAccounts = $bankUserModel->getBankAccountsByCharIdentifier($charIdentifier);


        $viewData = [
            'character' => $character,
            'inventory' => $inventory,
            'bankAccounts' => $bankAccounts,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'View Character: ' . htmlspecialchars($character['firstname'] . ' ' . $character['lastname']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/characters/view.php';
        $GLOBALS['viewData'] = $viewData;
    }


    /**
     * Show form to create a new character.
     */
    public function create() {
        // Permission: Typically admins or any logged-in user (up to their slot limit).
        // For now, let's restrict to admins for simplicity of initial setup.
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to create characters directly (admin function).';
            // Non-admins might have a different flow, e.g., a "create new character" button on their own profile.
            header('Location: index.php?action=dashboard');
            exit;
        }

        $viewData = [
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? []
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Create New Character';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/characters/create.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Store a newly created character in the database.
     */
    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?action=characterCreate');
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. Character creation failed.';
            header('Location: index.php?action=characterList'); // Or back to create form
            exit;
        }

        // Admin permission check (consistent with create form access)
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to store characters.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $data = [
            'identifier' => $_POST['identifier'] ?? null, // User's Steam ID
            'steamname' => $_POST['steamname'] ?? null, // User's Steam Name (often from users table or API)
            'firstname' => $_POST['firstname'] ?? null,
            'lastname' => $_POST['lastname'] ?? null,
            'gender' => $_POST['gender'] ?? 'Unknown',
            'age' => isset($_POST['age']) ? (int)$_POST['age'] : 18,
            'money' => isset($_POST['money']) ? (float)$_POST['money'] : 0.00,
            'gold' => isset($_POST['gold']) ? (float)$_POST['gold'] : 0.00,
            'job' => $_POST['job'] ?? 'unemployed',
            // Add other fields from the form as needed, model has defaults for many
        ];

        // Basic validation
        if (empty($data['identifier']) || empty($data['steamname']) || empty($data['firstname']) || empty($data['lastname'])) {
            $_SESSION['error_message'] = 'User Identifier (SteamID), Steam Name, First Name, and Last Name are required.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=characterCreate');
            exit;
        }

        // Validate if user identifier (SteamID) exists in the users table
        $userExists = $this->userModel->findByIdentifier($data['identifier']);
        if (!$userExists) {
            $_SESSION['error_message'] = 'The provided User Identifier (SteamID) does not exist.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=characterCreate');
            exit;
        }
        // Optionally, auto-fill steamname from $userExists if not provided or to ensure consistency
        if (empty($data['steamname']) && isset($userExists['steamname'])) { // Assuming users table has steamname
             //$data['steamname'] = $userExists['steamname'];
        }


        if ($this->characterModel->createCharacter($data)) {
            $_SESSION['success_message'] = 'Character created successfully.';
            header('Location: index.php?action=characterList');
        } else {
            $_SESSION['error_message'] = 'Failed to create character. Check logs for details.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=characterCreate');
        }
        exit;
    }

    /**
     * Show form to edit an existing character.
     */
    public function edit($charIdentifier) {
        $character = $this->characterModel->findByCharIdentifier($charIdentifier);
        if (!$character) {
            $_SESSION['error_message'] = 'Character not found.';
            header('Location: index.php?action=characterList');
            exit;
        }

        // Permission: Admin can edit any. User can edit their own.
        $currentUserIdentifier = $this->authService->getCurrentUserId();
        if (!($this->authService->hasPermission('admin') || $this->authService->hasPermission('super_admin')) &&
            $character['identifier'] !== $currentUserIdentifier) {
            $_SESSION['error_message'] = 'You do not have permission to edit this character.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        $viewData = [
            'character' => $character,
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? $character // Pre-fill with character data or old form data on error
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Edit Character: ' . htmlspecialchars($character['firstname'] . ' ' . $character['lastname']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/characters/edit.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Update an existing character in the database.
     */
    public function update($charIdentifier) {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?action=characterEdit&charidentifier=' . urlencode($charIdentifier));
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. Character update failed.';
            header('Location: index.php?action=characterList');
            exit;
        }

        $character = $this->characterModel->findByCharIdentifier($charIdentifier);
        if (!$character) {
            $_SESSION['error_message'] = 'Character not found for update.';
            header('Location: index.php?action=characterList');
            exit;
        }

        // Permission check (consistency with edit form access)
        $currentUserIdentifier = $this->authService->getCurrentUserId();
        if (!($this->authService->hasPermission('admin') || $this->authService->hasPermission('super_admin')) &&
            $character['identifier'] !== $currentUserIdentifier) {
            $_SESSION['error_message'] = 'You do not have permission to update this character.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        // Collect data from POST, be careful about what fields are updatable
        // The model's updateCharacter method already prevents changing 'identifier' and 'charidentifier'
        $data = [
            'firstname' => $_POST['firstname'] ?? $character['firstname'],
            'lastname' => $_POST['lastname'] ?? $character['lastname'],
            'gender' => $_POST['gender'] ?? $character['gender'],
            'age' => isset($_POST['age']) ? (int)$_POST['age'] : $character['age'],
            'money' => isset($_POST['money']) ? (float)$_POST['money'] : $character['money'],
            'gold' => isset($_POST['gold']) ? (float)$_POST['gold'] : $character['gold'],
            'xp' => isset($_POST['xp']) ? (int)$_POST['xp'] : $character['xp'],
            'job' => $_POST['job'] ?? $character['job'],
            'joblabel' => $_POST['joblabel'] ?? $character['joblabel'],
            'healthouter' => isset($_POST['healthouter']) ? (int)$_POST['healthouter'] : $character['healthouter'],
            'coords' => $_POST['coords'] ?? $character['coords'], // This should be handled carefully, perhaps JSON encoded
            // Add other updatable fields here
        ];

        // Basic validation example
        if (empty($data['firstname']) || empty($data['lastname'])) {
            $_SESSION['error_message'] = 'First Name and Last Name are required.';
            $_SESSION['form_data'] = array_merge($character, $_POST); // Preserve attempt
            header('Location: index.php?action=characterEdit&charidentifier=' . urlencode($charIdentifier));
            exit;
        }


        if ($this->characterModel->updateCharacter($charIdentifier, $data)) {
            $_SESSION['success_message'] = 'Character updated successfully.';
            header('Location: index.php?action=characterView&charidentifier=' . urlencode($charIdentifier));
        } else {
            $_SESSION['error_message'] = 'Failed to update character. Check logs for details.';
            $_SESSION['form_data'] = array_merge($character, $_POST);
            header('Location: index.php?action=characterEdit&charidentifier=' . urlencode($charIdentifier));
        }
        exit;
    }

    /**
     * Delete a character.
     */
    public function delete($charIdentifier) {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') { // Should be POST for deletion
            $_SESSION['error_message'] = 'Invalid request method for delete action.';
            header('Location: index.php?action=characterList');
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. Character deletion failed.';
            header('Location: index.php?action=characterList');
            exit;
        }

        $character = $this->characterModel->findByCharIdentifier($charIdentifier);
        if (!$character) {
            $_SESSION['error_message'] = 'Character not found for deletion.';
            header('Location: index.php?action=characterList');
            exit;
        }

        // Permission check: Only admin or super_admin for now for this direct delete action.
        // Owner might be able to delete their own characters, but that's a specific game rule.
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to delete characters.';
            header('Location: index.php?action=dashboard');
            exit;
        }

        if ($this->characterModel->deleteCharacter($charIdentifier)) {
            $_SESSION['success_message'] = 'Character deleted successfully.';
        } else {
            $_SESSION['error_message'] = 'Failed to delete character.';
        }
        header('Location: index.php?action=characterList');
        exit;
    }
}
