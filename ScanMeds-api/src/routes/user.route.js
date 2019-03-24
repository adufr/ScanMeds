const express = require('express')
const UserController = require('../controllers/user.controller')
const PermissionMiddleware = require('../middlewares/auth.permission.middleware')
const ValidationMiddleware = require('../middlewares/auth.validation.middleware')
const UserVerificationMiddleware = require('../middlewares/verify.user.middleware')

const FREE = 1
// const PAID = 4
// const ADMIN = 2048

const router = express.Router()

/**
 * @api {post} /user/ Create a new user
 * @apiVersion 0.0.1
 * @apiName CreateUser
 * @apiGroup User
 * @apiPermission none
 *
 * @apiParam {String} username    Username of the User (unique).
 * @apiParam {String} email       Email of the User (unique).
 * @apiParam {String} password    Password of the User.
 * @apiParam {String} [firstname] Firstname of the User.
 * @apiParam {String} [lastname]  Lastname of the User.
 *
 * @apiSuccess (Success 201) {String} message Response information message.
 * @apiSuccess (Success 201) {String} id      The <code>id</code> of the created user.
 *
 * @apiSuccessExample {json} Response (example):
 *     HTTP/1.1 201 Success
 *     {
 *       "message": "Your account has successfully been created",
 *       "id": "5c8950108b60e909f2ce491c"
 *     }
 *
 * @apiError UsernameAlreadyUsed There's already a User with the provided <code>username</code>.
 * @apiError EmailAlreadyUsed    There's already a User with the provided <code>email</code>.
 */
router.post('/', [
  UserVerificationMiddleware.hasRegisterValidFields,
  UserVerificationMiddleware.isEmailOrUsernameNotInUse,
  UserController.create
])

/**
 * @api {get} /user/users Get all Users
 * @apiVersion 0.0.1
 * @apiName GetUsers
 * @apiGroup User
 * @apiPermission none
 *
 * @apiSuccess (Success 200) {Array} users All Users
 *
 * @apiSuccessExample {json} Response (example):
 *     HTTP/1.1 200 Success
 *     {
 *        "users": [
 *           {
 *              "_id": "5c8946a6e2726403e512893a",
 *              "username": "John",
 *              "email": "johndoe@gmail.com",
 *              "firstname": "John",
 *              "lastname": "Doe"
 *           },
 *           {
 *              "_id": "5c8946a6e2726403e512893b",
 *              "username": "Jane",
 *              "email": "janedoe@gmail.com",
 *              "firstname": "Jane",
 *              "lastname": "Doe"
 *           }
 *        ]
 *     }
 */
router.get('/users', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  UserController.list
])

/**
 * @api {get} /user/:userId Get a User
 * @apiVersion 0.0.1
 * @apiName GetUser
 * @apiGroup User
 * @apiPermission none
 *
 * @apiSuccess (Success 200) {Object} user           The user object which contains User's data.
 * @apiSuccess (Success 200) {String} user._id       The Mongo ObjectID of the User.
 * @apiSuccess (Success 200) {String} user.username  Username of the User.
 * @apiSuccess (Success 200) {String} user.email     Email of the User.
 * @apiSuccess (Success 200) {String} user.firstname Firstname of the User.
 * @apiSuccess (Success 200) {String} user.lastname  Lastname of the User.
 *
 * @apiSuccessExample {object} Response (example):
 *     HTTP/1.1 200 Success
 *     {
 *        "user": {
 *            "_id": "5c8950108b60e909f2ce491c",
 *            "username": "Arthur",
 *            "email": "arthur@arthurdufour.com",
 *            "firstname": "Arthur",
 *            "lastname": "Dufour"
 *        }
 *     }
 *
 * @apiError UserNotFound There are no user with the provided <code>id</code>.
 */
router.get('/:userId', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.minimumPermissionLevelRequired(FREE),
  UserController.getById
])

/**
 * @api {patch} /user/:userId Updates User informations
 * @apiVersion  0.0.1
 * @apiName UpdateUser
 * @apiGroup User
 * @apiPermission none
 *
 * @apiParam {String} [firstname] New firstname to set for the User.
 * @apiParam {String} [lastname]  New lastname to set for the User.
 *
 * @apiSuccess (Success 200) {String} message Response information message.
 *
 * @apiError UserNotFound There are no user with the provided <code>id</code>.
 */
router.patch('/:userId', [
  ValidationMiddleware.validJWTNeeded,
  PermissionMiddleware.onlySameUserOrAdminCanDoThisAction,
  UserController.update
])

module.exports = router
