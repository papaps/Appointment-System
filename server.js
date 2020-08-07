const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const urlencoder = bodyParser.urlencoded({
    extended: false
}) 

const session = require("express-session");
const path = require("path");
var app = new express();

mongoose.Promise = global.Promise
mongoose.connect("mongodb://localhost:27017/dental", {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

app.use(urlencoder);
app.use(session({
    resave: false,
    name: "appointment-system",
    saveUninitialized: true, 
    secret: "secretpass"
}))
app.use(express.static(path.join(__dirname, 'public')));
app.use(function(req, res, next) {
    res.set("Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0");
    next();
})

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'views'));

app.use(require("./controller"));

// var server = app.listen(process.env.PORT || 3000, function(){
//     console.log("Server is running at port 3000...");
// })
app.get('/test', async (req, res) => {
    res.json({message: 'pass!'})
})

module.exports =app;