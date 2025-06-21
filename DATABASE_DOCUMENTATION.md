# Database Documentation
## Red Dead Redemption 2 Server Database Schema

---

## 📊 Database Overview

**Database Name:** `zap1312222-1`
**Engine:** MariaDB 11.6.2
**Charset:** utf8mb4
**Collation:** utf8mb4_uca1400_ai_ci
**Total Tables:** 33
**Game:** Red Dead Redemption 2 (RDR2) Server

---

## 🗂️ Table Categories & Relationships

### **1. User & Authentication (3 tables)**
```sql
users ←→ characters (1:N)
users ←→ whitelist (1:1)
characters ←→ [all character-related tables] (1:N)
```

### **2. Economy & Banking (2 tables)**
```sql
users ←→ bank_users (1:N)
characters ←→ bank_users (1:N)
```

### **3. Housing & Property (4 tables)**
```sql
characters ←→ bcchousing (1:N)
characters ←→ bcchousinghotels (1:N)
bcchousing ←→ bcchousing_transactions (1:N)
characters ←→ housing (1:N)
```

### **4. Inventory & Items (4 tables)**
```sql
item_group ←→ items (1:N)
items ←→ items_crafted (1:N)
characters ←→ character_inventories (1:N)
characters ←→ items_crafted (1:N)
```

### **5. Animals & Mounts (6 tables)**
```sql
characters ←→ player_horses (1:N)
characters ←→ pets (1:N)
characters ←→ player_wagons (1:N)
characters ←→ horse_complements (1:N)
characters ←→ stables (1:N)
characters ←→ wagons (1:N)
```

### **6. Crafting & Production (4 tables)**
```sql
characters ←→ bcc_crafting_log (1:N)
characters ←→ bcc_craft_progress (1:1)
characters ←→ bcc_farming (1:N)
characters ←→ brewing (1:N)
```

### **7. Social Features (3 tables)**
```sql
characters ←→ posse (1:N)
characters ←→ mailbox_mails (1:N)
characters ←→ bcc_camp (1:N)
```

### **8. Game Mechanics (7 tables)**
```sql
characters ←→ loadout (1:N)
characters ←→ doorlocks (1:N)
characters ←→ oil (1:1)
characters ←→ legendaries (1:1)
characters ←→ rooms (1:N)
characters ←→ train (1:N)
characters ←→ outfits (1:N)
```

---

## 📋 Detailed Table Schemas

