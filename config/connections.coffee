_ = require 'lodash'

if not ("DBURL" of process.env)
  throw new Error "process.env.DBURL not yet defined"

module.exports =
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: "#{process.env.DBURL}db" 
