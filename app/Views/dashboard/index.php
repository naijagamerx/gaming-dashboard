<?php
// app/Views/dashboard/index.php
// This file will be included by layouts/main.php
// Assumes $authService is available (passed by router or main.php)
// Assumes $pageTitle is set by the router (index.php)

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Data for the dashboard would be prepared by a DashboardController and passed via $viewData
// For now, just a simple welcome.
$userId = $_SESSION['user_id'] ?? 'Guest';
$userGroup = $_SESSION['user_group'] ?? 'N/A';

// Example stats (these would come from a controller that fetches them from models)
$stats = [
    'serverStatus' => [
        'activeUsers' => 0, // Placeholder
        'uptime' => 'N/A' // Placeholder
    ],
    'economyOverview' => [
        'totalMoney' => 0, // Placeholder
        'totalGold' => 0 // Placeholder
    ],
    'playerMetrics' => [
        'totalCharacters' => 0, // Placeholder
        'activeToday' => 0 // Placeholder
    ]
];
// In a real app:
// $dashboardController = new DashboardController();
// $stats = $dashboardController->getDashboardStats();
// $chartsData = $dashboardController->getChartsData();
// extract($chartsData); // To make chart data available

?>

<div class="container-fluid mt-4">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= htmlspecialchars($pageTitle ?? 'Dashboard') ?></h1>
        <!-- Optional: Report button or other actions -->
        <!-- <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a> -->
    </div>

    <p>Welcome, <strong><?= htmlspecialchars($userId) ?></strong>! Your group is: <strong><?= htmlspecialchars($userGroup) ?></strong>.</p>
    <p>This is the main dashboard area. Content and statistics will be displayed here.</p>

    <!-- Content Row - Example Cards (from PHP_BOOTSTRAP_IMPLEMENTATION.md structure) -->
    <div class="row">

        <!-- Active Users Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Active Users (Placeholder)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?= htmlspecialchars($stats['serverStatus']['activeUsers']) ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people-fill fs-2 text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Money Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Total Money (Placeholder)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">$<?= number_format($stats['economyOverview']['totalMoney']) ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-currency-dollar fs-2 text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Characters Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Characters (Placeholder)
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><?= htmlspecialchars($stats['playerMetrics']['totalCharacters']) ?></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-person-badge fs-2 text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pending Requests Card Example (Placeholder) -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                Server Uptime (Placeholder)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><?= htmlspecialchars($stats['serverStatus']['uptime']) ?></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-clock-history fs-2 text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Placeholder for charts or more detailed stats -->
    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Future Content Area</h6>
                </div>
                <div class="card-body">
                    <p>More detailed statistics, charts, and management tools will be available here.</p>
                    <p>For example, a chart showing player activity over time, or a table of recent server events.</p>
                    <!-- Example: <canvas id="playerActivityChart"></canvas> -->
                </div>
            </div>
        </div>
    </div>

</div>

<?php
// If there are page-specific scripts for the dashboard (e.g., for charts)
// $scripts = ['assets/js/dashboard-charts.js']; // This would be set by controller and picked up by main.php
?>
