<?php
// app/Views/economy/adjust_balance.php
// Expected $viewData: 'character', 'bankAccounts', 'csrfToken'
if (!isset($character) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "Adjust Balances";
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?>: <small class="text-muted"><?= htmlspecialchars($character['firstname'] . ' ' . $character['lastname']) ?></small></h1>
        <div>
            <a href="index.php?action=economyView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to Character Economy
            </a>
        </div>
    </div>

    <form action="index.php?action=economyProcessAdjustBalance" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($csrfToken ?? ''); ?>">
        <input type="hidden" name="charidentifier" value="<?= htmlspecialchars($character['charidentifier']); ?>">

        <div class="card">
            <div class="card-header">
                <h5>Adjust Balance</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="balance_type" class="form-label">Balance Type</label>
                        <select class="form-select" id="balance_type" name="balance_type" required>
                            <option value="">Select Type...</option>
                            <option value="pocket">Pocket</option>
                            <option value="bank">Bank Account</option>
                        </select>
                        <div class="invalid-feedback">Please select a balance type.</div>
                    </div>

                    <div class="col-md-4 mb-3" id="bankAccountSelector" style="display: none;">
                        <label for="bank_account_id" class="form-label">Bank Account</label>
                        <select class="form-select" id="bank_account_id" name="bank_account_id">
                            <option value="">Select Bank Account...</option>
                            <?php if (!empty($bankAccounts)): ?>
                                <?php foreach ($bankAccounts as $account): ?>
                                    <option value="<?= htmlspecialchars($account['id']) ?>">
                                        <?= htmlspecialchars($account['name']) ?> (ID: <?= htmlspecialchars($account['id']) ?>) -
                                        Money: $<?= number_format($account['money'], 2) ?>,
                                        Gold: <?= number_format($account['gold'], 2) ?> G
                                    </option>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </select>
                        <div class="invalid-feedback">Please select a bank account if type is 'Bank'.</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="currency_type" class="form-label">Currency Type</label>
                        <select class="form-select" id="currency_type" name="currency_type" required>
                            <option value="">Select Currency...</option>
                            <option value="money">Money ($)</option>
                            <option value="gold">Gold (G)</option>
                            <!-- <option value="rol">Rol (Other)</option> --> <!-- If 'rol' is also adjustable -->
                        </select>
                        <div class="invalid-feedback">Please select a currency type.</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="action_type" class="form-label">Action Type</label>
                        <select class="form-select" id="action_type" name="action_type" required>
                            <option value="set">Set To Amount</option>
                            <option value="add">Add/Subtract Amount</option>
                        </select>
                        <div class="invalid-feedback">Please select an action type.</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="adjustment_amount" class="form-label">Amount</label>
                        <input type="number" step="0.01" class="form-control" id="adjustment_amount" name="adjustment_amount" required>
                        <div class="form-text">For "Add/Subtract", use negative for subtraction.</div>
                        <div class="invalid-feedback">Please enter an amount.</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-save"></i> Apply Adjustment
            </button>
            <a href="index.php?action=economyView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-secondary">
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
        // Custom validation for bank account ID if bank type is selected
        var balanceTypeSelect = form.querySelector('#balance_type');
        var bankAccountSelect = form.querySelector('#bank_account_id');
        if (balanceTypeSelect.value === 'bank' && bankAccountSelect.value === '') {
            bankAccountSelect.classList.add('is-invalid'); // Show feedback if needed
            bankAccountSelect.setCustomValidity('Bank account must be selected for bank type adjustments.');
        } else {
            bankAccountSelect.setCustomValidity('');
            bankAccountSelect.classList.remove('is-invalid');
        }

        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }
        form.classList.add('was-validated')
      }, false)
    });

    // Show/hide bank account selector based on balance type
    var balanceTypeSelect = document.getElementById('balance_type');
    var bankAccountSelectorDiv = document.getElementById('bankAccountSelector');
    var bankAccountSelectInput = document.getElementById('bank_account_id');

    if (balanceTypeSelect) {
        balanceTypeSelect.addEventListener('change', function() {
            if (this.value === 'bank') {
                bankAccountSelectorDiv.style.display = 'block';
                bankAccountSelectInput.setAttribute('required', 'required');
            } else {
                bankAccountSelectorDiv.style.display = 'none';
                bankAccountSelectInput.removeAttribute('required');
                bankAccountSelectInput.value = ''; // Clear selection
                bankAccountSelectInput.classList.remove('is-invalid');
                bankAccountSelectInput.setCustomValidity('');


            }
        });
        // Trigger change on load if pre-selected (e.g. form repopulation)
        if (balanceTypeSelect.value === 'bank') {
             bankAccountSelectorDiv.style.display = 'block';
             bankAccountSelectInput.setAttribute('required', 'required');
        }
    }
})()
</script>
