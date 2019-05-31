const crypto = require('crypto')
const jwt = require('jsonwebtoken')
const jwtSecret = require('../config/config').jwt.secret
const User = require('../models/user.model')

exports.login = async (req, res) => {
  const _userId = req.body.userId

  // creating an access token from user's id and jwt's secret
  const refreshId = _userId + jwtSecret
  const salt = crypto.randomBytes(16).toString('base64')
  const hash = crypto.createHmac('sha512', salt).update(refreshId).digest('base64')
  req.body.refreshKey = salt
  const token = jwt.sign(req.body, jwtSecret)
  const b = Buffer.from(hash)
  const refreshToken = b.toString('base64')

  const user = await User.findById(_userId)
    .select('firstname lastname username email')
    .lean()

  res.status(201).json({
    user,
    accessToken: token,
    refreshToken
  })
}

exports.refresh_token = (req, res) => {
  req.body = req.jwt
  const token = jwt.sign(req.body, jwtSecret)
  res.status(201).json({ id: token })
}
