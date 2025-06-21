<?php
// public/index.php - Main Entry Point / Front Controller

// Start session management
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Basic error reporting (for development)
// In production, log errors to a file and don't display them to users.
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Autoloading for classes (if using Composer, otherwise manual requires)
// Assuming composer.json is set up with PSR-4 autoloading for App\
// and vendor/autoload.php would exist after `composer install`.
// Since we don't have composer install in sandbox, manual requires are safer for now.
// If you run `composer install` locally, you can switch to:
// require_once __DIR__ . '/../vendor/autoload.php';

// Manual requires for now
require_once __DIR__ . '/../app/Config/database.php';
require_once __DIR__ . '/../app/Services/AuthService.php';
require_once __DIR__ . '/../app/Controllers/AuthController.php';
require_once __DIR__ . '/../app/Controllers/UserController.php';
require_once __DIR__ . '/../app/Controllers/CharacterController.php';
require_once __DIR__ . '/../app/Controllers/EconomyController.php';
require_once __DIR__ . '/../app/Controllers/ItemController.php';
require_once __DIR__ . '/../app/Controllers/HousingController.php'; // Added
require_once __DIR__ . '/../app/Controllers/AnimalController.php'; // Added
require_once __DIR__ . '/../app/Controllers/CraftingController.php'; // Added
require_once __DIR__ . '/../app/Controllers/PosseController.php'; // Added


// Basic Routing
$action = $_GET['action'] ?? 'showLogin'; // Default action if none is specified
$charIdentifierParam = $_GET['charidentifier'] ?? null; // Common parameter for character related actions
$idParam = $_GET['id'] ?? null; // Common parameter for item/other ID related actions

// Instantiate AuthService here to be available for layout and controllers if needed
$authService = new AuthService();

// Initialize $pageTitle here, controllers can override it
$pageTitle = 'Gaming Dashboard';
$viewFile = null; // The specific view file to be included by main.php
$viewData = [];   // Data to be extracted for the view
$content = '';    // Alternative for views that generate full content string

// CSRF token check for POST/modifying requests (a simplified global check)
// More specific checks should be in controllers for relevant actions.
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!isset($_POST['csrf_token']) || !$authService->verifyCsrfToken($_POST['csrf_token'])) {
        // Handle CSRF error: log, show error message, redirect
        $_SESSION['error_message'] = 'CSRF token validation failed. Please try again.';
        // Redirect to a safe page, perhaps the previous one or home.
        // For simplicity, redirecting to dashboard or login.
        if ($authService->isLoggedIn()) {
            header('Location: index.php?action=dashboard');
        } else {
            header('Location: index.php?action=showLogin');
        }
        exit;
    }
}


