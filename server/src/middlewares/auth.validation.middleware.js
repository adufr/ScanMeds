const jwt = require('jsonwebtoken')
const crypto = require('crypto')
const config = require('../config/config')
const logger = require('../config/winston')

exports.verifyRefreshBodyField = (req, res, next) => {
  if (!req.body || !req.body.refresh_token) {
    return res.status(400).json({ error: 'You need to pass refresh_token field' })
  }
  return next()
}

exports.validRefreshNeeded = (req, res, next) => {
  const b = Buffer.from(req.body.refresh_token, 'base64')
  const refreshToken = b.toString()
  const hash = crypto.createHmac('sha512', req.jwt.refreshKey).update(req.jwt.userId + config.jwt.secret).digest('base64')

  if (hash !== refreshToken) {
    return res.status(400).json({ error: 'Invalid refresh token' })
  }

  req.body = req.jwt
  return next()
}

exports.validJWTNeeded = (req, res, next) => {
  // if there's a token
  if (config.node_env === 'development' && config.jwt.raw_token && req.query.raw_token) {
    if (req.query.raw_token === config.jwt.raw_token) {
      logger.warn('authenticated using raw_token')
      req.jwt = { permissionLevel: 1 }
      return next()
    } else {
      return res.status(400).json({ error: 'Invalid token' })
    }
  }

  // classic authentication
  if (req.headers['authorization']) {
    try {
      const authorization = req.headers['authorization'].split(' ')
      if (authorization[0] !== 'Bearer') {
        return res.status(401).send()
      } else {
        req.jwt = jwt.verify(authorization[1], config.jwt.secret)
        return next()
      }
    } catch (err) {
      return res.status(400).json({ error: 'Invalid token' })
    }
  } else {
    return res.status(401).json({ error: 'Authentication required' })
  }
}
