const express = require('express')
const UserController = require('../controllers/user.controller')
const PermissionMiddleware = require('../middlewares/auth.permission.middleware')
const ValidationMiddleware = require('../middlewares/auth.validation.middleware')
const UserVerificationMiddleware = require('../middlewares/verify.user.middleware')

const FREE = 1
// const PAID = 4
// const ADMIN = 2048

const router = express.Router()

// ================================
// == No authentication required
// ================================

// Checks if username is taken
router.get('/isUsernameTaken/:username', [
  UserController.isUsernameTaken
])

// Checks if email is taken
router.get('/isEmailTaken/:email', [
  UserController.isEmailTaken
])

// Create a user (register)
router.post('/', [
  UserVerificationMiddleware.hasRegisterValidFields,
  UserVerificationMiddleware.isEmailOrUsernameNotInUse,
  UserController.create
])

// ================================
// == Authentication required
// ================================

router.get('/users', [
  // ValidationMiddleware.validJWTNeeded,
  // PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  UserController.list
])

router.get('/:userId', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  UserController.getById
])

router.patch('/:userId', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.onlySameUserOrAdminCanDoThisAction,
  UserController.update
])

module.exports = router
