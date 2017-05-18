env = require './env.coffee'
require 'PageableAR'
require 'angular-file-saver'
require 'ng-file-upload'
		
angular.module 'starter.model', ['PageableAR', 'ngFileSaver', 'ngFileUpload']
	
	.factory 'model', (pageableAR, $http, $filter, FileSaver) ->

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
					$http
						.get "#{@$urlRoot}/content/#{@id}", responseType: 'blob'
						.then (res) ->
							filename = res.headers('Content-Disposition').match(/filename="(.+)"/)[1]
							FileSaver.saveAs res.data, filename
			
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
