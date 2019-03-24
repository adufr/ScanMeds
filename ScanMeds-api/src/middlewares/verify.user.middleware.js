const bcrypt = require('bcryptjs')
const User = require('../models/user.model')

// check if required fields aren't missing
exports.hasAuthValidFields = (req, res, next) => {
  const _email = req.body.email
  const _password = req.body.password

  const errors = []
  if (!_email) errors.push('Missing email field')
  if (!_password) errors.push('Missing password field')

  if (errors.length) {
    return res.status(400).json({
      message: 'Missing required fields',
      errors: errors
    })
  }

  return next()
}

// check if has required fields for register
exports.hasRegisterValidFields = (req, res, next) => {
  const _email = req.body.email
  const _username = req.body.username
  const _password = req.body.password

  const errors = []
  if (!_username) errors.push('Please enter a username')
  if (!_email) errors.push('Please enter a valid email')
  if (!_password) errors.push('Please enter a password')
  if (_password && _password.length < 6) errors.push('Your password must be a least 6 caracters long')

  if (errors.length) {
    return res.status(400).json({
      message: 'Invalid required fields',
      errors: errors
    })
  }

  return next()
}

// check if user has valid authentication data
exports.isPasswordAndUserMatch = async (req, res, next) => {
  const _email = req.body.email
  const _password = req.body.password

  const user = await User.findOne({ email: _email })
  if (!user) {
    return res.status(404).json({
      message: 'No user found'
    })
  }

  if (bcrypt.compareSync(_password, user.password)) {
    req.body = {
      userId: user._id,
      email: user.email,
      permissionLevel: user.permissionLevel,
      name: user.firstname + ' ' + user.lastname
    }
    return next()
  } else {
    return res.status(401).json({
      message: 'Incorrect password'
    })
  }
}

// check if email && username aren't already used
exports.isEmailOrUsernameNotInUse = async (req, res, next) => {
  const _email = req.body.email
  const _username = req.body.username

  const isEmailUsed = await User.findOne({ email: _email })
  if (isEmailUsed) {
    return res.status(409).json({
      message: 'Email already used'
    })
  }

  const isUsernameUsed = await User.findOne({ username: _username })
  if (isUsernameUsed) {
    return res.status(409).json({
      message: 'Username already used'
    })
  }

  return next()
}
