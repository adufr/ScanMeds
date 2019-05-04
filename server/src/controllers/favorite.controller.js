const User = require('../models/user.model')

// Gets all favorites from user
exports.list = async (req, res) => {
  const _userId = req.jwt.userId

  const user = await User.findById(_userId).select('favorites')

  res.status(200).json({
    favorites: user.favorites
  })
}

// Add a medicine to user's favorites
exports.add = async (req, res) => {
  const _userId = req.jwt.userId
  const _codeCIS = req.body.codeCIS
  const _denomination = req.body.denomination

  const user = await User.findById(_userId)
  user.favorites.push({ codeCIS: _codeCIS, denomination: _denomination })
  await user.save()

  res.status(200).json({})
}

// Remove a medicine from user's favorites
exports.remove = async (req, res) => {
  const _userId = req.jwt.userId
  const _codeCIS = req.body.codeCIS

  const user = await User.findById(_userId)
  user.favorites.splice(user.favorites.map(fav => fav.codeCIS).indexOf(_codeCIS), 1)
  user.save()

  res.status(200).json({})
}
