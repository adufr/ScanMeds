const express = require('express')
const UserController = require('../controllers/user.controller')
const PermissionMiddleware = require('../middlewares/auth.permission.middleware')
const ValidationMiddleware = require('../middlewares/auth.validation.middleware')
const UserVerificationMiddleware = require('../middlewares/verify.user.middleware')

const FREE = 1
// const PAID = 4
// const ADMIN = 2048

const router = express.Router()

router.post('/', [
  UserVerificationMiddleware.hasRegisterValidFields,
  UserVerificationMiddleware.isEmailOrUsernameNotInUse,
  UserController.create
])

router.get('/users', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
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
