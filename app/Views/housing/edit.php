<?php
// app/Views/housing/edit.php
if (!isset($house) && isset($viewData)) extract($viewData); // $house, $characters, $csrfToken, $formData
$pageTitle = $GLOBALS['pageTitle'] ?? "Edit House";
$currentData = $formData ?? $house; // Use $formData for repopulation if available, else current $house data
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?>: <small class="text-muted"><?= htmlspecialchars($house['uniqueName'] ?: ('ID ' . $house['houseid'])) ?></small></h1>

    <form action="index.php?action=housingUpdate&id=<?= urlencode($house['houseid']) ?>" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="card">
            <div class="card-header"><h5>Core House Information</h5></div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="uniqueName" class="form-label">Unique House Name</label>
                        <input type="text" class="form-control" id="uniqueName" name="uniqueName" value="<?= htmlspecialchars($currentData['uniqueName'] ?? '') ?>" required>
                        <div class="invalid-feedback">Unique house name is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="charidentifier" class="form-label">Owner Character ID</label>
                        <select class="form-select" id="charidentifier" name="charidentifier" required>
                            <option value="">Select Owner...</option>
                            <?php if (!empty($characters)): ?>
                                <?php foreach ($characters as $char): ?>
                                    <option value="<?= htmlspecialchars($char['charidentifier']) ?>" <?= (($currentData['charidentifier'] ?? '') == $char['charidentifier']) ? 'selected' : '' ?>>
                                        <?= htmlspecialchars($char['firstname'] . ' ' . $char['lastname'] . ' (ID: ' . $char['charidentifier'] . ', User: ' . $char['identifier'] . ')') ?>
                                    </option>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </select>
                        <div class="invalid-feedback">Please select an owner.</div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="house_coords" class="form-label">House Coordinates (JSON)</label>
                        <textarea class="form-control" id="house_coords" name="house_coords" rows="3" required><?= htmlspecialchars($currentData['house_coords'] ?? '{}') ?></textarea>
                        <div class="form-text">E.g., {"x":123.4,"y":56.7,"z":89.0}</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="house_radius_limit" class="form-label">House Radius Limit</label>
                        <input type="text" class="form-control" id="house_radius_limit" name="house_radius_limit" value="<?= htmlspecialchars($currentData['house_radius_limit'] ?? '50') ?>" required>
                    </div>
                </div>
                 <div class="col-md-6 mb-3">
                    <label for="ownershipStatus" class="form-label">Ownership Status</label>
                    <select class="form-select" id="ownershipStatus" name="ownershipStatus">
                        <option value="purchased" <?= (($currentData['ownershipStatus'] ?? '') == 'purchased') ? 'selected' : '' ?>>Purchased</option>
                        <option value="rented" <?= (($currentData['ownershipStatus'] ?? '') == 'rented') ? 'selected' : '' ?>>Rented</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="card mt-3">
            <div class="card-header"><h5>Financials & Limits</h5></div>
            <div class="card-body">
                 <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="invlimit" class="form-label">Inventory Limit</label>
                        <input type="text" class="form-control" id="invlimit" name="invlimit" value="<?= htmlspecialchars($currentData['invlimit'] ?? '200') ?>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="ledger" class="form-label">Ledger Balance</label>
                        <input type="number" step="0.01" class="form-control" id="ledger" name="ledger" value="<?= htmlspecialchars(number_format($currentData['ledger'] ?? 0.00, 2, '.', '')) ?>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="tax_amount" class="form-label">Tax Amount</label>
                        <input type="number" step="0.01" class="form-control" id="tax_amount" name="tax_amount" value="<?= htmlspecialchars(number_format($currentData['tax_amount'] ?? 0.00, 2, '.', '')) ?>">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="taxes_collected" class="form-label">Taxes Collected?</label>
                    <select class="form-select" id="taxes_collected" name="taxes_collected">
                        <option value="false" <?= (isset($currentData['taxes_collected']) && ($currentData['taxes_collected'] == 'false' || $currentData['taxes_collected'] == 0 || $currentData['taxes_collected'] == '')) ? 'selected' : '' ?>>No</option>
                        <option value="true" <?= (isset($currentData['taxes_collected']) && ($currentData['taxes_collected'] == 'true' || $currentData['taxes_collected'] == 1)) ? 'selected' : '' ?>>Yes</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="card mt-3">
            <div class="card-header"><h5>Advanced Data (JSON)</h5></div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="furniture" class="form-label">Furniture (JSON)</label>
                        <textarea class="form-control" id="furniture" name="furniture" rows="4"><?= htmlspecialchars($currentData['furniture'] ?? '{}') ?></textarea>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="doors" class="form-label">Doors (JSON)</label>
                        <textarea class="form-control" id="doors" name="doors" rows="4"><?= htmlspecialchars($currentData['doors'] ?? '{}') ?></textarea>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="allowed_ids" class="form-label">Allowed IDs (JSON Array)</label>
                        <textarea class="form-control" id="allowed_ids" name="allowed_ids" rows="4"><?= htmlspecialchars($currentData['allowed_ids'] ?? '[]') ?></textarea>
                        <div class="form-text">E.g., ["charid1", "steam:xxxx"]</div>
                    </div>
                </div>
                 <div class="row mt-2">
                    <div class="col-md-4 mb-3">
                        <label for="tpInt" class="form-label">Teleport Interior ID</label>
                        <input type="number" class="form-control" id="tpInt" name="tpInt" value="<?= htmlspecialchars($currentData['tpInt'] ?? 0) ?>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="tpInstance" class="form-label">Teleport Instance</label>
                        <input type="number" class="form-control" id="tpInstance" name="tpInstance" value="<?= htmlspecialchars($currentData['tpInstance'] ?? 0) ?>">
                    </div>
                     <div class="col-md-4 mb-3">
                        <label for="player_source_spawnedfurn" class="form-label">Player Source Spawned Furniture</label>
                        <input type="text" class="form-control" id="player_source_spawnedfurn" name="player_source_spawnedfurn" value="<?= htmlspecialchars($currentData['player_source_spawnedfurn'] ?? 'none') ?>">
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Update House
            </button>
            <a href="index.php?action=housingView&id=<?= urlencode($house['houseid']) ?>" class="btn btn-secondary">
                <i class="bi bi-x-circle"></i> Cancel
            </a>
        </div>
    </form>
</div>

<script>
(function () {
  'use strict'
  var forms = document.querySelectorAll('.needs-validation')
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }
        form.classList.add('was-validated')
      }, false)
    })
})()
</script>
