var express = require('express');
var router = express.Router();
var mongojs = require('mongojs');
var db = mongojs('mongodb://mongo-0.mongo');

router.get('/', function(req, res, next){
     
    res.render('index.ejs');
});

router.get('/adduser', function(req, res, next){
    res.render('addUser.ejs');
});

router.post('/adduser', function(req, res, next){
    user=req.body
    db.users.save(user, function(err, user) {
       if(err) { 
            console.log(err); 
       }
    });
    res.render('addUser.ejs');
});

router.get('/listuser', function(req, res, next){
    
    db.users.find(function(err, users) {
       if(err) { 
            console.log(err); 
       }else {
            res.render('listUser.ejs', { "users": users });
       }
    });
});

module.exports = router;
 
