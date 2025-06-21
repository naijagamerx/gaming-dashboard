import express from 'express';
import { DashboardController } from '../controllers/dashboardController.js';
import { User, Character, BankUser, Item, PlayerHorse, Housing } from '../models/GameModels.js';

const router = express.Router();
const dashboardController = new DashboardController();

// Dashboard routes
router.get('/dashboard/overview', async (req, res) => {
  try {
    const stats = await dashboardController.getOverviewStats();
    res.json(stats);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/dashboard/activity', async (req, res) => {
  try {
    const days = parseInt(req.query.days) || 7;
    const activity = await dashboardController.getPlayerActivity(days);
    res.json(activity);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/dashboard/recent', async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 50;
    const recent = await dashboardController.getRecentActivity(limit);
    res.json(recent);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/dashboard/health', async (req, res) => {
  try {
    const health = await dashboardController.getSystemHealth();
    res.json(health);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// User management routes
router.get('/users', async (req, res) => {
  try {
    const userModel = new User();
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 20;
    const offset = (page - 1) * limit;

    const users = await userModel.findAll({}, limit, offset);
    const total = await userModel.count();

    res.json({
      users,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/users/:identifier', async (req, res) => {
  try {
    const userModel = new User();
    const user = await userModel.getWithCharacters(req.params.identifier);
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Character management routes
router.get('/characters', async (req, res) => {
  try {
    const characterModel = new Character();
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 20;
    const offset = (page - 1) * limit;

    const characters = await characterModel.findAll({}, limit, offset);
    const total = await characterModel.count();

    res.json({
      characters,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/characters/:id', async (req, res) => {
  try {
    const characterModel = new Character();
    const character = await characterModel.getWithUserInfo(req.params.id);
    
    if (!character) {
      return res.status(404).json({ error: 'Character not found' });
    }

    res.json(character);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put('/characters/:id', async (req, res) => {
  try {
    const characterModel = new Character();
    const updated = await characterModel.update(req.params.id, req.body);
    
    if (!updated) {
      return res.status(404).json({ error: 'Character not found' });
    }

    res.json({ success: true, message: 'Character updated successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Economy routes
router.get('/economy/overview', async (req, res) => {
  try {
    const stats = await dashboardController.getEconomyStats();
    res.json(stats);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/economy/wealth-distribution', async (req, res) => {
  try {
    const characterModel = new Character();
    const distribution = await characterModel.getWealthDistribution();
    res.json(distribution);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Housing routes
router.get('/housing', async (req, res) => {
  try {
    const housingModel = new Housing();
    const houses = await housingModel.getHousesWithOwners();
    res.json(houses);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/housing/stats', async (req, res) => {
  try {
    const housingModel = new Housing();
    const stats = await housingModel.getHousingStats();
    res.json(stats);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Items routes
router.get('/items', async (req, res) => {
  try {
    const itemModel = new Item();
    const items = await itemModel.getItemsWithGroups();
    res.json(items);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/items/popular', async (req, res) => {
  try {
    const itemModel = new Item();
    const limit = parseInt(req.query.limit) || 20;
    const popular = await itemModel.getMostUsedItems(limit);
    res.json(popular);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Horses routes
router.get('/horses', async (req, res) => {
  try {
    const horseModel = new PlayerHorse();
    const horses = await horseModel.getHorsesWithOwners();
    res.json(horses);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/horses/breeds', async (req, res) => {
  try {
    const horseModel = new PlayerHorse();
    const breeds = await horseModel.getHorseBreedStats();
    res.json(breeds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;