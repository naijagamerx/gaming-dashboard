import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import helmet from 'helmet';
import compression from 'compression';
import morgan from 'morgan';
import rateLimit from 'express-rate-limit';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

import { dbMonitor } from './config/database.js';
import apiRoutes from './routes/api.js';
import { DashboardController } from './controllers/dashboardController.js';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const server = createServer(app);
const io = new Server(server, {
  cors: {
    origin: process.env.CLIENT_URL || "http://localhost:3000",
    methods: ["GET", "POST"]
  }
});

const PORT = process.env.PORT || 5000;

// Middleware
app.use(helmet({
  contentSecurityPolicy: false // Disable for development
}));
app.use(cors());
app.use(compression());
app.use(morgan('combined'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use('/api', limiter);

// Serve static files in production
if (process.env.NODE_ENV === 'production') {
  app.use(express.static(path.join(__dirname, '../dist')));
}

// API routes
app.use('/api', apiRoutes);

// Socket.IO for real-time updates
const dashboardController = new DashboardController();

io.on('connection', (socket) => {
  console.log('Client connected:', socket.id);

  // Send initial dashboard data
  socket.emit('dashboard:initial', async () => {
    try {
      const stats = await dashboardController.getOverviewStats();
      return stats;
    } catch (error) {
      console.error('Error sending initial data:', error);
      return { error: 'Failed to load initial data' };
    }
  });

  // Handle real-time stats requests
  socket.on('dashboard:requestStats', async () => {
    try {
      const stats = await dashboardController.getOverviewStats();
      socket.emit('dashboard:stats', stats);
    } catch (error) {
      socket.emit('dashboard:error', { message: 'Failed to fetch stats' });
    }
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
  });
});

// Database change monitoring
dbMonitor.onTableChange((changes) => {
  console.log('Database changes detected:', changes);
  
  // Broadcast changes to all connected clients
  io.emit('database:changes', {
    changes,
    timestamp: new Date()
  });

  // Refresh dashboard stats when important tables change
  const importantTables = ['users', 'characters', 'bank_users', 'bcchousing'];
  const hasImportantChanges = changes.some(change => 
    importantTables.includes(change.table)
  );

  if (hasImportantChanges) {
    dashboardController.getOverviewStats().then(stats => {
      io.emit('dashboard:stats', stats);
    }).catch(error => {
      console.error('Error refreshing stats after DB change:', error);
    });
  }
});

// Start database monitoring
dbMonitor.startMonitoring(5000); // Check every 5 seconds

// Health check endpoint
app.get('/health', async (req, res) => {
  try {
    const health = await dashboardController.getSystemHealth();
    res.json(health);
  } catch (error) {
    res.status(500).json({ error: 'Health check failed' });
  }
});

// Catch-all handler for production
if (process.env.NODE_ENV === 'production') {
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../dist/index.html'));
  });
}

// Error handling middleware
app.use((error, req, res, next) => {
  console.error('Server error:', error);
  res.status(500).json({ 
    error: process.env.NODE_ENV === 'production' 
      ? 'Internal server error' 
      : error.message 
  });
});

server.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📊 Dashboard will be available at http://localhost:${PORT}`);
  console.log(`🔍 Database monitoring active`);
});

export { io };