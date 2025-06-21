# PHP Bootstrap Gaming Dashboard Implementation
## Detailed Code Examples and Structure

---

## 🚀 Core Implementation Files

### **1. Database Configuration (app/Config/database.php)**
```php
<?php
class Database {
    private static $instance = null;
    private $connection;
    
    private $host = 'localhost'; // Hostinger MySQL host
    private $dbname = 'zap1312222-1';
    private $username = 'your_db_user';
    private $password = 'your_db_password';
    
    private function __construct() {
        try {
            $this->connection = new PDO(
                "mysql:host={$this->host};dbname={$this->dbname};charset=utf8mb4",
                $this->username,
                $this->password,
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false,
                    PDO::ATTR_PERSISTENT => true
                ]
            );
        } catch(PDOException $e) {
            error_log("Database connection failed: " . $e->getMessage());
            die("Database connection failed");
        }
    }
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    public function getConnection() {
        return $this->connection;
    }
}
```

### **2. Authentication Service (app/Services/AuthService.php)**
```php
<?php
class AuthService {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function login($identifier, $password) {
        $stmt = $this->db->prepare("
            SELECT u.*, COUNT(c.charidentifier) as character_count 
            FROM users u 
            LEFT JOIN characters c ON u.identifier = c.identifier 
            WHERE u.identifier = ? AND u.banned = 0
            GROUP BY u.identifier
        ");
        $stmt->execute([$identifier]);
        $user = $stmt->fetch();
        
        if ($user && password_verify($password, $user['password_hash'])) {
            // Start secure session
            session_regenerate_id(true);
            $_SESSION['user_id'] = $user['identifier'];
            $_SESSION['user_group'] = $user['group'];
            $_SESSION['character_count'] = $user['character_count'];
            $_SESSION['login_time'] = time();
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
            
            // Log successful login
            $this->logUserActivity($user['identifier'], 'login', $_SERVER['REMOTE_ADDR']);
            
            return true;
        }
        
        // Log failed login attempt
        $this->logUserActivity($identifier, 'failed_login', $_SERVER['REMOTE_ADDR']);
        return false;
    }
    
    public function logout() {
        if (isset($_SESSION['user_id'])) {
            $this->logUserActivity($_SESSION['user_id'], 'logout', $_SERVER['REMOTE_ADDR']);
        }
        
        session_destroy();
        session_start();
        session_regenerate_id(true);
    }
    
    public function hasPermission($permission) {
        if (!isset($_SESSION['user_group'])) {
            return false;
        }
        
        $permissions = [
            'super_admin' => ['*'],
            'server_admin' => ['users.*', 'characters.*', 'economy.*', 'housing.*'],
            'moderator' => ['characters.*', 'social.*', 'view.*'],
            'support' => ['view.*'],
            'viewer' => ['view.analytics']
        ];
        
        $userPermissions = $permissions[$_SESSION['user_group']] ?? [];
        
        // Check for wildcard permission
        if (in_array('*', $userPermissions)) {
            return true;
        }
        
        // Check specific permission
        return in_array($permission, $userPermissions) || 
               in_array(explode('.', $permission)[0] . '.*', $userPermissions);
    }
    
    private function logUserActivity($userId, $action, $ipAddress) {
        $stmt = $this->db->prepare("
            INSERT INTO user_activity_log (user_id, action, ip_address, timestamp) 
            VALUES (?, ?, ?, NOW())
        ");
        $stmt->execute([$userId, $action, $ipAddress]);
    }
}
```

