env = require './env.coffee'
require 'PageableAR'
		
angular.module 'starter.model', ['PageableAR']
	
	.factory 'model', (pageableAR, $filter) ->

		class User extends pageableAR.Model
			$urlRoot: "#{env.serverUrl()}/org/api/users/"
				
			@me: ->
				(new User(username: 'me/')).$fetch()	
		
		# Db model
		class Db extends pageableAR.Model
			$urlRoot: "#{env.serverUrl()}/api/db"
			
		class DbList extends pageableAR.PageableCollection
			model: Db
		
			$urlRoot: "#{env.serverUrl()}/api/db"
			
			$parse: (res, opts) ->
				_.each res.results, (value, key) =>
					res.results[key] = new Db res.results[key]
				return res
	
		User:	User
		Db:	Db
		DbList:	DbList