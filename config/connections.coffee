_ = require 'lodash'

_.forEach ['APP_DB','DBURL'], (prop) ->
  if not (prop of process.env)
    throw new Error "process.env.#{prop} not yet defined"

module.exports =
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: "#{process.env.DBURL}#{process.env.APP_DB}" 
