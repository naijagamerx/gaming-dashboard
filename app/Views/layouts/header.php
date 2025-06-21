<?php
// app/Views/layouts/header.php
// Assumes $authService is available, or session directly checked.
$isLoggedIn = $_SESSION['user_id'] ?? false;
$username = $_SESSION['user_id'] ?? 'Guest'; // Replace with actual username if available
$userGroup = $_SESSION['user_group'] ?? 'N/A';

?>
<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
    <div class="container-fluid">
        <button class="btn btn-primary btn-sm" id="sidebarToggle"><i class="bi bi-list"></i></button>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                <?php if ($isLoggedIn): ?>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle"></i> <?= htmlspecialchars($username) ?> (<?= htmlspecialchars($userGroup) ?>)
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#!">Profile (TODO)</a></li>
                            <li><a class="dropdown-item" href="#!">Settings (TODO)</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="index.php?action=logout">Logout</a></li>
                        </ul>
                    </li>
                <?php else: ?>
                    <li class="nav-item">
                        <a class="nav-link" href="index.php?action=showLogin">Login</a>
                    </li>
                <?php endif; ?>
                 <li class="nav-item">
                    <button class="btn btn-link nav-link" id="themeToggleBtn" title="Toggle theme">
                        <i class="bi <?= ($_SESSION['theme'] ?? 'light') == 'light' ? 'bi-moon-stars-fill' : 'bi-sun-fill' ?>"></i>
                    </button>
                </li>
            </ul>
        </div>
    </div>
</nav>