### **1. users - System and Player Accounts**
```sql
CREATE TABLE `users` (
  `identifier` varchar(50) NOT NULL,           -- Steam ID (Primary Key)
  `group` varchar(50) DEFAULT 'user',          -- User role (admin/user)
  `warnings` int(11) DEFAULT 0,               -- Warning count
  `banned` tinyint(1) DEFAULT NULL,           -- Ban status
  `banneduntil` int(10) DEFAULT 0,            -- Ban expiration timestamp
  `char` int(11) DEFAULT 5                    -- Character slot limit
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **2. characters - Player Character Data**
```sql
CREATE TABLE `characters` (
  `identifier` varchar(50) NOT NULL,          -- Steam ID (Foreign Key)
  `steamname` varchar(50) NOT NULL,           -- Steam username
  `charidentifier` int(11) NOT NULL,          -- Character ID (Primary Key)
  `group` varchar(10) DEFAULT 'user',         -- Character group
  `money` double(11,2) DEFAULT 0.00,          -- Cash amount
  `gold` double(11,2) DEFAULT 0.00,           -- Gold amount
  `rol` double(11,2) NOT NULL DEFAULT 0.00,   -- Additional currency
  `xp` int(11) DEFAULT 0,                     -- Experience points
  `healthouter` int(4) DEFAULT 500,           -- Outer health
  `healthinner` int(4) DEFAULT 100,           -- Inner health
  `staminaouter` int(4) DEFAULT 100,          -- Outer stamina
  `staminainner` int(4) DEFAULT 100,          -- Inner stamina
  `hours` float NOT NULL DEFAULT 0,           -- Playtime hours
  `LastLogin` date DEFAULT NULL,              -- Last login date
  `inventory` longtext DEFAULT NULL,          -- Character inventory JSON
  `slots` decimal(20,1) NOT NULL DEFAULT 35.0, -- Inventory slots
  `job` varchar(50) DEFAULT 'unemployed',     -- Character job
  `joblabel` varchar(255) DEFAULT 'Unemployed', -- Job display name
  `meta` varchar(255) NOT NULL DEFAULT '{}', -- Metadata JSON
  `firstname` varchar(50) DEFAULT ' ',        -- Character first name
  `lastname` varchar(50) DEFAULT ' ',         -- Character last name
  `character_desc` mediumtext DEFAULT ' ',    -- Character description
  `gender` varchar(50) NOT NULL DEFAULT ' ', -- Character gender
  `age` int(11) NOT NULL DEFAULT 0,          -- Character age
  `nickname` varchar(50) DEFAULT ' ',        -- Character nickname
  `skinPlayer` longtext DEFAULT NULL,        -- Character appearance JSON
  `compPlayer` longtext DEFAULT NULL,        -- Character components JSON
  `compTints` longtext DEFAULT NULL,         -- Component tints JSON
  `jobgrade` int(11) DEFAULT 0,             -- Job grade level
  `coords` longtext DEFAULT '{}',           -- Character coordinates JSON
  `status` varchar(140) DEFAULT '{}',       -- Character status JSON
  `isdead` tinyint(1) DEFAULT 0,           -- Death status
  `skills` longtext DEFAULT NULL,          -- Character skills JSON
  `walk` varchar(50) DEFAULT 'noanim',     -- Walking animation
  `gunsmith` double(11,2) DEFAULT 0.00,    -- Gunsmith credits
  `ammo` longtext DEFAULT '{}',            -- Ammunition JSON
  `discordid` varchar(255) DEFAULT '0',    -- Discord ID
  `lastjoined` longtext DEFAULT '[]',      -- Last joined data
  `posseid` int(11) DEFAULT 0              -- Posse ID
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **3. bank_users - Banking System**
```sql
CREATE TABLE `bank_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Bank account ID
  `name` varchar(50) NOT NULL,                -- Bank location name
  `identifier` varchar(50) NOT NULL,          -- Steam ID (Foreign Key)
  `charidentifier` int(11) NOT NULL,          -- Character ID (Foreign Key)
  `money` double(22,2) DEFAULT 0.00,          -- Stored money
  `gold` double(22,2) DEFAULT 0.00,           -- Stored gold
  `items` longtext DEFAULT '[]',              -- Stored items JSON
  `invspace` int(11) NOT NULL                 -- Storage space
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **4. items - Master Item Database**
```sql
CREATE TABLE `items` (
  `item` varchar(50) NOT NULL,                -- Item code (Primary Key)
  `label` varchar(50) NOT NULL,               -- Display name
  `limit` int(11) NOT NULL DEFAULT 1,         -- Stack limit
  `can_remove` tinyint(1) NOT NULL DEFAULT 1, -- Removable flag
  `type` varchar(50) DEFAULT NULL,            -- Item type
  `usable` tinyint(1) DEFAULT NULL,           -- Usable flag
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Item ID
  `groupId` int(10) NOT NULL DEFAULT 1,       -- Group ID (Foreign Key)
  `metadata` longtext DEFAULT '{}',           -- Item metadata JSON
  `desc` varchar(5550) DEFAULT 'nice item',   -- Item description
  `degradation` tinyint(1) DEFAULT 0,         -- Degradation flag
  `weight` float(10,2) DEFAULT 0.25           -- Item weight
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **5. player_horses - Horse Management**
```sql
CREATE TABLE `player_horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Horse ID
  `identifier` varchar(50) NOT NULL,          -- Steam ID (Foreign Key)
  `charid` int(11) NOT NULL,                  -- Character ID (Foreign Key)
  `selected` int(11) NOT NULL DEFAULT 0,      -- Selected status
  `name` varchar(100) NOT NULL,               -- Horse name
  `model` varchar(100) NOT NULL,              -- Horse model
  `components` varchar(5000) DEFAULT '{}',    -- Horse components JSON
  `gender` enum('male','female') DEFAULT 'male', -- Horse gender
  `xp` int(11) NOT NULL DEFAULT 0,           -- Horse experience
  `captured` int(11) NOT NULL DEFAULT 0,      -- Captured status
  `born` datetime DEFAULT CURRENT_TIMESTAMP,  -- Birth date
  `health` int(11) NOT NULL DEFAULT 50,       -- Horse health
  `stamina` int(11) NOT NULL DEFAULT 50,      -- Horse stamina
  `writhe` int(11) NOT NULL DEFAULT 0,        -- Writhe status
  `dead` int(11) NOT NULL DEFAULT 0           -- Death status
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **6. bcchousing - Housing System**
```sql
CREATE TABLE `bcchousing` (
  `charidentifier` varchar(50) NOT NULL,      -- Character ID
  `house_coords` longtext NOT NULL,           -- House coordinates JSON
  `house_radius_limit` varchar(100) NOT NULL, -- Radius limit
  `houseid` int(11) NOT NULL AUTO_INCREMENT,  -- House ID (Primary Key)
  `furniture` longtext DEFAULT 'none',        -- Furniture data JSON
  `doors` longtext DEFAULT 'none',            -- Doors data JSON
  `allowed_ids` longtext DEFAULT 'none',      -- Allowed users JSON
  `invlimit` varchar(50) DEFAULT '200',       -- Inventory limit
  `player_source_spawnedfurn` varchar(50) DEFAULT 'none', -- Spawned furniture
  `taxes_collected` varchar(50) DEFAULT 'false', -- Tax collection status
  `ledger` float NOT NULL DEFAULT 0,          -- Financial ledger
  `tax_amount` float NOT NULL DEFAULT 0,      -- Tax amount
  `tpInt` int(10) DEFAULT 0,                  -- Teleport interior
  `tpInstance` int(10) DEFAULT 0,             -- Teleport instance
  `uniqueName` varchar(255) NOT NULL,         -- Unique house name
  `ownershipStatus` enum('purchased','rented') DEFAULT 'purchased' -- Ownership type
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **7. items_crafted - Crafted Items Tracking**
```sql
CREATE TABLE `items_crafted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Crafted item ID
  `character_id` int(11) NOT NULL,            -- Character ID (Foreign Key)
  `item_id` int(11) NOT NULL,                 -- Item ID (Foreign Key)
  `item_name` varchar(50) DEFAULT 'item',     -- Item name
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP, -- Last update
  `metadata` longtext NOT NULL               -- Item metadata JSON
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **8. character_inventories - Multi-Inventory System**
```sql
CREATE TABLE `character_inventories` (
  `character_id` int(11) DEFAULT NULL,        -- Character ID (Foreign Key)
  `inventory_type` varchar(100) DEFAULT 'default', -- Inventory type
  `item_crafted_id` int(11) NOT NULL,         -- Crafted item ID
  `item_name` varchar(50) DEFAULT 'item',     -- Item name
  `amount` int(11) DEFAULT NULL,              -- Item quantity
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP, -- Creation date
  `degradation` int(11) DEFAULT NULL,         -- Degradation level
  `percentage` int(11) DEFAULT NULL           -- Percentage value
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **9. posse - Player Groups**
```sql
CREATE TABLE `posse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Posse ID
  `identifier` varchar(50) DEFAULT '0',       -- Leader Steam ID
  `characterid` varchar(50) DEFAULT '0',      -- Leader Character ID
  `possename` varchar(50) DEFAULT NULL        -- Posse name
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### **10. bcc_crafting_log - Crafting Activity Tracking**
```sql
CREATE TABLE `bcc_crafting_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,       -- Log entry ID
  `charidentifier` varchar(50) NOT NULL,      -- Character ID
  `itemName` varchar(100) NOT NULL,           -- Crafted item name
  `itemLabel` varchar(100) NOT NULL,          -- Item display label
  `itemAmount` int(11) NOT NULL,              -- Quantity crafted
  `requiredItems` text NOT NULL,              -- Required items JSON
  `timestamp` bigint(20) NOT NULL,            -- Craft timestamp
  `status` varchar(20) NOT NULL,              -- Crafting status
  `duration` int(11) NOT NULL,                -- Craft duration
  `rewardXP` int(11) NOT NULL,                -- XP reward
  `completed_at` datetime DEFAULT NULL,       -- Completion time
  `locationId` varchar(50) DEFAULT NULL       -- Crafting location
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## 🔑 Key Relationships & Constraints

### **Primary Foreign Key Relationships:**
```sql
-- Users to Characters (1:N)
ALTER TABLE `characters`
  ADD CONSTRAINT `FK_characters_users` 
  FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) 
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Bank Users to Users (N:1)
ALTER TABLE `bank_users`
  ADD CONSTRAINT `bankusers` 
  FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) 
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Items to Item Groups (N:1)
ALTER TABLE `items`
  ADD CONSTRAINT `FK_items_item_group` 
  FOREIGN KEY (`groupId`) REFERENCES `item_group` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION;
