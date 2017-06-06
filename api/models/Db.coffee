module.exports =

	tableName:		'db'
  
	schema: 		true
	
	autoCreatedAt:	true
  
	attributes:
  
		name:
			type: 'string'
			required:	true
			unique: 	true
		username:
        		type:   'string'
        		required:       true
		createdBy:
			type:	'string'
			required:	true
