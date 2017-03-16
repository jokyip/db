_ = require 'lodash'

_.forEach ['VERIFYURL','OAUTH2_SCOPE'], (prop) ->
	if not (prop of process.env)
  	throw new Error "process.env.#{prop} not yet defined"

module.exports =
  oauth2:
    verifyURL: process.env.VERIFYURL
    scope: process.env.OAUTH2_SCOPE?.split(' ') || [
        'User'
      ]
