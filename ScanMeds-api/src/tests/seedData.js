const bcrypt = require('bcryptjs')
const mongoose = require('mongoose')
const logger = require('../config/winston')

const User = mongoose.model('User')

// ===================================
// == start by removing all data
// ===================================
module.exports.removeAllData = async function removeAllData () {
  try {
    await User.deleteMany({})
    logger.info('=> Successfully removed all existent data')
  } catch (err) {
    logger.error(err)
  }
}

// ===================================
// == add data
// ===================================
module.exports.seedData = async function seedData () {
  try {
    // users
    const user1 = new User({
      username: 'John',
      email: 'johndoe@gmail.com',
      password: bcrypt.hashSync('password', 10),
      firstname: 'John',
      lastname: 'Doe'
    })
    const user2 = new User({
      username: 'Jane',
      email: 'janedoe@gmail.com',
      password: bcrypt.hashSync('password', 10),
      firstname: 'Jane',
      lastname: 'Doe'
    })

    await user1.save()
    logger.info(`=> user1 (${user1.username}) saved (${user1._id})`)
    await user2.save()
    logger.info(`=> user2 (${user2.username}) saved (${user2._id})`)
  } catch (err) {
    logger.error(err)
  }
}
