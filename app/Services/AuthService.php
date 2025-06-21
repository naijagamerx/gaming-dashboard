<?php

// app/Services/AuthService.php

// Ensure Database class is loaded. Adjust path if necessary.
require_once __DIR__ . '/../Config/database.php';

class AuthService {
    private $db;
    private $userModel; // We'll need a UserModel later

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
        // $this->userModel = new UserModel(); // Instantiate UserModel when it's created
    }

    public function login($identifier, $password) {
        // This is a placeholder. Actual implementation will need the UserModel.
        // For now, we'll simulate a login check.
        // In a real scenario, you would fetch the user by identifier (e.g., email or username)
        // and then verify the password.

        // Placeholder for fetching user from the database
        // $user = $this->userModel->findByEmailOrUsername($identifier);

        // For now, let's assume the `users` table has 'identifier' (PK, e.g. steam id), 'password_hash', and 'group'
        // This query structure is based on PHP_BOOTSTRAP_IMPLEMENTATION.md
        try {
            $stmt = $this->db->prepare("
                SELECT identifier, password_hash, \`group\`
                FROM users
                WHERE identifier = :identifier AND (banned IS NULL OR banned = 0)
            ");
            $stmt->bindParam(':identifier', $identifier);
            $stmt->execute();
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user && password_verify($password, $user['password_hash'])) {
                // Start secure session
                if (session_status() == PHP_SESSION_NONE) {
                    session_start();
                }
                session_regenerate_id(true); // Prevent session fixation

                $_SESSION['user_id'] = $user['identifier'];
                $_SESSION['user_group'] = $user['group']; // 'group' from users table
                $_SESSION['login_time'] = time();
                $_SESSION['csrf_token'] = bin2hex(random_bytes(32));

                // Placeholder for logging activity
                // $this->logUserActivity($user['identifier'], 'login', $_SERVER['REMOTE_ADDR']);

                return true;
            }
        } catch (PDOException $e) {
            error_log("Login error: " . $e->getMessage());
            // Handle database errors appropriately
            return false;
        }

        // Placeholder for logging failed attempt
        // $this->logUserActivity($identifier, 'failed_login', $_SERVER['REMOTE_ADDR']);
        return false;
    }

    public function logout() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }

        if (isset($_SESSION['user_id'])) {
            // Placeholder for logging activity
            // $this->logUserActivity($_SESSION['user_id'], 'logout', $_SERVER['REMOTE_ADDR']);
        }

        // Unset all session variables
        $_SESSION = [];

        // Destroy the session
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }
        session_destroy();

        // Start a new session to prevent session fixation on next login
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        session_regenerate_id(true);
    }

    public function isLoggedIn() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        return isset($_SESSION['user_id']);
    }

    public function getCurrentUserId() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        return $_SESSION['user_id'] ?? null;
    }

    public function getCurrentUserGroup() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        return $_SESSION['user_group'] ?? null;
    }

    public function getCsrfToken() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }

    public function verifyCsrfToken($token) {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
    }

    // Basic permission check, can be expanded based on IMPLEMENTATION_PROMPT.md
    public function hasPermission($requiredGroup) {
        $userGroup = $this->getCurrentUserGroup();
        if (!$userGroup) {
            return false;
        }
        // This is a simplified check. A more robust RBAC would be needed.
        // Example: 'super_admin' has all permissions.
        if ($userGroup === 'super_admin') return true;
        if ($userGroup === 'admin' && ($requiredGroup === 'admin' || $requiredGroup === 'user')) return true;
        return $userGroup === $requiredGroup;
    }

    // Placeholder for password hashing during user creation/update
    public static function hashPassword($password) {
        // Using Argon2ID as recommended if available, otherwise bcrypt
        if (defined('PASSWORD_ARGON2ID')) {
            return password_hash($password, PASSWORD_ARGON2ID, [
                'memory_cost' => 65536, // 64MB
                'time_cost'   => 4,
                'threads'     => 3
            ]);
        } else {
            return password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);
        }
    }

    // Placeholder for logging user activity - adapt as needed
    /*
    private function logUserActivity($userId, $action, $ipAddress) {
        try {
            $stmt = $this->db->prepare("
                INSERT INTO user_activity_log (user_id, action, ip_address, timestamp)
                VALUES (:user_id, :action, :ip_address, NOW())
            ");
            $stmt->bindParam(':user_id', $userId);
            $stmt->bindParam(':action', $action);
            $stmt->bindParam(':ip_address', $ipAddress);
            $stmt->execute();
        } catch (PDOException $e) {
            error_log("Failed to log user activity: " . $e->getMessage());
        }
    }
    */
}

// Secure session settings
ini_set('session.use_only_cookies', 1);
ini_set('session.cookie_httponly', 1);
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') {
    ini_set('session.cookie_secure', 1); // Send cookie only over HTTPS
}
ini_set('session.gc_maxlifetime', 7200); // Session timeout: 2 hours
session_set_cookie_params([
    'lifetime' => 7200,
    'path' => '/',
    'domain' => $_SERVER['HTTP_HOST'] ?? 'localhost',
    'secure' => isset($_SERVER['HTTPS']),
    'httponly' => true,
    'samesite' => 'Lax' // Or 'Strict'
]);

// It's good practice to start the session here if it's always needed when AuthService is included,
// or ensure it's started before any session operations are called.
// However, individual methods also check and start session if needed to be safe.
// Session configuration settings have been moved to public/index.php to be set before session_start().

if (session_status() == PHP_SESSION_NONE) {
    // It's generally better to let index.php handle the initial session_start()
    // after configurations are set. If AuthService is instantiated after session_start()
    // in index.php, this is fine.
    // For safety, methods in this class will still check session_status() if they directly use $_SESSION.
    // session_start(); // Consider if this is still needed here or if index.php guarantees it.
}
