'use strict'
define (require) ->

  Backbone          = require 'backbone'
  Notification      = require 'models/notification'
  NotificationView  = require 'views/notifications/notification'
  ebus              = require('lib/event_bus')()

  NotificationListView = Backbone.View.extend

    tagName: 'ul'

    initialize: () ->
      ebus.on 'notification', (notification) =>
        @.collection.add new Notification(notification) # {type: ..., message: ...}

      @.listenTo @.collection, 'add', (notificationModel) ->
        @.addOne notificationModel

      @.listenTo @.collection, 'remove', (model) ->
        @.render()

    render: () ->
      @.$el.empty()
      @.addAll()
      return @

    addOne: (model) ->
      notificationView = new NotificationView(model: model)
      @.$el.append  notificationView.render().el

    addAll: () ->
      addOne(model) for model in @.collection.models

