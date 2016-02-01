request = require 'supertest'

describe 'DbController', ->

	describe 'CRUD', ->
	
		id = null
	
		it 'Create Db', ->
			request(sails.hooks.http.app)
			.post('/api/db')
			.send({ name: 'unitTest', password: 'pass1234', createdBy:'jokyip' })
			.set('Authorization',"Bearer #{sails.token}")
			.expect (res)->
				id = res.body.id
			.expect 201
			
		it 'Read Db', ->
			request(sails.hooks.http.app)
			.get("/api/db/unitTest")
			.set('Authorization',"Bearer #{sails.token}")
			.expect 200
			
		it 'Delete Db', (done) ->
			request(sails.hooks.http.app)
			.del("/api/db/unitTest")
			.set('Authorization',"Bearer #{sails.token}")
			.expect 200
			.end ->
				setTimeout done, 1000