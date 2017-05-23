env = require './env.coffee'
Promise = require 'promise'

angular

	.module 'starter.controller', [
		'ionic' 
		'ngCordova'
		'http-auth-interceptor'
		'starter.model'
		'platform'
	]
	
	.controller 'MenuCtrl', ($scope) ->
		_.extend $scope,
			env: env
			navigator: navigator
			
	.controller 'DbCtrl', ($scope, model, $location) ->
		_.extend $scope,
			model: model
			save: ->			
				$scope.model.$save()
					.then ->
						$location.url "/db/myList"
					.catch (err) ->
						alert {data:{error:"Name already exists. Please choose other name."}}
						
	.controller 'DbListCtrl', ($scope, collection, $location, $ionicPopup) ->
		_.extend $scope,
			collection: collection
			create: ->
				$location.url "/db/create"
			edit: (id) ->
				$location.url "/db/edit/#{id}"
			delete: (obj) ->
				$ionicPopup.confirm title: 'Delete Database', template: 'Please note that all data stored in this database will be loss. Do you still proceed?'
					.then (res) ->
						if res
							collection.remove obj
			loadMore: ->
				collection.$fetch()
					.then ->
						$scope.$broadcast('scroll.infiniteScrollComplete')
					.catch alert

	.controller 'ItemCtrl', ($scope, $log, $ionicActionSheet, $location) ->
		_.extend $scope,
			showAction: ->
				$ionicActionSheet.show
					buttons: [
						{ text: 'Change Password', cmd: 'changepwd' }
					]
					buttonClicked: (index, button) ->
						if button.cmd == 'changepwd'
							$location.url "/db/edit/#{$scope.model.id}"
						return true
					

