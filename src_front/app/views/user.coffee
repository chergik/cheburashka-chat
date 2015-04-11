'use strict'
define (require) ->

  Backbone     = require 'backbone'
  User         = require 'models/user'
  userTemplate = require 'templates/user'

  UserView = Backbone.View.extend
    tagName: 'li'

    template: userTemplate

    render: ->
      @.$el.html @.template.render(@.model.attributes)
      return @

