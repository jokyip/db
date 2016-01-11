module.exports =

	tableName:		'db'
  
	schema: 		true
	
	autoCreatedAt:	true
	
	autoPK:	false
  
	attributes:
  
		name:
			type: 'string'
			primaryKey:	true
			required:	true
			unique: 	true
		createdBy:
			type:	'string'
			required:	true