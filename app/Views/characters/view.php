<?php
// app/Views/characters/view.php
// View data expected: $character, $csrfToken
if (!isset($character) && isset($viewData)) extract($viewData);

$pageTitle = $GLOBALS['pageTitle'] ?? "View Character";

// Helper for displaying JSON data nicely (optional)
function printJson красиво($jsonString) {
    $data = json_decode($jsonString, true);
    if (json_last_error() === JSON_ERROR_NONE && is_array($data) && !empty($data)) {
        return '<pre>' . htmlspecialchars(json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)) . '</pre>';
    }
    return htmlspecialchars($jsonString); // Fallback for invalid JSON or empty
}
?>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1><?= htmlspecialchars($pageTitle) ?></h1>
        <div>
            <a href="index.php?action=characterEdit&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-primary me-2">
                <i class="bi bi-pencil-square"></i> Edit Character
            </a>
            <a href="index.php?action=characterList" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to List
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">Character Details: <?= htmlspecialchars($character['firstname'] . ' ' . $character['lastname']) ?> (ID: <?= htmlspecialchars($character['charidentifier']) ?>)</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <!-- Column 1: Basic Info -->
                <div class="col-md-6">
                    <h5>Basic Information</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th>Owner (SteamID):</th><td><?= htmlspecialchars($character['identifier']) ?></td></tr>
                        <tr><th>Steam Name:</th><td><?= htmlspecialchars($character['steamname']) ?></td></tr>
                        <tr><th>First Name:</th><td><?= htmlspecialchars($character['firstname']) ?></td></tr>
                        <tr><th>Last Name:</th><td><?= htmlspecialchars($character['lastname']) ?></td></tr>
                        <tr><th>Nickname:</th><td><?= htmlspecialchars($character['nickname'] ?? 'N/A') ?></td></tr>
                        <tr><th>Gender:</th><td><?= htmlspecialchars($character['gender'] ?? 'N/A') ?></td></tr>
                        <tr><th>Age:</th><td><?= htmlspecialchars($character['age'] ?? 'N/A') ?></td></tr>
                        <tr><th>Description:</th><td><?= nl2br(htmlspecialchars($character['character_desc'] ?? 'N/A')) ?></td></tr>
                    </table>

                    <h5 class="mt-4">Status & Stats</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th>Job:</th><td><?= htmlspecialchars($character['joblabel'] ?? $character['job']) ?> (Grade: <?= htmlspecialchars($character['jobgrade'] ?? 0) ?>)</td></tr>
                        <tr><th>Money:</th><td>$<?= number_format($character['money'] ?? 0, 2) ?></td></tr>
                        <tr><th>Gold:</th><td><?= number_format($character['gold'] ?? 0, 2) ?> G</td></tr>
                        <tr><th>Rol (Other Currency):</th><td><?= number_format($character['rol'] ?? 0, 2) ?></td></tr>
                        <tr><th>XP:</th><td><?= htmlspecialchars($character['xp'] ?? 0) ?></td></tr>
                        <tr><th>Health (Outer/Inner):</th><td><?= htmlspecialchars($character['healthouter'] ?? 0) ?> / <?= htmlspecialchars($character['healthinner'] ?? 0) ?></td></tr>
                        <tr><th>Stamina (Outer/Inner):</th><td><?= htmlspecialchars($character['staminaouter'] ?? 0) ?> / <?= htmlspecialchars($character['staminainner'] ?? 0) ?></td></tr>
                        <tr><th>Hours Played:</th><td><?= htmlspecialchars($character['hours'] ?? 0) ?></td></tr>
                        <tr><th>Last Login:</th><td><?= htmlspecialchars($character['LastLogin'] ?? 'N/A') ?></td></tr>
                        <tr><th>Is Dead:</th><td><?= ($character['isdead'] ?? 0) ? '<span class="badge bg-danger">Yes</span>' : '<span class="badge bg-success">No</span>' ?></td></tr>
                    </table>
                </div>

                <!-- Column 2: Game Data (JSON fields, etc.) -->
                <div class="col-md-6">
                    <h5>Game Data</h5>
                    <table class="table table-sm table-borderless">
                        <tr><th>Coordinates:</th><td><?= printJson красиво($character['coords'] ?? '{}') ?></td></tr>
                        <tr><th>Status JSON:</th><td><?= printJson красиво($character['status'] ?? '{}') ?></td></tr>
                        <tr><th>Skills JSON:</th><td><?= printJson красиво($character['skills'] ?? '{}') ?></td></tr>
                        <tr><th>Skin/Appearance JSON:</th><td><?= printJson красиво($character['skinPlayer'] ?? '{}') ?></td></tr>
                        <tr><th>Components JSON:</th><td><?= printJson красиво($character['compPlayer'] ?? '{}') ?></td></tr>
                        <tr><th>Component Tints JSON:</th><td><?= printJson красиво($character['compTints'] ?? '{}') ?></td></tr>
                        <tr><th>Inventory (Raw):</th><td><?= printJson красиво($character['inventory'] ?? '{}') ?> <span class="text-muted small">(Note: This is the old inventory field, detailed inventory below)</span></td></tr>
                        <tr><th>Inventory Slots:</th><td><?= htmlspecialchars($character['slots'] ?? 'N/A') ?></td></tr>
                        <tr><th>Ammunition JSON:</th><td><?= printJson красиво($character['ammo'] ?? '{}') ?></td></tr>
                        <tr><th>Meta JSON:</th><td><?= printJson красиво($character['meta'] ?? '{}') ?></td></tr>
                        <tr><th>Walking Style:</th><td><?= htmlspecialchars($character['walk'] ?? 'N/A') ?></td></tr>
                        <tr><th>Gunsmith Credits:</th><td><?= number_format($character['gunsmith'] ?? 0, 2) ?></td></tr>
                        <tr><th>Discord ID:</th><td><?= htmlspecialchars($character['discordid'] ?? 'N/A') ?></td></tr>
                        <tr><th>Posse ID:</th><td><?= htmlspecialchars($character['posseid'] ?? 'N/A') ?></td></tr>
                        <tr><th>Last Joined Data:</th><td><?= printJson красиво($character['lastjoined'] ?? '[]') ?></td></tr>
                    </table>
                </div>
            </div>

            <hr>
            <!-- Detailed Inventory (Step 7) -->
            <div id="characterInventorySection" class="mt-4">
                <h5>Character Inventory (Detailed)</h5>
                <?php if (!empty($inventory)): ?>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Type</th>
                                    <th>Item Name</th>
                                    <th>Amount</th>
                                    <th>Base Item Code</th>
                                    <th>Group</th>
                                    <th>Weight</th>
                                    <th>Degradation</th>
                                    <th>%</th>
                                    <th>Metadata (Crafted)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($inventory as $itemEntry): ?>
                                    <tr>
                                        <td><?= htmlspecialchars($itemEntry['inventory_type']) ?></td>
                                        <td><?= htmlspecialchars($itemEntry['base_item_label']) ?></td>
                                        <td><?= htmlspecialchars($itemEntry['amount']) ?></td>
                                        <td><?= htmlspecialchars($itemEntry['base_item_code']) ?></td>
                                        <td><?= htmlspecialchars($itemEntry['item_group_name'] ?? 'N/A') ?></td>
                                        <td><?= htmlspecialchars($itemEntry['base_item_weight'] ?? 'N/A') ?></td>
                                        <td><?= htmlspecialchars($itemEntry['degradation'] ?? 'N/A') ?></td>
                                        <td><?= htmlspecialchars($itemEntry['percentage'] ?? 'N/A') ?></td>
                                        <td><?= printJson красиво($itemEntry['crafted_item_metadata'] ?? '{}') ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="text-muted">No detailed inventory items found for this character.</p>
                <?php endif; ?>
            </div>

            <!-- Bank Balance (Step 5) -->
            <div id="characterBankBalanceSection" class="mt-4">
                <h5>Bank Accounts</h5>
                <?php if (!empty($bankAccounts)): ?>
                     <?php foreach ($bankAccounts as $account): ?>
                        <div class="mb-3 p-2 border rounded">
                            <h6>Bank: <?= htmlspecialchars($account['name']) ?> (ID: <?= htmlspecialchars($account['id']) ?>)</h6>
                            <dl class="row mb-0">
                                <dt class="col-sm-5">Bank Money:</dt>
                                <dd class="col-sm-7">$<?= number_format($account['money'] ?? 0, 2) ?></dd>
                                <dt class="col-sm-5">Bank Gold:</dt>
                                <dd class="col-sm-7"><?= number_format($account['gold'] ?? 0, 2) ?> G</dd>
                            </dl>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p class="text-muted">No bank accounts found for this character.</p>
                <?php endif; ?>
                 <a href="index.php?action=economyView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-sm btn-outline-info">
                    View Full Economy Details
                </a>
            </div>

            <hr>
            <!-- Crafting & Production Data -->
            <div id="characterCraftingSection" class="mt-4">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Recent Crafting Logs (Last 5)</h5>
                        <?php if (!empty($recentCraftingLogs)): ?>
                            <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                                <table class="table table-sm table-striped table-hover">
                                    <thead class="table-light sticky-top">
                                        <tr>
                                            <th>Timestamp</th>
                                            <th>Item Name</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($recentCraftingLogs as $log): ?>
                                            <tr>
                                                <td><?= htmlspecialchars(date('Y-m-d H:i:s', $log['timestamp'])) ?></td>
                                                <td><?= htmlspecialchars($log['itemLabel'] ?: $log['itemName']) ?></td>
                                                <td><?= htmlspecialchars($log['itemAmount']) ?></td>
                                                <td><span class="badge bg-<?= $log['status'] == 'completed' ? 'success' : ($log['status'] == 'failed' ? 'danger' : 'secondary') ?>"><?= htmlspecialchars($log['status']) ?></span></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php else: ?>
                            <p class="text-muted">No recent crafting logs found.</p>
                        <?php endif; ?>
                    </div>
                    <div class="col-md-6">
                        <h5>Crafting Progress</h5>
                        <?php if (!empty($craftingProgress)): ?>
                            <table class="table table-sm table-borderless">
                                <!-- Example fields, adjust based on actual bcc_craft_progress schema -->
                                <?php if (isset($craftingProgress['general_xp'])): ?>
                                <tr><th style="width: 30%;">General XP:</th><td><?= htmlspecialchars($craftingProgress['general_xp']) ?></td></tr>
                                <?php endif; ?>
                                <?php if (isset($craftingProgress['general_level'])): ?>
                                <tr><th>General Level:</th><td><?= htmlspecialchars($craftingProgress['general_level']) ?></td></tr>
                                <?php endif; ?>

                                <!-- If skills are in a JSON field -->
                                <?php
                                $skillsData = null;
                                if (isset($craftingProgress['skills_json'])) {
                                    $skillsData = json_decode($craftingProgress['skills_json'], true);
                                } elseif (isset($craftingProgress['specific_skills'])) { // Alternative column name
                                    $skillsData = json_decode($craftingProgress['specific_skills'], true);
                                }
                                ?>
                                <?php if (is_array($skillsData) && !empty($skillsData)): ?>
                                    <tr><td colspan="2"><strong>Specific Skills:</strong></td></tr>
                                    <?php foreach ($skillsData as $skillName => $skillDetails): ?>
                                        <tr>
                                            <td class="ps-3">- <?= htmlspecialchars(ucfirst(str_replace('_', ' ', $skillName))) ?>:</td>
                                            <td>
                                                <?php if (is_array($skillDetails)): ?>
                                                    XP: <?= htmlspecialchars($skillDetails['xp'] ?? 'N/A') ?>,
                                                    Level: <?= htmlspecialchars($skillDetails['level'] ?? 'N/A') ?>
                                                <?php else: ?>
                                                    <?= htmlspecialchars($skillDetails) ?>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php elseif (!empty($craftingProgress) && !isset($craftingProgress['id']) && !isset($craftingProgress['charidentifier'])): ?>
                                     <tr><td colspan="2"><strong>Raw Progress Data:</strong></td></tr>
                                     <?php foreach($craftingProgress as $key => $value):
                                        if ($key == 'id' || $key == 'charidentifier') continue; ?>
                                        <tr>
                                            <td class="ps-3">- <?= htmlspecialchars(ucfirst(str_replace('_', ' ', $key))) ?>:</td>
                                            <td><?= htmlspecialchars($value) ?></td>
                                        </tr>
                                     <?php endforeach; ?>
                                <?php endif; ?>
                            </table>
                        <?php else: ?>
                            <p class="text-muted">No crafting progress data found.</p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <hr>
            <!-- Social Features Data -->
            <div id="characterSocialSection" class="mt-4">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Posse Information</h5>
                        <?php if (!empty($posseInfo)): ?>
                            <p>
                                <strong>Posse Name:</strong> <?= htmlspecialchars($posseInfo['possename']) ?> (ID: <?= htmlspecialchars($posseInfo['id']) ?>)<br>
                                <strong>Leader CharID:</strong> <?= htmlspecialchars($posseInfo['characterid']) ?><br>
                                <strong>Leader SteamID:</strong> <?= htmlspecialchars($posseInfo['identifier']) ?>
                            </p>
                            <h6>Members (<?= count($posseMembers) ?>):</h6>
                            <?php if (!empty($posseMembers)): ?>
                                <ul class="list-group list-group-sm" style="max-height: 150px; overflow-y: auto;">
                                    <?php foreach ($posseMembers as $member): ?>
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <?= htmlspecialchars($member['firstname'] . ' ' . $member['lastname']) ?>
                                            <small class="text-muted">(CharID: <?= htmlspecialchars($member['charidentifier']) ?>)</small>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php else: ?>
                                <p class="text-muted">No members listed for this posse (or character is the only member and not listed here).</p>
                            <?php endif; ?>
                        <?php elseif (isset($character['posseid']) && !empty($character['posseid'])): ?>
                             <p class="text-muted">Belongs to Posse ID: <?= htmlspecialchars($character['posseid']) ?> (Details not found or error loading).</p>
                        <?php else: ?>
                            <p class="text-muted">Not currently a member of a posse.</p>
                        <?php endif; ?>
                    </div>
                    <div class="col-md-6">
                        <h5>Recent Mail (Received - Last 3)</h5>
                        <?php if (!empty($recentMail)): ?>
                             <div class="list-group list-group-sm" style="max-height: 200px; overflow-y: auto;">
                                <?php foreach ($recentMail as $mail): ?>
                                    <a href="#" class="list-group-item list-group-item-action flex-column align-items-start disabled" title="Mail viewing not fully implemented yet. Subject: <?= htmlspecialchars($mail['subject']) ?>"> <!-- Link to full mail view later -->
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1"><?= htmlspecialchars($mail['subject']) ?></h6>
                                            <small class="text-muted"><?= htmlspecialchars(date('Y-m-d H:i', strtotime($mail['sent_at']))) ?></small>
                                        </div>
                                        <p class="mb-1 small">From: <?= htmlspecialchars($mail['sender_firstname'] . ' ' . $mail['sender_lastname'] ?: 'Unknown Sender') ?></p>
                                        <small class="text-muted fst-italic">Status: <?= ($mail['is_read'] ?? 0) ? 'Read' : 'Unread' ?></small>
                                    </a>
                                <?php endforeach; ?>
                            </div>
                        <?php else: ?>
                            <p class="text-muted">No recent mail found.</p>
                        <?php endif; ?>
                        <!-- Link to full mailbox view if implemented later -->
                        <!-- <a href="index.php?action=mailboxView&charidentifier=<?= urlencode($character['charidentifier']) ?>" class="btn btn-sm btn-outline-secondary mt-2">View Full Mailbox (TODO)</a> -->
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
