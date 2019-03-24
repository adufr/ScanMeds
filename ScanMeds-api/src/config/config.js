const convict = require('convict')
require('dotenv').config()

const config = convict({
  node_env: {
    doc: 'The application runtime environment',
    format: ['development', 'production'],
    default: 'development',
    arg: 'node_env',
    env: 'NODE_ENV'
  },
  app_port: {
    doc: 'The API port',
    format: Number,
    default: 3000,
    arg: 'app_port',
    env: 'APP_PORT'
  },
  populate: {
    doc: 'Should populate DB w/ fake dataset?',
    format: Boolean,
    default: false,
    arg: 'populate',
    env: 'POPULATE'
  },
  db: {
    host: {
      doc: 'The MongoDB hostname',
      format: String,
      default: '127.0.0.1',
      arg: 'db_host',
      env: 'DB_HOST'
    },
    port: {
      doc: 'The MongoDB port',
      format: Number,
      default: '27017',
      arg: 'db_port',
      env: 'DB_PORT'
    },
    name: {
      doc: 'The MongoDB database name',
      format: String,
      default: 'api-boilerplate',
      arg: 'db_name',
      env: 'DB_NAME'
    },
    user: {
      doc: 'The MongoDB user',
      format: String,
      default: 'username',
      arg: 'db_user',
      env: 'DB_USER'
    },
    password: {
      doc: `The MongoDB user's password`,
      format: String,
      default: 'password',
      arg: 'db_password',
      env: 'DB_PASSWORD'
    }
  },
  jwt: {
    secret: {
      doc: `JWT's secret token`,
      format: String,
      default: 'imasecret',
      arg: 'jwt_secret',
      env: 'JWT_SECRET'
    },
    expiration: {
      doc: `JWT's secret token expiration time (in seconds)`,
      format: Number,
      default: '36000',
      arg: 'jwt_expiration',
      env: 'JWT_EXPIRATION'
    },
    raw_token: {
      doc: `Clear token (ONLY USED IN DEV)`,
      format: String,
      default: '',
      arg: 'jwt_raw_token',
      env: 'JWT_RAW_TOKEN'
    }
  }
})

config.validate({ allowed: 'strict' })
module.exports = config.getProperties()
