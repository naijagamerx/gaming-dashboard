<?php
// app/Views/crafting/progress_index.php
if (!isset($progressData) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "Crafting Progress";

if (!function_exists('printJsonКрасивоCrafting')) {
    function printJsonКрасивоCrafting($jsonString) {
        $data = json_decode($jsonString, true);
        if (json_last_error() === JSON_ERROR_NONE && (is_array($data) || is_object($data)) && !empty($data)) {
            return '<pre class="bg-light p-1 rounded" style="font-size: 0.8em; max-height: 100px; overflow-y: auto;">' . htmlspecialchars(json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)) . '</pre>';
        }
        return '<span class="text-muted">' . htmlspecialchars($jsonString ?: '(empty/not JSON)') . '</span>';
    }
}
?>

<div class="container-fluid mt-4">
    <div class="row mb-3">
        <div class="col-md-8">
            <h1><?= htmlspecialchars($pageTitle) ?> <small class="text-muted fs-5">(Admin View)</small></h1>
        </div>
        <!-- Optional actions here -->
    </div>

    <form action="index.php" method="GET" class="mb-3">
        <input type="hidden" name="action" value="craftingProgressList">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by CharID or Character Name..." value="<?= htmlspecialchars($searchTerm ?? '') ?>">
            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-sm">
                    <thead class="table-light">
                        <tr>
                            <th>Entry ID (if any)</th>
                            <th>Character ID</th>
                            <th>Character Name</th>
                            <th>General XP</th> <!-- Example column -->
                            <th>General Level</th> <!-- Example column -->
                            <th>Specific Skills (JSON)</th> <!-- Example column -->
                            <!-- Add other columns based on actual `bcc_craft_progress` schema -->
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($progressData)): ?>
                            <?php foreach ($progressData as $progress): ?>
                                <tr>
                                    <td><?= htmlspecialchars($progress['id'] ?? 'N/A') ?></td> <!-- Assuming 'id' is PK -->
                                    <td><?= htmlspecialchars($progress['charidentifier']) ?></td>
                                    <td><?= htmlspecialchars(($progress['char_firstname'] ?? '') . ' ' . ($progress['char_lastname'] ?? 'N/A')) ?></td>
                                    <td><?= htmlspecialchars($progress['general_xp'] ?? 'N/A') ?></td>
                                    <td><?= htmlspecialchars($progress['general_level'] ?? 'N/A') ?></td>
                                    <td><?= printJsonКрасивоCrafting($progress['specific_skills'] ?? ($progress['skills_json'] ?? '{}')) ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="6" class="text-center">No crafting progress data found.</td>
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
                <li class="page-item"><a class="page-link" href="index.php?action=craftingProgressList&page=<?= $currentPage - 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Previous</a></li>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= ($i == $currentPage) ? 'active' : '' ?>">
                    <a class="page-link" href="index.php?action=craftingProgressList&page=<?= $i ?>&search=<?= urlencode($searchTerm ?? '') ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>
            <?php if ($currentPage < $totalPages): ?>
                <li class="page-item"><a class="page-link" href="index.php?action=craftingProgressList&page=<?= $currentPage + 1 ?>&search=<?= urlencode($searchTerm ?? '') ?>">Next</a></li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
