<?php
// app/Views/characters/index.php
// View data expected from CharacterController::index() via $GLOBALS['viewData']
// extract($GLOBALS['viewData']);
// $characters, $totalPages, $currentPage, $searchTerm, $userIdentifierFilter, $csrfToken

// Fallback if not using $GLOBALS approach and view is directly included/required
if (!isset($characters) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "Character Management"; // Set by controller
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-6">
            <h1><?= htmlspecialchars($pageTitle) ?></h1>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="index.php?action=characterCreate" class="btn btn-primary">
                <i class="bi bi-person-plus-fill"></i> Add New Character
            </a>
        </div>
    </div>

    <!-- Search and Filter Form -->
    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="characterList">
        <div class="row g-2">
            <div class="col-md-5">
                <input type="text" name="search" class="form-control" placeholder="Search Name, CharID, Steam Name..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            </div>
            <div class="col-md-5">
                <input type="text" name="user_identifier" class="form-control" placeholder="Filter by User SteamID..." value="<?= htmlspecialchars($userIdentifierFilter ?? '') ?>">
            </div>
            <div class="col-md-2">
                <button class="btn btn-outline-secondary w-100" type="submit"><i class="bi bi-search"></i> Filter / Search</button>
            </div>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Char ID</th>
                            <th>Owner (SteamID)</th>
                            <th>Steam Name</th>
                            <th>Full Name</th>
                            <th>Job</th>
                            <th>Money</th>
                            <th>Gold</th>
                            <th>XP</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($characters)): ?>
                            <?php foreach ($characters as $char): ?>
                                <tr>
                                    <td><?= htmlspecialchars($char['charidentifier']) ?></td>
                                    <td><?= htmlspecialchars($char['identifier']) ?></td>
                                    <td><?= htmlspecialchars($char['steamname']) ?></td>
                                    <td><?= htmlspecialchars($char['firstname'] . ' ' . $char['lastname']) ?></td>
                                    <td><?= htmlspecialchars($char['joblabel'] ?? $char['job']) ?></td>
                                    <td>$<?= number_format($char['money'] ?? 0, 2) ?></td>
                                    <td><?= number_format($char['gold'] ?? 0, 2) ?> G</td>
                                    <td><?= htmlspecialchars($char['xp'] ?? 0) ?></td>
                                    <td>
                                        <a href="index.php?action=characterView&charidentifier=<?= urlencode($char['charidentifier']) ?>" class="btn btn-sm btn-outline-info me-1" title="View">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                        <a href="index.php?action=characterEdit&charidentifier=<?= urlencode($char['charidentifier']) ?>" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="index.php?action=characterDelete&charidentifier=<?= urlencode($char['charidentifier']) ?>" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this character? This action cannot be undone.');">
                                            <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="9" class="text-center">No characters found.</td>
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
            <?php if ($currentPage > 1): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=characterList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>&user_identifier=<?= urlencode($userIdentifierFilter ?? '') ?>">Previous</a></li>
            <?php endif; ?>

            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=characterList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>&user_identifier=<?= urlencode($userIdentifierFilter ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>

            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=characterList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>&user_identifier=<?= urlencode($userIdentifierFilter ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
