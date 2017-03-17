actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	create: (req, res) ->
		Model = actionUtil.parseModel(req)
		data = actionUtil.parseValues(req)
			
		Model.create(data)
			.then (model) ->
				sails.services.db.add data
				res.created(model)
			.catch res.serverError
			
	update: (req, res) ->
		pk = actionUtil.requirePk(req)
		Model = actionUtil.parseModel(req)
		data = actionUtil.parseValues(req)
		Model
			.update({id: pk},data)
      		.then (updatedInstance) ->
				sails.services.db.update data
				res.ok()
			.catch res.serverError		
			
	destroy: (req, res) ->
		pk = actionUtil.requirePk(req)
		Model = actionUtil.parseModel(req)

		Model.destroy({id: pk})
			.then (records) ->
				sails.services.db.remove records[0]
				res.ok()
			.catch res.serverError
			
	findByMe: (req, res) ->
		sails.services.crud
			.find(req)
			.then res.ok
			.catch res.serverError				