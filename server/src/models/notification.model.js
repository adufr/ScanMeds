const mongoose = require('mongoose')
const Schema = mongoose.Schema

const notificationSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  isRead: { type: Boolean, default: false, required: true },
  date: { type: Date, default: new Date(), required: true },
  title: { type: String, required: true },
  message: { type: String, required: true }
})

module.exports = mongoose.model('Notification', notificationSchema)
