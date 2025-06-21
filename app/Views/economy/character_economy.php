<?php
// app/Views/economy/character_economy.php
// Expected $viewData: 'character', 'bankAccounts', 'csrfToken'
if (!isset($character) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "Character Economy";
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?>: <small class="text-muted"><?= htmlspecialchars($character['firstname'] . ' ' . $character['lastname']) ?></small></h1>
        <div>
            <a href="index.php?action=characterView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to Character View
            </a>
             <?php
            // Assuming $authService is available or can be instantiated globally/passed
            global $authService;
            if ($authService && ($authService->hasPermission('admin') || $authService->hasPermission('super_admin'))): ?>
            <a href="index.php?action=economyAdjustBalanceForm&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-warning ms-2">
                <i class="bi bi-pencil-fill"></i> Adjust Balances
            </a>
            <?php endif; ?>
        </div>
    </div>

    <div class="row">
        <!-- Pocket Money/Gold -->
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-wallet2"></i> Pocket Funds</h5>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-4">Pocket Money:</dt>
                        <dd class="col-sm-8">$<?= number_format($character['money'] ?? 0, 2) ?></dd>

                        <dt class="col-sm-4">Pocket Gold:</dt>
                        <dd class="col-sm-8"><?= number_format($character['gold'] ?? 0, 2) ?> G</dd>

                        <dt class="col-sm-4">Other Currency (Rol):</dt>
                        <dd class="col-sm-8"><?= number_format($character['rol'] ?? 0, 2) ?></dd>
                    </dl>
                </div>
            </div>
        </div>

        <!-- Bank Accounts -->
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header">
                     <h5 class="mb-0"><i class="bi bi-bank"></i> Bank Accounts</h5>
                </div>
                <div class="card-body">
                    <?php if (!empty($bankAccounts)): ?>
                        <?php foreach ($bankAccounts as $account): ?>
                            <div class="mb-3 p-2 border rounded">
                                <h6>Bank: <?= htmlspecialchars($account['name']) ?> (ID: <?= htmlspecialchars($account['id']) ?>)</h6>
                                <dl class="row mb-0">
                                    <dt class="col-sm-5">Bank Money:</dt>
                                    <dd class="col-sm-7">$<?= number_format($account['money'] ?? 0, 2) ?></dd>

                                    <dt class="col-sm-5">Bank Gold:</dt>
                                    <dd class="col-sm-7"><?= number_format($account['gold'] ?? 0, 2) ?> G</dd>

                                    <dt class="col-sm-5">Storage Space:</dt>
                                    <dd class="col-sm-7"><?= htmlspecialchars($account['invspace'] ?? 0) ?> slots</dd>

                                    <dt class="col-sm-5">Stored Items (Raw):</dt>
                                    <dd class="col-sm-7">
                                        <?php
                                        $itemsJson = $account['items'] ?? '[]';
                                        $itemsArray = json_decode($itemsJson, true);
                                        if (json_last_error() === JSON_ERROR_NONE && !empty($itemsArray)) {
                                            echo '<pre style="font-size: 0.8em; max-height: 100px; overflow-y: auto;">' . htmlspecialchars(json_encode($itemsArray, JSON_PRETTY_PRINT)) . '</pre>';
                                        } else {
                                            echo htmlspecialchars($itemsJson);
                                        }
                                        ?>
                                    </dd>
                                </dl>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <p class="text-muted">No bank accounts found for this character.</p>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
