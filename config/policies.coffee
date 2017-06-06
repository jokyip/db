module.exports = 
	policies:		
		DbController:
			'*':		false
			find:		['isAuth']
			findByMe:	['isAuth', 'filterByOwner']
			findOne:	['isAuth', 'filterByOwner']			
			create:		['isAuth', 'setOwner', 'setUsername']
			update:		['isAuth', 'isOwner']
			destroy:	['isAuth', 'isOwner']
			export:		['isAuth', 'isOwner']
			import:		['isAuth', 'isOwner']
