path = '/db'

module.exports =
	port: 			8022
	promise:
		timeout:	10000 # ms
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		tokenURL:			"https://mob.myvnc.com/org/oauth2/token/"
		scope:				[ "https://mob.myvnc.com/org/users"]		
	models:
		connection: 'mongo'
		migrate:	'alter'
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			host:		'db'
			port:		27017
			user:		'dbrw'
			password:	'pass1234'
			database:	'db'
	dbAdmin:
		url:		"mongodb://admin:Pass1234!@db/admin"
	db:
		default:
			roles:	['dbOwner']			
	log:
		level:		'silly'