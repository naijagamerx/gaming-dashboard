<?php
// app/Views/animals/horse_view.php
if (!isset($horse) && isset($viewData)) extract($viewData); // $horse, $ownerCharacter, $csrfToken
$pageTitle = $GLOBALS['pageTitle'] ?? "View Player Horse";

if (!function_exists('printJsonКрасивоAnimal')) { // Avoid re-declaration
    function printJsonКрасивоAnimal($jsonString) {
        $data = json_decode($jsonString, true);
        if (json_last_error() === JSON_ERROR_NONE && (is_array($data) || is_object($data)) && !empty($data)) {
            return '<pre class="bg-light p-2 rounded" style="font-size: 0.85em; max-height: 150px; overflow-y: auto;">' . htmlspecialchars(json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)) . '</pre>';
        }
        return '<span class="text-muted">' . htmlspecialchars($jsonString ?: '(empty)') . '</span>';
    }
}
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?></h1>
        <div>
            <a href="index.php?action=horseEdit&id=<?= urlencode($horse['id']) ?>" class="btn btn-primary me-2">
                <i class="bi bi-pencil-square"></i> Edit Horse
            </a>
            <a href="index.php?action=horseList" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to Horse List
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">Horse Details: <?= htmlspecialchars($horse['name']) ?> (ID: <?= htmlspecialchars($horse['id']) ?>)</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>General Information</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">Name:</th><td><?= htmlspecialchars($horse['name']) ?></td></tr>
                        <tr><th>Model:</th><td><?= htmlspecialchars($horse['model']) ?></td></tr>
                        <tr><th>Gender:</th><td><?= ucfirst(htmlspecialchars($horse['gender'])) ?></td></tr>
                        <tr><th>Owner CharID:</th><td><?= htmlspecialchars($horse['charid']) ?></td></tr>
                        <?php if (isset($ownerCharacter) && $ownerCharacter): ?>
                        <tr><th>Owner Name:</th><td><?= htmlspecialchars($ownerCharacter['firstname'] . ' ' . $ownerCharacter['lastname']) ?></td></tr>
                        <tr><th>Owner SteamID:</th><td><?= htmlspecialchars($ownerCharacter['identifier']) ?></td></tr>
                        <?php else: ?>
                        <tr><th>Owner Info:</th><td><span class="text-muted">Character details not found.</span></td></tr>
                        <?php endif; ?>
                        <tr><th>User SteamID (on horse record):</th><td><?= htmlspecialchars($horse['identifier']) ?></td></tr>
                         <tr><th>Born/Acquired:</th><td><?= htmlspecialchars($horse['born'] ? date('Y-m-d H:i:s', strtotime($horse['born'])) : 'N/A') ?></td></tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <h5>Stats & Status</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">XP:</th><td><?= htmlspecialchars($horse['xp']) ?></td></tr>
                        <tr><th>Health:</th><td><?= htmlspecialchars($horse['health']) ?></td></tr>
                        <tr><th>Stamina:</th><td><?= htmlspecialchars($horse['stamina']) ?></td></tr>
                        <tr><th>Selected:</th><td><?= $horse['selected'] ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td></tr>
                        <tr><th>Dead:</th><td><?= $horse['dead'] ? '<span class="badge bg-danger">Yes</span>' : '<span class="badge bg-secondary">No</span>' ?></td></tr>
                        <tr><th>Captured:</th><td><?= $horse['captured'] ? '<span class="badge bg-info">Yes</span>' : '<span class="badge bg-light text-dark">No (Wild?)</span>' ?></td></tr>
                        <tr><th>Writhe Status:</th><td><?= htmlspecialchars($horse['writhe']) ?></td></tr>
                    </table>
                </div>
            </div>
            <hr>
            <h5>Components & Appearance (JSON)</h5>
            <?= printJsonКрасивоAnimal($horse['components']) ?>

            <!-- Placeholder for horse_complements data if needed later -->
            <div class="mt-3">
                <h6>Equipment / Complements (TODO)</h6>
                <p class="text-muted">Detailed equipment from `horse_complements` table can be listed here.</p>
            </div>
        </div>
    </div>
</div>
