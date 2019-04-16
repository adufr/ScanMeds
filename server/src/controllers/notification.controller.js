const Notification = require('../models/notification.model')

// Gets all user's notifications
exports.list = async (req, res) => {
  const _userId = req.jwt.userId

  const notifications = await Notification.find({ user: _userId, isRead: false })

  res.status(200).json({
    notifications
  })
}

// Mark a notification as "read"
exports.readById = async (req, res) => {
  const _notificationId = req.params.notificationId

  const notification = await Notification.findById(_notificationId)

  notification.isRead = true
  await notification.save()

  res.status(200).json({
    message: 'Success'
  })
}

// Mark a notification as "read"
exports.readAll = async (req, res) => {
  const _userId = req.jwt.userId

  const notifications = await Notification.find({ user: _userId, isRead: false })

  async function asyncForEach (array, callback) {
    for (let index = 0; index < array.length; index++) {
      await callback(array[index], index, array)
    }
  }

  const start = async () => {
    await asyncForEach(notifications, async (notification) => {
      notification.isRead = true
      await notification.save()
    })
    res.status(200).json({ message: 'Success' })
  }

  start()
}
