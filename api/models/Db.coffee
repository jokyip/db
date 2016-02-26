module.exports =

	tableName:		'db'
  
	schema: 		true
	
	autoCreatedAt:	true
  
	attributes:
  
		name:
			type: 'string'
			required:	true
			unique: 	true
		createdBy:
			type:	'string'
			required:	true