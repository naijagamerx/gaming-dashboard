<?php
// app/Views/housing/create.php
if (!isset($csrfToken) && isset($viewData)) extract($viewData); // $csrfToken, $formData, $characters
$pageTitle = $GLOBALS['pageTitle'] ?? "Create New House";
$formData = $formData ?? [];
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?></h1>

    <form action="index.php?action=housingStore" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="card">
            <div class="card-header">
                <h5>Core House Information</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="uniqueName" class="form-label">Unique House Name</label>
                        <input type="text" class="form-control" id="uniqueName" name="uniqueName" value="<?= htmlspecialchars($formData['uniqueName'] ?? '') ?>" required>
                        <div class="form-text">A unique identifier for this house property (e.g., "valentine_main_street_01").</div>
                        <div class="invalid-feedback">Unique house name is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="charidentifier" class="form-label">Owner Character ID</label>
                        <select class="form-select" id="charidentifier" name="charidentifier" required>
                            <option value="">Select Owner...</option>
                            <?php if (!empty($characters)): ?>
                                <?php foreach ($characters as $char): ?>
                                    <option value="<?= htmlspecialchars($char['charidentifier']) ?>" <?= (isset($formData['charidentifier']) && $formData['charidentifier'] == $char['charidentifier']) ? 'selected' : '' ?>>
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
                        <textarea class="form-control" id="house_coords" name="house_coords" rows="3" required><?= htmlspecialchars($formData['house_coords'] ?? '{}') ?></textarea>
                        <div class="form-text">E.g., {"x":123.4,"y":56.7,"z":89.0}</div>
                        <div class="invalid-feedback">House coordinates (JSON format) are required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="house_radius_limit" class="form-label">House Radius Limit</label>
                        <input type="text" class="form-control" id="house_radius_limit" name="house_radius_limit" value="<?= htmlspecialchars($formData['house_radius_limit'] ?? '50') ?>" required>
                        <div class="invalid-feedback">Radius limit is required.</div>
                    </div>
                </div>
                 <div class="col-md-6 mb-3">
                    <label for="ownershipStatus" class="form-label">Ownership Status</label>
                    <select class="form-select" id="ownershipStatus" name="ownershipStatus">
                        <option value="purchased" <?= (isset($formData['ownershipStatus']) && $formData['ownershipStatus'] == 'purchased') ? 'selected' : '' ?>>Purchased</option>
                        <option value="rented" <?= (isset($formData['ownershipStatus']) && $formData['ownershipStatus'] == 'rented') ? 'selected' : '' ?>>Rented</option>
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
                        <input type="text" class="form-control" id="invlimit" name="invlimit" value="<?= htmlspecialchars($formData['invlimit'] ?? '200') ?>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="ledger" class="form-label">Ledger Balance</label>
                        <input type="number" step="0.01" class="form-control" id="ledger" name="ledger" value="<?= htmlspecialchars($formData['ledger'] ?? '0.00') ?>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="tax_amount" class="form-label">Tax Amount</label>
                        <input type="number" step="0.01" class="form-control" id="tax_amount" name="tax_amount" value="<?= htmlspecialchars($formData['tax_amount'] ?? '0.00') ?>">
                    </div>
                </div>
                 <div class="mb-3">
                    <label for="taxes_collected" class="form-label">Taxes Collected?</label>
                    <select class="form-select" id="taxes_collected" name="taxes_collected">
                        <option value="false" <?= (isset($formData['taxes_collected']) && ($formData['taxes_collected'] == 'false' || $formData['taxes_collected'] == 0)) ? 'selected' : '' ?>>No</option>
                        <option value="true" <?= (isset($formData['taxes_collected']) && ($formData['taxes_collected'] == 'true' || $formData['taxes_collected'] == 1)) ? 'selected' : '' ?>>Yes</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="card mt-3">
            <div class="card-header"><h5>Advanced Data (JSON - Optional)</h5></div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="furniture" class="form-label">Furniture (JSON)</label>
                        <textarea class="form-control" id="furniture" name="furniture" rows="3"><?= htmlspecialchars($formData['furniture'] ?? '{}') ?></textarea>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="doors" class="form-label">Doors (JSON)</label>
                        <textarea class="form-control" id="doors" name="doors" rows="3"><?= htmlspecialchars($formData['doors'] ?? '{}') ?></textarea>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="allowed_ids" class="form-label">Allowed IDs (JSON Array)</label>
                        <textarea class="form-control" id="allowed_ids" name="allowed_ids" rows="3"><?= htmlspecialchars($formData['allowed_ids'] ?? '[]') ?></textarea>
                        <div class="form-text">E.g., ["charid1", "steam:xxxx"]</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Create House
            </button>
            <a href="index.php?action=housingList" class="btn btn-secondary">
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
