const bcrypt = require('bcryptjs')
const User = require('../models/user.model')

// creates a new user (register)
exports.create = async (req, res) => {
  const _password = bcrypt.hashSync(req.body.password, 10)
  const _username = req.body.username
  const _email = req.body.email
  const _firstname = req.body.firstname
  const _lastname = req.body.lastname

  const userData = {
    username: _username,
    email: _email,
    password: _password,
    firstname: _firstname,
    lastname: _lastname
  }

  const user = new User(userData)
  await user.save()

  res.status(201).json({
    message: 'Your account has successfully been created',
    id: user._id
  })
}

// lists all existing users
exports.list = async (req, res) => {
  const users = await User.find({})
    .select('firstname lastname username email')
  res.status(200).json({ users: users })
}

// gets a user by its id
exports.getById = async (req, res) => {
  const _userId = req.params.userId

  const user = await User.findById(_userId)
    .select('firstname lastname username email')

  if (!user) {
    return res.status(404).json({ message: 'User not found' })
  }

  res.status(200).json({ user: user })
}

// updates user informations
exports.update = async (req, res) => {
  const _userId = req.params.userId
  const _firstname = req.body.firstname
  const _lastname = req.body.lastname

  try {
    const user = await User.findById(_userId)
    if (!user) return res.status(404).json({ message: 'User not found' })

    if (_firstname) user.firstname = _firstname
    if (_lastname) user.lastname = _lastname

    await user.save()
    return res.status(200).json({ message: 'User has successfuly been updated' })
  } catch (err) {
    return res.status(400).json({ error: 'Please provide a correct userId' })
  }
}
