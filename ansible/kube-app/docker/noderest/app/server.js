var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');

var api=require('./routes/api');

var port=3000
var app = express();


//Body parser MW
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false }));

app.use('/api',api);


app.listen(port, function(){
  console.log('Server started on port '+port);
});

