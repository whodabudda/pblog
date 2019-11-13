const environment = require('./environment')
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

process.env.VAPID_PUBLIC_DEV = 'BJHrwn78cnJSfvjoNeBdqAo9PLE21vaYMKaQh2NxQG9MmIx-E_CbSs89XYzZ8PEnbyqtQquC-yKQYqLm4RPHZX4='
process.env.VAPID_PRIVATE_DEV = 'ra-oRqfwt1EqO-App7xgwL0UeAPbL0mZOAzp3lCxdxE='


module.exports = environment.toWebpackConfig()
