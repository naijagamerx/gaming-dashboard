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
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'userList') === 0 || strpos($currentAction, 'userCreate') === 0 || strpos($currentAction, 'userEdit') === 0) ? 'active' : '' ?>" href="index.php?action=userList">
                <i class="bi bi-people me-2"></i>User Management
            </a>
            <?php endif; ?>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): // Simplified check for now ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'characterList') === 0 || strpos($currentAction, 'characterCreate') === 0 || strpos($currentAction, 'characterEdit') === 0 || strpos($currentAction, 'characterView') === 0) ? 'active' : '' ?>" href="index.php?action=characterList">
                <i class="bi bi-person-badge me-2"></i>Character Management
            </a>
            <?php endif; ?>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'housingList') === 0 || strpos($currentAction, 'housingCreate') === 0 || strpos($currentAction, 'housingEdit') === 0 || strpos($currentAction, 'housingView') === 0) ? 'active' : '' ?>" href="index.php?action=housingList">
                <i class="bi bi-house-door-fill me-2"></i>Housing Management
            </a>
            <?php endif; ?>

            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'horseList') === 0 || strpos($currentAction, 'horseCreate') === 0 || strpos($currentAction, 'horseEdit') === 0 || strpos($currentAction, 'horseView') === 0) ? 'active' : '' ?>" href="index.php?action=horseList">
                <i class="bi bi-hearts me-2"></i>Animal Management
            </a>
            <?php endif; ?>

            <?php
            // Economy link: A character's economy is viewed via characterView -> economyView action.
            // Sidebar link could be for a general Economy Overview (admin) or admin tools.
            ?>
            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
                 <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'economyAdjustBalanceForm') === 0) ? 'active' : '' ?>" href="index.php?action=characterList&info=economyTools"> <!-- Link to char list, then pick char for tools -->
                    <i class="bi bi-currency-dollar me-2"></i>Economy Tools (Admin)
                </a>
            <?php endif; ?>

            <!-- Item/Inventory Management -->
            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
            <div class="list-group-item list-group-item-dark p-0">
                <a href="#itemManagementSubmenu" data-bs-toggle="collapse" aria-expanded="<?= (strpos($currentAction, 'itemList') === 0) ? 'true' : 'false' ?>" class="list-group-item list-group-item-action list-group-item-dark p-3 dropdown-toggle <?= (strpos($currentAction, 'itemList') === 0) ? 'active' : '' ?>">
                    <i class="bi bi-box-seam me-2"></i>Item Management
                </a>
                <ul class="collapse list-unstyled <?= (strpos($currentAction, 'itemList') === 0) ? 'show' : '' ?>" id="itemManagementSubmenu">
                    <li>
                        <a href="index.php?action=itemList" class="list-group-item list-group-item-action list-group-item-dark p-3 ps-5 <?= ($currentAction == 'itemList') ? 'active' : '' ?>">Items Database</a>
                    </li>
                    <!-- Future links: Create Item, Crafted Items, etc. -->
                </ul>
            </div>
            <?php endif; ?>

            <!-- Crafting Logs & Progress (Admin View) -->
            <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
            <div class="list-group-item list-group-item-dark p-0">
                <a href="#craftingManagementSubmenu" data-bs-toggle="collapse" aria-expanded="<?= (strpos($currentAction, 'craftingLogList') === 0 || strpos($currentAction, 'craftingProgressList') === 0) ? 'true' : 'false' ?>" class="list-group-item list-group-item-action list-group-item-dark p-3 dropdown-toggle <?= (strpos($currentAction, 'craftingLogList') === 0 || strpos($currentAction, 'craftingProgressList') === 0) ? 'active' : '' ?>">
                    <i class="bi bi-tools me-2"></i>Crafting Admin
                </a>
                <ul class="collapse list-unstyled <?= (strpos($currentAction, 'craftingLogList') === 0 || strpos($currentAction, 'craftingProgressList') === 0) ? 'show' : '' ?>" id="craftingManagementSubmenu">
                    <li>
                        <a href="index.php?action=craftingLogList" class="list-group-item list-group-item-action list-group-item-dark p-3 ps-5 <?= ($currentAction == 'craftingLogList') ? 'active' : '' ?>">Crafting Logs</a>
                    </li>
                     <li>
                        <a href="index.php?action=craftingProgressList" class="list-group-item list-group-item-action list-group-item-dark p-3 ps-5 <?= ($currentAction == 'craftingProgressList') ? 'active' : '' ?>">Crafting Progress</a>
                    </li>
                </ul>
            </div>
            <?php endif; ?>

            <!-- Posses (Admin View) -->
             <?php if ($authService->hasPermission('admin') || $authService->hasPermission('super_admin')): ?>
            <a class="list-group-item list-group-item-action list-group-item-dark p-3 <?= (strpos($currentAction, 'posseList') === 0) ? 'active' : '' ?>" href="index.php?action=posseList">
                <i class="bi bi-people-fill me-2"></i>Posse Management
            </a>
            <?php endif; ?>


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
