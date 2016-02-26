module.exports = 
	policies:		
		DbController:
			'*':		false
			find:		['isAuth', 'filterByOwner']
			findOne:	['isAuth', 'filterByOwner']
			create:		['isAuth', 'setOwner']
			update:		['isAuth', 'isOwner']
			destroy:	['isAuth', 'isOwner']