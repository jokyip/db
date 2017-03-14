config = require './config.json'
root = require('url').parse config.ROOTURL
url = "#{root.protocol}//#{root.host}"

module.exports =
  server:
    app:
      url:		url					# server url
      urlRoot:	"#{url}#{root.path}"		# api url
    auth:
      urlRoot:	config.AUTHURL
    mobile:
      urlRoot:	config.MOBILEURL
  isMobile: ->
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
  isNative: ->
    /^file/i.test(document.URL)
  platform: ->
    if module.exports.isNative() then 'mobile' else 'browser'
  oauth2: ->
    opts:
      authUrl: 		"#{module.exports.server.auth.urlRoot}/oauth2/authorize/"
      response_type:	"token"
      scope:			config.OAUTH2_SCOPE
      client_id:		config.CLIENT_ID