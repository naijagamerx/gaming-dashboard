<?php
// app/Views/animals/horse_edit.php
if (!isset($horse) && isset($viewData)) extract($viewData); // $horse, $ownerCharacterName, $csrfToken, $formData
$pageTitle = $GLOBALS['pageTitle'] ?? "Edit Player Horse";
$currentData = $formData ?? $horse;
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?>: <small class="text-muted"><?= htmlspecialchars($horse['name']) ?></small></h1>

    <form action="index.php?action=horseUpdate&id=<?= urlencode($horse['id']) ?>" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="card">
            <div class="card-header"><h5>Horse Information</h5></div>
            <div class="card-body">
                 <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Owner Character ID:</label>
                        <input type="text" class="form-control" value="<?= htmlspecialchars($horse['charid']) ?>" readonly disabled>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Owner Character Name:</label>
                        <input type="text" class="form-control" value="<?= htmlspecialchars($ownerCharacterName ?? 'N/A') ?>" readonly disabled>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name" class="form-label">Horse Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="<?= htmlspecialchars($currentData['name'] ?? '') ?>" required>
                        <div class="invalid-feedback">Horse name is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="model" class="form-label">Horse Model</label>
                        <input type="text" class="form-control" id="model" name="model" value="<?= htmlspecialchars($currentData['model'] ?? '') ?>" required>
                        <div class="form-text">E.g., "a_c_horse_turkoman_gold"</div>
                        <div class="invalid-feedback">Horse model is required.</div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="male" <?= (($currentData['gender'] ?? '') == 'male') ? 'selected' : '' ?>>Male</option>
                            <option value="female" <?= (($currentData['gender'] ?? '') == 'female') ? 'selected' : '' ?>>Female</option>
                        </select>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="xp" class="form-label">XP</label>
                        <input type="number" class="form-control" id="xp" name="xp" value="<?= htmlspecialchars($currentData['xp'] ?? 0) ?>" min="0">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="health" class="form-label">Health</label>
                        <input type="number" class="form-control" id="health" name="health" value="<?= htmlspecialchars($currentData['health'] ?? 50) ?>" min="0">
                    </div>
                     <div class="col-md-3 mb-3">
                        <label for="stamina" class="form-label">Stamina</label>
                        <input type="number" class="form-control" id="stamina" name="stamina" value="<?= htmlspecialchars($currentData['stamina'] ?? 50) ?>" min="0">
                    </div>
                </div>
                <div class="row">
                     <div class="col-md-3 mb-3 form-check ms-2">
                        <input type="checkbox" class="form-check-input" id="selected" name="selected" value="1" <?= (isset($currentData['selected']) && $currentData['selected'] == 1) ? 'checked' : '' ?>>
                        <label class="form-check-label" for="selected">Is Selected?</label>
                    </div>
                     <div class="col-md-3 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="dead" name="dead" value="1" <?= (isset($currentData['dead']) && $currentData['dead'] == 1) ? 'checked' : '' ?>>
                        <label class="form-check-label" for="dead">Is Dead?</label>
                    </div>
                     <div class="col-md-3 mb-3">
                        <label for="captured" class="form-label">Captured Status</label> <!-- Readonly or special logic -->
                        <input type="text" class="form-control" value="<?= htmlspecialchars($currentData['captured'] ?? 0) ?>" readonly disabled title="Capture status usually handled by game events">
                    </div>
                     <div class="col-md-3 mb-3">
                        <label for="writhe" class="form-label">Writhe Status</label> <!-- Readonly or special logic -->
                        <input type="text" class="form-control" name="writhe" value="<?= htmlspecialchars($currentData['writhe'] ?? 0) ?>">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="components" class="form-label">Components (JSON)</label>
                    <textarea class="form-control" id="components" name="components" rows="3"><?= htmlspecialchars($currentData['components'] ?? '{}') ?></textarea>
                    <div class="form-text">JSON data for horse appearance/components.</div>
                </div>
                 <div class="mb-3">
                    <label for="born" class="form-label">Born/Acquired Date</label>
                    <input type="datetime-local" class="form-control" id="born" name="born" value="<?= htmlspecialchars($currentData['born'] ? date('Y-m-d\TH:i:s', strtotime($currentData['born'])) : '') ?>">
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Update Horse
            </button>
            <a href="index.php?action=horseView&id=<?= urlencode($horse['id']) ?>" class="btn btn-secondary">
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
