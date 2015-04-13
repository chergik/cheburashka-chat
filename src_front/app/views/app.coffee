'use strict'
define (require) ->

  Backbone                = require 'backbone'
  UsersCollection         = require 'collections/users'
  MessagesCollection      = require 'collections/messages'
  NotificationsCollection = require 'collections/notifications'
  MessageBoxView          = require 'views/messages/message_box'
  NotificationsListView   = require 'views/notifications/notifications_list'
  UsersListView           = require 'views/users/users_list'
  MessagesListView        = require 'views/messages/messages_list'
  appTemplate             = require 'templates/app'
  ebus                    = require('lib/event_bus')() # ebus singleton.

  AppView = Backbone.View.extend
    el: '#app'
    template: appTemplate

    initialize: () ->

    render: () ->

      # Notifications.
      notificationsListView = new NotificationsListView(collection: new NotificationsCollection())

      # Users in the chat room.
      usersListView = new UsersListView(collection: new UsersCollection())

      # Messages backlog.
      messagesListView = new MessagesListView(collection: new MessagesCollection())

      # Create message box controls.
      messageBoxView = new MessageBoxView()

      # Get user's name first.
      @username = prompt "What is your name?"

      @.$el.html @.template(user: @username)
      @.$el.find('#notifications-list').append notificationsListView.render().el
      @.$el.find('#users-list').append         usersListView.render().el
      @.$el.find('#messages-list').append      messagesListView.render().el
      @.$el.find('#message-box').append        messageBoxView.render().el

      # Add user to the chatroom.
      ebus.trigger 'client:join', @username

      return @
