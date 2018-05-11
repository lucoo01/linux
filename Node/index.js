var express = require('express');
var app = express();
var process = require('child_process');
var bodyParser = require('body-parser');


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));


var fs = require('fs');
var PORT = 9005;
//console.log('fssssss');

function writeFile(file, str) {

    fs.writeFile(file, str, function(err) {
        if (err) console.log("fail " + err);
    });
}

app.get('/killdiepid', function(req, res) {

    process.exec("/root/kill_die_process.sh", function(error, stdout, stderr) {

        if (error !== null) {
            console.log('exec error: ' + error);
            res.send("清除失败");
        } else {
            res.send("已成功清除");
        }

    });


});

//app.get("/runcode", function(req, res){
	
//res.send("Hello runcode");

//});

app.all('/runcode', function(req, res, next) {

    res.header("Access-Control-Allow-Origin", "*"); // 手机端的来源要如何控制
    res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

app.post('/runcode', function(req, res) {
   // console.log('fffffffff');
    var lang = req.body.lang;
    var code = req.body.code;
    var classname = req.body.classname;



    var langsuf = {
        'php': {
            'suf': 'php',
            'cmd': 'php -f #{file}'
        },
        'ruby': {
            'suf': 'rb',
            'cmd': 'ruby #{file}'
        },
        'python': {
            'suf': 'py',
            'cmd': 'python #{file}'
        },
        'python3': {
            'suf': 'py',
            'cmd': 'python3 #{file}'
        },
        'java': {
            'suf': 'java',
            'cmd': 'javac #{file}; java -cp #{path} #{classname}'
        },
        'c': {
            'suf': 'c',
            'cmd': 'gcc #{file} -o #{path}runc; #{path}runc'
        },
        'cpp': {
            'suf': 'cpp',
            'cmd': 'g++ #{file} -o #{path}runcpp; #{path}runcpp'
        },
        'go': {
            'suf': 'go',
            'cmd': 'go run #{file}'
        },
        'perl': {
            'suf': 'pl',
            'cmd': 'perl #{file}'
        },
        'perl6': {
            'suf': 'pl',
            'cmd': 'perl6 #{file}'
        },
        'lua': {
            'suf': 'lua',
            'cmd': 'lua #{file}'
        }
    };



    if (typeof langsuf[lang] == 'undefined') {
        res.end('no support this language!!');
    }

    var filePath = '/root/soft/playground/';
    var file, filename;
    if (lang == 'java') {
        classname = classname.replace(/^\s+|\s+$/g, '');
        if (classname == '') {
            res.end('java param is error!!!');
            return;
        }
        filename = classname + '.' + langsuf[lang]['suf'];
        file = filePath + filename;
    } else {
        filename = 'index.' + langsuf[lang]['suf'];
        file = filePath + filename;

    }

    writeFile(file, code);
    var exec_cmd = langsuf[lang]['cmd'];
    exec_cmd = exec_cmd.replace(/#{file}/g, file);
    exec_cmd = exec_cmd.replace(/#{path}/g, filePath);
    exec_cmd = exec_cmd.replace(/#{classname}/g, classname);
    exec_cmd = exec_cmd.replace(/#{filename}/g, filename);

    process.exec(exec_cmd, function(error, stdout, stderr) {
        if (error !== null) {
            console.log('exec error: ' + error);
        }
        var errinfo = '';
        if (stdout === null) {

            res.end(stderr);
        } else {
            if (stderr !== null && stderr != '') {
                errinfo = stderr;
            }
            res.end(stdout + errinfo);
        }

    });

});

var server = app.listen(PORT, function () {
 
  var host = server.address().address
  var port = server.address().port
 
  console.log("应用实例，访问地址为 http://%s:%s", host, port)
 
});