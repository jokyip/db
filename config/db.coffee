_ = require 'lodash'

module.exports =
	dbAdmin:
		url:		"#{process.env.DBURL}admin"
	db:
		default:
			roles:	process.env.USER_ROLE?.split(' ') || [
        'dbOwner'
      ]
