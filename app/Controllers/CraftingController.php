<?php
// app/Controllers/CraftingController.php

require_once __DIR__ . '/../Models/CraftingLog.php';
require_once __DIR__ . '/../Models/CraftingProgress.php';
require_once __DIR__ . '/../Services/AuthService.php';

class CraftingController {
    private $craftingLogModel;
    private $craftingProgressModel;
    private $authService;

    public function __construct() {
        $this->craftingLogModel = new CraftingLog();
        $this->craftingProgressModel = new CraftingProgress();
        $this->authService = new AuthService();

        if (!$this->authService->isLoggedIn() || !$this->authService->hasPermission('admin')) {
            $_SESSION['error_message'] = 'You do not have permission to access crafting administration.';
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
     * List all crafting logs (admin view).
     */
    public function listCraftingLogs() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 15;
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $logs = $this->craftingLogModel->getAllCraftingLogs($limit, $offset, $searchTerm);
        $totalLogs = $this->craftingLogModel->getTotalCraftingLogCount($searchTerm);
        $totalPages = ceil($totalLogs / $limit);

        $viewData = [
            'logs' => $logs,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Crafting Log Admin';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/crafting/logs_index.php';
        $GLOBALS['viewData'] = $viewData;
    }

    /**
     * List all crafting progress entries (admin view).
     */
    public function listCraftingProgress() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 15;
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $progressData = $this->craftingProgressModel->getAllCraftingProgressData($limit, $offset, $searchTerm);
        $totalProgressEntries = $this->craftingProgressModel->getTotalCraftingProgressCount($searchTerm);
        $totalPages = ceil($totalProgressEntries / $limit);

        $viewData = [
            'progressData' => $progressData,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'searchTerm' => $searchTerm,
            'csrfToken' => $this->authService->getCsrfToken()
        ];
        $GLOBALS['pageTitle'] = 'Crafting Progress Admin';
        $GLOBALS['viewFile'] = __DIR__ . '/../Views/crafting/progress_index.php';
        $GLOBALS['viewData'] = $viewData;
    }
}
