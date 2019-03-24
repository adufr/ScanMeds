const express = require('express')
const VerifyUserMiddleware = require('../middlewares/verify.user.middleware')
const AuthValidationMiddleware = require('../middlewares/auth.validation.middleware')
const AuthController = require('../controllers/auth.controller')

const router = express.Router()

/**
 * @api {post} /auth/ Login a user
 * @apiVersion 0.0.1
 * @apiName Login
 * @apiGroup Auth
 * @apiPermission none
 *
 * @apiParam {String} email    Email of the User.
 * @apiParam {String} password Password of the User.
 *
 * @apiSuccess (Success 200) {String} accessToken A token which has to be used in every request requiring authentication.
 * @apiSuccess (Success 200) {String} refreshToken A token which can be used to refresh a token that has timed out.
 *
 * @apiError UserNotFound There are no user with the provided informations.
 * @apiError IncorrectPassword The provided password is incorrect.
 */
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
