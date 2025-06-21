<?php
// app/Views/users/index.php
// This view will be included by a layout file eventually.
// For now, assume $authService is available for CSRF token.
// And $users, $totalPages, $page, $searchTerm are passed by UserController::index()

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$csrfToken = $_SESSION['csrf_token'] ?? ''; // Should be set by AuthService or controller

// Basic structure, assuming it will be wrapped by a main layout
$pageTitle = "User Management";
ob_start();
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-6">
            <h1>User Management</h1>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="index.php?action=userCreate" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Add New User
            </a>
        </div>
    </div>

    <?php if (isset($_SESSION['success_message'])): ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <?= htmlspecialchars($_SESSION['success_message']); ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <?php unset($_SESSION['success_message']); ?>
    <?php endif; ?>

    <?php if (isset($_SESSION['error_message'])): ?>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <?= htmlspecialchars($_SESSION['error_message']); ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <?php unset($_SESSION['error_message']); ?>
    <?php endif; ?>

    <!-- Search Form -->
    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="userList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by Identifier or Group..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Identifier (Steam ID)</th>
                            <th>Group</th>
                            <th>Warnings</th>
                            <th>Banned</th>
                            <th>Ban Expires</th>
                            <th>Char Slots</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($users)): ?>
                            <?php foreach ($users as $user): ?>
                                <tr>
                                    <td><?= htmlspecialchars($user['identifier']) ?></td>
                                    <td><?= htmlspecialchars($user['group']) ?></td>
                                    <td><?= htmlspecialchars($user['warnings']) ?></td>
                                    <td><?= $user['banned'] ? '<span class="badge bg-danger">Yes</span>' : '<span class="badge bg-success">No</span>' ?></td>
                                    <td><?= $user['banneduntil'] ? date('Y-m-d H:i:s', $user['banneduntil']) : 'N/A' ?></td>
                                    <td><?= htmlspecialchars($user['char']) ?></td>
                                    <td>
                                        <a href="index.php?action=userEdit&identifier=<?= urlencode($user['identifier']) ?>" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="index.php?action=userDelete&identifier=<?= urlencode($user['identifier']) ?>" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                            <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken); ?>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="7" class="text-center">No users found.</td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <?php if ($totalPages > 1): ?>
    <nav aria-label="Page navigation" class="mt-3">
        <ul class="pagination justify-content-center">
            <?php if ($page > 1): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=userList&page=<?= $page - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>

            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $page) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=userList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>

            <?php if ($page < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=userList&page=<?= $page + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>

</div>

<?php
$content = ob_get_clean();
// If using a layout system, this $content would be injected into it.
// For standalone testing, you might need to include header/footer manually or echo $content.
// For now, we'll assume this will be included by a main layout file.
// echo $content; // Or: require_once __DIR__ . '/../layouts/main.php'; (if main.php expects $content)
?>
