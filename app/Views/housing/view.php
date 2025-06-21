<?php
// app/Views/housing/view.php
if (!isset($house) && isset($viewData)) extract($viewData);
$pageTitle = $GLOBALS['pageTitle'] ?? "View House";

// Helper for displaying JSON data nicely
if (!function_exists('printJsonКрасивоHousing')) { // Avoid re-declaration if already in another view
    function printJsonКрасивоHousing($jsonString) {
        $data = json_decode($jsonString, true);
        if (json_last_error() === JSON_ERROR_NONE && (is_array($data) || is_object($data)) && !empty($data)) {
            return '<pre class="bg-light p-2 rounded" style="font-size: 0.85em; max-height: 200px; overflow-y: auto;">' . htmlspecialchars(json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)) . '</pre>';
        }
        return '<span class="text-muted">' . htmlspecialchars($jsonString ?: '(empty)') . '</span>';
    }
}
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?></h1>
        <div>
            <a href="index.php?action=housingEdit&id=<?= urlencode($house['houseid']) ?>" class="btn btn-primary me-2">
                <i class="bi bi-pencil-square"></i> Edit House
            </a>
            <a href="index.php?action=housingList" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to List
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">House Details: <?= htmlspecialchars($house['uniqueName'] ?: ('ID ' . $house['houseid'])) ?></h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>Core Information</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">House ID:</th><td><?= htmlspecialchars($house['houseid']) ?></td></tr>
                        <tr><th>Unique Name:</th><td><?= htmlspecialchars($house['uniqueName']) ?></td></tr>
                        <tr><th>Owner CharID:</th><td><?= htmlspecialchars($house['charidentifier']) ?></td></tr>
                        <?php if (isset($ownerCharacter) && $ownerCharacter): ?>
                        <tr><th>Owner Name:</th><td><?= htmlspecialchars($ownerCharacter['firstname'] . ' ' . $ownerCharacter['lastname']) ?></td></tr>
                        <?php endif; ?>
                        <tr><th>Ownership Status:</th><td><span class="badge bg-info"><?= htmlspecialchars($house['ownershipStatus']) ?></span></td></tr>
                        <tr><th>Inventory Limit:</th><td><?= htmlspecialchars($house['invlimit']) ?> slots</td></tr>
                    </table>

                    <h5 class="mt-3">Financials</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">Ledger Balance:</th><td>$<?= number_format($house['ledger'] ?? 0, 2) ?></td></tr>
                        <tr><th>Tax Amount:</th><td>$<?= number_format($house['tax_amount'] ?? 0, 2) ?></td></tr>
                        <tr><th>Taxes Collected:</th><td><?= ($house['taxes_collected'] == 'true' || $house['taxes_collected'] == 1) ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-danger">No</span>' ?></td></tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <h5>Location & Access</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">Coordinates:</th><td><?= printJsonКрасивоHousing($house['house_coords']) ?></td></tr>
                        <tr><th>Radius Limit:</th><td><?= htmlspecialchars($house['house_radius_limit']) ?></td></tr>
                        <tr><th>Teleport Interior ID:</th><td><?= htmlspecialchars($house['tpInt'] ?? 'N/A') ?></td></tr>
                        <tr><th>Teleport Instance:</th><td><?= htmlspecialchars($house['tpInstance'] ?? 'N/A') ?></td></tr>
                        <tr><th>Allowed IDs:</th><td><?= printJsonКрасивоHousing($house['allowed_ids']) ?></td></tr>
                    </table>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <h5>Furniture & Doors</h5>
                    <p class="mb-1"><strong>Furniture Data (JSON):</strong></p>
                    <?= printJsonКрасивоHousing($house['furniture']) ?>
                    <p class="mt-2 mb-1"><strong>Doors Data (JSON):</strong></p>
                    <?= printJsonКрасивоHousing($house['doors']) ?>
                </div>
                <div class="col-md-6">
                    <h5>Other Data</h5>
                     <p class="mb-1"><strong>Player Source Spawned Furniture:</strong></p>
                    <p><?= htmlspecialchars($house['player_source_spawnedfurn'] ?? 'N/A') ?></p>
                    <!-- Add other fields if necessary -->
                </div>
            </div>

            <!-- Placeholder for future linked data, e.g., transactions, hotel rooms -->
            <div class="mt-4">
                <h6>Related Data (Placeholders)</h6>
                <ul class="list-group">
                    <li class="list-group-item">View Transactions (TODO)</li>
                    <li class="list-group-item">Manage Hotel Rooms (if applicable) (TODO)</li>
                </ul>
            </div>
        </div>
    </div>
</div>
