<?php
// app/Views/items/index.php
// View data expected from ItemController::index() via $GLOBALS['viewData']
if (!isset($items) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "Item Database";
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-6">
            <h1><?= htmlspecialchars($pageTitle) ?></h1>
        </div>
        <div class="col-md-6 text-md-end">
            <!-- Placeholder for Add New Item button if CRUD for items is implemented -->
            <!-- <a href="index.php?action=itemCreate" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Add New Item
            </a> -->
            <span class="text-muted fst-italic">Full item CRUD to be implemented later.</span>
        </div>
    </div>

    <!-- Search Form -->
    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="itemList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by Label, Item Code, or Description..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Item Code (Name)</th>
                            <th>Label</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Group</th>
                            <th>Limit</th>
                            <th>Weight</th>
                            <th>Usable</th>
                            <th>Removable</th>
                            <!-- <th>Actions</th> --> <!-- For future Edit/Delete -->
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($items)): ?>
                            <?php foreach ($items as $item): ?>
                                <tr>
                                    <td><?= htmlspecialchars($item['id']) ?></td>
                                    <td><?= htmlspecialchars($item['item']) ?></td>
                                    <td><?= htmlspecialchars($item['label']) ?></td>
                                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="<?= htmlspecialchars($item['desc']) ?>">
                                        <?= htmlspecialchars($item['desc']) ?>
                                    </td>
                                    <td><?= htmlspecialchars($item['type'] ?? 'N/A') ?></td>
                                    <td><?= htmlspecialchars($item['groupName'] ?? 'N/A') ?></td>
                                    <td><?= htmlspecialchars($item['limit']) ?></td>
                                    <td><?= htmlspecialchars($item['weight'] ?? 'N/A') ?></td>
                                    <td><?= ($item['usable'] ?? 0) ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td>
                                    <td><?= ($item['can_remove'] ?? 0) ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td>
                                    <!-- <td>
                                        <a href="#" class="btn btn-sm btn-outline-primary me-1 disabled" title="Edit (TODO)">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="#" class="btn btn-sm btn-outline-danger disabled" title="Delete (TODO)">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td> -->
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="10" class="text-center">No items found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=itemList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>

            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=itemList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>

            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=itemList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