### **3. Base Model Class (app/Models/BaseModel.php)**
```php
<?php
abstract class BaseModel {
    protected $db;
    protected $table;
    protected $primaryKey = 'id';
    
    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function find($id) {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$this->primaryKey} = ?");
        $stmt->execute([$id]);
        return $stmt->fetch();
    }
    
    public function findAll($conditions = [], $limit = null, $offset = 0) {
        $sql = "SELECT * FROM {$this->table}";
        $params = [];
        
        if (!empty($conditions)) {
            $whereClause = [];
            foreach ($conditions as $field => $value) {
                $whereClause[] = "{$field} = ?";
                $params[] = $value;
            }
            $sql .= " WHERE " . implode(' AND ', $whereClause);
        }
        
        if ($limit) {
            $sql .= " LIMIT {$limit} OFFSET {$offset}";
        }
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }
    
    public function create($data) {
        $fields = array_keys($data);
        $placeholders = array_fill(0, count($fields), '?');
        
        $sql = "INSERT INTO {$this->table} (" . implode(', ', $fields) . ") 
                VALUES (" . implode(', ', $placeholders) . ")";
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array_values($data));
        
        return $this->db->lastInsertId();
    }
    
    public function update($id, $data) {
        $fields = [];
        $params = [];
        
        foreach ($data as $field => $value) {
            $fields[] = "{$field} = ?";
            $params[] = $value;
        }
        $params[] = $id;
        
        $sql = "UPDATE {$this->table} SET " . implode(', ', $fields) . 
               " WHERE {$this->primaryKey} = ?";
        
        $stmt = $this->db->prepare($sql);
        return $stmt->execute($params);
    }
    
    public function delete($id) {
        $stmt = $this->db->prepare("DELETE FROM {$this->table} WHERE {$this->primaryKey} = ?");
        return $stmt->execute([$id]);
    }
    
    public function count($conditions = []) {
        $sql = "SELECT COUNT(*) FROM {$this->table}";
        $params = [];
        
        if (!empty($conditions)) {
            $whereClause = [];
            foreach ($conditions as $field => $value) {
                $whereClause[] = "{$field} = ?";
                $params[] = $value;
            }
            $sql .= " WHERE " . implode(' AND ', $whereClause);
        }
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchColumn();
    }
}
```

### **4. Character Model (app/Models/Character.php)**
```php
<?php
class Character extends BaseModel {
    protected $table = 'characters';
    protected $primaryKey = 'charidentifier';
    
    public function getWithUser($charId) {
        $stmt = $this->db->prepare("
            SELECT c.*, u.group as user_group, u.steamname, u.banned
            FROM characters c
            JOIN users u ON c.identifier = u.identifier
            WHERE c.charidentifier = ?
        ");
        $stmt->execute([$charId]);
        return $stmt->fetch();
    }
    
    public function getInventory($charId, $inventoryType = 'default') {
        $stmt = $this->db->prepare("
            SELECT ci.*, i.label, i.desc, i.weight, ic.metadata
            FROM character_inventories ci
            JOIN items_crafted ic ON ci.item_crafted_id = ic.id
            JOIN items i ON ic.item_id = i.id
            WHERE ci.character_id = ? AND ci.inventory_type = ?
            ORDER BY i.label
        ");
        $stmt->execute([$charId, $inventoryType]);
        return $stmt->fetchAll();
    }
    
    public function getActiveCharacters($hoursThreshold = 24) {
        $stmt = $this->db->prepare("
            SELECT c.*, u.steamname
            FROM characters c
            JOIN users u ON c.identifier = u.identifier
            WHERE c.LastLogin >= DATE_SUB(NOW(), INTERVAL ? HOUR)
            AND u.banned = 0
            ORDER BY c.LastLogin DESC
        ");
        $stmt->execute([$hoursThreshold]);
        return $stmt->fetchAll();
    }
    
    public function getWealthDistribution() {
        $stmt = $this->db->prepare("
            SELECT 
                CASE 
                    WHEN (money + gold) < 100 THEN 'Poor (0-99)'
                    WHEN (money + gold) < 1000 THEN 'Middle (100-999)'
                    WHEN (money + gold) < 10000 THEN 'Rich (1000-9999)'
                    ELSE 'Very Rich (10000+)'
                END as wealth_category,
                COUNT(*) as player_count,
                AVG(money + gold) as avg_wealth
            FROM characters
            GROUP BY wealth_category
        ");
        $stmt->execute();
        return $stmt->fetchAll();
    }
    
    public function teleport($charId, $x, $y, $z) {
        $coords = json_encode(['x' => $x, 'y' => $y, 'z' => $z]);
        return $this->update($charId, ['coords' => $coords]);
    }
    
    public function adjustMoney($charId, $amount, $type = 'money') {
        if (!in_array($type, ['money', 'gold'])) {
            throw new InvalidArgumentException('Invalid money type');
        }
        
        $character = $this->find($charId);
        if (!$character) {
            throw new Exception('Character not found');
        }
        
        $newAmount = $character[$type] + $amount;
        if ($newAmount < 0) {
            throw new Exception('Insufficient funds');
        }
        
        return $this->update($charId, [$type => $newAmount]);
    }
}
```

