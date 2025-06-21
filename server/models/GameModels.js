import { pool } from '../config/database.js';

class BaseModel {
  constructor(tableName, primaryKey = 'id') {
    this.tableName = tableName;
    this.primaryKey = primaryKey;
  }

  async findAll(conditions = {}, limit = null, offset = 0) {
    let query = `SELECT * FROM \`${this.tableName}\``;
    const params = [];

    if (Object.keys(conditions).length > 0) {
      const whereClause = Object.keys(conditions).map(key => `\`${key}\` = ?`).join(' AND ');
      query += ` WHERE ${whereClause}`;
      params.push(...Object.values(conditions));
    }

    if (limit) {
      query += ` LIMIT ${limit} OFFSET ${offset}`;
    }

    const [rows] = await pool.execute(query, params);
    return rows;
  }

  async findById(id) {
    const [rows] = await pool.execute(
      `SELECT * FROM \`${this.tableName}\` WHERE \`${this.primaryKey}\` = ?`,
      [id]
    );
    return rows[0] || null;
  }

  async count(conditions = {}) {
    let query = `SELECT COUNT(*) as count FROM \`${this.tableName}\``;
    const params = [];

    if (Object.keys(conditions).length > 0) {
      const whereClause = Object.keys(conditions).map(key => `\`${key}\` = ?`).join(' AND ');
      query += ` WHERE ${whereClause}`;
      params.push(...Object.values(conditions));
    }

    const [rows] = await pool.execute(query, params);
    return rows[0].count;
  }

  async create(data) {
    const fields = Object.keys(data);
    const placeholders = fields.map(() => '?').join(', ');
    const query = `INSERT INTO \`${this.tableName}\` (\`${fields.join('`, `')}\`) VALUES (${placeholders})`;
    
    const [result] = await pool.execute(query, Object.values(data));
    return result.insertId;
  }

  async update(id, data) {
    const fields = Object.keys(data);
    const setClause = fields.map(field => `\`${field}\` = ?`).join(', ');
    const query = `UPDATE \`${this.tableName}\` SET ${setClause} WHERE \`${this.primaryKey}\` = ?`;
    
    const [result] = await pool.execute(query, [...Object.values(data), id]);
    return result.affectedRows > 0;
  }

  async delete(id) {
    const [result] = await pool.execute(
      `DELETE FROM \`${this.tableName}\` WHERE \`${this.primaryKey}\` = ?`,
      [id]
    );
    return result.affectedRows > 0;
  }
}

// Specific models for RDR2 database
export class User extends BaseModel {
  constructor() {
    super('users', 'identifier');
  }

  async getWithCharacters(identifier) {
    const [rows] = await pool.execute(`
      SELECT u.*, 
             COUNT(c.charidentifier) as character_count,
             GROUP_CONCAT(c.firstname, ' ', c.lastname) as character_names
      FROM users u
      LEFT JOIN characters c ON u.identifier = c.identifier
      WHERE u.identifier = ?
      GROUP BY u.identifier
    `, [identifier]);
    return rows[0] || null;
  }

  async getActiveUsers(hours = 24) {
    const [rows] = await pool.execute(`
      SELECT u.*, c.LastLogin, c.firstname, c.lastname
      FROM users u
      JOIN characters c ON u.identifier = c.identifier
      WHERE c.LastLogin >= DATE_SUB(NOW(), INTERVAL ? HOUR)
      AND u.banned = 0
      ORDER BY c.LastLogin DESC
    `, [hours]);
    return rows;
  }
}

export class Character extends BaseModel {
  constructor() {
    super('characters', 'charidentifier');
  }

  async getWithUserInfo(charId) {
    const [rows] = await pool.execute(`
      SELECT c.*, u.group as user_group, u.banned, u.warnings
      FROM characters c
      JOIN users u ON c.identifier = u.identifier
      WHERE c.charidentifier = ?
    `, [charId]);
    return rows[0] || null;
  }

  async getWealthDistribution() {
    const [rows] = await pool.execute(`
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
    `);
    return rows;
  }

  async getTopPlayers(limit = 10) {
    const [rows] = await pool.execute(`
      SELECT firstname, lastname, money, gold, xp, hours,
             (money + gold) as total_wealth
      FROM characters
      ORDER BY total_wealth DESC
      LIMIT ?
    `, [limit]);
    return rows;
  }
}

export class BankUser extends BaseModel {
  constructor() {
    super('bank_users');
  }

  async getTotalBankWealth() {
    const [rows] = await pool.execute(`
      SELECT 
        SUM(money) as total_money,
        SUM(gold) as total_gold,
        COUNT(*) as account_count,
        AVG(money) as avg_money
      FROM bank_users
    `);
    return rows[0];
  }
}

export class Item extends BaseModel {
  constructor() {
    super('items');
  }

  async getItemsWithGroups() {
    const [rows] = await pool.execute(`
      SELECT i.*, ig.name as group_name
      FROM items i
      LEFT JOIN item_group ig ON i.groupId = ig.id
      ORDER BY ig.name, i.label
    `);
    return rows;
  }

  async getMostUsedItems(limit = 20) {
    const [rows] = await pool.execute(`
      SELECT i.item, i.label, COUNT(ci.item_crafted_id) as usage_count
      FROM items i
      JOIN items_crafted ic ON i.id = ic.item_id
      JOIN character_inventories ci ON ic.id = ci.item_crafted_id
      GROUP BY i.id
      ORDER BY usage_count DESC
      LIMIT ?
    `, [limit]);
    return rows;
  }
}

export class PlayerHorse extends BaseModel {
  constructor() {
    super('player_horses');
  }

  async getHorsesWithOwners() {
    const [rows] = await pool.execute(`
      SELECT ph.*, c.firstname, c.lastname, c.steamname
      FROM player_horses ph
      JOIN characters c ON ph.charid = c.charidentifier
      ORDER BY ph.born DESC
    `);
    return rows;
  }

  async getHorseBreedStats() {
    const [rows] = await pool.execute(`
      SELECT model, COUNT(*) as count, AVG(xp) as avg_xp, AVG(health) as avg_health
      FROM player_horses
      GROUP BY model
      ORDER BY count DESC
    `);
    return rows;
  }
}

export class Housing extends BaseModel {
  constructor() {
    super('bcchousing', 'houseid');
  }

  async getHousesWithOwners() {
    const [rows] = await pool.execute(`
      SELECT h.*, c.firstname, c.lastname, c.steamname
      FROM bcchousing h
      JOIN characters c ON h.charidentifier = c.charidentifier
      ORDER BY h.houseid
    `);
    return rows;
  }

  async getHousingStats() {
    const [rows] = await pool.execute(`
      SELECT 
        COUNT(*) as total_houses,
        SUM(CASE WHEN ownershipStatus = 'purchased' THEN 1 ELSE 0 END) as purchased,
        SUM(CASE WHEN ownershipStatus = 'rented' THEN 1 ELSE 0 END) as rented,
        AVG(ledger) as avg_ledger,
        SUM(tax_amount) as total_taxes
      FROM bcchousing
    `);
    return rows[0];
  }
}