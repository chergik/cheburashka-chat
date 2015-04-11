'use strict'
define (require) ->

  Backbone     = require 'backbone'
  User         = require 'models/user'
  userTemplate = require 'templates/users/user'

  UserView = Backbone.View.extend
    tagName: 'li'

    template: userTemplate

    render: ->
      @.$el.html @.template(@.model.attributes)
      return @

