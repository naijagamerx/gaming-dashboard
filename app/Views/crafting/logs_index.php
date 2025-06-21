<?php
// app/Views/crafting/logs_index.php
if (!isset($logs) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "Crafting Logs";
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-8">
            <h1><?= htmlspecialchars($pageTitle) ?> <small class="text-muted fs-5">(Admin View)</small></h1>
        </div>
        <!-- Optional: Add log export or other actions here -->
    </div>

    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="craftingLogList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by CharID, Item Name/Label, Owner Name..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>Log ID</th>
                            <th>Timestamp</th>
                            <th>Character ID</th>
                            <th>Character Name</th>
                            <th>Item Name</th>
                            <th>Item Label</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Duration (s)</th>
                            <th>XP Reward</th>
                            <!-- <th>Required Items</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($logs)): ?>
                            <?php foreach ($logs as $log): ?>
                                <tr>
                                    <td><?= htmlspecialchars($log['id']) ?></td>
                                    <td><?= htmlspecialchars(date('Y-m-d H:i:s', $log['timestamp'])) ?></td>
                                    <td><?= htmlspecialchars($log['charidentifier']) ?></td>
                                    <td><?= htmlspecialchars(($log['char_firstname'] ?? '') . ' ' . ($log['char_lastname'] ?? 'N/A')) ?></td>
                                    <td><?= htmlspecialchars($log['itemName']) ?></td>
                                    <td><?= htmlspecialchars($log['itemLabel']) ?></td>
                                    <td><?= htmlspecialchars($log['itemAmount']) ?></td>
                                    <td><span class="badge bg-<?= $log['status'] == 'completed' ? 'success' : ($log['status'] == 'failed' ? 'danger' : 'secondary') ?>"><?= htmlspecialchars($log['status']) ?></span></td>
                                    <td><?= htmlspecialchars($log['duration']) ?></td>
                                    <td><?= htmlspecialchars($log['rewardXP']) ?></td>
                                    <!-- <td><pre style="font-size:0.8em; max-height: 50px; overflow-y:auto;"><?= htmlspecialchars($log['requiredItems']) ?></pre></td> -->
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="10" class="text-center">No crafting logs found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=craftingLogList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=craftingLogList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>
            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=craftingLogList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
