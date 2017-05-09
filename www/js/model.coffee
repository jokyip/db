env = require './env.coffee'
require 'PageableAR'
		
angular.module 'starter.model', ['PageableAR']
	
	.factory 'model', (pageableAR, $filter) ->

		class User extends pageableAR.Model
			$urlRoot: "org/api/users/"
				
			@me: ->
				(new User(username: 'me/')).$fetch()	
		
		# Db model
		class Db extends pageableAR.Model
			$urlRoot: "api/db"
			
			cfg: ->
				JSON.stringify {url:"#{env.mongo.url}#{@.name}", updatedAt:@.updatedAt}
			cmd: (op)->
				if op == "import"
					@$save {}, url: "#{@$urlRoot}/content/#{@id}"
				else
					@$fetch {url: "#{@$urlRoot}/content/#{@id}"}
			
		class DbList extends pageableAR.PageableCollection
			model: Db
		
			$urlRoot: "api/db"
			
			$parse: (res, opts) ->
				_.each res.results, (value, key) =>
					res.results[key] = new Db res.results[key]
				return res
				
		class MyDbList extends DbList
			$urlRoot: "api/db/me"		
	
		User:	User
		Db:	Db
		DbList:	DbList
		MyDbList:	MyDbList
