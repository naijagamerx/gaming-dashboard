<?php
// app/Views/animals/horse_create.php
if (!isset($csrfToken) && isset($viewData)) extract($viewData); // $csrfToken, $formData, $characters
$pageTitle = $GLOBALS['pageTitle'] ?? "Add New Player Horse";
$formData = $formData ?? [];
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?></h1>

    <form action="index.php?action=horseStore" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="card">
            <div class="card-header"><h5>Horse Information</h5></div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="charid" class="form-label">Owner Character</label>
                        <select class="form-select" id="charid" name="charid" required>
                            <option value="">Select Owner Character...</option>
                            <?php if (!empty($characters)): ?>
                                <?php foreach ($characters as $char): ?>
                                    <option value="<?= htmlspecialchars($char['charidentifier']) ?>" <?= (isset($formData['charid']) && $formData['charid'] == $char['charidentifier']) ? 'selected' : '' ?>>
                                        <?= htmlspecialchars($char['firstname'] . ' ' . $char['lastname'] . ' (ID: ' . $char['charidentifier'] . ', User: ' . $char['identifier'] . ')') ?>
                                    </option>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </select>
                        <div class="invalid-feedback">Please select an owner character.</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name" class="form-label">Horse Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="<?= htmlspecialchars($formData['name'] ?? '') ?>" required>
                        <div class="invalid-feedback">Horse name is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="model" class="form-label">Horse Model</label>
                        <input type="text" class="form-control" id="model" name="model" value="<?= htmlspecialchars($formData['model'] ?? '') ?>" required>
                        <div class="form-text">E.g., "a_c_horse_turkoman_gold"</div>
                        <div class="invalid-feedback">Horse model is required.</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="male" <?= (isset($formData['gender']) && $formData['gender'] == 'male') ? 'selected' : '' ?>>Male</option>
                            <option value="female" <?= (isset($formData['gender']) && $formData['gender'] == 'female') ? 'selected' : '' ?>>Female</option>
                        </select>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="xp" class="form-label">XP</label>
                        <input type="number" class="form-control" id="xp" name="xp" value="<?= htmlspecialchars($formData['xp'] ?? 0) ?>" min="0">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="health" class="form-label">Health</label>
                        <input type="number" class="form-control" id="health" name="health" value="<?= htmlspecialchars($formData['health'] ?? 50) ?>" min="0">
                    </div>
                     <div class="col-md-3 mb-3">
                        <label for="stamina" class="form-label">Stamina</label>
                        <input type="number" class="form-control" id="stamina" name="stamina" value="<?= htmlspecialchars($formData['stamina'] ?? 50) ?>" min="0">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3 form-check ms-2">
                        <input type="checkbox" class="form-check-input" id="selected" name="selected" value="1" <?= (isset($formData['selected']) && $formData['selected']) ? 'checked' : '' ?>>
                        <label class="form-check-label" for="selected">Is Selected (Active Horse)?</label>
                    </div>
                     <div class="col-md-5 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="dead" name="dead" value="1" <?= (isset($formData['dead']) && $formData['dead']) ? 'checked' : '' ?>>
                        <label class="form-check-label" for="dead">Is Dead?</label>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="components" class="form-label">Components (JSON)</label>
                    <textarea class="form-control" id="components" name="components" rows="3"><?= htmlspecialchars($formData['components'] ?? '{}') ?></textarea>
                    <div class="form-text">JSON data for horse appearance/components.</div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Add Horse
            </button>
            <a href="index.php?action=horseList" class="btn btn-secondary">
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
