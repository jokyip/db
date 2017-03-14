module.exports =
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: process.env.DB || 'mongodb://@db_mongo:27017/db'
