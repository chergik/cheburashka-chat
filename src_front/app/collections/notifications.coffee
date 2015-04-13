'use strict'
define (require) ->

  Backbone     = require 'backbone'
  Notification = require 'models/notification'

  NotificationsCollection = Backbone.Collection.extend
    model: Notification

    initialize: () ->
      @.on 'add', (model) =>
        @.shift() if @.length is 3
