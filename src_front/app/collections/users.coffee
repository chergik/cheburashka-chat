'use strict'
define (require) ->

  Backbone    = require 'backbone'
  User        = require 'models/user'

  UsersCollection = Backbone.Collection.extend
    model: User