```

### **Important Indexes:**
```sql
-- Characters table indexes for performance
ALTER TABLE `characters`
  ADD KEY `charidentifier` (`charidentifier`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `money` (`money`),
  ADD KEY `steamname` (`steamname`);

-- Player horses indexes
ALTER TABLE `player_horses`
  ADD KEY `idx_charid` (`charid`),
  ADD KEY `idx_identifier` (`identifier`);

-- Items crafted indexes
ALTER TABLE `items_crafted`
  ADD KEY `crafted_item_idx` (`character_id`);
```

---

## 📊 Data Analysis Insights

### **Player Economy Statistics:**
- **Total Money in System:** Sum of all character money + bank money
- **Gold Distribution:** Track wealth inequality
- **Transaction Patterns:** Monitor economic activity
- **Item Circulation:** Track item usage and popularity

### **Player Engagement Metrics:**
- **Active Players:** Characters with recent login dates
- **Playtime Analysis:** Hours distribution across players
- **Character Progression:** XP and skill development tracking
- **Social Engagement:** Posse participation and mail activity

### **Content Usage Analysis:**
- **Housing Utilization:** Property ownership and usage
- **Crafting Activity:** Most popular recipes and items
- **Animal Management:** Horse and pet ownership patterns
- **Item Popularity:** Most used and valuable items

---

## 🛠️ Database Optimization Recommendations

### **Performance Optimizations:**
1. **Index Optimization:**
   ```sql
   -- Add composite indexes for common queries
   ALTER TABLE `characters` ADD INDEX `idx_identifier_char` (`identifier`, `charidentifier`);
   ALTER TABLE `items_crafted` ADD INDEX `idx_char_item` (`character_id`, `item_id`);
   ALTER TABLE `character_inventories` ADD INDEX `idx_char_type` (`character_id`, `inventory_type`);
   ```

2. **Query Optimization:**
   ```sql
   -- Use EXPLAIN for slow queries
   EXPLAIN SELECT * FROM characters WHERE identifier = 'steam:xxxxx';
   
   -- Optimize JOIN operations
   SELECT c.*, u.group FROM characters c 
   JOIN users u ON c.identifier = u.identifier 
   WHERE c.charidentifier = 1;
   ```

3. **Table Partitioning:**
   ```sql
   -- Partition large tables by date for better performance
   ALTER TABLE `bcc_crafting_log` 
   PARTITION BY RANGE (YEAR(FROM_UNIXTIME(timestamp))) (
     PARTITION p2024 VALUES LESS THAN (2025),
     PARTITION p2025 VALUES LESS THAN (2026),
     PARTITION p_future VALUES LESS THAN MAXVALUE
   );
   ```

### **Maintenance Procedures:**
1. **Regular Statistics Updates:**
   ```sql
   ANALYZE TABLE characters, items, player_horses, bank_users;
   ```

2. **Index Maintenance:**
   ```sql
   OPTIMIZE TABLE characters;
   CHECK TABLE items;
   REPAIR TABLE items_crafted;
   ```

3. **Cleanup Procedures:**
   ```sql
   -- Remove old audit logs
   DELETE FROM bcc_crafting_log WHERE completed_at < DATE_SUB(NOW(), INTERVAL 6 MONTH);
   
   -- Clean up orphaned records
   DELETE FROM character_inventories 
   WHERE character_id NOT IN (SELECT charidentifier FROM characters);
   ```

---

## 🔐 Security Considerations

### **Data Protection:**
1. **Sensitive Data Encryption:**
   - Steam IDs should be hashed for privacy
   - Player coordinates should be encrypted
   - Discord IDs require protection

2. **Access Control:**
   - Implement row-level security for character data
   - Restrict administrative access to user management
   - Audit all data modifications

3. **Data Validation:**
   ```sql
   -- Add constraints for data integrity
   ALTER TABLE `characters` ADD CONSTRAINT `chk_money` CHECK (`money` >= 0);
   ALTER TABLE `bank_users` ADD CONSTRAINT `chk_gold` CHECK (`gold` >= 0);
   ALTER TABLE `player_horses` ADD CONSTRAINT `chk_health` CHECK (`health` BETWEEN 0 AND 100);
   ```

### **Backup Strategy:**
1. **Full Database Backup:**
   ```bash
   mysqldump --single-transaction --routines --triggers zap1312222-1 > backup_$(date +%Y%m%d).sql
   ```

2. **Table-Specific Backups:**
   ```bash
   mysqldump --single-transaction zap1312222-1 characters users > critical_data_backup.sql
   ```

3. **Point-in-Time Recovery:**
   - Enable binary logging
   - Regular backup scheduling
   - Test recovery procedures

---

## 📈 Monitoring & Alerts

### **Performance Monitoring:**
```sql
-- Monitor slow queries
SELECT * FROM information_schema.PROCESSLIST 
WHERE COMMAND != 'Sleep' AND TIME > 5;

-- Check table sizes
SELECT table_name, 
       ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)"
