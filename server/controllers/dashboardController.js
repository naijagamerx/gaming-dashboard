import { User, Character, BankUser, Item, PlayerHorse, Housing } from '../models/GameModels.js';
import { pool } from '../config/database.js';

export class DashboardController {
  constructor() {
    this.userModel = new User();
    this.characterModel = new Character();
    this.bankModel = new BankUser();
    this.itemModel = new Item();
    this.horseModel = new PlayerHorse();
    this.housingModel = new Housing();
  }

  async getOverviewStats() {
    try {
      const [serverStats, economyStats, playerStats, contentStats] = await Promise.all([
        this.getServerStats(),
        this.getEconomyStats(),
        this.getPlayerStats(),
        this.getContentStats()
      ]);

      return {
        server: serverStats,
        economy: economyStats,
        players: playerStats,
        content: contentStats,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('Error getting overview stats:', error);
      throw error;
    }
  }

  async getServerStats() {
    const activeUsers = await this.userModel.getActiveUsers(1); // Last hour
    const totalUsers = await this.userModel.count();
    const bannedUsers = await this.userModel.count({ banned: 1 });

    return {
      activeUsers: activeUsers.length,
      totalUsers,
      bannedUsers,
      uptime: process.uptime(),
      serverLoad: process.cpuUsage(),
      memoryUsage: process.memoryUsage()
    };
  }

  async getEconomyStats() {
    const [characterWealth] = await pool.execute(`
      SELECT SUM(money) as total_money, SUM(gold) as total_gold
      FROM characters
    `);

    const bankWealth = await this.bankModel.getTotalBankWealth();
    const wealthDistribution = await this.characterModel.getWealthDistribution();

    return {
      totalMoney: (characterWealth.total_money || 0) + (bankWealth.total_money || 0),
      totalGold: (characterWealth.total_gold || 0) + (bankWealth.total_gold || 0),
      bankAccounts: bankWealth.account_count || 0,
      wealthDistribution
    };
  }

  async getPlayerStats() {
    const totalCharacters = await this.characterModel.count();
    const activeToday = await this.characterModel.count({
      'LastLogin >=': new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString().split('T')[0]
    });

    const [maxLevelResult] = await pool.execute(`
      SELECT MAX(xp) as max_xp FROM characters
    `);

    const topPlayers = await this.characterModel.getTopPlayers(5);

    return {
      totalCharacters,
      activeToday,
      maxLevel: maxLevelResult.max_xp || 0,
      topPlayers
    };
  }

  async getContentStats() {
    const totalItems = await this.itemModel.count();
    const totalHorses = await this.horseModel.count();
    const housingStats = await this.housingModel.getHousingStats();

    const [posseCount] = await pool.execute(`SELECT COUNT(*) as count FROM posse`);

    return {
      totalItems,
      totalHorses,
      totalHouses: housingStats.total_houses || 0,
      totalPosses: posseCount.count || 0,
      housingStats
    };
  }

  async getPlayerActivity(days = 7) {
    const [rows] = await pool.execute(`
      SELECT 
        DATE(LastLogin) as date,
        COUNT(DISTINCT charidentifier) as active_players
      FROM characters
      WHERE LastLogin >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
      GROUP BY DATE(LastLogin)
      ORDER BY date
    `, [days]);

    return rows;
  }

  async getRecentActivity(limit = 50) {
    // This would require an activity log table, for now we'll simulate with character updates
    const [rows] = await pool.execute(`
      SELECT 
        c.firstname,
        c.lastname,
        c.LastLogin as timestamp,
        'character_login' as action,
        c.charidentifier
      FROM characters c
      WHERE c.LastLogin IS NOT NULL
      ORDER BY c.LastLogin DESC
      LIMIT ?
    `, [limit]);

    return rows;
  }

  async getSystemHealth() {
    try {
      // Test database connection
      await pool.execute('SELECT 1');
      
      // Get database stats
      const [dbStats] = await pool.execute(`
        SELECT 
          COUNT(*) as total_tables
        FROM information_schema.TABLES 
        WHERE TABLE_SCHEMA = DATABASE()
      `);

      // Get connection info
      const [connectionInfo] = await pool.execute('SHOW STATUS LIKE "Threads_connected"');
      
      return {
        database: {
          connected: true,
          totalTables: dbStats.total_tables,
          connections: connectionInfo.Value
        },
        server: {
          uptime: process.uptime(),
          memory: process.memoryUsage(),
          cpu: process.cpuUsage()
        }
      };
    } catch (error) {
      return {
        database: {
          connected: false,
          error: error.message
        },
        server: {
          uptime: process.uptime(),
          memory: process.memoryUsage(),
          cpu: process.cpuUsage()
        }
      };
    }
  }
}