# Gaming Dashboard Development Prompt
## Complete PHP/Bootstrap Implementation Guide for RDR2 Server Management System

---

## 🎯 Project Overview

**Objective:** Build a comprehensive, secure, and highly detailed gaming dashboard for Red Dead Redemption 2 server administration using PHP, Bootstrap, and MySQL, optimized for shared hosting environments like Hostinger.

**Database:** MySQL with 33 tables covering all game mechanics
**Hosting:** Hostinger shared hosting with cPanel and phpMyAdmin
**Primary Focus:** Web-based administrative control, player management, economy oversight, and real-time monitoring

---

## 🗄️ Database Structure Analysis

### Core Tables (33 total):

#### **User & Authentication Tables:**
1. `users` - System and player accounts
2. `whitelist` - Server access control
3. `characters` - Player character data

#### **Economy & Banking Tables:**
4. `bank_users` - Banking system with money/gold tracking
5. Character money fields - Economy integration

#### **Housing & Property Tables:**
6. `bcchousing` - Main housing system
7. `bcchousinghotels` - Hotel room management
8. `bcchousing_transactions` - Property transactions
9. `housing` - Additional housing data

#### **Inventory & Items Tables:**
10. `items` - Master item database (700+ items)
11. `item_group` - Item categorization system
12. `items_crafted` - Player-crafted items tracking
13. `character_inventories` - Multi-inventory system

#### **Animals & Mounts Tables:**
14. `player_horses` - Horse ownership and stats
15. `pets` - Pet management system
16. `player_wagons` - Vehicle management
17. `horse_complements` - Horse equipment
18. `stables` - Stable management
19. `wagons` - Additional vehicle data

#### **Crafting & Production Tables:**
20. `bcc_crafting_log` - Crafting activity tracking
21. `bcc_craft_progress` - Player skill progression
22. `bcc_farming` - Agricultural system
23. `brewing` - Alcohol production system

#### **Social Features Tables:**
24. `posse` - Player group management
25. `mailbox_mails` - In-game messaging
26. `bcc_camp` - Shared camp system

#### **Game Mechanics Tables:**
27. `loadout` - Weapon configurations
28. `doorlocks` - Access control system
29. `oil` - Oil business mechanics
30. `legendaries` - Legendary animal progress
31. `rooms` - Room and instance management
32. `train` - Transportation system
33. `outfits` - Character appearance

---

## 🛠️ Technical Implementation Requirements

### **Frontend Technology Stack:**
```php
// Required Libraries and Frameworks
- Bootstrap 5.3+ (CSS Framework)
- jQuery 3.6+ for DOM manipulation
- DataTables.js for advanced table functionality
- Chart.js for analytics and reporting
- Bootstrap Icons for UI elements
- SweetAlert2 for enhanced alerts
- Summernote or TinyMCE for rich text editing
- Select2 for enhanced dropdown menus
```

### **Backend Technology Stack:**
```php
// Server Architecture
- PHP 8.1+ with OOP principles
- Custom MVC framework or CodeIgniter 4
- PDO for secure database connections
- PHPMailer for email functionality
- Firebase JWT (if needed for API)
- Composer for dependency management
- Guzzle for HTTP client requests
- Monolog for logging
```

### **Database Configuration:**
```sql
-- Connection Requirements
- MySQL 8.0+ (Hostinger compatible)
- PDO connection with prepared statements
- Connection timeout: 30 seconds
- Charset: utf8mb4
- Collation: utf8mb4_unicode_ci
- Timezone: UTC
```

---

## 🏗️ Application Architecture

