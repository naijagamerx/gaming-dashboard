// RDR2 Gaming Dashboard - Main JavaScript
class RDR2Dashboard {
    constructor() {
        this.socket = null;
        this.currentSection = 'dashboard';
        this.charts = {};
        this.tables = {};
        this.isConnected = false;
        
        this.init();
    }

    init() {
        this.initSocket();
        this.initNavigation();
        this.initTables();
        this.loadDashboard();
        
        // Auto-refresh every 30 seconds
        setInterval(() => this.refreshCurrentSection(), 30000);
    }

    initSocket() {
        this.socket = io();
        
        this.socket.on('connect', () => {
            this.isConnected = true;
            this.updateConnectionStatus(true);
            console.log('Connected to server');
        });

        this.socket.on('disconnect', () => {
            this.isConnected = false;
            this.updateConnectionStatus(false);
            console.log('Disconnected from server');
        });

        // Listen for database changes
        this.socket.on('database:changes', (data) => {
            this.handleDatabaseChanges(data);
        });

        // Listen for dashboard updates
        this.socket.on('dashboard:stats', (stats) => {
            this.updateDashboardStats(stats);
        });

        this.socket.on('dashboard:error', (error) => {
            this.showAlert('danger', 'Dashboard Error: ' + error.message);
        });
    }

    updateConnectionStatus(connected) {
        const statusIcon = document.getElementById('connection-status');
        const statusText = document.getElementById('connection-text');
        
        if (connected) {
            statusIcon.className = 'bi bi-circle-fill text-success me-1';
            statusText.textContent = 'Connected';
        } else {
            statusIcon.className = 'bi bi-circle-fill text-danger me-1 pulse';
            statusText.textContent = 'Disconnected';
        }
    }

    handleDatabaseChanges(data) {
        const { changes, timestamp } = data;
        
        // Show notification for database changes
        const changesList = changes.map(change => 
            `${change.table} (${new Date(change.timestamp).toLocaleTimeString()})`
        ).join(', ');
        
        this.showAlert('info', 
            `Database changes detected in: ${changesList}`, 
            'Database Update', 
            10000
        );

        // Refresh current section if affected
        const currentTables = this.getCurrentSectionTables();
        const hasRelevantChanges = changes.some(change => 
            currentTables.includes(change.table)
        );

        if (hasRelevantChanges) {
            setTimeout(() => this.refreshCurrentSection(), 1000);
        }
    }

    getCurrentSectionTables() {
        const sectionTables = {
            'dashboard': ['users', 'characters', 'bank_users', 'bcchousing'],
            'users': ['users'],
            'characters': ['characters'],
            'economy': ['characters', 'bank_users'],
            'housing': ['bcchousing'],
            'items': ['items', 'item_group'],
            'horses': ['player_horses']
        };
        
        return sectionTables[this.currentSection] || [];
    }

