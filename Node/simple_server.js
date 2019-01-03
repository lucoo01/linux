
// 使用nodejs 编写简单的服务器
var http = require("http");
var hostName = '0.0.0.0';

var port = 9006;

var server = http.createServer(function(req,res){
    res.setHeader('Content-Type','text/plain');
    res.end("hello nodejs");

});
server.listen(port,hostName,function(){
    console.log(`服务器运行在http://${hostName}:${port}`);
});
