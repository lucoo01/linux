var express = require('express');
var app = express();
//var process = require('child_process');
var bodyParser = require('body-parser');
var path = require('path');
var http = require('http'); 

var PORT = 8089;

// 获取POST数据必要的操作
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 使用静态资源
app.use(express.static(path.join(__dirname, 'public')));

app.use(express.static('./js'));

var fs = require('fs');

// 创建一个http服务器
var httpServer = http.createServer(app);

httpServer.listen(PORT, function(){
        console.log('HTTP Server is running on hppts://localhost:%s',PORT);
});

app.all('/', function(req, res, next) {

    //res.header("Access-Control-Allow-Origin", "*");
    res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

app.get('/', function(req, res){

	var lang = req.query.lang;
	var code = req.query.code;


	res.end('lang:'+lang+'   code:'+code);

});