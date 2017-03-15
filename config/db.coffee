_.forEach ['ADMIN_DB','ADMIN_ROLE'], (prop) ->
	if not (prop of process.env)
  	throw new Error "process.env.#{prop} not yet defined"

module.exports =
	dbAdmin:
		url:		process.env.ADMIN_DB
	db:
		default:
			roles:	process.env.ADMIN_ROLE?.split(' ') || [
        'dbOwner'
      ]