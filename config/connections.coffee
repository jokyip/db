_ = require 'lodash'

_.forEach ['DB_NAME','DBURL'], (prop) ->
  if not (prop of process.env)
    throw new Error "process.env.#{prop} not yet defined"

module.exports =
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: "#{process.env.DBURL}#{process.env.DB_NAME}" 
