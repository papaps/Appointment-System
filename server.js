const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require('./model/connection');
const session = require('express-session');
const MongoStore = require('connect-mongo')(session);
const cors = require('cors');

const urlencoder = bodyParser.urlencoded({
    extended: false
}) 

const path = require("path");
const port = process.env.PORT || 5000;

var app = new express();

app.use(express.static(path.join(__dirname, 'client/build')));

if(process.env.NODE_ENV === 'production') {  
    app.use(express.static(path.join(__dirname, 'client/build')));  
    app.get('*', (req, res) => {    res.sendfile(path.join(__dirname = 'client/build/index.html'));  })
}

app.get('*', (req, res) => {  
    res.sendFile(path.join(__dirname+'/client/public/index.html'));
})

app.use(cors());
app.use(express.json())

app.use('/', express.static(path.join(__dirname, '/build')));


mongoose.Promise = global.Promise

app.use(urlencoder);

//creates a session for the user
app.use(session({
    resave: false,
    name: "appointment-system",
    store: new MongoStore({mongooseConnection: mongoose.connection}),
    saveUninitialized: true, 
    secret: "secretpass"
}))
//Checks if mongoDB is connected
mongoose.connection.once('open', ()=>{
    console.log("MongoDB Connected");
})

app.use(express.static(path.join(__dirname, 'public')));
app.use(function(req, res, next) {
    res.set("Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0");
    next();
})

const secretaryRoute = require("./controller/secretaryController")
app.use('/secretary', secretaryRoute)

const adminRoute = require("./controller/adminController")
app.use('/admin', adminRoute)

const dentistRoute = require("./controller/dentistController")
app.use('/dentist', dentistRoute)

app.use(require("./controller"));

 var server = app.listen(port, function(){
     console.log("Server is running at port 8080...");
 })
app.get('/test', async (req, res) => {
    res.json({message: 'pass!'})
})