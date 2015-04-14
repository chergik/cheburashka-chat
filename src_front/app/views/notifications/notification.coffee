'use strict'
define (require) ->

  Backbone             = require 'backbone'
  notificationTemplate = require 'templates/notifications/notification'

  NotificationView = Backbone.View.extend
    className: 'notification'

    initialize: () ->
      @.listenTo @.model, 'destroy', () ->
        @.remove()

    template: notificationTemplate

    events:
      'click div.dismiss': 'dismiss'

    render: () ->
      @.$el.html @.template(@.model.attributes)
      return @

    dismiss: () ->
      @.model.destroy()
