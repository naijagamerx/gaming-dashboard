import jwt from 'jsonwebtoken';
import { User } from '../models/GameModels.js';

export const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const userModel = new User();
    const user = await userModel.findById(decoded.identifier);
    
    if (!user) {
      return res.status(403).json({ error: 'Invalid token' });
    }

    req.user = user;
    next();
  } catch (error) {
    return res.status(403).json({ error: 'Invalid or expired token' });
  }
};

export const requireRole = (roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    if (!roles.includes(req.user.group)) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }

    next();
  };
};

export const requirePermission = (permission) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const userPermissions = getUserPermissions(req.user.group);
    
    if (!hasPermission(userPermissions, permission)) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }

    next();
  };
};

function getUserPermissions(role) {
  const permissions = {
    'super_admin': ['*'],
    'server_admin': ['users.*', 'characters.*', 'economy.*', 'housing.*', 'items.*', 'horses.*'],
    'moderator': ['characters.*', 'social.*', 'view.*'],
    'support': ['view.*'],
    'viewer': ['view.analytics']
  };
  
  return permissions[role] || [];
}

function hasPermission(userPermissions, requiredPermission) {
  // Check for wildcard permission
  if (userPermissions.includes('*')) {
    return true;
  }
  
  // Check specific permission
  if (userPermissions.includes(requiredPermission)) {
    return true;
  }
  
  // Check category permission (e.g., 'users.*' covers 'users.view')
  const category = requiredPermission.split('.')[0];
  if (userPermissions.includes(`${category}.*`)) {
    return true;
  }
  
  return false;
}