<?php
// app/Views/characters/create.php
// View data expected: $csrfToken, $formData (optional, for repopulation)
if (!isset($csrfToken) && isset($viewData)) extract($viewData); // Fallback

$pageTitle = $GLOBALS['pageTitle'] ?? "Create New Character";
$formData = $formData ?? []; // Ensure $formData is an array
?>

<div class="container-fluid mt-4">
    <h1><?= htmlspecialchars($pageTitle) ?></h1>

    <form action="index.php?action=characterStore" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">

        <div class="card">
            <div class="card-header">
                <h5>Required Information</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="identifier" class="form-label">Owner's User Identifier (SteamID)</label>
                        <input type="text" class="form-control" id="identifier" name="identifier" value="<?= htmlspecialchars($formData['identifier'] ?? '') ?>" required>
                        <div class="form-text">The SteamID of the user who will own this character (e.g., steam:xxxxxxxxxxxxxxxxx).</div>
                        <div class="invalid-feedback">Owner's SteamID is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="steamname" class="form-label">Owner's Steam Name</label>
                        <input type="text" class="form-control" id="steamname" name="steamname" value="<?= htmlspecialchars($formData['steamname'] ?? '') ?>" required>
                        <div class="form-text">The current Steam Name of the owner. This might be auto-filled or validated against the User ID.</div>
                        <div class="invalid-feedback">Owner's Steam Name is required.</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstname" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="firstname" name="firstname" value="<?= htmlspecialchars($formData['firstname'] ?? '') ?>" required>
                        <div class="invalid-feedback">First name is required.</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastname" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="lastname" name="lastname" value="<?= htmlspecialchars($formData['lastname'] ?? '') ?>" required>
                        <div class="invalid-feedback">Last name is required.</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mt-3">
            <div class="card-header">
                <h5>Basic Details (Optional - Defaults will be used)</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="Male" <?= (isset($formData['gender']) && $formData['gender'] == 'Male') ? 'selected' : '' ?>>Male</option>
                            <option value="Female" <?= (isset($formData['gender']) && $formData['gender'] == 'Female') ? 'selected' : '' ?>>Female</option>
                            <option value="Unknown" <?= (!isset($formData['gender']) || $formData['gender'] == 'Unknown') ? 'selected' : '' ?>>Unknown</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="age" class="form-label">Age</label>
                        <input type="number" class="form-control" id="age" name="age" value="<?= htmlspecialchars($formData['age'] ?? 18) ?>" min="0">
                    </div>
                     <div class="col-md-4 mb-3">
                        <label for="job" class="form-label">Job (Code)</label>
                        <input type="text" class="form-control" id="job" name="job" value="<?= htmlspecialchars($formData['job'] ?? 'unemployed') ?>">
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="money" class="form-label">Starting Money</label>
                        <input type="number" step="0.01" class="form-control" id="money" name="money" value="<?= htmlspecialchars($formData['money'] ?? 0.00) ?>" min="0">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="gold" class="form-label">Starting Gold</label>
                        <input type="number" step="0.01" class="form-control" id="gold" name="gold" value="<?= htmlspecialchars($formData['gold'] ?? 0.00) ?>" min="0">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="character_desc" class="form-label">Character Description</label>
                    <textarea class="form-control" id="character_desc" name="character_desc" rows="3"><?= htmlspecialchars($formData['character_desc'] ?? '') ?></textarea>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle-fill"></i> Create Character
            </button>
            <a href="index.php?action=characterList" class="btn btn-secondary">
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