FROM information_schema.TABLES 
WHERE table_schema = 'zap1312222-1'
ORDER BY (data_length + index_length) DESC;

-- Monitor connections
SHOW PROCESSLIST;
SHOW STATUS LIKE 'Threads_connected';
```

### **Data Quality Monitoring:**
```sql
-- Check for orphaned records
SELECT COUNT(*) FROM character_inventories ci
LEFT JOIN characters c ON ci.character_id = c.charidentifier
WHERE c.charidentifier IS NULL;

-- Validate data integrity
SELECT COUNT(*) FROM bank_users bu
LEFT JOIN users u ON bu.identifier = u.identifier
WHERE u.identifier IS NULL;

-- Monitor unusual activity
SELECT identifier, COUNT(*) as char_count
FROM characters
GROUP BY identifier
HAVING char_count > 5;
```

---

## 🔍 Useful Queries for Dashboard

### **Player Statistics:**
```sql
-- Active players in last 30 days
SELECT COUNT(DISTINCT identifier) as active_players
FROM characters
WHERE LastLogin >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Wealth distribution
SELECT 
  CASE 
    WHEN money < 100 THEN 'Poor (0-99)'
    WHEN money < 1000 THEN 'Middle (100-999)'
    WHEN money < 10000 THEN 'Rich (1000-9999)'
    ELSE 'Very Rich (10000+)'
  END as wealth_category,
  COUNT(*) as player_count