### **Folder Structure:**
```
gaming-dashboard/
├── public/
│   ├── index.php
│   ├── assets/
│   │   ├── css/
│   │   │   ├── bootstrap.min.css
│   │   │   ├── custom.css
│   │   │   └── themes/
│   │   ├── js/
│   │   │   ├── bootstrap.bundle.min.js
│   │   │   ├── jquery.min.js
│   │   │   ├── datatables.min.js
│   │   │   ├── chart.js
│   │   │   └── custom.js
│   │   ├── images/
│   │   └── icons/
│   └── uploads/
├── app/
│   ├── Controllers/
│   │   ├── AuthController.php
│   │   ├── DashboardController.php
│   │   ├── UserController.php
│   │   ├── CharacterController.php
│   │   ├── EconomyController.php
│   │   ├── HousingController.php
│   │   ├── InventoryController.php
│   │   ├── AnimalController.php
│   │   ├── CraftingController.php
│   │   ├── SocialController.php
│   │   └── MechanicsController.php
│   ├── Models/
│   │   ├── User.php
│   │   ├── Character.php
│   │   ├── BankUser.php
│   │   ├── Item.php
│   │   ├── PlayerHorse.php
│   │   └── [all other table models]
│   ├── Views/
│   │   ├── layouts/
│   │   │   ├── header.php
│   │   │   ├── footer.php
│   │   │   ├── sidebar.php
│   │   │   └── main.php
│   │   ├── auth/
│   │   │   ├── login.php
│   │   │   ├── register.php
│   │   │   └── forgot-password.php
│   │   ├── dashboard/
│   │   │   └── index.php
│   │   ├── users/
│   │   ├── characters/
│   │   ├── economy/
│   │   ├── housing/
│   │   ├── inventory/
│   │   ├── animals/
│   │   ├── crafting/
│   │   ├── social/
│   │   └── mechanics/
│   ├── Config/
│   │   ├── database.php
│   │   ├── app.php
│   │   └── security.php
│   ├── Middleware/
│   │   ├── AuthMiddleware.php
│   │   ├── RoleMiddleware.php
│   │   └── CSRFMiddleware.php
│   ├── Services/
│   │   ├── DatabaseService.php
│   │   ├── AuthService.php
│   │   ├── AnalyticsService.php
│   │   └── NotificationService.php
│   └── Utils/
│       ├── Validator.php
│       ├── Helper.php
│       └── Logger.php
├── storage/
│   ├── logs/
│   ├── cache/
│   └── backups/
├── vendor/
├── composer.json
├── .htaccess
└── README.md
```

---

## 🔐 Authentication & Security Implementation

### **Multi-Level Role System:**
```php
<?php
class UserRole {
    const SUPER_ADMIN = 'super_admin';
    const SERVER_ADMIN = 'server_admin';
    const MODERATOR = 'moderator';
    const SUPPORT = 'support';
    const VIEWER = 'viewer';
    
    public static function getPermissions($role) {
        $permissions = [
            self::SUPER_ADMIN => ['*'], // All permissions
            self::SERVER_ADMIN => ['users.*', 'characters.*', 'economy.*'],
            self::MODERATOR => ['characters.*', 'social.*'],
            self::SUPPORT => ['view.*'],
            self::VIEWER => ['view.analytics']
        ];
        return $permissions[$role] ?? [];
    }
}
```

### **Security Features Required:**
1. **PHP Session Implementation:**
   ```php
   // Secure session configuration
   ini_set('session.cookie_httponly', 1);
   ini_set('session.use_only_cookies', 1);
   ini_set('session.cookie_secure', 1);
   session_start();
   
   // Session regeneration for security
   session_regenerate_id(true);
   ```

2. **Password Security:**
   ```php
   // Strong password hashing
   $hashed = password_hash($password, PASSWORD_ARGON2ID, [
       'memory_cost' => 65536,
       'time_cost' => 4,
       'threads' => 3
   ]);
   
   // Password verification
   if (password_verify($password, $hashed)) {
       // Login success
   }
   ```

3. **CSRF Protection:**
   ```php
   // Generate CSRF token
   if (empty($_SESSION['csrf_token'])) {
       $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
   }
   
   // Validate CSRF token
   if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
       die('CSRF token mismatch');
   }
   ```

4. **SQL Injection Prevention:**
   ```php
   // Using PDO prepared statements
   $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ? AND status = ?");
   $stmt->execute([$userId, $status]);
   $user = $stmt->fetch(PDO::FETCH_ASSOC);
   ```

---

## 📊 Dashboard Modules Implementation

