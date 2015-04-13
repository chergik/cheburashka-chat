'use strict'
define (require) ->

  Backbone             = require 'backbone'
  notificationTemplate = require 'templates/notifications/notification'

  NotificationView = Backbone.View.extend

    initialize: () ->
      @.listenTo @.model, 'destroy', () ->
        @.remove()

    template: notificationTemplate

    events:
      'click div.dismiss': 'dismiss'

    render: () ->
      @.setElement @.template(@.model.attributes)
      return @

    dismiss: () ->
      @.model.destroy()
