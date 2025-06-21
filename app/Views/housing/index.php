<?php
// app/Views/housing/index.php
if (!isset($houses) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "Housing Management";
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-6">
            <h1><?= htmlspecialchars($pageTitle) ?></h1>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="index.php?action=housingCreate" class="btn btn-primary">
                <i class="bi bi-house-add-fill"></i> Add New House
            </a>
        </div>
    </div>

    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="housingList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by House ID, Owner CharID/Name, Unique Name..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>House ID</th>
                            <th>Unique Name</th>
                            <th>Owner CharID</th>
                            <th>Owner Name</th>
                            <th>Status</th>
                            <th>Ledger</th>
                            <th>Tax Amount</th>
                            <th>Taxes Collected?</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($houses)): ?>
                            <?php foreach ($houses as $house): ?>
                                <tr>
                                    <td><?= htmlspecialchars($house['houseid']) ?></td>
                                    <td><?= htmlspecialchars($house['uniqueName']) ?></td>
                                    <td><?= htmlspecialchars($house['charidentifier']) ?></td>
                                    <td><?= htmlspecialchars(($house['owner_firstname'] ?? '') . ' ' . ($house['owner_lastname'] ?? 'N/A')) ?></td>
                                    <td><?= htmlspecialchars($house['ownershipStatus']) ?></td>
                                    <td>$<?= number_format($house['ledger'] ?? 0, 2) ?></td>
                                    <td>$<?= number_format($house['tax_amount'] ?? 0, 2) ?></td>
                                    <td><?= ($house['taxes_collected'] == 'true' || $house['taxes_collected'] == 1) ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-danger">No</span>' ?></td>
                                    <td>
                                        <a href="index.php?action=housingView&id=<?= urlencode($house['houseid']) ?>" class="btn btn-sm btn-outline-info me-1" title="View">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                        <a href="index.php?action=housingEdit&id=<?= urlencode($house['houseid']) ?>" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="index.php?action=housingDelete&id=<?= urlencode($house['houseid']) ?>" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this house (ID: <?= htmlspecialchars($house['houseid']) ?>)? This is a permanent action.');">
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
                                <td colspan="9" class="text-center">No houses found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=housingList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=housingList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>
            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=housingList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
