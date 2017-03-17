env = require '../../env.coffee'
request = require 'supertest-as-promised'
oauth2 = require 'oauth2_client'
Promise = require 'bluebird'

describe 'DbController', ->

  describe 'CRUD', ->

    id = null
    token = null

    before ->
      oauth2
        .token env.tokenUrl, env.client, env.user, env.scope
        .then (t) ->
          token = t

    it 'Create Db', ->
      request(sails.hooks.http.app)
      .post('/api/db')
      .send({ name: 'unitTest', password: 'pass1234', createdBy:'jokyip' })
      .set('Authorization',"Bearer #{token}")
      .expect 201
      .then (res)->
        id = res.body.id

    it 'Read Db', ->
      request(sails.hooks.http.app)
      .get("/api/db/#{id}")
      .set('Authorization',"Bearer #{token}")
      .expect 200

    it 'Delete Db', ->
      request(sails.hooks.http.app)
      .del("/api/db/#{id}")
      .set('Authorization',"Bearer #{token}")
      .expect 200