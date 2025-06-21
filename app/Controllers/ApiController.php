<?php
// app/Controllers/ApiController.php

// Include necessary models and services
require_once __DIR__ . '/../Models/User.php';
require_once __DIR__ . '/../Models/Character.php';
// Add other models as needed for more API endpoints
require_once __DIR__ . '/../Services/AuthService.php'; // For API authentication/authorization

class ApiController {
    private $userModel;
    private $characterModel;
    private $authService;

    public function __construct() {
        $this->userModel = new User();
        $this->characterModel = new Character();
        $this->authService = new AuthService(); // For session-based auth or future API key auth

        // Set content type to JSON for all responses from this controller
        header('Content-Type: application/json');
    }

    /**
     * Authenticate API request.
     * For now, relies on existing session-based authentication.
     * Admins/SuperAdmins have access.
     * TODO: Implement API key or JWT authentication for broader API use.
     * @return bool True if authenticated and authorized, false otherwise (and sends error response).
     */
    private function authenticateRequest() {
        if (!$this->authService->isLoggedIn()) {
            http_response_code(401); // Unauthorized
            echo json_encode(['error' => 'Unauthorized: Login required.']);
            return false;
        }
        // For these initial stubs, restrict to admin/super_admin
        if (!$this->authService->hasPermission('admin') && !$this->authService->hasPermission('super_admin')) {
            http_response_code(403); // Forbidden
            echo json_encode(['error' => 'Forbidden: Admin access required for this API.']);
            return false;
        }
        return true;
    }

    /**
     * GET /api/users
     * List users (basic version, paginated).
     */
    public function listUsers() {
        if (!$this->authenticateRequest()) return;

        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
        $offset = ($page - 1) * $limit;
        // No search term for this basic stub

        $users = $this->userModel->getAllUsers($limit, $offset);
        $totalUsers = $this->userModel->getTotalUserCount();

        // Remove sensitive data like password_hash before sending
        $usersSafe = array_map(function($user){
            unset($user['password_hash']);
            return $user;
        }, $users);

        echo json_encode([
            'data' => $usersSafe,
            'pagination' => [
                'total' => $totalUsers,
                'limit' => $limit,
                'page' => $page,
                'totalPages' => ceil($totalUsers / $limit)
            ]
        ]);
    }

    /**
     * GET /api/users/:id
     * Get a specific user by identifier.
     * @param string $identifier User's SteamID
     */
    public function getUser($identifier) {
        if (!$this->authenticateRequest()) return;

        $user = $this->userModel->findByIdentifier($identifier);
        if ($user) {
            unset($user['password_hash']); // Remove sensitive data
            echo json_encode(['data' => $user]);
        } else {
            http_response_code(404); // Not Found
            echo json_encode(['error' => 'User not found.']);
        }
    }

    /**
     * GET /api/characters
     * List characters (basic version, paginated).
     */
    public function listCharacters() {
        if (!$this->authenticateRequest()) return;

        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
        $offset = ($page - 1) * $limit;
        $userIdentifierFilter = $_GET['user_identifier'] ?? null; // Optional filter by owner

        $characters = $this->characterModel->getAllCharacters($limit, $offset, '', $userIdentifierFilter);
        $totalCharacters = $this->characterModel->getTotalCharacterCount('', $userIdentifierFilter);

        echo json_encode([
            'data' => $characters,
            'pagination' => [
                'total' => $totalCharacters,
                'limit' => $limit,
                'page' => $page,
                'user_identifier_filter' => $userIdentifierFilter,
                'totalPages' => ceil($totalCharacters / $limit)
            ]
        ]);
    }

    /**
     * GET /api/characters/:id
     * Get a specific character by charidentifier.
     * @param int $charIdentifier Character's unique ID
     */
    public function getCharacter($charIdentifier) {
        if (!$this->authenticateRequest()) return;

        $character = $this->characterModel->findByCharIdentifier((int)$charIdentifier);
        if ($character) {
            // Optionally fetch and include related data like inventory, posse, etc.
            // For this stub, just the basic character data.
            echo json_encode(['data' => $character]);
        } else {
            http_response_code(404); // Not Found
            echo json_encode(['error' => 'Character not found.']);
        }
    }

    // --- Helper for sending JSON responses ---
    private function jsonResponse($data, $statusCode = 200) {
        http_response_code($statusCode);
        echo json_encode($data);
        exit; // Important to prevent further output
    }

    // --- Placeholder for other API endpoints as per IMPLEMENTATION_PROMPT.md ---
    // Example: POST /api/users (Create User)
    /*
    public function createUser() {
        if (!$this->authenticateRequest()) return;
        // Check if it's a POST request
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->jsonResponse(['error' => 'Invalid request method. Only POST allowed.'], 405);
        }
        // Get data from request body (e.g., json_decode(file_get_contents('php://input'), true))
        // Validate data
        // Create user using UserModel
        // Return success or error response
    }
    */
}
