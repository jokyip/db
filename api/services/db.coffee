mongodb = require 'mongodb'

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
					return err
				sails.log.info "DB user #{database.createdBy} is created."	
				newDb.close
			db.close
			
	update: (database) ->		
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				return res.serverError
			existingDb = db.db database.name
			existingDb.removeUser database.createdBy, (err, result) ->
				if err
					sails.log.error err
				existingDb.addUser database.createdBy, database.password, {roles: sails.config.db.default.roles}, (err2, result) ->
					if err2
						sails.log.error err2
					else						
						sails.log.info "The password of DB user #{database.createdBy} is updated."						
			existingDb.close
			db.close		
			
	remove: (database) ->		
		MongoClient = mongodb.MongoClient
		MongoClient.connect sails.config.dbAdmin.url, (err, db) ->
			if err
				sails.log.error err
				return res.serverError
			existingDb = db.db database.name
			sails.log.info "DB #{database.name} is removed."
			existingDb.dropDatabase (err, result) ->
				existingDb.removeUser database.createdBy, (err, result) ->
					if err
						sails.log.error err
						return err
					sails.log.info "DB user #{database.createdBy} is removed."		
					existingDb.close
			db.close

	export: (database) ->
		return
