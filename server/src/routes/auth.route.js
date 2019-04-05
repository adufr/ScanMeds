const express = require('express')
const VerifyUserMiddleware = require('../middlewares/verify.user.middleware')
const AuthValidationMiddleware = require('../middlewares/auth.validation.middleware')
const AuthController = require('../controllers/auth.controller')

const router = express.Router()

router.post('/', [
  VerifyUserMiddleware.hasAuthValidFields,
  VerifyUserMiddleware.isPasswordAndUserMatch,
  AuthController.login
])

router.post('/refresh', [
  AuthValidationMiddleware.validJWTNeeded,
  AuthValidationMiddleware.verifyRefreshBodyField,
  AuthValidationMiddleware.validRefreshNeeded,
  AuthController.login
])

module.exports = router
