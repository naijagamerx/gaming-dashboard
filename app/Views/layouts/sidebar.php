<?php
// app/Views/layouts/sidebar.php
// Assumes $authService is available for permission checks, and $currentAction for active links.
// Fallback if $authService not passed:
if (!isset($authService)) {
    require_once __DIR__ . '/../../Services/AuthService.php';
    $authService = new AuthService();
}
$currentAction = $_GET['action'] ?? 'dashboard'; // Default to dashboard
$isLoggedIn = $authService->isLoggedIn();
?>
<div class="bg-dark border-end" id="sidebar-wrapper">
    <div class="sidebar-heading border-bottom bg-dark text-light">
        <i class="bi bi-controller"></i> RDR2 Admin
    </div>
    <div class="list-group list-group-flush">
        <?php if ($isLoggedIn): ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= ($currentAction == 'dashboard' || $currentAction == '') ? 'active' : '' ?>" href="index.php?action=dashboard">
                <i class="bi bi-speedometer2 me-2"></i>Dashboard
            </a>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): // Simplified check ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'user') === 0) ? 'active' : '' ?>" href="index.php?action=userList">
                <i class="bi bi-people me-2"></i>User Management
            </a>
            <?php endif; ?>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): // Simplified check, adapt for specific character permissions ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'character') === 0) ? 'active' : '' ?>" href="#!characters"> <!-- Placeholder Link -->
                <i class="bi bi-person-badge me-2"></i>Characters (TODO)
            </a>
            <?php endif; ?>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): // Simplified check, adapt for specific economy permissions ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'economy') === 0) ? 'active' : '' ?>" href="#!economy"> <!-- Placeholder Link -->
                <i class="bi bi-currency-dollar me-2"></i>Economy (TODO)
            </a>
            <?php endif; ?>

            <!-- Example Dropdown (from PHP_BOOTSTRAP_IMPLEMENTATION.md) -->
            <div class="list-group-item list-group-item-dark p-0">
                <a href="#inventorySubmenu" data-bs-toggle="collapse" aria-expanded="false" class="list-group-item list-group-item-action list-group-item-dark p-3 dropdown-toggle">
                    <i class="bi bi-box me-2"></i>Inventory (TODO)
                </a>
                <ul class="collapse list-unstyled" id="inventorySubmenu">
                    <li>
                        <a href="#!" class="list-group-item list-group-item-action list-group-item-dark p-3 ps-5">Items Database</a>
                    </li>
                    <li>
                        <a href="#!" class="list-group-item list-group-item-action list-group-item-dark p-3 ps-5">Crafted Items</a>
                    </li>
                </ul>
            </div>

            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= ($currentAction == 'settings') ? 'active' : '' ?>" href="#!settings"> <!-- Placeholder Link -->
                <i class="bi bi-gear me-2"></i>Settings (TODO)
            </a>
        <?php else: ?>
             <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= ($currentAction == 'showLogin') ? 'active' : '' ?>" href="index.php?action=showLogin">
                <i class="bi bi-box-arrow-in-right me-2"></i>Login
            </a>
        <?php endif; ?>
    </div>
</div>
