# RDR2 Gaming Dashboard

A comprehensive, real-time web dashboard for managing Red Dead Redemption 2 server databases. This dashboard provides complete administrative control over all game mechanics including players, characters, economy, housing, items, and more.

## 🚀 Features

### Real-time Database Monitoring
- **Live Change Detection**: Automatically detects when your SQL database is updated from external sources
- **Real-time Notifications**: Instant alerts when database changes occur
- **Auto-refresh**: Dashboard automatically updates when relevant data changes
- **Connection Status**: Live connection monitoring with visual indicators

### Comprehensive Management Modules
- **Dashboard Overview**: Real-time server statistics and key metrics
- **User Management**: Player accounts, bans, warnings, and permissions
- **Character Management**: Character stats, money, XP, inventory, and teleportation
- **Economy System**: Wealth distribution, banking, transaction monitoring
- **Housing Management**: Property ownership, taxes, furniture, and transfers
- **Inventory Control**: Items database, crafting, distribution tools
- **Animal Management**: Horses, pets, wagons, and breeding systems
- **Analytics**: Advanced reporting and data visualization

### Advanced Analytics
- Player retention and behavior analysis
- Economic trends and wealth distribution
- Content usage statistics
- Server performance monitoring
- Security metrics and threat detection

## 🛠️ Technology Stack

- **Backend**: Node.js, Express.js, MySQL2
- **Frontend**: Vanilla JavaScript, Bootstrap 5, Chart.js
- **Real-time**: Socket.IO for live updates
- **Database**: MySQL with automatic change detection
- **Security**: JWT authentication, role-based access control

## 📋 Prerequisites

- Node.js 16+ 
- MySQL 8.0+
- Your existing RDR2 server database (`zap1312222-1`)

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd rdr2-gaming-dashboard
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   ```

4. **Start the application**
   ```bash
   # Development mode (with auto-reload)
   npm run dev
   
   # Production mode
   npm start
   ```

5. **Access the dashboard**
   - Open http://localhost:3000 in your browser
   - The API runs on http://localhost:5000

## ⚙️ Configuration

### Environment Variables

```env
# Database Configuration
DB_HOST=localhost
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_NAME=zap1312222-1

# Server Configuration
PORT=5000
NODE_ENV=development
CLIENT_URL=http://localhost:3000

# Database Monitoring
DB_MONITOR_INTERVAL=5000  # Check for changes every 5 seconds
DB_CHANGE_DETECTION=true
```

### Database Permissions

Ensure your database user has the following permissions:
- `SELECT` on all tables
- `INSERT`, `UPDATE`, `DELETE` for management operations
- `CHECKSUM TABLE` for change detection
- Access to `information_schema` for metadata

## 🔍 Database Change Detection

The dashboard uses MySQL's `CHECKSUM TABLE` feature to detect changes:

- **Automatic Detection**: Monitors all tables every 5 seconds (configurable)
- **Change Notifications**: Real-time alerts when external changes occur
- **Smart Refresh**: Only refreshes relevant dashboard sections
- **Performance Optimized**: Minimal impact on database performance

### How It Works

1. **Initial Scan**: Records checksums for all tables on startup
2. **Continuous Monitoring**: Periodically checks table checksums
3. **Change Detection**: Compares current vs. stored checksums
4. **Notification**: Broadcasts changes to connected clients via Socket.IO
5. **Auto-refresh**: Updates dashboard data when important tables change

## 📊 Dashboard Sections

### 1. Overview Dashboard
- Server status and uptime
- Active player count
- Economic overview (total money/gold)
- Recent activity feed
- Player activity charts
- Wealth distribution visualization

### 2. User Management
- View all player accounts
- Ban/unban functionality
- Warning system management
- Character slot allocation
- Steam ID validation

### 3. Character Management
- Character statistics and progression
- Money and gold adjustment
- Experience point management
- Inventory viewing and editing
- Character teleportation tools

### 4. Economy System
- Total wealth tracking
- Bank account management
- Transaction monitoring
- Wealth distribution analysis
- Economic trend reporting

### 5. Housing Management
- Property ownership tracking
- Tax collection and management
- Furniture and decoration control
- Ownership transfer tools
- Housing statistics

### 6. Items & Inventory
- Complete items database
- Inventory management tools
- Item distribution system
- Crafting progress tracking
- Usage statistics

### 7. Animals & Mounts
- Horse ownership and stats
- Pet management system
- Wagon and vehicle tracking
- Breeding system oversight
- Equipment management

## 🔐 Security Features

- **Role-based Access Control**: Multiple permission levels
- **JWT Authentication**: Secure token-based authentication
- **Rate Limiting**: API request throttling
- **Input Validation**: Comprehensive data validation
- **Audit Logging**: Complete action tracking
- **CORS Protection**: Cross-origin request security

## 📈 Performance Features

- **Connection Pooling**: Optimized database connections
- **Query Optimization**: Efficient database queries
- **Caching**: Smart data caching strategies
- **Compression**: Response compression
- **Error Handling**: Comprehensive error management

## 🔧 API Endpoints

### Dashboard
- `GET /api/dashboard/overview` - Main dashboard statistics
- `GET /api/dashboard/activity` - Player activity data
- `GET /api/dashboard/health` - System health check

### Users
- `GET /api/users` - List all users
- `GET /api/users/:id` - Get user details
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Characters
- `GET /api/characters` - List all characters
- `GET /api/characters/:id` - Get character details
- `PUT /api/characters/:id` - Update character

### Economy
- `GET /api/economy/overview` - Economic statistics
- `GET /api/economy/wealth-distribution` - Wealth analysis

### Housing
- `GET /api/housing` - List all properties
- `GET /api/housing/stats` - Housing statistics

### Items
- `GET /api/items` - Items database
- `GET /api/items/popular` - Most used items

### Horses
- `GET /api/horses` - List all horses
- `GET /api/horses/breeds` - Breed statistics

## 🔄 Real-time Events

### Socket.IO Events

**Client → Server:**
- `dashboard:requestStats` - Request dashboard update

**Server → Client:**
- `dashboard:stats` - Dashboard statistics update
- `database:changes` - Database change notification
- `dashboard:error` - Error notifications

## 📝 Logging

The application provides comprehensive logging:

- **Application Logs**: All server activities
- **Database Changes**: Detailed change tracking
- **API Requests**: Request/response logging
- **Error Tracking**: Complete error stack traces
- **Security Events**: Authentication and authorization logs

Logs are stored in the `logs/` directory with daily rotation.

## 🚀 Deployment

### Development
```bash
npm run dev
```

### Production
```bash
npm run build
npm start
```

### Docker (Optional)
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Check the documentation
- Review the logs in `logs/` directory
- Open an issue on GitHub

## 🔮 Future Features

- [ ] Mobile app companion
- [ ] Advanced AI analytics
- [ ] Multi-server management
- [ ] Plugin system
- [ ] Advanced reporting tools
- [ ] Automated backup system
- [ ] Discord bot integration
- [ ] REST API for external tools

---

**Built for RDR2 server administrators who need complete control over their game database with real-time monitoring and comprehensive management tools.**