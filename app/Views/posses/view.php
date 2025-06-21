<?php
// app/Views/posses/view.php
if (!isset($posse) && isset($viewData)) extract($viewData); // $posse, $members, $csrfToken
$pageTitle = $GLOBALS['pageTitle'] ?? "View Posse";
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?></h1>
        <div>
            <!-- Edit Posse link placeholder -->
            <!-- <a href="index.php?action=posseEdit&id=<?= urlencode($posse['id']) ?>" class="btn btn-primary me-2 disabled">
                <i class="bi bi-pencil-square"></i> Edit Posse (TODO)
            </a> -->
            <a href="index.php?action=posseList" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to Posse List
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">Posse: <?= htmlspecialchars($posse['possename']) ?> (ID: <?= htmlspecialchars($posse['id']) ?>)</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>Posse Details</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th style="width:30%;">Posse Name:</th><td><?= htmlspecialchars($posse['possename']) ?></td></tr>
                        <tr><th>Leader CharID:</th><td><?= htmlspecialchars($posse['characterid']) ?></td></tr>
                        <tr><th>Leader SteamID:</th><td><?= htmlspecialchars($posse['identifier']) ?></td></tr>
                        <?php
                        // Leader's name might already be joined in $posse array from PosseModel::getAllPosses
                        // If not, or if findByPosseId was used, it might need a separate fetch or to be passed.
                        // Assuming PosseModel::findByPosseId doesn't join for leader name for simplicity here.
                        // Controller could fetch and pass leader_firstname, leader_lastname separately if needed.
                        if (isset($posse['leader_firstname']) && isset($posse['leader_lastname'])) {
                            echo "<tr><th>Leader Name:</th><td>" . htmlspecialchars($posse['leader_firstname'] . ' ' . $posse['leader_lastname']) . "</td></tr>";
                        }
                        ?>
                    </table>
                </div>
                <div class="col-md-6">
                    <h5>Members (<?= count($members) ?>)</h5>
                    <?php if (!empty($members)): ?>
                        <div class="list-group" style="max-height: 300px; overflow-y: auto;">
                            <?php foreach ($members as $member): ?>
                                <a href="index.php?action=characterView&charidentifier=<?= urlencode($member['charidentifier']) ?>" class="list-group-item list-group-item-action">
                                    <?= htmlspecialchars($member['firstname'] . ' ' . $member['lastname']) ?>
                                    <small class="text-muted d-block">CharID: <?= htmlspecialchars($member['charidentifier']) ?>, User SteamID: <?= htmlspecialchars($member['user_steam_id']) ?></small>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php else: ?>
                        <p class="text-muted">No members found for this posse.</p>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
