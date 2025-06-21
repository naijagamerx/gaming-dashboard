import express from 'express';
import { AnalyticsController } from '../controllers/analyticsController.js';
import { authenticateToken, requirePermission } from '../middleware/auth.js';

const router = express.Router();
const analyticsController = new AnalyticsController();

// All analytics routes require view permission
router.use(authenticateToken);
router.use(requirePermission('view.analytics'));

// Player analytics
router.get('/player-retention', analyticsController.getPlayerRetention.bind(analyticsController));
router.get('/player-behavior', analyticsController.getPlayerBehavior.bind(analyticsController));

// Economy analytics
router.get('/economy-trends', analyticsController.getEconomyTrends.bind(analyticsController));

// Content analytics
router.get('/content-usage', analyticsController.getContentUsage.bind(analyticsController));

// Server performance
router.get('/server-performance', analyticsController.getServerPerformance.bind(analyticsController));

// Security metrics (requires admin permission)
router.get('/security-metrics', requirePermission('admin.security'), analyticsController.getSecurityMetrics.bind(analyticsController));

export default router;