### **1. Main Dashboard Overview:**
```php
<?php
class DashboardController {
    public function index() {
        $stats = [
            'serverStatus' => [
                'uptime' => $this->getServerUptime(),
                'activeUsers' => $this->getActiveUsersCount(),
                'databaseConnections' => $this->getDatabaseConnections(),
                'serverLoad' => sys_getloadavg()[0]
            ],
            'economyOverview' => [
                'totalMoney' => $this->getTotalMoney(),
                'totalGold' => $this->getTotalGold(),
                'dailyTransactions' => $this->getDailyTransactions(),
                'inflationRate' => $this->getInflationRate()
            ],
            'playerMetrics' => [
                'totalPlayers' => $this->getTotalPlayers(),
                'activeToday' => $this->getActivePlayers(),
                'newRegistrations' => $this->getNewRegistrations(),
                'bannedUsers' => $this->getBannedUsers()
            ]
        ];
        
        $this->view('dashboard/index', compact('stats'));
    }
}
```

### **2. User Management Module:**
```php
<?php
class UserController {
    // User CRUD operations
    public function create($userData) {
        $validator = new Validator($userData, [
            'identifier' => 'required|unique:users',
            'group' => 'required|in:admin,user',
            'warnings' => 'integer|min:0'
        ]);
        
        if ($validator->fails()) {
            return $this->jsonResponse(['errors' => $validator->errors()], 400);
        }
        
        $user = User::create($userData);
        return $this->jsonResponse(['user' => $user], 201);
    }
    
    public function bulkActions($userIds, $action) {
        switch($action) {
            case 'ban':
                return User::whereIn('identifier', $userIds)->update(['banned' => 1]);
            case 'unban':
                return User::whereIn('identifier', $userIds)->update(['banned' => 0]);
            case 'delete':
                return User::whereIn('identifier', $userIds)->delete();
        }
    }
    
    public function search($criteria) {
        $query = User::query();
        
        if (!empty($criteria['search'])) {
            $query->where('steamname', 'LIKE', '%' . $criteria['search'] . '%');
        }
        
        if (!empty($criteria['group'])) {
            $query->where('group', $criteria['group']);
        }
        
        return $query->paginate(20);
    }
}
```

### **3. Character Management Module:**
```php
<?php
class CharacterController {
    public function getCharacterDetails($charId) {
        $character = Character::with(['user', 'inventories', 'horses'])
                             ->find($charId);
        
        if (!$character) {
            throw new Exception('Character not found');
        }
        
        return $character;
    }
    
    public function updateCharacterStats($charId, $stats) {
        $character = Character::find($charId);
        
        $character->update([
            'money' => $stats['money'] ?? $character->money,
            'gold' => $stats['gold'] ?? $character->gold,
            'xp' => $stats['xp'] ?? $character->xp,
            'healthouter' => $stats['health'] ?? $character->healthouter
        ]);
        
        // Log the change
        $this->logAction('character_update', [
            'character_id' => $charId,
            'changes' => $stats,
            'admin_id' => $_SESSION['user_id']
        ]);
    }
    
    public function teleportCharacter($charId, $coordinates) {
        $coords = json_encode([
            'x' => $coordinates['x'],
            'y' => $coordinates['y'],
            'z' => $coordinates['z']
        ]);
        
        Character::where('charidentifier', $charId)
                 ->update(['coords' => $coords]);
    }
}
```

### **4. Economy Management Module:**
```php
<?php
class EconomyController {
    public function getBankingOverview() {
        return [
            'totalBankMoney' => BankUser::sum('money'),
            'totalBankGold' => BankUser::sum('gold'),
            'totalCharacterMoney' => Character::sum('money'),
            'totalCharacterGold' => Character::sum('gold'),
            'bankAccounts' => BankUser::count(),
            'averageBalance' => BankUser::avg('money')
        ];
    }
    
    public function adjustBankBalance($userId, $amount, $type) {
        $bankUser = BankUser::where('identifier', $userId)->first();
        
        if ($type === 'money') {
            $bankUser->money += $amount;
        } elseif ($type === 'gold') {
            $bankUser->gold += $amount;
        }
        
        $bankUser->save();
        
        // Log transaction
        $this->logTransaction([
            'user_id' => $userId,
            'type' => $type,
            'amount' => $amount,
            'admin_id' => $_SESSION['user_id'],
            'timestamp' => date('Y-m-d H:i:s')
        ]);
    }
    
    public function flagSuspiciousActivity($threshold = 10000) {
        // Find users with large money transfers
        $suspicious = Character::where('money', '>', $threshold)
                               ->orWhere('gold', '>', $threshold)
                               ->get();
        
        return $suspicious;
    }
}
```

