env = require './env.coffee'
Promise = require 'promise'

MenuCtrl = ($scope) ->
	_.extend $scope,
		env: env
		navigator: navigator

DbCtrl = ($scope, model, $location) ->
	_.extend $scope,
		model: model
		save: ->			
			$scope.model.$save()
				.then ->
					$location.url "/db"
				.catch (err) ->
					alert {data:{error:"Name already exists. Please choose other name."}}
	
DbListCtrl = ($scope, collection, $location) ->
	_.extend $scope,
		collection: collection
		create: ->
			$location.url "/db/create"
		edit: (id) ->
			$location.url "/db/edit/#{id}"	
		delete: (obj) ->
			collection.remove obj
		loadMore: ->
			collection.$fetch()
				.then ->
					$scope.$broadcast('scroll.infiniteScrollComplete')
				.catch alert

config = ->
	return
	
angular.module('starter.controller', ['ionic', 'ngCordova', 'http-auth-interceptor', 'starter.model', 'platform']).config [config]
angular.module('starter.controller').controller 'MenuCtrl', ['$scope', MenuCtrl]
angular.module('starter.controller').controller 'DbCtrl', ['$scope', 'model', '$location', DbCtrl]
angular.module('starter.controller').controller 'DbListCtrl', ['$scope', 'collection', '$location', DbListCtrl]