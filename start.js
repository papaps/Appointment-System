const app = require('./server')

var server = app.listen(process.env.PORT || 3000, function(){
     console.log("Server is running at port 3000...");
})

module.exports = server