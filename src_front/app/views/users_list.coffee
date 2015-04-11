'use strict'
define (require) ->

  Backbone          = require 'backbone'
  User              = require 'models/user'
  UserView          = require 'views/user'
  usersListTemplate = require 'templates/users_list'
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
        usersToRemove = @.collection.where(name: user)
        @.collection.remove  usersToRemove

      # Listen for new user added to the collection.
      @.listentTo @.collection, 'add', @.addOne

      # Listen for user who left collection.
      @.listentTo @.collection, 'remove', @.render()

    render: () ->
      @.$el.html @.template()
      addAll()

    addAll: () ->
      addOne(userModel) for userModel in @.collection

    addOne: (model) ->
      newUserView = new UserView(model: model)
      @.$el.append newUserView.render().el