    initNavigation() {
        document.querySelectorAll('[data-section]').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const section = e.target.closest('[data-section]').dataset.section;
                this.showSection(section);
            });
        });
    }

    showSection(section) {
        // Update navigation
        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
        });
        document.querySelector(`[data-section="${section}"]`).classList.add('active');

        // Hide all sections
        document.querySelectorAll('.content-section').forEach(sec => {
            sec.classList.add('d-none');
        });

        // Show selected section
        document.getElementById(`${section}-section`).classList.remove('d-none');
        
        this.currentSection = section;
        this.loadSectionData(section);
    }

    async loadSectionData(section) {
        switch(section) {
            case 'dashboard':
                await this.loadDashboard();
                break;
            case 'users':
                await this.loadUsers();
                break;
            case 'characters':
                await this.loadCharacters();
                break;
            case 'economy':
                await this.loadEconomy();
                break;
            case 'housing':
                await this.loadHousing();
                break;
            case 'items':
                await this.loadItems();
                break;
            case 'horses':
                await this.loadHorses();
                break;
        }
    }

    async refreshCurrentSection() {
        if (this.isConnected) {
            await this.loadSectionData(this.currentSection);
        }
    }

    async loadDashboard() {
        try {
            const response = await fetch('/api/dashboard/overview');
            const data = await response.json();
            
            this.renderStatsCards(data);
            await this.loadCharts();
            await this.loadRecentActivity();
            
        } catch (error) {
            console.error('Error loading dashboard:', error);
            this.showAlert('danger', 'Failed to load dashboard data');
        }
    }

    renderStatsCards(data) {
        const { server, economy, players, content } = data;
        
        const cardsHtml = `
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card stats-card border-primary">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title text-primary">Server Status</h6>
                                <h2 class="mb-0">${server.activeUsers}</h2>
                                <small class="text-muted">Active Users</small>
                            </div>
                            <div class="align-self-center">
                                <i class="bi bi-server text-primary stats-icon"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-success">Online</span>
                            <small class="text-muted">Total: ${server.totalUsers}</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card stats-card border-success">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title text-success">Total Wealth</h6>
                                <h2 class="mb-0">$${this.formatNumber(economy.totalMoney)}</h2>
                                <small class="text-muted">${this.formatNumber(economy.totalGold)} Gold</small>
                            </div>
                            <div class="align-self-center">
                                <i class="bi bi-currency-dollar text-success stats-icon"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <small class="text-muted">Bank Accounts: ${economy.bankAccounts}</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card stats-card border-info">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title text-info">Players</h6>
                                <h2 class="mb-0">${players.totalCharacters}</h2>
                                <small class="text-muted">Total Characters</small>
                            </div>
                            <div class="align-self-center">
                                <i class="bi bi-people text-info stats-icon"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <span class="text-success">${players.activeToday}</span>
                            <small class="text-muted">active today</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card stats-card border-warning">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title text-warning">Content</h6>
                                <h2 class="mb-0">${content.totalItems}</h2>
                                <small class="text-muted">Items in Database</small>
                            </div>
                            <div class="align-self-center">
                                <i class="bi bi-box text-warning stats-icon"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <small class="text-muted">
                                ${content.totalHorses} Horses, ${content.totalHouses} Houses
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        document.getElementById('stats-cards').innerHTML = cardsHtml;
    }

    async loadCharts() {
        try {
            // Load activity chart data
            const activityResponse = await fetch('/api/dashboard/activity?days=7');
            const activityData = await activityResponse.json();
            
            // Load wealth distribution
            const wealthResponse = await fetch('/api/economy/wealth-distribution');
            const wealthData = await wealthResponse.json();
            
            this.renderActivityChart(activityData);
            this.renderWealthChart(wealthData);
            
        } catch (error) {
            console.error('Error loading charts:', error);
        }
    }

    renderActivityChart(data) {
        const ctx = document.getElementById('activityChart').getContext('2d');
        
        if (this.charts.activity) {
            this.charts.activity.destroy();
        }
        
        this.charts.activity = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.map(d => new Date(d.date).toLocaleDateString()),
                datasets: [{
                    label: 'Active Players',
                    data: data.map(d => d.active_players),
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    tension: 0.1,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    }

    renderWealthChart(data) {
        const ctx = document.getElementById('wealthChart').getContext('2d');
        
        if (this.charts.wealth) {
            this.charts.wealth.destroy();
        }
        
        this.charts.wealth = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: data.map(d => d.wealth_category),
                datasets: [{
                    data: data.map(d => d.player_count),
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
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    }

    async loadRecentActivity() {
        try {
            const response = await fetch('/api/dashboard/recent?limit=10');
            const data = await response.json();
            
            const tbody = document.querySelector('#recentActivityTable tbody');
            tbody.innerHTML = data.map(activity => `
                <tr>
                    <td>${new Date(activity.timestamp).toLocaleString()}</td>
                    <td>
                        <span class="badge bg-primary">${activity.firstname} ${activity.lastname}</span>
                    </td>
                    <td>
                        <span class="badge bg-info">${activity.action.replace('_', ' ')}</span>
                    </td>
                    <td>${activity.charidentifier}</td>
                </tr>
            `).join('');
            
        } catch (error) {
            console.error('Error loading recent activity:', error);
        }
    }

    async loadUsers() {
        try {
            const response = await fetch('/api/users');
            const data = await response.json();
            
            if (this.tables.users) {
                this.tables.users.destroy();
            }
            
            const tbody = document.querySelector('#usersTable tbody');
            tbody.innerHTML = data.users.map(user => `
                <tr>
                    <td class="text-truncate">${user.identifier}</td>
                    <td><span class="badge bg-secondary">${user.group}</span></td>
                    <td>${user.char || 0}</td>
                    <td>
                        ${user.warnings > 0 ? 
                            `<span class="badge bg-warning">${user.warnings}</span>` : 
                            '<span class="text-muted">0</span>'
                        }
                    </td>
                    <td>
                        ${user.banned ? 
                            '<span class="badge bg-danger">Banned</span>' : 
                            '<span class="badge bg-success">Active</span>'
                        }
                    </td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" onclick="dashboard.viewUser('${user.identifier}')">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-warning" onclick="dashboard.editUser('${user.identifier}')">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
            
            this.tables.users = $('#usersTable').DataTable({
                responsive: true,
                pageLength: 25,
                order: [[0, 'asc']]
            });
            
        } catch (error) {
            console.error('Error loading users:', error);
            this.showAlert('danger', 'Failed to load users data');
        }
    }

    async loadCharacters() {
        try {
            const response = await fetch('/api/characters');
            const data = await response.json();
            
            if (this.tables.characters) {
                this.tables.characters.destroy();
            }
            
            const tbody = document.querySelector('#charactersTable tbody');
            tbody.innerHTML = data.characters.map(char => `
                <tr>
                    <td>${char.charidentifier}</td>
                    <td>${char.firstname} ${char.lastname}</td>
                    <td>${char.steamname}</td>
                    <td>$${this.formatNumber(char.money)}</td>
                    <td>${this.formatNumber(char.gold)} Gold</td>
                    <td>${this.formatNumber(char.xp)}</td>
                    <td>${char.LastLogin ? new Date(char.LastLogin).toLocaleDateString() : 'Never'}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" onclick="dashboard.viewCharacter(${char.charidentifier})">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-warning" onclick="dashboard.editCharacter(${char.charidentifier})">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
            
            this.tables.characters = $('#charactersTable').DataTable({
                responsive: true,
                pageLength: 25,
                order: [[6, 'desc']] // Order by last login
            });
            
        } catch (error) {
            console.error('Error loading characters:', error);
            this.showAlert('danger', 'Failed to load characters data');
        }
    }

    async loadEconomy() {
        try {
            const [overviewResponse, wealthResponse] = await Promise.all([
                fetch('/api/economy/overview'),
                fetch('/api/economy/wealth-distribution')
            ]);
            
            const overview = await overviewResponse.json();
            const wealth = await wealthResponse.json();
            
            // Render economy stats cards
            const statsHtml = `
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card stats-card">
                        <div class="card-body text-center">
                            <h3 class="text-success">$${this.formatNumber(overview.totalMoney)}</h3>
                            <p class="text-muted mb-0">Total Money</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card stats-card">
                        <div class="card-body text-center">
                            <h3 class="text-warning">${this.formatNumber(overview.totalGold)}</h3>
                            <p class="text-muted mb-0">Total Gold</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card stats-card">
                        <div class="card-body text-center">
                            <h3 class="text-info">${overview.bankAccounts}</h3>
                            <p class="text-muted mb-0">Bank Accounts</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card stats-card">
                        <div class="card-body text-center">
                            <h3 class="text-primary">${wealth.length}</h3>
                            <p class="text-muted mb-0">Wealth Categories</p>
                        </div>
                    </div>
                </div>
            `;
            
            document.getElementById('economy-stats').innerHTML = statsHtml;
            
            // Render wealth distribution table
            const tbody = document.querySelector('#wealthTable tbody');
            const totalPlayers = wealth.reduce((sum, w) => sum + w.player_count, 0);
            
            tbody.innerHTML = wealth.map(w => `
                <tr>
                    <td>${w.wealth_category}</td>
                    <td>${w.player_count}</td>
                    <td>$${this.formatNumber(w.avg_wealth)}</td>
                    <td>${((w.player_count / totalPlayers) * 100).toFixed(1)}%</td>
                </tr>
            `).join('');
            
        } catch (error) {
            console.error('Error loading economy:', error);
            this.showAlert('danger', 'Failed to load economy data');
        }
    }

    async loadHousing() {
        try {
            const response = await fetch('/api/housing');
            const data = await response.json();
            
            if (this.tables.housing) {
                this.tables.housing.destroy();
            }
            
            const tbody = document.querySelector('#housingTable tbody');
            tbody.innerHTML = data.map(house => `
                <tr>
                    <td>${house.houseid}</td>
                    <td>${house.firstname} ${house.lastname}</td>
                    <td>
                        <span class="badge ${house.ownershipStatus === 'purchased' ? 'bg-success' : 'bg-info'}">
                            ${house.ownershipStatus}
                        </span>
                    </td>
                    <td>$${this.formatNumber(house.ledger)}</td>
                    <td>$${this.formatNumber(house.tax_amount)}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" onclick="dashboard.viewHouse(${house.houseid})">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-warning" onclick="dashboard.editHouse(${house.houseid})">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
            
            this.tables.housing = $('#housingTable').DataTable({
                responsive: true,
                pageLength: 25,
                order: [[0, 'asc']]
            });
            
        } catch (error) {
            console.error('Error loading housing:', error);
            this.showAlert('danger', 'Failed to load housing data');
        }
    }

    async loadItems() {
        try {
            const response = await fetch('/api/items');
            const data = await response.json();
            
            if (this.tables.items) {
                this.tables.items.destroy();
            }
            
            const tbody = document.querySelector('#itemsTable tbody');
            tbody.innerHTML = data.map(item => `
                <tr>
                    <td><code>${item.item}</code></td>
                    <td>${item.label}</td>
                    <td>
                        <span class="badge bg-secondary">${item.group_name || 'None'}</span>
                    </td>
                    <td>${item.type || 'N/A'}</td>
                    <td>${item.weight}kg</td>
                    <td>${item.limit}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" onclick="dashboard.viewItem(${item.id})">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-warning" onclick="dashboard.editItem(${item.id})">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
            
            this.tables.items = $('#itemsTable').DataTable({
                responsive: true,
                pageLength: 25,
                order: [[1, 'asc']]
            });
            
        } catch (error) {
            console.error('Error loading items:', error);
            this.showAlert('danger', 'Failed to load items data');
        }
    }

    async loadHorses() {
        try {
            const response = await fetch('/api/horses');
            const data = await response.json();
            
            if (this.tables.horses) {
                this.tables.horses.destroy();
            }
            
            const tbody = document.querySelector('#horsesTable tbody');
            tbody.innerHTML = data.map(horse => `
                <tr>
                    <td>${horse.id}</td>
                    <td>${horse.name}</td>
                    <td>${horse.model}</td>
                    <td>${horse.firstname} ${horse.lastname}</td>
                    <td>
                        <span class="badge ${horse.gender === 'male' ? 'bg-primary' : 'bg-pink'}">
                            ${horse.gender}
                        </span>
                    </td>
                    <td>${horse.xp}</td>
                    <td>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar bg-success" style="width: ${horse.health}%">
                                ${horse.health}%
                            </div>
                        </div>
                    </td>
                    <td>${new Date(horse.born).toLocaleDateString()}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" onclick="dashboard.viewHorse(${horse.id})">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-warning" onclick="dashboard.editHorse(${horse.id})">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
            
            this.tables.horses = $('#horsesTable').DataTable({
                responsive: true,
                pageLength: 25,
                order: [[7, 'desc']] // Order by birth date
            });
            
        } catch (error) {
            console.error('Error loading horses:', error);
            this.showAlert('danger', 'Failed to load horses data');
        }
    }

    initTables() {
        // Initialize empty tables to prevent errors
        this.tables = {};
    }

    updateDashboardStats(stats) {
        if (this.currentSection === 'dashboard') {
            this.renderStatsCards(stats);
        }
    }

    // Utility methods
    formatNumber(num) {
        if (num === null || num === undefined) return '0';
        return new Intl.NumberFormat().format(num);
    }

    showAlert(type, message, title = '', duration = 5000) {
        const alertsContainer = document.getElementById('change-alerts');
        const alertId = 'alert-' + Date.now();
        
        const alertHtml = `
            <div id="${alertId}" class="alert alert-${type} alert-dismissible fade show" role="alert">
                ${title ? `<strong>${title}:</strong> ` : ''}${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `;
        
        alertsContainer.insertAdjacentHTML('beforeend', alertHtml);
        
        // Auto-dismiss after duration
        if (duration > 0) {
            setTimeout(() => {
                const alert = document.getElementById(alertId);
                if (alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            }, duration);
        }
    }

    // Action methods (placeholders for future implementation)
    viewUser(identifier) {
        console.log('View user:', identifier);
        // TODO: Implement user detail modal
    }

    editUser(identifier) {
        console.log('Edit user:', identifier);
        // TODO: Implement user edit modal
    }

    viewCharacter(id) {
        console.log('View character:', id);
        // TODO: Implement character detail modal
    }

    editCharacter(id) {
        console.log('Edit character:', id);
        // TODO: Implement character edit modal
    }

    viewHouse(id) {
        console.log('View house:', id);
        // TODO: Implement house detail modal
    }

    editHouse(id) {
        console.log('Edit house:', id);
        // TODO: Implement house edit modal
    }

    viewItem(id) {
        console.log('View item:', id);
        // TODO: Implement item detail modal
    }

    editItem(id) {
        console.log('Edit item:', id);
        // TODO: Implement item edit modal
    }

    viewHorse(id) {
        console.log('View horse:', id);
        // TODO: Implement horse detail modal
    }

    editHorse(id) {
        console.log('Edit horse:', id);
        // TODO: Implement horse edit modal
    }
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.dashboard = new RDR2Dashboard();
});

// Add some global styles for pink badge
const style = document.createElement('style');
style.textContent = `
    .bg-pink {
        background-color: #e91e63 !important;
        color: white;
    }
`;
document.head.appendChild(style);