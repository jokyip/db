actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
backup = require 'mongodb-backup'
restore = require 'mongodb-restore'
Promise = require 'bluebird'

module.exports =
	findByMe: (req, res) ->
		sails.services.crud
			.find(req)
			.then res.ok
			.catch res.serverError

	export: (req, res) ->
		pk = actionUtil.requirePk req
		Model = actionUtil.parseModel(req)
		Model.findOne(pk)
			.populateAll()
			.then (result) ->
				opts = 
					uri: "#{process.env.DBURL}#{result.name}"
					parser: "json"
					stream: res
					logger: "log/#{result.name}.log"
				backup opts
				res.attachment "#{result.name}.tar.xz"
			.catch res.serverError
	import: (req, res) ->
		pk = actionUtil.requirePk req
		Model = actionUtil.parseModel(req)
		Model.findOne(pk)
			.populateAll()
			.then (result) ->
				new Promise (resolve, reject) ->
					req
						.file 'file'
						.on 'error', reject
						.on 'data', (file) ->
							opts =
								uri: "#{process.env.DBURL}#{result.name}" 
								parser: "json"
								logger: "log/#{result.name}.log"
								stream: file
								drop: true
							restore opts
							return resolve()
			.then res.ok, (err) ->
				res.serverError err.toString()
