actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	create: (req, res) ->
		Model = actionUtil.parseModel(req)
		data = actionUtil.parseValues(req)
			
		Model.create(data)
			.then ->
				sails.services.db.add data
				res.created(data)
			.catch res.serverError
			
	destroy: (req, res) ->
		pk = actionUtil.requirePk(req)
		Model = actionUtil.parseModel(req)
		
		Model.destroy({name: pk})
			.then (records) ->
				sails.services.db.remove records[0]
				res.ok()
			.catch res.serverError		