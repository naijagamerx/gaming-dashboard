import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

class Logger {
  constructor() {
    this.logDir = path.join(__dirname, '../../logs');
    this.ensureLogDirectory();
  }

  ensureLogDirectory() {
    if (!fs.existsSync(this.logDir)) {
      fs.mkdirSync(this.logDir, { recursive: true });
    }
  }

  log(level, message, meta = {}) {
    const timestamp = new Date().toISOString();
    const logEntry = {
      timestamp,
      level,
      message,
      ...meta
    };

    // Console output
    console.log(`[${timestamp}] ${level.toUpperCase()}: ${message}`);

    // File output
    const logFile = path.join(this.logDir, `${new Date().toISOString().split('T')[0]}.log`);
    fs.appendFileSync(logFile, JSON.stringify(logEntry) + '\n');
  }

  info(message, meta = {}) {
    this.log('info', message, meta);
  }

  warn(message, meta = {}) {
    this.log('warn', message, meta);
  }

  error(message, meta = {}) {
    this.log('error', message, meta);
  }

  debug(message, meta = {}) {
    if (process.env.NODE_ENV === 'development') {
      this.log('debug', message, meta);
    }
  }

  // Database change logging
  logDatabaseChange(changes) {
    this.info('Database changes detected', {
      type: 'database_change',
      changes: changes.map(change => ({
        table: change.table,
        timestamp: change.timestamp,
        checksum_change: {
          from: change.previousChecksum,
          to: change.currentChecksum
        }
      }))
    });
  }

  // API request logging
  logApiRequest(req, res, responseTime) {
    this.info('API Request', {
      type: 'api_request',
      method: req.method,
      url: req.url,
      ip: req.ip,
      userAgent: req.get('User-Agent'),
      responseTime: `${responseTime}ms`,
      statusCode: res.statusCode
    });
  }

  // Error logging with stack trace
  logError(error, context = {}) {
    this.error(error.message, {
      type: 'application_error',
      stack: error.stack,
      context
    });
  }
}

export default new Logger();