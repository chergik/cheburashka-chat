'use strict'
define (require) ->

  Backbone     = require 'backbone'
  User         = require 'models/user'
  userTemplate = require 'templates/users/user'

  UserView = Backbone.View.extend

    template: userTemplate

    render: ->
      @.setElement @.template(@.model.attributes)
      return @

