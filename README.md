# db

Create a mongo database


Server API
---------------------------------------------------------
## db
		
* api

	```
	get /api/db - list your owned database for specified pagination/sorting parameters skip, limit, sort
	post /api/db - create a database with the specified attributes excluding id
    delete /api/db/:id - delete database of the specified id

Configuration
=============

*   git clone https://github.com/jokyip/db.git
*   cd db
*   npm install && bower install
*   update environment variables in config/env/development.coffee for server
```
port: 3000
connections:
	mongo:
		driver:		'mongodb'
		host:		'localhost'
		port:		27017
		user:		'dbrw'
		password:	'password'
		database:	'db'
```

*	update environment variables in www/js/env.coffee for client
```
path: '/db'

# proxy server setting (if required)
agent = require 'https-proxy-agent'

http:
	opts:
		agent:	new agent("http://proxy.server.com:8080")

```

*	node_modules/.bin/gulp
*	sails lift --dev
