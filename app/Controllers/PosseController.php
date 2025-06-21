<?php
// app/Controllers/PosseController.php

require_once __DIR__ . '/../Models/Posse.php';
require_once __DIR__ . '/../Services/AuthService.php';

class PosseController {
    private $posseModel;
    private $authService;

    public function __construct() {
        $this->posseModel = new Posse();
        $this->authService = new AuthService();

        if (!$this->authService->isLoggedIn() || !$this->authService->hasPermission('admin')) {
             $_SESSION['error_message'] = 'You do not have permission to access posse administration.';
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
     * List all posses (admin view).
     */
    public function listPosses() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 15;
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $posses = $this->posseModel->getAllPosses($limit, $offset, $searchTerm);
        $totalPosses = $this->posseModel->getTotalPosseCount($searchTerm);
        $totalPages = ceil($totalPosses / $limit);

        $viewData = [
            'posses' => $posses,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'csrfToken' => $this->authService->getCsrfToken() // For potential future actions on this page
        ];
        $GLOBALS['pageTitle'] = 'Posse Management (Admin View)';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/posses/index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * View details of a specific posse, including members.
     */
    public function viewPosse($posseId) {
        $posse = $this->posseModel->findByPosseId($posseId);
        if (!$posse) {
            $_SESSION['error_message'] = 'Posse not found.';
            header('Location: index.php?action=posseList');
            exit;
        }

        $members = $this->posseModel->getPosseMembers($posseId);

        $viewData = [
            'posse' => $posse,
            'members' => $members,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'View Posse: ' . htmlspecialchars($posse['possename']);
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/posses/view.php';
        $GLOBALS['viewData'] = $viewData;
    }

    // CRUD for posses (create, edit, delete) would be more complex due to game logic
    // (e.g., assigning leader, inviting members, disbanding posse and its effects on characters.posseid)
    // These are deferred for now, focusing on viewing.
}