### **5. Housing Management Module:**
```typescript
interface HousingManagement {
  // Property operations
  getPropertyOverview(): Promise<PropertyStats>;
  transferProperty(houseId: number, newOwnerId: string): Promise<void>;
  evictPlayer(houseId: number, reason: string): Promise<void>;
  
  // Tax management
  processTaxCollection(): Promise<TaxCollectionResult>;
  adjustTaxRates(houseId: number, rate: number): Promise<void>;
  
  // Furniture management
  addFurnitureToHouse(houseId: number, furniture: FurnitureItem[]): Promise<void>;
  removeFurnitureFromHouse(houseId: number, furnitureIds: number[]): Promise<void>;
}
```

### **6. Inventory & Items Module:**
```typescript
interface InventoryManagement {
  // Item database management
  createItem(itemData: ItemCreateInput): Promise<Item>;
  updateItem(itemId: number, updates: ItemUpdateInput): Promise<Item>;
  deleteItem(itemId: number): Promise<boolean>;
  
  // Inventory operations
  getPlayerInventory(charId: number, inventoryType?: string): Promise<InventoryItem[]>;
  bulkItemDistribution(itemId: number, quantity: number, targetPlayers: number[]): Promise<void>;
  
  // Crafting management
  getCraftingProgress(charId: number): Promise<CraftingProgress>;
  adjustCraftingXP(charId: number, xpAmount: number): Promise<void>;
}
```

### **7. Animals & Mounts Module:**
```typescript
interface AnimalManagement {
  // Horse management
  getPlayerHorses(charId: number): Promise<Horse[]>;
  updateHorseStats(horseId: number, stats: HorseStats): Promise<void>;
  transferHorse(horseId: number, newOwnerId: number): Promise<void>;
  
  // Pet management
  getPlayerPets(charId: number): Promise<Pet[]>;
  updatePetStatus(petId: number, status: PetStatus): Promise<void>;
  
  // Wagon management
  getPlayerWagons(charId: number): Promise<Wagon[]>;
  repairWagon(wagonId: number): Promise<void>;
}
```

---

## 📈 Analytics & Reporting System

### **Real-time Analytics:**
```typescript
interface RealTimeAnalytics {
  // Live metrics
  getCurrentOnlineUsers(): Promise<number>;
  getServerResourceUsage(): Promise<ResourceUsage>;
  getDatabasePerformance(): Promise<DBPerformance>;
  
  // Live events
  streamPlayerActivity(): AsyncGenerator<PlayerActivity>;
  streamTransactions(): AsyncGenerator<Transaction>;
  streamSystemAlerts(): AsyncGenerator<SystemAlert>;
}
```

### **Advanced Reporting:**
```typescript
interface ReportingSystem {
  // Player reports
  generatePlayerActivityReport(playerId: string, period: DateRange): Promise<PlayerReport>;
  generateRetentionAnalysis(period: DateRange): Promise<RetentionReport>;
  
  // Economic reports
  generateEconomyReport(period: DateRange): Promise<EconomyReport>;
  generateItemUsageReport(period: DateRange): Promise<ItemUsageReport>;
  
  // Server reports
  generatePerformanceReport(period: DateRange): Promise<PerformanceReport>;
  generateSecurityReport(period: DateRange): Promise<SecurityReport>;
}
```

---

## 🔄 Real-time Features Implementation

### **Socket.io Events:**
```typescript
// Server-side events
io.emit('player:online', { playerId, timestamp });
io.emit('player:offline', { playerId, sessionDuration });
io.emit('economy:transaction', { from, to, amount, type });
io.emit('admin:alert', { level, message, timestamp });

// Client-side event handlers
socket.on('player:online', updateOnlineCount);
socket.on('economy:transaction', updateEconomyMetrics);
socket.on('admin:alert', showNotification);
```

### **Live Updates Required:**
1. Player connection status
2. Real-time transaction monitoring
3. Server resource usage
4. Database performance metrics
5. Security alert notifications
6. Administrative action confirmations

---

## 🎨 UI/UX Implementation Guidelines

