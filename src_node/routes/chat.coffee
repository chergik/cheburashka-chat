'use strict'

express = require 'express'

router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'chat'

module.exports = router
