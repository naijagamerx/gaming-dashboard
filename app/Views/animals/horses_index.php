<?php
// app/Views/animals/horses_index.php
if (!isset($horses) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "Player Horse Management";
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-6">
            <h1><?= htmlspecialchars($pageTitle) ?></h1>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="index.php?action=horseCreate" class="btn btn-primary">
                <i class="bi bi-plus-circle-dotted"></i> Add New Horse
            </a>
        </div>
    </div>

    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="horseList">
        <div class="row g-2">
            <div class="col-md-4">
                <input type="text" name="search" class="form-control" placeholder="Search Horse Name/Model, Owner Name/SteamID..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            </div>
            <div class="col-md-3">
                <input type="text" name="charid" class="form-control" placeholder="Filter by Owner CharID..." value="<?= htmlspecialchars($charIdFilter ?? '') ?>">
            </div>
             <div class="col-md-3">
                <input type="text" name="identifier" class="form-control" placeholder="Filter by Owner SteamID..." value="<?= htmlspecialchars($userIdentifierFilter ?? '') ?>">
            </div>
            <div class="col-md-2">
                <button class="btn btn-outline-secondary w-100" type="submit"><i class="bi bi-search"></i> Filter/Search</button>
            </div>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Model</th>
                            <th>Owner CharID</th>
                            <th>Owner Name</th>
                            <th>Owner SteamID</th>
                            <th>Gender</th>
                            <th>XP</th>
                            <th>Health</th>
                            <th>Stamina</th>
                            <th>Selected</th>
                            <th>Dead</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($horses)): ?>
                            <?php foreach ($horses as $horse): ?>
                                <tr>
                                    <td><?= htmlspecialchars($horse['id']) ?></td>
                                    <td><?= htmlspecialchars($horse['name']) ?></td>
                                    <td><?= htmlspecialchars($horse['model']) ?></td>
                                    <td><?= htmlspecialchars($horse['charid']) ?></td>
                                    <td><?= htmlspecialchars(($horse['owner_firstname'] ?? '') . ' ' . ($horse['owner_lastname'] ?? 'N/A')) ?></td>
                                    <td><?= htmlspecialchars($horse['owner_steamid'] ?? 'N/A') ?></td>
                                    <td><?= ucfirst(htmlspecialchars($horse['gender'])) ?></td>
                                    <td><?= htmlspecialchars($horse['xp']) ?></td>
                                    <td><?= htmlspecialchars($horse['health']) ?></td>
                                    <td><?= htmlspecialchars($horse['stamina']) ?></td>
                                    <td><?= $horse['selected'] ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td>
                                    <td><?= $horse['dead'] ? '<span class="badge bg-danger">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td>
                                    <td>
                                        <a href="index.php?action=horseView&id=<?= urlencode($horse['id']) ?>" class="btn btn-sm btn-outline-info me-1" title="View">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                        <a href="index.php?action=horseEdit&id=<?= urlencode($horse['id']) ?>" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="index.php?action=horseDelete&id=<?= urlencode($horse['id']) ?>" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this horse (<?= htmlspecialchars($horse['name']) ?> - ID: <?= htmlspecialchars($horse['id']) ?>)?');">
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
                                <td colspan="13" class="text-center">No player horses found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=horseList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>&charid=<?= urlencode($charIdFilter ?? '') ?>&identifier=<?= urlencode($userIdentifierFilter ?? '') ?>">Previous</a></li>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=horseList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>&charid=<?= urlencode($charIdFilter ?? '') ?>&identifier=<?= urlencode($userIdentifierFilter ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>
            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=horseList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>&charid=<?= urlencode($charIdFilter ?? '') ?>&identifier=<?= urlencode($userIdentifierFilter ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
