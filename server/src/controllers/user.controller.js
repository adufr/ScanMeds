const bcrypt = require('bcryptjs')
const User = require('../models/user.model')
const Notification = require('../models/notification.model')

// Checks if username is taken
exports.isUsernameTaken = async (req, res) => {
  const _username = req.params.username

  const user = await User.findOne({ username: _username })

  res.status(200).json({
    result: !!user
  })
}

// Checks if email is taken
exports.isEmailTaken = async (req, res) => {
  const _email = req.params.email

  const user = await User.findOne({ email: _email })

  res.status(200).json({
    result: !!user
  })
}

// creates a new user (register)
exports.create = async (req, res) => {
  const _username = req.body.username
  const _email = req.body.email
  const _password = req.body.password
  const _password2 = req.body.password2

  const errors = []

  if (!_username) errors.push("Veuillez indiquer un nom d'utilisateur")
  if (_username.length < 3) errors.push("Votre nom d'utilisateur doit contenir au moins 3 caractères")
  if (!_email) errors.push('Veuillez indiquer une adresse mail valide')
  if (!_password) errors.push('Veuillez indiquer un mot de passe')
  if (_password.length < 6) errors.push('Votre mot de passe doit contenir au moins 6 caractères')
  if (_password !== _password2) errors.push('Les deux mots de passe ne correspondent pas')
  const isUsernameTaken = await User.findOne({ username: _username })
  if (isUsernameTaken) errors.push("Cette nom d'utilisateur n'est pas disponible")
  const isEmailTaken = await User.findOne({ email: _email })
  if (isEmailTaken) errors.push("Cette adresse mail n'est pas disponible")

  if (errors.length) {
    return res.status(412).json({
      errors
    })
  }

  const userData = {
    username: _username,
    email: _email,
    password: bcrypt.hashSync(_password, 10)
  }

  const user = new User(userData)
  await user.save()

  const notificationData = {
    user: user._id,
    title: 'Bienvenue !',
    message: 'Nous vous souhaitons la bienvenue sur notre plateforme ScanMeds !'
  }

  const notification = new Notification(notificationData)
  await notification.save()

  res.status(201).json({
    message: 'Votre compte a bien été créé',
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
  const _email = req.body.email
  const _firstname = req.body.firstname
  const _lastname = req.body.lastname

  try {
    const user = await User.findById(_userId)
    if (!user) return res.status(404).json({ message: 'User not found' })

    if (_email) user.email = _email
    if (_firstname) user.firstname = _firstname
    if (_lastname) user.lastname = _lastname

    await user.save()
    return res.status(200).json({ message: 'User has successfuly been updated' })
  } catch (err) {
    return res.status(400).json({ error: 'Please provide a correct userId' })
  }
}
