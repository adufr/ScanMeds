const express = require('express')
const FavoriteController = require('../controllers/favorite.controller')
const PermissionMiddleware = require('../middlewares/auth.permission.middleware')
const ValidationMiddleware = require('../middlewares/auth.validation.middleware')

const FREE = 1
// const PAID = 4
// const ADMIN = 2048

const router = express.Router()

// ================================
// == Favorites
// ================================

// get all favorites
router.get('/favorites', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  FavoriteController.list
])

// add a medicine to user's favorites
router.post('/', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  FavoriteController.add
])

// remove a medicine from user's favorites
router.delete('/', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  FavoriteController.remove
])

module.exports = router