### **Design System:**
```typescript
// Theme configuration
const theme = {
  palette: {
    primary: { main: '#1976d2' },
    secondary: { main: '#dc004e' },
    background: { default: '#f5f5f5', paper: '#ffffff' },
    success: { main: '#2e7d32' },
    warning: { main: '#ed6c02' },
    error: { main: '#d32f2f' }
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    h1: { fontSize: '2.5rem', fontWeight: 500 },
    h2: { fontSize: '2rem', fontWeight: 500 },
    body1: { fontSize: '1rem', lineHeight: 1.5 }
  }
};
```

### **Component Library Required:**
1. **Data Tables with:**
   - Advanced filtering
   - Column sorting
   - Pagination
   - Bulk selection
   - Export functionality

2. **Forms with:**
   - Real-time validation
   - Auto-save functionality
   - Conditional fields
   - File upload support

3. **Charts & Graphs:**
   - Line charts for trends
   - Bar charts for comparisons
   - Pie charts for distributions
   - Real-time updating charts

4. **Navigation:**
   - Collapsible sidebar
   - Breadcrumb navigation
   - Quick search functionality
   - Keyboard shortcuts

---

## 🔧 API Design Specifications

### **RESTful API Endpoints:**

#### **Authentication Endpoints:**
```
POST /api/auth/login
POST /api/auth/refresh
POST /api/auth/logout
POST /api/auth/enable-2fa
POST /api/auth/verify-2fa
```

#### **User Management Endpoints:**
```
GET    /api/users?page=1&limit=20&search=term
POST   /api/users
GET    /api/users/:id
PUT    /api/users/:id
DELETE /api/users/:id
POST   /api/users/bulk-action
```

#### **Character Management Endpoints:**
```
GET    /api/characters?page=1&limit=20
POST   /api/characters
GET    /api/characters/:id
PUT    /api/characters/:id
DELETE /api/characters/:id
POST   /api/characters/:id/teleport
POST   /api/characters/:id/inventory/add
DELETE /api/characters/:id/inventory/:itemId
```

#### **Economy Endpoints:**
```
GET    /api/economy/overview
GET    /api/economy/transactions
POST   /api/economy/adjust-balance
GET    /api/economy/reports/:type
GET    /api/banking/accounts
POST   /api/banking/transfer
```

#### **Housing Endpoints:**
```
GET    /api/housing/properties
GET    /api/housing/:id
PUT    /api/housing/:id
POST   /api/housing/:id/transfer
POST   /api/housing/tax-collection
GET    /api/housing/analytics
```

---

## 🧪 Testing Requirements

### **Testing Framework:**
```javascript
// Frontend Testing
- Jest for unit testing
- React Testing Library for component testing
- Cypress for E2E testing
- MSW for API mocking

// Backend Testing
- Jest for unit testing
- Supertest for API testing
- Database fixtures for integration testing
- Load testing with Artillery
```

### **Test Coverage Requirements:**
- Unit tests: 90%+ coverage
- Integration tests: 80%+ coverage
- E2E tests: Critical user flows
- Performance tests: All API endpoints
- Security tests: Authentication and authorization

---

## 📦 Deployment & DevOps

### **Docker Configuration:**
```dockerfile
# Frontend Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]

# Backend Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
```

### **Environment Configuration:**
```env
# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=zap1312222-1
DB_USER=admin
DB_PASS=secure_password

# Authentication
JWT_SECRET=ultra_secure_secret
JWT_REFRESH_SECRET=ultra_secure_refresh_secret
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d

# Security
BCRYPT_ROUNDS=12
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX=100

# External Services
REDIS_URL=redis://localhost:6379
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
```

---

## 📊 Performance Requirements

### **Performance Benchmarks:**
- Page load time: < 2 seconds
- API response time: < 300ms (95th percentile)
- Database query time: < 100ms average
- Real-time update latency: < 50ms
- File upload speed: > 10MB/s
- Concurrent users: 100+ simultaneous

### **Optimization Strategies:**
1. **Database Optimization:**
   - Query optimization and indexing
   - Connection pooling
   - Query result caching
   - Database partitioning for large tables

2. **Application Optimization:**
   - Code splitting and lazy loading
   - Image optimization and compression
   - CDN integration
   - Browser caching strategies

3. **Infrastructure Optimization:**
   - Load balancing
   - Auto-scaling policies
   - Performance monitoring
   - Error tracking and alerting

---

