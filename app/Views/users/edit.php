<?php
// app/Views/users/edit.php
// This view will be included by a layout file eventually.
// For now, assume $authService is available for CSRF token.
// And $user is passed by UserController::edit()

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$csrfToken = $_SESSION['csrf_token'] ?? '';

$pageTitle = "Edit User: " . htmlspecialchars($user['identifier']);
ob_start();
?>

<div class="container mt-4">
    <h1>Edit User: <small class="text-muted"><?= htmlspecialchars($user['identifier']) ?></small></h1>

    <?php if (isset($_SESSION['error_message'])): ?>
        <div class="alert alert-danger">
            <?= htmlspecialchars($_SESSION['error_message']); ?>
        </div>
        <?php unset($_SESSION['error_message']); ?>
    <?php endif; ?>

    <form action="index.php?action=userUpdate&identifier=<?= urlencode($user['identifier']) ?>" method="POST">
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken); ?>">

        <div class="mb-3">
            <label for="identifier" class="form-label">Identifier (Steam ID)</label>
            <input type="text" class="form-control" id="identifier" name="identifier_display" value="<?= htmlspecialchars($user['identifier']) ?>" readonly disabled>
            <div class="form-text">The user identifier (primary key) cannot be changed.</div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">New Password (optional)</label>
            <input type="password" class="form-control" id="password" name="password">
            <div class="form-text">Leave blank to keep the current password.</div>
        </div>

        <div class="mb-3">
            <label for="group" class="form-label">Group</label>
            <select class="form-select" id="group" name="group">
                <option value="user" <?= ($user['group'] == 'user') ? 'selected' : '' ?>>User</option>
                <option value="admin" <?= ($user['group'] == 'admin') ? 'selected' : '' ?>>Admin</option>
                <option value="super_admin" <?= ($user['group'] == 'super_admin') ? 'selected' : '' ?>>Super Admin</option>
                <!-- Add other roles as defined in your system -->
            </select>
        </div>

        <div class="mb-3">
            <label for="warnings" class="form-label">Warnings</label>
            <input type="number" class="form-control" id="warnings" name="warnings" value="<?= htmlspecialchars($user['warnings']) ?>" min="0">
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="banned" name="banned" value="1" <?= ($user['banned'] ?? 0) ? 'checked' : '' ?>>
            <label class="form-check-label" for="banned">Banned</label>
        </div>

        <div class="mb-3">
            <label for="banneduntil" class="form-label">Banned Until (Timestamp or 0)</label>
            <input type="number" class="form-control" id="banneduntil" name="banneduntil" value="<?= htmlspecialchars($user['banneduntil'] ?? 0) ?>" min="0">
            <div class="form-text">Unix timestamp for when the ban expires. Use 0 for permanent or if not banned. Current: <?= $user['banneduntil'] ? date('Y-m-d H:i:s', $user['banneduntil']) : 'N/A' ?></div>
        </div>

        <div class="mb-3">
            <label for="char" class="form-label">Character Slots</label>
            <input type="number" class="form-control" id="char" name="char" value="<?= htmlspecialchars($user['char']) ?>" min="0">
        </div>

        <button type="submit" class="btn btn-primary">Update User</button>
        <a href="index.php?action=userList" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<?php
$content = ob_get_clean();
// If using a layout system, this $content would be injected into it.
// require_once __DIR__ . '/../layouts/main.php'; // Assuming main.php expects $content and $pageTitle
?>