FROM characters
GROUP BY wealth_category;

-- Top 10 richest players
SELECT firstname, lastname, money, gold, (money + gold) as total_wealth
FROM characters
ORDER BY total_wealth DESC
LIMIT 10;
```

### **Economy Analysis:**
```sql
-- Total money in circulation
SELECT 
  SUM(c.money) as character_money,
  SUM(b.money) as bank_money,
  SUM(c.money + b.money) as total_money
FROM characters c
LEFT JOIN bank_users b ON c.charidentifier = b.charidentifier;

-- Daily transaction volume (from crafting log)
SELECT 
  DATE(completed_at) as transaction_date,
  COUNT(*) as transaction_count,
  SUM(itemAmount) as items_crafted
FROM bcc_crafting_log
WHERE completed_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY DATE(completed_at)
ORDER BY transaction_date;
```

### **Content Usage:**
```sql
-- Most popular items
SELECT item_name, COUNT(*) as usage_count
FROM items_crafted
GROUP BY item_name
ORDER BY usage_count DESC
LIMIT 20;

-- Housing occupancy
SELECT 
  COUNT(*) as total_houses,
  COUNT(CASE WHEN ownershipStatus = 'purchased' THEN 1 END) as purchased,
  COUNT(CASE WHEN ownershipStatus = 'rented' THEN 1 END) as rented
FROM bcchousing;

-- Horse breeds popularity
SELECT model, COUNT(*) as horse_count
FROM player_horses
GROUP BY model
ORDER BY horse_count DESC;
```

---

This documentation provides a comprehensive overview of the RDR2 server database structure, enabling effective dashboard development and database management. The schema analysis reveals a complex gaming ecosystem with detailed tracking of player progression, economy, social interactions, and game mechanics.

*Last Updated: June 21, 2025*
*Database Version: MariaDB 11.6.2*
