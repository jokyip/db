mongodb = require 'mongodb'

module.exports =

	tableName:		'db'
  
	schema: 		true
	
	autoCreatedAt:	true
  
	attributes:
  
		name:
			type: 'string'
			required:	true
			unique: 	true
			notIn:	['db','admin']
		username:
        		type:   'string'
        		required:       true
		createdBy:
			type:	'string'
			required:	true

	beforeCreate: (values, cb) ->
		sails.models.db
			.findOne name:values.name
			.then (record) ->
				if record 
					cb("Database already exist")
					return
				MongoClient = mongodb.MongoClient
				MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
					if err
						sails.log.error err
						cb(err)	
					newDb = db.db values.name
					sails.log.info "DB #{values.name} is created."
					newDb.addUser values.username, values.password, {roles: sails.config.db.default.roles}, (err, result) ->
						if err
							sails.log.error err
							cb(err)	
						sails.log.info "DB user #{values.username} is created."	
						newDb.close
					db.close	
				cb()

	beforeUpdate: (values, cb) ->
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				cb(err)
			existingDb = db.db values.name
			existingDb.removeUser values.username, (err, result) ->
				if err
					sails.log.error err
					cb(err)
				existingDb.addUser values.username, values.password, {roles: sails.config.db.default.roles}, (err2, result) ->
					if err2
						sails.log.error err2
						cb(err2)
					else				
						sails.log.info "The password of DB user #{values.username} is updated."						
			existingDb.close
			db.close
		cb()

	afterDestroy: (values, cb) ->
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				cb(err)
			values = values[0]
			existingDb = db.db values.name
			sails.log.info "DB #{values.name} is removed."
			existingDb.dropDatabase (err, result) ->
				existingDb.removeUser values.username, (err, result) ->
					if err
						sails.log.error err
						cb(err)
					sails.log.info "DB user #{values.username} is removed."		
					existingDb.close
			db.close
		cb()
