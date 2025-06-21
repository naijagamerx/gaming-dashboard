<?php
// app/Views/users/create.php
// This view will be included by a layout file eventually.
// For now, assume $authService is available for CSRF token.

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$csrfToken = $_SESSION['csrf_token'] ?? '';
$formData = $_SESSION['form_data'] ?? [];
unset($_SESSION['form_data']);

$pageTitle = "Create New User";
ob_start();
?>

<div class="container mt-4">
    <h1>Create New User</h1>

    <?php if (isset($_SESSION['error_message'])): ?>
        <div class="alert alert-danger">
            <?= htmlspecialchars($_SESSION['error_message']); ?>
        </div>
        <?php unset($_SESSION['error_message']); ?>
    <?php endif; ?>

    <form action="index.php?action=userStore" method="POST">
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken); ?>">

        <div class="mb-3">
            <label for="identifier" class="form-label">Identifier (Steam ID)</label>
            <input type="text" class="form-control" id="identifier" name="identifier" value="<?= htmlspecialchars($formData['identifier'] ?? '') ?>" required>
            <div class="form-text">This is typically the user's Steam ID (e.g., steam:xxxxxxxxxxxxxxxxx). It is the primary key and cannot be changed after creation.</div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="form-text">Choose a strong password.</div>
        </div>

        <div class="mb-3">
            <label for="group" class="form-label">Group</label>
            <select class="form-select" id="group" name="group">
                <option value="user" <?= (isset($formData['group']) && $formData['group'] == 'user') ? 'selected' : '' ?>>User</option>
                <option value="admin" <?= (isset($formData['group']) && $formData['group'] == 'admin') ? 'selected' : '' ?>>Admin</option>
                <option value="super_admin" <?= (isset($formData['group']) && $formData['group'] == 'super_admin') ? 'selected' : '' ?>>Super Admin</option>
                <!-- Add other roles as defined in your system -->
            </select>
        </div>

        <div class="mb-3">
            <label for="warnings" class="form-label">Warnings</label>
            <input type="number" class="form-control" id="warnings" name="warnings" value="<?= htmlspecialchars($formData['warnings'] ?? 0) ?>" min="0">
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="banned" name="banned" value="1" <?= (isset($formData['banned']) && $formData['banned']) ? 'checked' : '' ?>>
            <label class="form-check-label" for="banned">Banned</label>
        </div>

        <div class="mb-3">
            <label for="banneduntil" class="form-label">Banned Until (Timestamp or 0)</label>
            <input type="number" class="form-control" id="banneduntil" name="banneduntil" value="<?= htmlspecialchars($formData['banneduntil'] ?? 0) ?>" min="0">
             <div class="form-text">Unix timestamp for when the ban expires. Use 0 for permanent or if not banned.</div>
        </div>

        <div class="mb-3">
            <label for="char" class="form-label">Character Slots</label>
            <input type="number" class="form-control" id="char" name="char" value="<?= htmlspecialchars($formData['char'] ?? 5) ?>" min="0">
        </div>

        <button type="submit" class="btn btn-primary">Create User</button>
        <a href="index.php?action=userList" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<?php
$content = ob_get_clean();
// If using a layout system, this $content would be injected into it.
// require_once __DIR__ . '/../layouts/main.php'; // Assuming main.php expects $content
?>
