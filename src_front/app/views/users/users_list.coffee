'use strict'
define (require) ->

  Backbone          = require 'backbone'
  User              = require 'models/user'
  UserView          = require 'views/users/user'
  usersListTemplate = require 'templates/users/users_list'
  ebus              = require('lib/event_bus')()

  UsersListView = Backbone.View.extend
    tagName: 'ul'
    id:      'users_list'

    template: usersListTemplate

    initialize: () ->

      # Listen on user join.
      ebus.on 'join', (user) => @.collection.add new User(user: user)

      # Listen on user left.
      ebus.on 'left', (user) =>
        usersToRemove = @.collection.where(user: user)
        @.collection.remove usersToRemove

      # Listen for new user added to the collection.
      @.listenTo @.collection, 'add', @.addOne

      # Listen for user who left collection.
      @.listenTo @.collection, 'remove', @.render

    render: () ->
      @.$el.html @.template()
      @.addAll()
      return @

    addOne: (model) ->
      newUserView = new UserView(model: model)
      @.$el.append newUserView.render().el

    addAll: () ->
      @.addOne(userModel) for userModel in @.collection.models


