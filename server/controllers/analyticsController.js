import { pool } from '../config/database.js';
import logger from '../utils/logger.js';

export class AnalyticsController {
  
  async getPlayerRetention(req, res) {
    try {
      const days = parseInt(req.query.days) || 30;
      
      const [rows] = await pool.execute(`
        SELECT 
          DATE(LastLogin) as date,
          COUNT(DISTINCT charidentifier) as returning_players,
          COUNT(DISTINCT CASE WHEN DATE(LastLogin) = CURDATE() THEN charidentifier END) as new_players
        FROM characters 
        WHERE LastLogin >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
        GROUP BY DATE(LastLogin)
        ORDER BY date
      `, [days]);

      res.json(rows);
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getPlayerRetention' });
      res.status(500).json({ error: 'Failed to get player retention data' });
    }
  }

  async getEconomyTrends(req, res) {
    try {
      const days = parseInt(req.query.days) || 30;
      
      // Get daily wealth changes
      const [wealthTrends] = await pool.execute(`
        SELECT 
          DATE(LastLogin) as date,
          AVG(money + gold) as avg_wealth,
          SUM(money + gold) as total_wealth,
          COUNT(*) as active_players
        FROM characters 
        WHERE LastLogin >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
        GROUP BY DATE(LastLogin)
        ORDER BY date
      `, [days]);

      // Get bank trends
      const [bankTrends] = await pool.execute(`
        SELECT 
          SUM(money) as total_bank_money,
          SUM(gold) as total_bank_gold,
          COUNT(*) as total_accounts,
          AVG(money) as avg_account_balance
        FROM bank_users
      `);

      res.json({
        wealthTrends,
        bankSummary: bankTrends[0]
      });
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getEconomyTrends' });
      res.status(500).json({ error: 'Failed to get economy trends' });
    }
  }

  async getContentUsage(req, res) {
    try {
      // Most popular items
      const [popularItems] = await pool.execute(`
        SELECT 
          i.item,
          i.label,
          COUNT(ci.item_crafted_id) as usage_count
        FROM items i
        JOIN items_crafted ic ON i.id = ic.item_id
        JOIN character_inventories ci ON ic.id = ci.item_crafted_id
        GROUP BY i.id
        ORDER BY usage_count DESC
        LIMIT 20
      `);

      // Horse breed popularity
      const [horseBreeds] = await pool.execute(`
        SELECT 
          model,
          COUNT(*) as count,
          AVG(xp) as avg_xp,
          AVG(health) as avg_health
        FROM player_horses
        GROUP BY model
        ORDER BY count DESC
        LIMIT 10
      `);

      // Housing statistics
      const [housingStats] = await pool.execute(`
        SELECT 
          ownershipStatus,
          COUNT(*) as count,
          AVG(ledger) as avg_ledger,
          SUM(tax_amount) as total_taxes
        FROM bcchousing
        GROUP BY ownershipStatus
      `);

      res.json({
        popularItems,
        horseBreeds,
        housingStats
      });
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getContentUsage' });
      res.status(500).json({ error: 'Failed to get content usage data' });
    }
  }

  async getServerPerformance(req, res) {
    try {
      // Database performance metrics
      const [dbStats] = await pool.execute(`
        SELECT 
          COUNT(*) as total_tables
        FROM information_schema.TABLES 
        WHERE TABLE_SCHEMA = DATABASE()
      `);

      const [connectionStats] = await pool.execute(`
        SHOW STATUS LIKE 'Threads_connected'
      `);

      const [queryStats] = await pool.execute(`
        SHOW STATUS LIKE 'Questions'
      `);

      // Table sizes
      const [tableSizes] = await pool.execute(`
        SELECT 
          table_name,
          ROUND(((data_length + index_length) / 1024 / 1024), 2) AS size_mb,
          table_rows
        FROM information_schema.TABLES 
        WHERE table_schema = DATABASE()
        ORDER BY (data_length + index_length) DESC
        LIMIT 10
      `);

      res.json({
        database: {
          totalTables: dbStats[0].total_tables,
          connections: parseInt(connectionStats[0].Value),
          totalQueries: parseInt(queryStats[0].Value),
          tableSizes
        },
        server: {
          uptime: process.uptime(),
          memory: process.memoryUsage(),
          cpu: process.cpuUsage()
        }
      });
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getServerPerformance' });
      res.status(500).json({ error: 'Failed to get server performance data' });
    }
  }

  async getPlayerBehavior(req, res) {
    try {
      // Login patterns
      const [loginPatterns] = await pool.execute(`
        SELECT 
          HOUR(LastLogin) as hour,
          COUNT(*) as login_count
        FROM characters 
        WHERE LastLogin >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        GROUP BY HOUR(LastLogin)
        ORDER BY hour
      `);

      // Session duration estimates (based on activity)
      const [sessionData] = await pool.execute(`
        SELECT 
          AVG(hours) as avg_playtime,
          MAX(hours) as max_playtime,
          MIN(hours) as min_playtime,
          COUNT(*) as total_characters
        FROM characters
        WHERE hours > 0
      `);

      // Character progression
      const [progressionData] = await pool.execute(`
        SELECT 
          CASE 
            WHEN xp < 1000 THEN 'Beginner (0-999)'
            WHEN xp < 5000 THEN 'Intermediate (1000-4999)'
            WHEN xp < 10000 THEN 'Advanced (5000-9999)'
            ELSE 'Expert (10000+)'
          END as xp_category,
          COUNT(*) as player_count,
          AVG(xp) as avg_xp
        FROM characters
        GROUP BY xp_category
      `);

      res.json({
        loginPatterns,
        sessionData: sessionData[0],
        progressionData
      });
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getPlayerBehavior' });
      res.status(500).json({ error: 'Failed to get player behavior data' });
    }
  }

  async getSecurityMetrics(req, res) {
    try {
      // Banned users
      const [bannedUsers] = await pool.execute(`
        SELECT 
          COUNT(*) as total_banned,
          COUNT(CASE WHEN banneduntil > UNIX_TIMESTAMP() THEN 1 END) as temp_banned,
          COUNT(CASE WHEN banned = 1 AND banneduntil = 0 THEN 1 END) as perm_banned
        FROM users
        WHERE banned = 1
      `);

      // Warning distribution
      const [warningStats] = await pool.execute(`
        SELECT 
          warnings,
          COUNT(*) as user_count
        FROM users
        WHERE warnings > 0
        GROUP BY warnings
        ORDER BY warnings
      `);

      // Recent bans (if we had a ban log table)
      const [recentActivity] = await pool.execute(`
        SELECT 
          identifier,
          banned,
          banneduntil,
          warnings
        FROM users
        WHERE banned = 1
        ORDER BY banneduntil DESC
        LIMIT 10
      `);

      res.json({
        bannedUsers: bannedUsers[0],
        warningStats,
        recentActivity
      });
    } catch (error) {
      logger.logError(error, { controller: 'analytics', method: 'getSecurityMetrics' });
      res.status(500).json({ error: 'Failed to get security metrics' });
    }
  }
}