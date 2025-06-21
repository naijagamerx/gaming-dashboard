<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
// Assuming AuthService is available or can be instantiated for user info and CSRF
// For simplicity, we might need to instantiate it here if not passed globally.
if (!isset($authService)) {
    // This is a fallback. Ideally, $authService would be available via a BaseController or dependency injection.
    require_once __DIR__ . '/../../Services/AuthService.php';
    $authService = new AuthService();
}
$csrfToken = $_SESSION['csrf_token'] ?? $authService->getCsrfToken(); // Ensure CSRF token is available

$currentAction = $_GET['action'] ?? 'dashboard'; // Determine current page for active links
?>
<!DOCTYPE html>
<html lang="en" data-bs-theme="<?= $_SESSION['theme'] ?? 'light' ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle ?? 'Gaming Dashboard') ?> - RDR2 Server Admin</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <!-- DataTables CSS (Optional - include if you plan to use it soon) -->
    <!-- <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet"> -->

    <!-- Custom CSS -->
    <link href="assets/css/custom.css" rel="stylesheet"> <!-- Make sure this path is correct from public/index.php -->

    <!-- CSRF Token for AJAX requests -->
    <meta name="csrf-token" content="<?= htmlspecialchars($csrfToken); ?>">
</head>
<body>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <?php require_once __DIR__ . '/sidebar.php'; ?>

        <!-- Page Content Wrapper -->
        <div id="page-content-wrapper">
            <!-- Top Navigation -->
            <?php require_once __DIR__ . '/header.php'; ?>

            <!-- Main Content -->
            <div class="container-fluid px-4">
                <!-- Breadcrumb could go here if implemented globally -->

                <!-- Alert Messages -->
                <?php if (isset($_SESSION['success_message'])): ?>
                    <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                        <?= htmlspecialchars($_SESSION['success_message']); ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['success_message']); ?>
                <?php endif; ?>

                <?php if (isset($_SESSION['error_message'])): ?>
                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                        <?= htmlspecialchars($_SESSION['error_message']); ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['error_message']); ?>
                <?php endif; ?>
                 <?php if (isset($_SESSION['login_error'])): ?>
                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                        <?= htmlspecialchars($_SESSION['login_error']); ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['login_error']); ?>
                <?php endif; ?>

                <!-- Page-specific content will be injected here -->
                <?php
                // This is where the content from views like users/index.php, users/create.php will go.
                // The controller action should prepare $content or include the view file directly
                // which then gets captured if this layout is used via ob_start/ob_get_clean.
                // For a simple include approach, controllers might directly include their views
                // and those views would be self-contained or this main.php would be included by them.
                // Let's assume controllers will call a render method that sets $viewFile and $viewData.
                if (isset($viewFile) && file_exists($viewFile)) {
                    // Make $viewData available to the $viewFile
                    if (isset($viewData) && is_array($viewData)) {
                        extract($viewData);
                    }
                    include $viewFile;
                } elseif (isset($content)) {
                     // If $content is already prepared (e.g. by ob_get_clean in the controller or view file itself)
                    echo $content;
                } else {
                    // Fallback or placeholder content
                    // echo "<p>Main content area. No specific view file provided.</p>";
                }
                ?>
            </div>

            <!-- Footer -->
            <?php require_once __DIR__ . '/footer.php'; ?>
        </div>
        <!-- /#page-content-wrapper -->
    </div>
    <!-- /#wrapper -->

    <!-- Bootstrap JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    <!-- jQuery (Optional - Bootstrap 5 doesn't strictly require it, but useful for DataTables etc.) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <!-- DataTables JS (Optional) -->
    <!-- <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script> -->
    <!-- <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script> -->

    <!-- SweetAlert2 (Optional) -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->

    <!-- Custom JS -->
    <script src="assets/js/custom.js"></script> <!-- Make sure this path is correct -->

    <!-- Page-specific scripts can be added here or in the $content -->
    <?php if (isset($scripts) && is_array($scripts)): ?>
        <?php foreach ($scripts as $script): ?>
            <script src="<?= htmlspecialchars($script) ?>"></script>
        <?php endforeach; ?>
    <?php endif; ?>
</body>
</html>
