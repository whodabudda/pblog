const environment = require('./environment')
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

//may not need these keys here.  Can put them into an erb.js file if they are needed 
//in a javascript. Otherwise, see if they can be confined to being used by just .rb files.
//process.env.VAPID_PUBLIC = ''
//process.env.VAPID_PRIVATE = ''


module.exports = environment.toWebpackConfig()
