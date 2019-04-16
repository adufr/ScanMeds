const bcrypt = require('bcryptjs')
const mongoose = require('mongoose')
const logger = require('../config/winston')

const User = mongoose.model('User')
const Notification = mongoose.model('Notification')

// ===================================
// == start by removing all data
// ===================================
module.exports.removeAllData = async function removeAllData () {
  try {
    await User.deleteMany({})
    await Notification.deleteMany({})
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
      _id: mongoose.Types.ObjectId('5cb5d0fc369451002e48a309'),
      username: 'John',
      email: 'test@gmail.com',
      password: bcrypt.hashSync('aze', 10),
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

    const notification1 = new Notification({
      user: user1._id,
      title: 'Test!',
      message: 'First notification test!'
    })

    const notification2 = new Notification({
      user: user1._id,
      title: 'Bienvenue',
      message: "Bienvenue sur ScanMeds ! N'hésitez pas à contacter le support en cas de besoin"
    })

    await notification1.save()
    logger.info(`=> notification1 (${notification1.title}) saved (${notification1.user})`)
    await notification2.save()
    logger.info(`=> notification2 (${notification2.title}) saved (${notification2.user})`)
  } catch (err) {
    logger.error(err)
  }
}