### **5. Dashboard Controller (app/Controllers/DashboardController.php)**
```php
<?php
class DashboardController extends BaseController {
    private $characterModel;
    private $userModel;
    private $bankModel;
    
    public function __construct() {
        parent::__construct();
        $this->characterModel = new Character();
        $this->userModel = new User();
        $this->bankModel = new BankUser();
    }
    
    public function index() {
        // Check authentication
        if (!$this->auth->isLoggedIn()) {
            header('Location: /auth/login');
            exit;
        }
        
        // Get dashboard statistics
        $stats = $this->getDashboardStats();
        
        // Get recent activity
        $recentActivity = $this->getRecentActivity();
        
        // Get charts data
        $chartsData = $this->getChartsData();
        
        $this->view('dashboard/index', [
            'stats' => $stats,
            'recentActivity' => $recentActivity,
            'chartsData' => $chartsData,
            'pageTitle' => 'Dashboard Overview'
        ]);
    }
    
    private function getDashboardStats() {
        return [
            'serverStatus' => [
                'uptime' => $this->getServerUptime(),
                'activeUsers' => $this->characterModel->count(['LastLogin >=' => date('Y-m-d', strtotime('-24 hours'))]),
                'totalUsers' => $this->userModel->count(),
                'bannedUsers' => $this->userModel->count(['banned' => 1])
            ],
            'economyOverview' => [
                'totalMoney' => $this->getTotalMoney(),
                'totalGold' => $this->getTotalGold(),
                'bankAccounts' => $this->bankModel->count(),
                'avgWealth' => $this->getAverageWealth()
            ],
            'playerMetrics' => [
                'totalCharacters' => $this->characterModel->count(),
                'activeToday' => $this->characterModel->count(['LastLogin >=' => date('Y-m-d')]),
                'newThisWeek' => $this->characterModel->count(['LastLogin >=' => date('Y-m-d', strtotime('-7 days'))]),
                'maxLevel' => $this->getMaxPlayerLevel()
            ],
            'contentStats' => [
                'totalItems' => $this->getItemCount(),
                'totalHorses' => $this->getHorseCount(),
                'activeHouses' => $this->getActiveHouseCount(),
                'totalPosses' => $this->getPosseCount()
            ]
        ];
    }
    
    private function getTotalMoney() {
        $stmt = $this->db->prepare("
            SELECT 
                (SELECT COALESCE(SUM(money), 0) FROM characters) +
                (SELECT COALESCE(SUM(money), 0) FROM bank_users) as total_money
        ");
        $stmt->execute();
        return $stmt->fetchColumn() ?: 0;
    }
    
    private function getChartsData() {
        return [
            'playerActivity' => $this->getPlayerActivityChart(),
            'economyTrends' => $this->getEconomyTrendsChart(),
            'wealthDistribution' => $this->characterModel->getWealthDistribution()
        ];
    }
    
    // AJAX endpoint for real-time updates
    public function getRealtimeStats() {
        if (!$this->auth->hasPermission('view.analytics')) {
            http_response_code(403);
            echo json_encode(['error' => 'Access denied']);
            return;
        }
        
        $stats = [
            'activeUsers' => $this->characterModel->count(['LastLogin >=' => date('Y-m-d H:i:s', strtotime('-1 hour'))]),
            'serverLoad' => sys_getloadavg()[0],
            'memoryUsage' => $this->getMemoryUsage(),
            'recentTransactions' => $this->getRecentTransactions(10)
        ];
        
        header('Content-Type: application/json');
        echo json_encode($stats);
    }
}
```

