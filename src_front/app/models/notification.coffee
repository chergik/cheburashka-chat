'use strict'
define (require) ->

  Backbone = require 'backbone'

  Notification = Backbone.Model.extend
    defaults:
      type: 'warning'
      message: 'Error occurred. Please try again later.'
