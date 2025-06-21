<?php
// app/Controllers/ItemController.php

require_once __DIR__ . '/../Models/Item.php';
require_once __DIR__ . '/../Services/AuthService.php';

class ItemController {
    private $itemModel;
    private $authService;

    public function __construct() {
        $this->itemModel = new Item();
        $this->authService = new AuthService();

        // Item management actions generally require login and admin privileges
        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to manage items.';
            header('Location: index.php?action=showLogin');
            exit;
        }
        // For now, basic admin check for all item actions
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            $_SESSION['error_message'] = 'You do not have permission to manage items.';
            header('Location: index.php?action=dashboard');
            exit;
        }
    }

    /**
     * List all items (from items table) - for admin viewing.
     */
    public function index() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 15; // Items per page
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $items = $this->itemModel->getAllItems($limit, $offset, $searchTerm);
        $totalItems = $this->itemModel->getTotalItemCount($searchTerm);
        $totalPages = ceil($totalItems / $limit);

        $viewData = [
            'items' => $items,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'csrfToken' => $this->authService->getCsrfToken()
            // CSRF might not be needed for a pure list view, but good practice if any forms/actions are on page
        ];
        $GLOBALS['pageTitle'] = 'Item Database Management';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/items/index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    // Placeholder for create/store/edit/update/delete item actions if full item CRUD is needed later.
    // For Phase 2, the focus was on Item Model and basic viewing of character inventory.
    // This index() method provides a way to view the master item list as per the sidebar link.

    /*
    public function create() { ... }
    public function store() { ... }
    public function edit($id) { ... } // Using 'id' (auto-increment PK)
    public function update($id) { ... }
    public function delete($id) { ... }
    */
}
