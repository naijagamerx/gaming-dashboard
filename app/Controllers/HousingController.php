<?php
// app/Controllers/HousingController.php

require_once __DIR__ . '/../Models/Housing.php';
require_once __DIR__ . '/../Models/User.php'; // For fetching user list for owner selection
require_once __DIR__ . '/../Models/Character.php'; // For fetching character list for owner selection
require_once __DIR__ . '/../Services/AuthService.php';

class HousingController {
    private $housingModel;
    private $userModel;
    private $characterModel;
    private $authService;

    public function __construct() {
        $this->housingModel = new Housing();
        $this->userModel = new User(); // For populating owner dropdowns
        $this->characterModel = new Character(); // For populating owner dropdowns
        $this->authService = new AuthService();

        // Housing management is typically an admin function
        if (!$this->authService->isLoggedIn() || !$this->authService->hasPermission('admin')) {
            $_SESSION['error_message'] = 'You do not have permission to manage housing.';
            if (!$this->authService->isLoggedIn()) {
                $_SESSION['login_error'] = $_SESSION['error_message'];
                 header('Location: index.php?action=showLogin');
            } else {
                 header('Location: index.php?action=dashboard');
            }
            exit;
        }
    }

    /**
     * List all houses (admin view).
     */
    public function index() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10; // Houses per page
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $houses = $this->housingModel->getAllHouses($limit, $offset, $searchTerm);
        $totalHouses = $this->housingModel->getTotalHouseCount($searchTerm);
        $totalPages = ceil($totalHouses / $limit);