// Route requests to controllers
switch ($action) {
    // Authentication routes
    case 'showLogin':
        $controller = new AuthController();
        $pageTitle = 'Login'; // AuthController's showLoginForm will handle view rendering
        $controller->showLoginForm(); // This method includes the view directly for now.
        exit; // Exit because showLoginForm handles the full page render.
    case 'login':
        $controller = new AuthController();
        $controller->login(); // Handles logic and redirects
        exit;
    case 'logout':
        $controller = new AuthController();
        $controller->logout(); // Handles logic and redirects
        exit;
    case 'dashboard':
        $controller = new AuthController(); // AuthController has a basic dashboard method
        $pageTitle = 'Dashboard';
        // The dashboard method in AuthController currently echoes directly.
        // To use the layout, it should prepare $content or set $viewFile.
        // For now, we'll call it and then include main.php if it doesn't exit.
        // A better approach: $content = $controller->dashboard(); require_once '../app/Views/layouts/main.php';
        // For now, AuthController::dashboard() includes its own simple HTML or exits.
        // To integrate with main.php properly, AuthController::dashboard should change.
        // Let's make a simple dashboard view and use $viewFile.
        if (!$authService->isLoggedIn()) {
            $_SESSION['login_error'] = 'You must be logged in to view the dashboard.';
            header('Location: index.php?action=showLogin');
            exit;
        }
        $viewFile = __DIR__ . '/../app/Views/dashboard/index.php'; // Create this file
        break;

    // User Management routes
    case 'userList':
        $controller = new UserController();
        $pageTitle = 'User Management';
        // UserController's index method will require the view and pass data.
        // To use main.php layout, UserController methods should prepare $content or set $viewFile.
        // For now, let's assume UserController::index() will set $viewFile and $viewData
        // This is a temporary direct call; ideally, controller sets vars for main.php
        $controller->index(); // This will include 'app/Views/users/index.php'
        // To make it work with main.php, users/index.php should capture its output to $content
        // or UserController methods should be refactored to set $viewFile and $viewData.
        // Let's assume users/index.php (and other user views) are now designed to be included by main.php
        // So, the controller actions that show views need to be adapted.
        // For example, UserController::index() should set $GLOBALS['users'], $GLOBALS['totalPages'] etc.
        // and then we set $viewFile here. This is getting messy.
        // A better way: controllers return data, and router includes view within layout.

        // Refactored approach for UserController:
        // 1. UserController methods prepare data.
        // 2. Router sets $viewFile and $viewData.
        // 3. main.php uses $viewFile and $viewData.

        // Let's adjust UserController calls slightly for this example
        // (Actual UserController methods would need to change to not echo/require directly)
        // For this example, we'll assume the view files called by controller methods
        // are now designed to be wrapped by main.php and use its variables.
        // The UserController itself will handle including the specific view file.
        // This means main.php would need to be included at the END of those specific view files,
        // or those view files use ob_start/ob_get_clean.
        // The current main.php tries to handle $viewFile or $content.
        // Let's make UserController->index() assign to $GLOBALS for view data for now.
        $userCtrl = new UserController();
        $userCtrl->index(); // This method will set $viewFile and $viewData in its scope or use require.
                            // For main.php to work, it's better if controller returns view path & data.
                            // For now, assume userList directly outputs or is self-contained with layout.
                            // The current UserController includes its views directly.
                            // So we need to exit after calling it if it renders a full page.
                            // To use the main.php layout correctly, UserController methods should NOT output directly.
                            // They should prepare data, and this router should then include main.php.

        // Corrected flow:
        $userCtlr = new UserController();
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 10;
        $offset = ($page - 1) * $limit;
        $searchTerm = $_GET['search'] ?? '';
        $viewData['users'] = $userCtlr->userModel->getAllUsers($limit, $offset, $searchTerm); // Accessing model directly from controller for data
        $viewData['totalUsers'] = $userCtlr->userModel->getTotalUserCount($searchTerm);
        $viewData['totalPages'] = ceil($viewData['totalUsers'] / $limit);
        $viewData['page'] = $page;
        $viewData['searchTerm'] = $searchTerm;
        $viewData['csrfToken'] = $authService->getCsrfToken(); // Pass CSRF
        $viewFile = __DIR__ . '/../app/Views/users/index.php';
        break;

    case 'userCreate':
        $userCtlr = new UserController(); // Auth check is inside constructor
        $pageTitle = 'Create User';
        $viewData['csrfToken'] = $authService->getCsrfToken();
        $viewData['formData'] = $_SESSION['form_data'] ?? []; // For repopulating form on error
        unset($_SESSION['form_data']);
        $viewFile = __DIR__ . '/../app/Views/users/create.php';
        break;
    case 'userStore':
        $controller = new UserController();
        $controller->store(); // Handles logic and redirects
        exit;
    case 'userEdit':
        $userCtlr = new UserController(); // Auth check is inside constructor
        $identifier = $_GET['identifier'] ?? null;
        if (!$identifier) { /* error, redirect */ header('Location: index.php?action=userList'); exit; }
        $userData = $userCtlr->userModel->findByIdentifier($identifier);
        if (!$userData) { /* error, redirect */ $_SESSION['error_message'] = 'User not found.'; header('Location: index.php?action=userList'); exit; }
        $pageTitle = 'Edit User: ' . htmlspecialchars($identifier);
        $viewData['user'] = $userData;
        $viewData['csrfToken'] = $authService->getCsrfToken();
        $viewFile = __DIR__ . '/../app/Views/users/edit.php';
        break;
    case 'userUpdate':
        $controller = new UserController();
        $identifier = $_GET['identifier'] ?? null; // Assuming identifier is passed for update target
        if (!$identifier) { /* error */ header('Location: index.php?action=userList'); exit; }
        $controller->update($identifier); // Handles logic and redirects
        exit;
    case 'userDelete':
        $controller = new UserController();
        $identifier = $_GET['identifier'] ?? null; // Assuming identifier is passed for delete target
        if (!$identifier) { /* error */ header('Location: index.php?action=userList'); exit; }
        $controller->delete($identifier); // Handles logic and redirects
        exit;

    // Character Management Routes
    case 'characterList':
        $controller = new CharacterController();
        $controller->index(); // This method now sets $GLOBALS for viewFile and viewData
        break;
    case 'characterCreate':
        $controller = new CharacterController();
        $controller->create();
        break;
    case 'characterStore':
        $controller = new CharacterController();
        $controller->store(); // Handles redirect
        exit;
    case 'characterView':
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new CharacterController();
        $controller->view($charIdentifierParam);
        break;
    case 'characterEdit':
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new CharacterController();
        $controller->edit($charIdentifierParam);
        break;
    case 'characterUpdate':
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new CharacterController();
        $controller->update($charIdentifierParam); // Handles redirect
        exit;
    case 'characterDelete':
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new CharacterController();
        $controller->delete($charIdentifierParam); // Handles redirect
        exit;

    // Economy Routes
    case 'economyView': // View economy for a specific character
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing for economy view.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new EconomyController();
        $controller->viewCharacterEconomy($charIdentifierParam);
        break;
    case 'economyAdjustBalanceForm': // Show form to adjust balance (admin)
        if (!$charIdentifierParam) { $_SESSION['error_message'] = 'Character ID missing for balance adjustment form.'; header('Location: index.php?action=characterList'); exit;}
        $controller = new EconomyController();
        $controller->adjustBalanceForm($charIdentifierParam);
        break;
    case 'economyProcessAdjustBalance': // Process balance adjustment (admin)
        $controller = new EconomyController();
        $controller->processAdjustBalance(); // Handles redirect
        exit;

    // Item Routes
    case 'itemList': // View list of all items in database
        $controller = new ItemController();
        $controller->index();
        break;
    // Item CRUD routes (itemCreate, itemStore, etc.) can be added when functionality is built.

    // Housing Routes (Admin)
    case 'housingList':
        $controller = new HousingController();
        $controller->index();
        break;
    case 'housingCreate':
        $controller = new HousingController();
        $controller->create();
        break;
    case 'housingStore':
        $controller = new HousingController();
        $controller->store(); // Handles redirect
        exit;
    case 'housingView':
        if (!$idParam) { $_SESSION['error_message'] = 'House ID missing.'; header('Location: index.php?action=housingList'); exit;}
        $controller = new HousingController();
        $controller->view($idParam);
        break;
    case 'housingEdit':
        if (!$idParam) { $_SESSION['error_message'] = 'House ID missing.'; header('Location: index.php?action=housingList'); exit;}
        $controller = new HousingController();
        $controller->edit($idParam);
        break;
    case 'housingUpdate':
        if (!$idParam) { $_SESSION['error_message'] = 'House ID missing.'; header('Location: index.php?action=housingList'); exit;}
        $controller = new HousingController();
        $controller->update($idParam); // Handles redirect
        exit;
    case 'housingDelete':
        if (!$idParam) { $_SESSION['error_message'] = 'House ID missing.'; header('Location: index.php?action=housingList'); exit;}
        $controller = new HousingController();
        $controller->delete($idParam); // Handles redirect
        exit;

    // Animal (Player Horses) Routes (Admin for CRUD, Owner/Admin for View)
    case 'horseList':
        $controller = new AnimalController();
        $controller->listHorses();
        break;
    case 'horseCreate':
        $controller = new AnimalController();
        $controller->createHorse();
        break;
    case 'horseStore':
        $controller = new AnimalController();
        $controller->storeHorse(); // Handles redirect
        exit;
    case 'horseView':
        if (!$idParam) { $_SESSION['error_message'] = 'Horse ID missing.'; header('Location: index.php?action=horseList'); exit;}
        $controller = new AnimalController();
        $controller->viewHorse($idParam);
        break;
    case 'horseEdit':
        if (!$idParam) { $_SESSION['error_message'] = 'Horse ID missing.'; header('Location: index.php?action=horseList'); exit;}
        $controller = new AnimalController();
        $controller->editHorse($idParam);
        break;
    case 'horseUpdate':
        if (!$idParam) { $_SESSION['error_message'] = 'Horse ID missing.'; header('Location: index.php?action=horseList'); exit;}
        $controller = new AnimalController();
        $controller->updateHorse($idParam); // Handles redirect
        exit;
    case 'horseDelete':
        if (!$idParam) { $_SESSION['error_message'] = 'Horse ID missing.'; header('Location: index.php?action=horseList'); exit;}
        $controller = new AnimalController();
        $controller->deleteHorse($idParam); // Handles redirect
        exit;

    // Crafting Admin Routes
    case 'craftingLogList':
        $controller = new CraftingController();
        $controller->listCraftingLogs();
        break;
    case 'craftingProgressList':
        $controller = new CraftingController();
        $controller->listCraftingProgress();
        break;

    // Posse Admin Routes
    case 'posseList':
        $controller = new PosseController();
        $controller->listPosses();
        break;
    case 'posseView':
        if (!$idParam) { $_SESSION['error_message'] = 'Posse ID missing.'; header('Location: index.php?action=posseList'); exit;}
        $controller = new PosseController();
        $controller->viewPosse($idParam);
        break;

    // AJAX route example for theme toggle (optional)
    case 'toggleTheme':
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['theme'])) {
            $theme = $_POST['theme'] === 'dark' ? 'dark' : 'light';
            $_SESSION['theme'] = $theme;
            echo json_encode(['success' => true, 'theme' => $theme]);
        } else {
            echo json_encode(['success' => false]);
        }
        exit; // AJAX response, no HTML layout needed

    default:
        // Fallback for unknown actions - show dashboard or login
        if ($authService->isLoggedIn()) {
            $pageTitle = 'Dashboard';
            // Create a simple dashboard view if it doesn't exist
            if (!file_exists(__DIR__ . '/../app/Views/dashboard/index.php')) {
                file_put_contents(__DIR__ . '/../app/Views/dashboard/index.php', '<h1>Dashboard</h1><p>Welcome, ' . htmlspecialchars($_SESSION['user_id']) . '!</p>');
            }
            $viewFile = __DIR__ . '/../app/Views/dashboard/index.php';
        } else {
            // If not logged in and action is not 'showLogin' or 'login', redirect to login
            header('Location: index.php?action=showLogin');
            exit;
        }
        break;
}

// If $viewFile is set, include the main layout which will then include $viewFile
if ($viewFile) {
    // $pageTitle, $viewFile, $viewData, $authService should be available to main.php
    // $authService is already instantiated.
    // The main.php will extract $viewData.
    require_once __DIR__ . '/../app/Views/layouts/main.php';
} elseif (!empty($content)) {
    // If a controller generated full $content (less ideal for this structure)
    // This path is less likely with the current main.php setup.
    echo $content;
}
// If a controller action already handled output and exited (like redirects), this point won't be reached.

?>