---

## 🎨 Bootstrap Frontend Implementation

### **6. Main Layout (app/Views/layouts/main.php)**
```php
<!DOCTYPE html>
<html lang="en" data-bs-theme="<?= $_SESSION['theme'] ?? 'light' ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $pageTitle ?? 'Gaming Dashboard' ?> - RDR2 Server Admin</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Custom CSS -->
    <link href="/assets/css/custom.css" rel="stylesheet">
    
    <!-- CSRF Token -->
    <meta name="csrf-token" content="<?= $_SESSION['csrf_token'] ?? '' ?>">
</head>
<body>
    <!-- Navigation -->
    <?php include 'header.php'; ?>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 px-0">
                <?php include 'sidebar.php'; ?>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <main class="p-4">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/dashboard">Dashboard</a></li>
                            <?php if (isset($breadcrumb)): ?>
                                <?php foreach ($breadcrumb as $item): ?>
                                    <li class="breadcrumb-item <?= $item['active'] ? 'active' : '' ?>">
                                        <?php if ($item['active']): ?>
                                            <?= $item['title'] ?>
                                        <?php else: ?>
                                            <a href="<?= $item['url'] ?>"><?= $item['title'] ?></a>
                                        <?php endif; ?>
                                    </li>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </ol>
                    </nav>
                    
                    <!-- Alert Messages -->
                    <?php if (isset($_SESSION['success'])): ?>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <?= $_SESSION['success'] ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <?php unset($_SESSION['success']); ?>
                    <?php endif; ?>
                    
                    <?php if (isset($_SESSION['error'])): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <?= $_SESSION['error'] ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <?php unset($_SESSION['error']); ?>
                    <?php endif; ?>
                    
                    <!-- Page Content -->
                    <?= $content ?>
                </main>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <?php include 'footer.php'; ?>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Custom JS -->
    <script src="/assets/js/custom.js"></script>
    
    <!-- Page-specific scripts -->
    <?php if (isset($scripts)): ?>
        <?php foreach ($scripts as $script): ?>
            <script src="<?= $script ?>"></script>
        <?php endforeach; ?>
    <?php endif; ?>
</body>
</html>
```

