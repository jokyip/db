mongodb = require 'mongodb'
Db = mongodb.Db
Server = mongodb.Server

module.exports = 
	add: (database) ->		
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				return res.serverError
			newDb = db.db database.name
			sails.log.info "DB #{database.name} is created."
			newDb.addUser database.createdBy, database.password, {roles: sails.config.db.default.roles}, (err, result) ->
				if err
					sails.log.error err
					return res.serverError
				sails.log.info "DB user #{database.createdBy} is created."	
				newDb.close
			db.close
			
	remove: (record) ->		
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				return res.serverError
			existingDb = db.db record.name
			sails.log.info "DB #{record.name} is removed."
			existingDb.dropDatabase (err, result) ->
				existingDb.removeUser record.createdBy, (err, result) ->
					if err
						sails.log.error err
						return res.serverError
					sails.log.info "DB user #{record.createdBy} is removed."		
					existingDb.close
			db.close				
									