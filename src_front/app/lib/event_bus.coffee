'use strict'
define (require) ->

  Backbone  = require 'backbone'
  _         = require 'underscore'

  EventBus = {}
  _.extend EventBus, Backbone.Events

  () ->
    EventBus