### **7. Sidebar Navigation (app/Views/layouts/sidebar.php)**
```php
<nav class="navbar navbar-expand-md navbar-dark bg-dark flex-md-column p-0 vh-100">
    <div class="container-fluid flex-md-column align-items-start p-3">
        <!-- Logo -->
        <a class="navbar-brand mb-3" href="/dashboard">
            <i class="bi bi-controller"></i>
            RDR2 Admin
        </a>
        
        <!-- Navigation Menu -->
        <ul class="navbar-nav flex-column w-100">
            <!-- Dashboard -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'dashboard' ? 'active' : '' ?>" href="/dashboard">
                    <i class="bi bi-speedometer2"></i>
                    Dashboard
                </a>
            </li>
            
            <?php if ($auth->hasPermission('users.view')): ?>
            <!-- User Management -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'users' ? 'active' : '' ?>" href="/users">
                    <i class="bi bi-people"></i>
                    User Management
                </a>
            </li>
            <?php endif; ?>
            
            <?php if ($auth->hasPermission('characters.view')): ?>
            <!-- Character Management -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'characters' ? 'active' : '' ?>" href="/characters">
                    <i class="bi bi-person-badge"></i>
                    Characters
                </a>
            </li>
            <?php endif; ?>
            
            <?php if ($auth->hasPermission('economy.view')): ?>
            <!-- Economy -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'economy' ? 'active' : '' ?>" href="/economy">
                    <i class="bi bi-currency-dollar"></i>
                    Economy
                </a>
            </li>
            <?php endif; ?>
            
            <?php if ($auth->hasPermission('housing.view')): ?>
            <!-- Housing -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'housing' ? 'active' : '' ?>" href="/housing">
                    <i class="bi bi-house"></i>
                    Housing
                </a>
            </li>
            <?php endif; ?>
            
            <!-- Inventory -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="bi bi-box"></i>
                    Inventory
                </a>
                <ul class="dropdown-menu dropdown-menu-dark">
                    <li><a class="dropdown-item" href="/inventory/items">Items Database</a></li>
                    <li><a class="dropdown-item" href="/inventory/crafted">Crafted Items</a></li>
                    <li><a class="dropdown-item" href="/inventory/distribution">Distribution</a></li>
                </ul>
            </li>
            
            <!-- Animals & Mounts -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="bi bi-emoji-dizzy"></i>
                    Animals
                </a>
                <ul class="dropdown-menu dropdown-menu-dark">
                    <li><a class="dropdown-item" href="/animals/horses">Horses</a></li>
                    <li><a class="dropdown-item" href="/animals/pets">Pets</a></li>
                    <li><a class="dropdown-item" href="/animals/wagons">Wagons</a></li>
                </ul>
            </li>
            
            <!-- Analytics -->
            <li class="nav-item">
                <a class="nav-link <?= $currentPage === 'analytics' ? 'active' : '' ?>" href="/analytics">
                    <i class="bi bi-graph-up"></i>
                    Analytics
                </a>
            </li>
            
            <!-- System Settings -->
            <?php if ($auth->hasPermission('system.admin')): ?>
            <li class="nav-item mt-3">
                <hr class="text-muted">
                <a class="nav-link text-muted" href="/settings">
                    <i class="bi bi-gear"></i>
                    Settings
                </a>
            </li>
            <?php endif; ?>
        </ul>
        
        <!-- User Info -->
        <div class="mt-auto w-100">
            <div class="dropdown">
                <a class="nav-link dropdown-toggle text-muted" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle"></i>
                    <?= $_SESSION['username'] ?? 'Admin' ?>
                </a>
                <ul class="dropdown-menu dropdown-menu-dark">
                    <li><a class="dropdown-item" href="/profile">Profile</a></li>
                    <li><a class="dropdown-item" href="/auth/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
```

