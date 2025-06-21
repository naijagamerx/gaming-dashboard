<?php
// app/Controllers/UserController.php

require_once __DIR__ . '/../Models/User.php';
require_once __DIR__ . '/../Services/AuthService.php';

class UserController {
    private $userModel;
    private $authService;

    public function __construct() {
        $this->userModel = new User();
        $this->authService = new AuthService();

        // All user management actions require login and admin privileges
        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to manage users.';
            header('Location: index.php?action=showLogin');
            exit;
        }
        // Simplified permission check for now.
        // Based on `PHP_BOOTSTRAP_IMPLEMENTATION.md`, 'users.*' permission for server_admin
        // and '*' for super_admin.
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
             // A more granular permission check like $this->authService->can('users.view') would be better
            $_SESSION['error_message'] = 'You do not have permission to manage users.';
            header('Location: index.php?action=dashboard'); // Redirect to dashboard or an error page
            exit;
        }
    }

    public function index() {
        // List all users - with pagination
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10; // Users per page
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';

        $users = $this->userModel->getAllUsers($limit, $offset, $searchTerm);
        $totalUsers = $this->userModel->getTotalUserCount($searchTerm);
        $totalPages = ceil($totalUsers / $limit);

        // Pass data to the view
        require_once __DIR__ . '/../Views/users/index.php';
    }

    public function create() {
        // Show form to create a new user
        require_once __DIR__ . '/../Views/users/create.php';
    }

    public function store() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!isset($_POST['csrf_token']) || !$this->authService->verifyCsrfToken($_POST['csrf_token'])) {
                $_SESSION['error_message'] = 'CSRF token mismatch. User creation failed.';
                header('Location: index.php?action=userList');
                exit;
            }

            $data = [
                'identifier' => $_POST['identifier'],
                'password' => $_POST['password'],
                'group' => $_POST['group'] ?? 'user', // Default to 'user' if not provided
                'warnings' => $_POST['warnings'] ?? 0,
                'banned' => isset($_POST['banned']) ? 1 : 0,
                'banneduntil' => $_POST['banneduntil'] ?? 0,
                'char' => $_POST['char'] ?? 5
            ];

            // Basic validation
            if (empty($data['identifier']) || empty($data['password'])) {
                $_SESSION['error_message'] = 'Identifier and password are required.';
                $_SESSION['form_data'] = $_POST; // Preserve form data
                header('Location: index.php?action=userCreate');
                exit;
            }

            // Check if user already exists
            if ($this->userModel->findByIdentifier($data['identifier'])) {
                $_SESSION['error_message'] = 'User with this identifier already exists.';
                $_SESSION['form_data'] = $_POST;
                header('Location: index.php?action=userCreate');
                exit;
            }


            if ($this->userModel->createUser($data)) {
                $_SESSION['success_message'] = 'User created successfully.';
            } else {
                $_SESSION['error_message'] = 'Failed to create user.';
            }
            header('Location: index.php?action=userList');
            exit;
        }
        // Not a POST request
        header('Location: index.php?action=userCreate');
        exit;
    }

    public function edit($identifier) {
        $user = $this->userModel->findByIdentifier($identifier);
        if (!$user) {
            $_SESSION['error_message'] = 'User not found.';
            header('Location: index.php?action=userList');
            exit;
        }
        // Pass user data to the edit view
        require_once __DIR__ . '/../Views/users/edit.php';
    }

    public function update($identifier) {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!isset($_POST['csrf_token']) || !$this->authService->verifyCsrfToken($_POST['csrf_token'])) {
                $_SESSION['error_message'] = 'CSRF token mismatch. User update failed.';
                header('Location: index.php?action=userList');
                exit;
            }

            $user = $this->userModel->findByIdentifier($identifier);
            if (!$user) {
                $_SESSION['error_message'] = 'User not found.';
                header('Location: index.php?action=userList');
                exit;
            }

            $data = [
                // Identifier (PK) cannot be changed
                'group' => $_POST['group'],
                'warnings' => (int)($_POST['warnings'] ?? $user['warnings']),
                'banned' => isset($_POST['banned']) ? 1 : 0,
                'banneduntil' => (int)($_POST['banneduntil'] ?? $user['banneduntil']),
                'char' => (int)($_POST['char'] ?? $user['char'])
            ];

            // Update password only if a new one is provided
            if (!empty($_POST['password'])) {
                $data['password'] = $_POST['password']; // Will be hashed by model
            }

            if ($this->userModel->updateUser($identifier, $data)) {
                $_SESSION['success_message'] = 'User updated successfully.';
            } else {
                $_SESSION['error_message'] = 'Failed to update user.';
            }
            header('Location: index.php?action=userList');
            exit;
        }
        // Not a POST request
        header('Location: index.php?action=userEdit&identifier=' . urlencode($identifier));
        exit;
    }

    public function delete($identifier) {
         if ($_SERVER['REQUEST_METHOD'] === 'POST') { // Ensure delete is via POST for CSRF protection
            if (!isset($_POST['csrf_token']) || !$this->authService->verifyCsrfToken($_POST['csrf_token'])) {
                $_SESSION['error_message'] = 'CSRF token mismatch. User deletion failed.';
                header('Location: index.php?action=userList');
                exit;
            }

            if ($this->userModel->deleteUser($identifier)) {
                $_SESSION['success_message'] = 'User deleted successfully.';
            } else {
                $_SESSION['error_message'] = 'Failed to delete user.';
            }
        } else {
            $_SESSION['error_message'] = 'Invalid request method for delete action.';
        }
        header('Location: index.php?action=userList');
        exit;
    }
}
