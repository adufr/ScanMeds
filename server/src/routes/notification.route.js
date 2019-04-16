const express = require('express')
const NotificationController = require('../controllers/notification.controller')
const PermissionMiddleware = require('../middlewares/auth.permission.middleware')
const ValidationMiddleware = require('../middlewares/auth.validation.middleware')

const FREE = 1
// const PAID = 4
// const ADMIN = 2048

const router = express.Router()

// ================================
// == Notifications
// ================================

// get all notifications
router.get('/notifications', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  NotificationController.list
])

// mark a notification as read
router.patch('/read/all', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  NotificationController.readAll
])

// mark a notification as read
router.patch('/read/:notificationId', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  NotificationController.readById
])

module.exports = router
