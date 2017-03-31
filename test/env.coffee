[
  'TOKENURL'
  'OAUTH2_SCOPE'
  'TEST_CLIENT_ID'
  'CLIENT_SECRET'
  'USER_ID'
  'USER_SECRET'
  'DBURL'
  'BkDIR'
].map (name) ->
  if not (name of process.env)
    throw new Error "process.env.#{name} not yet defined"

module.exports =
  upTime: 120000
  tokenUrl: process.env.TOKENURL
  scope: process.env.OAUTH2_SCOPE.split ' '
  client:
    id: process.env.TEST_CLIENT_ID
    secret: process.env.CLIENT_SECRET
  user:
    id: process.env.USER_ID
    secret: process.env.USER_SECRET
  bkDir: process.env.BkDIR 
  db: process.env.DBURL