### **8. Dashboard View (app/Views/dashboard/index.php)**
```php
<!-- Dashboard Overview Cards -->
<div class="row mb-4">
    <!-- Server Status Card -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="card border-primary">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h6 class="card-title text-primary">Server Status</h6>
                        <h2 class="mb-0" id="active-users"><?= $stats['serverStatus']['activeUsers'] ?></h2>
                        <small class="text-muted">Active Users</small>
                    </div>
                    <div class="align-self-center">
                        <i class="bi bi-server text-primary" style="font-size: 2rem;"></i>
                    </div>
                </div>
                <div class="mt-3">
                    <span class="badge bg-success">Online</span>
                    <small class="text-muted">Uptime: <?= $stats['serverStatus']['uptime'] ?></small>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Economy Overview Card -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="card border-success">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h6 class="card-title text-success">Total Wealth</h6>
                        <h2 class="mb-0">$<?= number_format($stats['economyOverview']['totalMoney']) ?></h2>
                        <small class="text-muted"><?= number_format($stats['economyOverview']['totalGold']) ?> Gold</small>
                    </div>
                    <div class="align-self-center">
                        <i class="bi bi-currency-dollar text-success" style="font-size: 2rem;"></i>
                    </div>
                </div>
                <div class="mt-3">
                    <small class="text-muted">Bank Accounts: <?= $stats['economyOverview']['bankAccounts'] ?></small>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Player Metrics Card -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="card border-info">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h6 class="card-title text-info">Players</h6>
                        <h2 class="mb-0"><?= $stats['playerMetrics']['totalCharacters'] ?></h2>
                        <small class="text-muted">Total Characters</small>
                    </div>
                    <div class="align-self-center">
                        <i class="bi bi-people text-info" style="font-size: 2rem;"></i>
                    </div>
                </div>
                <div class="mt-3">
                    <span class="text-success"><?= $stats['playerMetrics']['activeToday'] ?></span>
                    <small class="text-muted">active today</small>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Content Stats Card -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="card border-warning">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h6 class="card-title text-warning">Content</h6>
                        <h2 class="mb-0"><?= $stats['contentStats']['totalItems'] ?></h2>
                        <small class="text-muted">Items in Database</small>
                    </div>
                    <div class="align-self-center">
                        <i class="bi bi-box text-warning" style="font-size: 2rem;"></i>
                    </div>
                </div>
                <div class="mt-3">
                    <small class="text-muted">
                        <?= $stats['contentStats']['totalHorses'] ?> Horses, 
                        <?= $stats['contentStats']['activeHouses'] ?> Houses
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Charts Row -->
<div class="row mb-4">
    <!-- Player Activity Chart -->
    <div class="col-lg-8 mb-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Player Activity (Last 7 Days)</h5>
            </div>
            <div class="card-body">
                <canvas id="playerActivityChart" height="100"></canvas>
            </div>
        </div>
    </div>
    
    <!-- Wealth Distribution Chart -->
    <div class="col-lg-4 mb-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Wealth Distribution</h5>
            </div>
            <div class="card-body">
                <canvas id="wealthChart" height="200"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- Recent Activity Table -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Recent Activity</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped" id="recentActivityTable">
                        <thead>
                            <tr>
                                <th>Time</th>
                                <th>User</th>
                                <th>Action</th>
                                <th>Details</th>
                                <th>IP Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($recentActivity as $activity): ?>
                            <tr>
                                <td><?= date('M j, Y H:i', strtotime($activity['timestamp'])) ?></td>
                                <td>
                                    <span class="badge bg-primary"><?= htmlspecialchars($activity['username']) ?></span>
                                </td>
                                <td>
                                    <?php
                                    $badgeClass = match($activity['action']) {
                                        'login' => 'bg-success',
                                        'logout' => 'bg-secondary',
                                        'failed_login' => 'bg-danger',
                                        'character_update' => 'bg-info',
                                        'economy_adjustment' => 'bg-warning',
                                        default => 'bg-light text-dark'
                                    };
                                    ?>
                                    <span class="badge <?= $badgeClass ?>"><?= ucfirst(str_replace('_', ' ', $activity['action'])) ?></span>
                                </td>
                                <td><?= htmlspecialchars($activity['details']) ?></td>
                                <td><small class="text-muted"><?= $activity['ip_address'] ?></small></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Charts and Real-time Updates -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Player Activity Chart
    const playerActivityCtx = document.getElementById('playerActivityChart').getContext('2d');
    new Chart(playerActivityCtx, {
        type: 'line',
        data: {
            labels: <?= json_encode($chartsData['playerActivity']['labels']) ?>,
            datasets: [{
                label: 'Active Players',
                data: <?= json_encode($chartsData['playerActivity']['data']) ?>,
                borderColor: 'rgb(75, 192, 192)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
    // Wealth Distribution Chart
    const wealthCtx = document.getElementById('wealthChart').getContext('2d');
    new Chart(wealthCtx, {
        type: 'doughnut',
        data: {
            labels: <?= json_encode(array_column($chartsData['wealthDistribution'], 'wealth_category')) ?>,
            datasets: [{
                data: <?= json_encode(array_column($chartsData['wealthDistribution'], 'player_count')) ?>,
                backgroundColor: [
                    '#FF6384',
                    '#36A2EB',
                    '#FFCE56',
                    '#4BC0C0'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });
    
    // Initialize DataTable
    $('#recentActivityTable').DataTable({
        order: [[0, 'desc']],
        pageLength: 10,
        responsive: true
    });
    
    // Real-time updates every 30 seconds
    setInterval(updateRealtimeStats, 30000);
});

function updateRealtimeStats() {
    fetch('/dashboard/realtime-stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('active-users').textContent = data.activeUsers;
            // Update other real-time elements
        })
        .catch(error => console.error('Error updating stats:', error));
}
</script>
```

This implementation provides a solid foundation for the PHP/Bootstrap/MySQL gaming dashboard with shared hosting compatibility, security features, and responsive design. The code includes proper authentication, database security, and a modern Bootstrap interface.

*Total estimated development time: 16-20 weeks*
*Hosting requirement: Standard shared hosting with PHP 8.1+ and MySQL*
