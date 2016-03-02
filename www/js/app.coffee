env = require './env.coffee'

angular.module 'starter', ['ionic', 'starter.controller', 'starter.model', 'util.auth', 'ActiveRecord', 'ngTouch', 'ionic-datepicker', 'ngFancySelect', 'pascalprecht.translate', 'locale']

	.run (authService) ->
		authService.login env.oauth2.opts
		
	.run ($rootScope, platform, $ionicPlatform, $location, $http) ->
		$ionicPlatform.ready ->
			if (window.cordova && window.cordova.plugins.Keyboard)
				cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
			if (window.StatusBar)
				StatusBar.styleDefault()
						
	.config ($stateProvider, $urlRouterProvider) ->
		$stateProvider.state 'app',
			url: ""
			abstract: true
			templateUrl: "templates/menu.html"
	
		# Db
		$stateProvider.state 'app.db',
			url: "/db"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/db/list.html"
					controller: 'DbListCtrl'
			resolve:
				cliModel: 'model'	
				collection: (cliModel) ->
					ret = new cliModel.DbList()
					ret.$fetch()
					
		$stateProvider.state 'app.dbMe',
			url: "/db/me"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/db/listMe.html"
					controller: 'DbListCtrl'
			resolve:
				cliModel: 'model'	
				collection: (cliModel) ->
					ret = new cliModel.MyDbList()
					ret.$fetch()				
					
		$stateProvider.state 'app.dbCreate',
			url: "/db/create"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/db/create.html"
					controller: 'DbCtrl'
			resolve:
				cliModel: 'model'	
				model: (cliModel) ->
					ret = new cliModel.Db()
					
		$stateProvider.state 'app.dbEdit',
			url: "/db/edit/:id"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/db/edit.html"
					controller: 'DbCtrl'
			resolve:
				id: ($stateParams) ->
					$stateParams.id
				cliModel: 'model'	
				model: (cliModel, id) ->
					ret = new cliModel.Db({id: id})
					ret.$fetch()			
				
		$urlRouterProvider.otherwise('/db')