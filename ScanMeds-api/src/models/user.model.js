const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = new Schema({
  username: { type: String, minlength: 3, maxlength: 24, required: true, unique: true },
  email: { type: String, minLength: 4, maxLength: 64, required: true, unique: true },
  password: { type: String, minLength: 6, maxLength: 64, required: true },
  firstname: { type: String, minxLength: 1, maxlength: 32 },
  lastname: { type: String, minLength: 1, maxlength: 32 },
  permissionLevel: { type: Number, default: 1, required: true }
})

module.exports = mongoose.model('User', userSchema)
