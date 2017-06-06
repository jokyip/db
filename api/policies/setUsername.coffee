module.exports = (req, res, next) ->
	req.body.username = req.body.username || "#{req.body.name}rw"
	next()