## 🔍 Monitoring & Maintenance

### **Monitoring Requirements:**
```typescript
interface MonitoringConfig {
  // Application monitoring
  responseTime: AlertThreshold;
  errorRate: AlertThreshold;
  throughput: AlertThreshold;
  
  // Infrastructure monitoring
  cpuUsage: AlertThreshold;
  memoryUsage: AlertThreshold;
  diskSpace: AlertThreshold;
  networkLatency: AlertThreshold;
  
  // Business monitoring
  activeUsers: AlertThreshold;
  transactionVolume: AlertThreshold;
  securityIncidents: AlertThreshold;
}
```

### **Maintenance Procedures:**
1. **Regular Backups:**
   - Daily database backups
   - Weekly full system backups
   - Backup verification procedures
   - Disaster recovery testing

2. **System Updates:**
   - Security patch management
   - Dependency updates
   - Performance optimization
   - Feature deployments

3. **Health Checks:**
   - Automated health monitoring
   - Performance benchmarking
   - Security vulnerability scanning
   - Code quality assessment

---

## 📋 Success Criteria

### **Technical Success Metrics:**
- System uptime: 99.9%+
- API availability: 99.95%+
- Database performance: < 100ms average query time
- Security incidents: Zero critical vulnerabilities
- Load handling: 100+ concurrent users
- Mobile responsiveness: 95%+ score

### **Functional Success Metrics:**
- Administrative task completion: 90%+ success rate
- User satisfaction: 4.5/5.0 rating
- Training time: < 2 hours for new admins
- Error reduction: 80%+ decrease in manual errors
- Efficiency gain: 50%+ faster administrative tasks

### **Business Success Metrics:**
- Server administration cost reduction: 30%+
- Player support resolution time: 50%+ faster
- Administrative oversight improvement: 95%+ visibility
- Compliance adherence: 100% audit requirements met

---

## 🎯 Implementation Checklist

### **Phase 1: Foundation (Weeks 1-4)**
- [ ] Project setup and environment configuration
- [ ] Database connection and ORM setup
- [ ] Authentication system implementation
- [ ] Basic user management functionality
- [ ] Security framework implementation
- [ ] Initial UI framework setup

### **Phase 2: Core Modules (Weeks 5-8)**
- [ ] Character management module
- [ ] Economy management system
- [ ] Basic inventory management
- [ ] User role and permission system
- [ ] Real-time update framework
- [ ] Basic analytics dashboard

### **Phase 3: Advanced Features (Weeks 9-12)**
- [ ] Housing and property management
- [ ] Advanced analytics and reporting
- [ ] Crafting and production systems
- [ ] Animals and mounts management
- [ ] Social features implementation
- [ ] Game mechanics modules

### **Phase 4: Enhancement (Weeks 13-16)**
- [ ] Mobile responsive optimization
- [ ] Advanced security features
- [ ] API development and documentation
- [ ] Integration capabilities
- [ ] Performance optimization
- [ ] Automated testing implementation

### **Phase 5: Deployment (Weeks 17-20)**
- [ ] Production environment setup
- [ ] Comprehensive testing execution
- [ ] Security audit and penetration testing
- [ ] Performance benchmarking
- [ ] Documentation completion
- [ ] Production deployment and monitoring

---

## 🔗 External Resources & Documentation

### **Required Documentation:**
1. API documentation (OpenAPI/Swagger)
2. Database schema documentation
3. User manual for administrators
4. Technical setup and deployment guide
5. Security procedures and protocols
6. Troubleshooting and maintenance guide

### **External Integrations:**
1. Steam API for player verification
2. Discord webhook integration
3. Email service for notifications
4. SMS service for 2FA
5. Cloud storage for backups
6. CDN for static asset delivery

---

*This prompt serves as a comprehensive guide for implementing a world-class gaming dashboard system. Follow each section methodically to ensure complete functionality and optimal performance.*

**Priority Focus Areas:**
1. Security and authentication
2. Database performance and optimization
3. User experience and responsive design
4. Real-time functionality and monitoring
5. Comprehensive testing and quality assurance

**Final Delivery:** A fully functional, secure, and scalable gaming dashboard that provides complete administrative control over the RDR2 server with advanced analytics, real-time monitoring, and intuitive user management capabilities.