        $viewData = [
            'houses' => $houses,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Housing Management';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/housing/index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * View details of a specific house.
     */
    public function view($houseId) {
        $house = $this->housingModel->findByHouseId($houseId);
        if (!$house) {
            $_SESSION['error_message'] = 'House not found.';
            header('Location: index.php?action=housingList');
            exit;
        }

        // Potentially fetch owner (character) details if not fully joined in findByHouseId
        $ownerCharacter = $this->characterModel->findByCharIdentifier($house['charidentifier']);

        $viewData = [
            'house' => $house,
            'ownerCharacter' => $ownerCharacter, // Pass owner character details
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'View House: ' . htmlspecialchars($house['uniqueName'] ?: ('ID ' . $house['houseid']));
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/housing/view.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Show form to create a new house (admin).
     */
    public function create() {
        // Fetch characters to populate owner dropdown
        // Fetching all characters might be too much for a large DB, consider search/autocomplete later
        $characters = $this->characterModel->getAllCharacters(1000, 0); // Limit for dropdown

        $viewData = [
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? [],
            'characters' => $characters
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Create New House';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/housing/create.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Store a newly created house (admin).
     */
    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?action=housingCreate');
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. House creation failed.';
            header('Location: index.php?action=housingList');
            exit;
        }

        $data = [
            'charidentifier' => $_POST['charidentifier'] ?? null,
            'uniqueName' => $_POST['uniqueName'] ?? null,
            'house_coords' => $_POST['house_coords'] ?? '{}', // Expecting JSON string
            'house_radius_limit' => $_POST['house_radius_limit'] ?? '50', // Default if not set
            'invlimit' => $_POST['invlimit'] ?? '200',
            'ledger' => isset($_POST['ledger']) ? (float)$_POST['ledger'] : 0.0,
            'tax_amount' => isset($_POST['tax_amount']) ? (float)$_POST['tax_amount'] : 0.0,
            'taxes_collected' => $_POST['taxes_collected'] ?? 'false',
            'furniture' => $_POST['furniture'] ?? '{}', // Expecting JSON
            'doors' => $_POST['doors'] ?? '{}', // Expecting JSON
            'allowed_ids' => $_POST['allowed_ids'] ?? '[]', // Expecting JSON array string
            'ownershipStatus' => $_POST['ownershipStatus'] ?? 'purchased',
        ];

        if (empty($data['charidentifier']) || empty($data['uniqueName'])) {
            $_SESSION['error_message'] = 'Owner Character ID and Unique House Name are required.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=housingCreate');
            exit;
        }

        // Validate JSON fields (basic check)
        json_decode($data['house_coords']);
        if (json_last_error() !== JSON_ERROR_NONE) {
            $_SESSION['error_message'] = 'House Coordinates is not valid JSON.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=housingCreate');
            exit;
        }
        // Similar checks for furniture, doors, allowed_ids if they are expected to be complex JSON

        if ($this->housingModel->createHouse($data)) {
            $_SESSION['success_message'] = 'House created successfully.';
            header('Location: index.php?action=housingList');
        } else {
            $_SESSION['error_message'] = 'Failed to create house. Unique Name might already exist or other DB error.';
            $_SESSION['form_data'] = $_POST;
            header('Location: index.php?action=housingCreate');
        }
        exit;
    }


    /**
     * Show form to edit an existing house (admin).
     */
    public function edit($houseId) {
        $house = $this->housingModel->findByHouseId($houseId);
        if (!$house) {
            $_SESSION['error_message'] = 'House not found.';
            header('Location: index.php?action=housingList');
            exit;
        }

        $characters = $this->characterModel->getAllCharacters(1000, 0); // For owner dropdown

        $viewData = [
            'house' => $house,
            'characters' => $characters,
            'csrfToken' => $this->authService->getCsrfToken(),
            'formData' => $_SESSION['form_data'] ?? $house
        ];
        unset($_SESSION['form_data']);

        $GLOBALS['pageTitle'] = 'Edit House: ' . htmlspecialchars($house['uniqueName'] ?: ('ID ' . $house['houseid']));
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/housing/edit.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * Update an existing house (admin).
     */
    public function update($houseId) {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?action=housingEdit&id=' . urlencode($houseId));
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. House update failed.';
            header('Location: index.php?action=housingList');
            exit;
        }

        $house = $this->housingModel->findByHouseId($houseId);
        if (!$house) {
            $_SESSION['error_message'] = 'House not found for update.';
            header('Location: index.php?action=housingList');
            exit;
        }

        $data = [
            'charidentifier' => $_POST['charidentifier'] ?? $house['charidentifier'],
            'uniqueName' => $_POST['uniqueName'] ?? $house['uniqueName'],
            'house_coords' => $_POST['house_coords'] ?? $house['house_coords'],
            'house_radius_limit' => $_POST['house_radius_limit'] ?? $house['house_radius_limit'],
            'invlimit' => $_POST['invlimit'] ?? $house['invlimit'],
            'ledger' => isset($_POST['ledger']) ? (float)$_POST['ledger'] : $house['ledger'],
            'tax_amount' => isset($_POST['tax_amount']) ? (float)$_POST['tax_amount'] : $house['tax_amount'],
            'taxes_collected' => $_POST['taxes_collected'] ?? $house['taxes_collected'],
            'furniture' => $_POST['furniture'] ?? $house['furniture'],
            'doors' => $_POST['doors'] ?? $house['doors'],
            'allowed_ids' => $_POST['allowed_ids'] ?? $house['allowed_ids'],
            'ownershipStatus' => $_POST['ownershipStatus'] ?? $house['ownershipStatus'],
        ];

        if (empty($data['charidentifier']) || empty($data['uniqueName'])) {
            $_SESSION['error_message'] = 'Owner Character ID and Unique House Name are required.';
            $_SESSION['form_data'] = array_merge($house, $_POST);
            header('Location: index.php?action=housingEdit&id=' . urlencode($houseId));
            exit;
        }
        // Basic JSON validation
        json_decode($data['house_coords']); if (json_last_error() !== JSON_ERROR_NONE) { $_SESSION['error_message'] = 'House Coords invalid JSON.'; /* ... redirect ... */ }


        if ($this->housingModel->updateHouse($houseId, $data)) {
            $_SESSION['success_message'] = 'House updated successfully.';
            header('Location: index.php?action=housingView&id=' . urlencode($houseId));
        } else {
            $_SESSION['error_message'] = 'Failed to update house. Unique Name might conflict or other DB error.';
            $_SESSION['form_data'] = array_merge($house, $_POST);
            header('Location: index.php?action=housingEdit&id=' . urlencode($houseId));
        }
        exit;
    }

    /**
     * Delete a house (admin).
     */
    public function delete($houseId) {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $_SESSION['error_message'] = 'Invalid request method for delete action.';
            header('Location: index.php?action=housingList');
            exit;
        }
        if (!$this->authService->verifyCsrfToken($_POST['csrf_token'] ?? '')) {
            $_SESSION['error_message'] = 'CSRF token mismatch. House deletion failed.';
            header('Location: index.php?action=housingList');
            exit;
        }

        // Add additional checks if needed (e.g., house empty, owner notified)

        if ($this->housingModel->deleteHouse($houseId)) {
            $_SESSION['success_message'] = 'House deleted successfully.';
        } else {
            $_SESSION['error_message'] = 'Failed to delete house.';
        }
        header('Location: index.php?action=housingList');
        exit;
    }
}
