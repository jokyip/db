path = '/db'
agent = require 'https-proxy-agent'

module.exports =
	path:			path
	url:			"http://localhost:3000"
	port: 			3000
	promise:
		timeout:	10000 # ms
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		tokenURL:			"https://mob.myvnc.com/org/oauth2/token/"
		scope:				[ "https://mob.myvnc.com/org/users"]
	http:
		opts:
			agent:	new agent("http://proxy1.scig.gov.hk:8080")			
	models:
		connection: 'mongo'
		migrate:	'alter'
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			host:		'localhost'
			port:		27017
			user:		'dbrw'
			password:	'pass1234'
			database:	'db'
	dbAdmin:
		url:		"mongodb://admin:Pass1234!@localhost/admin"
	db:
		default:
			roles:	['dbOwner']			
	log:
		level:		'silly'