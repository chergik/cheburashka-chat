'use strict'
define (require) ->
  socket = require 'socketio'
  io = socket()
  () -> io