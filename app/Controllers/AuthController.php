<?php
// app/Controllers/AuthController.php

require_once __DIR__ . '/../Services/AuthService.php';

class AuthController {
    private $authService;

    public function __construct() {
        $this->authService = new AuthService();
         // Ensure session is started for CSRF token generation
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        // Initialize CSRF token if not set
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
    }

    public function showLoginForm() {
        // If already logged in, redirect to dashboard (or appropriate page)
        if ($this->authService->isLoggedIn()) {
            header('Location: index.php?action=dashboard'); // Assuming a dashboard route
            exit;
        }
        // Regenerate CSRF token for login form
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        require_once __DIR__ . '/../Views/auth/login.php';
    }

    public function login() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!isset($_POST['csrf_token']) || !$this->authService->verifyCsrfToken($_POST['csrf_token'])) {
                $_SESSION['login_error'] = 'CSRF token mismatch. Please try again.';
                header('Location: index.php?action=showLogin');
                exit;
            }

            $identifier = $_POST['identifier'] ?? null;
            $password = $_POST['password'] ?? null;

            if (empty($identifier) || empty($password)) {
                $_SESSION['login_error'] = 'Identifier and password are required.';
                header('Location: index.php?action=showLogin');
                exit;
            }

            if ($this->authService->login($identifier, $password)) {
                // Successful login, redirect to a protected page (e.g., dashboard)
                // The AuthService already started and regenerated the session
                unset($_SESSION['login_error']); // Clear any previous error
                header('Location: index.php?action=dashboard'); // Assuming a dashboard route
                exit;
            } else {
                // Failed login
                $_SESSION['login_error'] = 'Invalid identifier or password.';
                header('Location: index.php?action=showLogin');
                exit;
            }
        } else {
            // Not a POST request, redirect to login form
            header('Location: index.php?action=showLogin');
            exit;
        }
    }

    public function logout() {
        $this->authService->logout();
        // Redirect to login page after logout
        header('Location: index.php?action=showLogin');
        exit;
    }

    // A protected route example
    public function dashboard() {
        if (!$this->authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to view this page.';
            header('Location: index.php?action=showLogin');
            exit;
        }

        // Load dashboard view
        // For now, just a simple message
        echo "Welcome to the Dashboard, " . htmlspecialchars($_SESSION['user_id']) . "!";
        echo "<br>Your group: " . htmlspecialchars($_SESSION['user_group'] ?? 'N/A');
        echo '<br><a href="index.php?action=logout">Logout</a>';
        // Later, this will load app/Views/dashboard/index.php
    }
}
