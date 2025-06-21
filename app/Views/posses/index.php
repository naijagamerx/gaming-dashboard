<?php
// app/Views/posses/index.php
if (!isset($posses) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "Posse Management";
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-8">
            <h1><?= htmlspecialchars($pageTitle) ?> <small class="text-muted fs-5">(Admin View)</small></h1>
        </div>
        <!-- Optional: Add New Posse button if create functionality is added -->
        <!-- <div class="col-md-4 text-md-end">
            <a href="index.php?action=posseCreate" class="btn btn-primary">
                <i class="bi bi-people-fill"></i> Create New Posse (TODO)
            </a>
        </div> -->
    </div>

    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="posseList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by Posse Name, Leader CharID/SteamID, Leader Name..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>Posse ID</th>
                            <th>Posse Name</th>
                            <th>Leader CharID</th>
                            <th>Leader Name</th>
                            <th>Leader SteamID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($posses)): ?>
                            <?php foreach ($posses as $posse): ?>
                                <tr>
                                    <td><?= htmlspecialchars($posse['id']) ?></td>
                                    <td><?= htmlspecialchars($posse['possename']) ?></td>
                                    <td><?= htmlspecialchars($posse['characterid']) ?></td>
                                    <td><?= htmlspecialchars(($posse['leader_firstname'] ?? '') . ' ' . ($posse['leader_lastname'] ?? 'N/A')) ?></td>
                                    <td><?= htmlspecialchars($posse['identifier']) ?></td>
                                    <td>
                                        <a href="index.php?action=posseView&id=<?= urlencode($posse['id']) ?>" class="btn btn-sm btn-outline-info me-1" title="View Details">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                        <!-- Edit/Delete actions for posses would be complex and are placeholders -->
                                        <!--
                                        <a href="index.php?action=posseEdit&id=<?= urlencode($posse['id']) ?>" class="btn btn-sm btn-outline-primary me-1 disabled" title="Edit (TODO)">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="index.php?action=posseDelete&id=<?= urlencode($posse['id']) ?>" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure? This might affect character posse memberships.');">
                                            <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger disabled" title="Delete (TODO)">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                        -->
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="6" class="text-center">No posses found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=posseList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=posseList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>
            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=posseList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
