import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'zap1312222-1',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  acquireTimeout: 60000,
  timeout: 60000,
  reconnect: true
};

// Create connection pool
const pool = mysql.createPool(dbConfig);

// Database change detection setup
class DatabaseMonitor {
  constructor() {
    this.lastChecksums = new Map();
    this.watchers = new Map();
  }

  async getTableChecksum(tableName) {
    try {
      const [rows] = await pool.execute(`CHECKSUM TABLE \`${tableName}\``);
      return rows[0]?.Checksum || 0;
    } catch (error) {
      console.error(`Error getting checksum for ${tableName}:`, error);
      return 0;
    }
  }

  async getAllTables() {
    try {
      const [rows] = await pool.execute(`
        SELECT TABLE_NAME 
        FROM information_schema.TABLES 
        WHERE TABLE_SCHEMA = ? 
        AND TABLE_TYPE = 'BASE TABLE'
      `, [process.env.DB_NAME || 'zap1312222-1']);
      
      return rows.map(row => row.TABLE_NAME);
    } catch (error) {
      console.error('Error getting table list:', error);
      return [];
    }
  }

  async detectChanges() {
    const tables = await this.getAllTables();
    const changes = [];

    for (const table of tables) {
      const currentChecksum = await this.getTableChecksum(table);
      const lastChecksum = this.lastChecksums.get(table);

      if (lastChecksum !== undefined && currentChecksum !== lastChecksum) {
        changes.push({
          table,
          previousChecksum: lastChecksum,
          currentChecksum,
          timestamp: new Date()
        });
      }

      this.lastChecksums.set(table, currentChecksum);
    }

    return changes;
  }

  async initializeChecksums() {
    const tables = await this.getAllTables();
    for (const table of tables) {
      const checksum = await this.getTableChecksum(table);
      this.lastChecksums.set(table, checksum);
    }
    console.log(`Initialized checksums for ${tables.length} tables`);
  }

  onTableChange(callback) {
    this.changeCallback = callback;
  }

  async startMonitoring(intervalMs = 5000) {
    await this.initializeChecksums();
    
    setInterval(async () => {
      const changes = await this.detectChanges();
      if (changes.length > 0 && this.changeCallback) {
        this.changeCallback(changes);
      }
    }, intervalMs);
  }
}

const dbMonitor = new DatabaseMonitor();

export { pool, dbMonitor };