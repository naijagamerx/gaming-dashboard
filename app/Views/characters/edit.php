<?php
// app/Views/characters/edit.php
// View data expected: $character, $csrfToken, $formData (optional)
if (!isset($character) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "Edit Character";
// $formData could be pre-filled by controller on validation error, otherwise use $character
$currentData = $formData ?? $character;
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?>: <small class="text-muted"><?= htmlspecialchars($character['firstname'] . ' ' . $character['lastname']) ?></small></h1>

    <form action="index.php?action=characterUpdate&charidentifier=<?= urlencode($character['charidentifier']) ?>" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="row">
            <div class="col-lg-8">
                <!-- Left Column: Main Details -->
                <div class="card mb-3">
                    <div class="card-header"><h5>Core Information</h5></div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="identifier_display" class="form-label">Owner's User Identifier (SteamID)</label>
                                <input type="text" class="form-control" id="identifier_display" value="<?= htmlspecialchars($character['identifier']) ?>" readonly disabled>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="steamname_display" class="form-label">Owner's Steam Name</label>
                                <input type="text" class="form-control" id="steamname_display" value="<?= htmlspecialchars($character['steamname']) ?>" readonly disabled>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstname" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstname" name="firstname" value="<?= htmlspecialchars($currentData['firstname'] ?? '') ?>" required>
                                <div class="invalid-feedback">First name is required.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastname" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" value="<?= htmlspecialchars($currentData['lastname'] ?? '') ?>" required>
                                <div class="invalid-feedback">Last name is required.</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="Male" <?= (($currentData['gender'] ?? '') == 'Male') ? 'selected' : '' ?>>Male</option>
                                    <option value="Female" <?= (($currentData['gender'] ?? '') == 'Female') ? 'selected' : '' ?>>Female</option>
                                    <option value="Unknown" <?= (($currentData['gender'] ?? '') == 'Unknown') ? 'selected' : '' ?>>Unknown</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="age" class="form-label">Age</label>
                                <input type="number" class="form-control" id="age" name="age" value="<?= htmlspecialchars($currentData['age'] ?? 18) ?>" min="0">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="character_desc" class="form-label">Character Description</label>
                            <textarea class="form-control" id="character_desc" name="character_desc" rows="3"><?= htmlspecialchars($currentData['character_desc'] ?? '') ?></textarea>
                        </div>
                    </div>
                </div>

                <div class="card mb-3">
                    <div class="card-header"><h5>Financial & Progression</h5></div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="money" class="form-label">Money</label>
                                <input type="number" step="0.01" class="form-control" id="money" name="money" value="<?= htmlspecialchars(number_format($currentData['money'] ?? 0.00, 2, '.', '')) ?>" min="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="gold" class="form-label">Gold</label>
                                <input type="number" step="0.01" class="form-control" id="gold" name="gold" value="<?= htmlspecialchars(number_format($currentData['gold'] ?? 0.00, 2, '.', '')) ?>" min="0">
                            </div>
                             <div class="col-md-4 mb-3">
                                <label for="xp" class="form-label">XP</label>
                                <input type="number" class="form-control" id="xp" name="xp" value="<?= htmlspecialchars($currentData['xp'] ?? 0) ?>" min="0">
                            </div>
                        </div>
                    </div>
                </div>

                 <div class="card mb-3">
                    <div class="card-header"><h5>Job & Status</h5></div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="job" class="form-label">Job (Code)</label>
                                <input type="text" class="form-control" id="job" name="job" value="<?= htmlspecialchars($currentData['job'] ?? 'unemployed') ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="joblabel" class="form-label">Job Label</label>
                                <input type="text" class="form-control" id="joblabel" name="joblabel" value="<?= htmlspecialchars($currentData['joblabel'] ?? 'Unemployed') ?>">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="healthouter" class="form-label">Health Outer</label>
                                <input type="number" class="form-control" id="healthouter" name="healthouter" value="<?= htmlspecialchars($currentData['healthouter'] ?? 500) ?>" min="0">
                            </div>
                             <div class="col-md-6 mb-3">
                                <label for="isdead" class="form-label">Is Dead?</label>
                                <select class="form-select" id="isdead" name="isdead">
                                    <option value="0" <?= (($currentData['isdead'] ?? 0) == 0) ? 'selected' : '' ?>>No</option>
                                    <option value="1" <?= (($currentData['isdead'] ?? 0) == 1) ? 'selected' : '' ?>>Yes</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <div class="col-lg-4">
                <!-- Right Column: Coordinates and other technical data -->
                <div class="card mb-3">
                    <div class="card-header"><h5>Technical Data (JSON)</h5></div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="coords" class="form-label">Coordinates (JSON)</label>
                            <textarea class="form-control" id="coords" name="coords" rows="3"><?= htmlspecialchars($currentData['coords'] ?? '{}') ?></textarea>
                            <div class="form-text">Enter valid JSON for coordinates. E.g., {"x":123.45,"y":67.89,"z":10.11}</div>
                        </div>
                         <div class="mb-3">
                            <label for="skinPlayer" class="form-label">Skin/Appearance (JSON)</label>
                            <textarea class="form-control" id="skinPlayer" name="skinPlayer" rows="4"><?= htmlspecialchars($currentData['skinPlayer'] ?? '{}') ?></textarea>
                        </div>
                        <!-- Add more JSON fields if needed: status, skills, compPlayer, compTints, ammo, meta -->
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Update Character
            </button>
            <a href="index.php?action=characterView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-secondary">
                 <i class="bi bi-x-circle"></i> Cancel
            </a>
        </div>
    </form>
</div>

<script>
// Example starter JavaScript for disabling form submissions if there are invalid fields
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
