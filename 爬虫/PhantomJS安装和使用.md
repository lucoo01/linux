一.安装：

获取安装包，并解压：
```
mkdir ~/bin/
cd ~/bin/
## 
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar -xjvf phantomjs-2.1.1-linux-x86_64.tar.bz2
```

将可执行文件放入系统路径：　
```
sudo ln -s ~/bin/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
```

安装依赖——fontconfig和freetype：　
```
yum install -y fontconfig freetype2
```
在终端下测试Phantomjs。你应该会看到如下输出：
```
phantomjs -v

2.1.1

cd ~/bin/phantomjs-2.1.1-linux-x86_64/bin
```
新建脚本，并确认截图是否OK：
```
vim a.js
```
```
var page = require('webpage').create();
page.open('https://www.baidu.com/', function () {
    page.render('test/example.png');
    phantom.exit();
});
```
保存后进行截图测试　
```
phantomjs a.js
```
完成后会出现一个test文件夹，在文件夹内有个图片

查看图片，显示乱码。

解决方案，安装字体。
```
yum install -y bitmap-fonts bitmap-fonts-cjk
```
再次执行截图
```
phantomjs a.js
```
查看图片，字体显示正常。

二.使用：

Hello， World！

新建一个包含下面两行脚本的文本文件：
```
vim hello.js
```
```
console.log('Hello, world!');
phantom.exit();
```
将文件保存后执行：

```
phantomjs hello.js
```
输出结果为：Hello, world!

第一行将会在终端打印出字符串，第二行 phantom.exit 将退出运行。 
在该脚本中调用 phantom.exit 是非常重要的，否则 PhantomJS 将根本不会停止。

脚本参数 – Script Arguments

Phantomjs如何传递参数呢？如下所示 ：
```
phantomjs examples/arguments.js foo bar baz
```
其中的foo, bar, baz就是要传递的参数，如何获取呢：

```
var system = require('system');
if (system.args.length === 1) {
    console.log('Try to pass some args when invoking this script!');
} else {
    system.args.forEach(function (arg, i) {
            console.log(i + ': ' + arg);
    });
}
phantom.exit();
```
它将输出 ：

0: foo
1: bar
2: baz

页面加载 – Page Loading

通过创建一个网页对象，一个网页可以被加载，分析和渲染。

下面的脚本将示例页面对象最简单的用法，它加载 example.com 并且将它保存为一张图片， example.png 。
```
vi a.js
```
```
var page = require('webpage').create();
page.open('https://www.baidu.com/', function () {
    page.render('test/example.png');
    phantom.exit();
});
```
保存后进行截图测试　
```
phantomjs a.js
```
由于它的这个特性，PhantomJS 可以用来 网页截屏 ，截取一些内容的快照，比如将网页、SVG存成图片，PDF等，这个功能很牛X。

接下来的 loadspeed.js 脚本加载一个特殊的URL (不要忘了http协议) 并且计量加载该页面的时间。

```
var page = require('webpage').create(),
    system = require('system'),
    t, address;

if (system.args.length === 1) {
    console.log('Usage: loadspeed.js <some URL>');
    phantom.exit();
}

t = Date.now();
address = system.args[1];
page.open(address, function (status) {
    if (status !== 'success') {
        console.log('FAIL to load the address');
    } else {
        t = Date.now() - t;
        console.log('Loading time ' + t + ' msec');
    }
    phantom.exit();
});
```
在命令行运行该脚本：　
```
phantomjs loadspeed.js http://www.google.com
```
它输出像下面的东西：
```
Loading  http://www.google.com  Loading time 719 msec
```

代码运算 – Code Evaluation

要想在网页的上下文中对JavaScript 或 CoffeeScript 进行运算，使用 evaluate()方法。代码是在“沙箱”中运行的，它没有办法读取在其所属页面上下文之外的任何JavaScript对象和变量。 evaluate() 会返回一个对象，然而它仅限制于简单的对象并且不能包含方法或闭包。

这有一个示例来显示网页标题：

```
var page = require('webpage').create();
page.open(url, function (status) {
    var title = page.evaluate(function () {
        return document.title;
    });
    console.log('Page title is ' + title);
});
```

任何来自于网页并且包括来自 evaluate() 内部代码的控制台信息，默认不会显示的。要重写这个行为，使用 onConsoleMessage 回调函数，前一个示例可以被改写成：

```
var page = require('webpage').create();
page.onConsoleMessage = function (msg) {
    console.log('Page title is ' + msg);
};
page.open(url, function (status) {
    page.evaluate(function () {
        console.log(document.title);
    });
});
```
DOM操作 – DOM Manipulation

由于脚本好像是一个Web浏览器上运行的一样，标准的DOM脚本和CSS选择器可以很好的工作。这使得PhantomJS适合支持各种 页面自动化任务 。

下面的  useragent.js  将读取 id  为myagent的元素的  textContent  属性：

```
var page = require('webpage').create();
console.log('The default user agent is ' + page.settings.userAgent);
page.settings.userAgent = 'SpecialAgent';
page.open('http://www.httpuseragent.org', function (status) {
    if (status !== 'success') {
        console.log('Unable to access network');
    } else {
        var ua = page.evaluate(function () {
            return document.getElementById('myagent').textContent;
        });
        console.log(ua);
    }
    phantom.exit();
});
```
上面示例同样提供了一种自定义 user agent 的方法。

使用JQuery及其他类库：

```
var page = require('webpage').create();
page.open('http://www.sample.com', function() {
    page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
        page.evaluate(function() {
            $("button").click();
        });
        phantom.exit()
    });
});
```

网络请求及响应 – Network Requests and Responses

将一个页面从一台远程服务器请求一个资源的时候，请求和响应均可以通过 onResourceRequested  和  onResourceReceived  回调方法追踪到。示例  netlog.js ：

```
var page = require('webpage').create();
page.onResourceRequested = function (request) {
    console.log('Request ' + JSON.stringify(request, undefined, 4));
};
page.onResourceReceived = function (response) {
    console.log('Receive ' + JSON.stringify(response, undefined, 4));
};
page.open(url);
```
获取如何把该特性用于HAR 输出以及基于YSlow的性能分析的更多信息，请参阅 网络监控页面 。


自定义Cookie
```
var webPage = require('webpage');
var page = webPage.create();

phantom.addCookie({
  'name'     : 'Valid-Cookie-Name',   /* required property */
  'value'    : 'Valid-Cookie-Value',  /* required property */
  'domain'   : 'localhost',
  'path'     : '/foo',                /* required property */
  'httponly' : true,
  'secure'   : false,
  'expires'  : (new Date()).getTime() + (1000 * 60 * 60)   /* <-- expires in 1 hour */
});
```

实例
```
var page = require('webpage').create();  
var ad = require('./address.js');
var address = ad.address;
var filename = ad.filename;
var fs = require('fs');

var output = './screen.png';//存储文件路径和名称  

page.viewportSize = { width: 1280, height: 800 };//设置长宽  
  
var flag = phantom.addCookie({  
        "domain": ".newrank.cn",  
        "expires": "Fri, 01 Jan 2038 00:00:00 GMT",  
        "expiry": 2145916800,  
        "httponly": false,  
        "name": "token",  
        "path": "/",  
        "secure": false,  
        "value": "449203942DF9D2DC45B7BEF629D0ED60" //这里省略了，输入自己的value即可  
});  
  
if(flag){  
    page.open(address, function (status) {  
        if (status !== 'success') {  
        console.log('Unable to load the address!');  
        phantom.exit();  
        } else {
        window.setTimeout(function(){  
            //page.render(output);
            fs.write('./static/'+filename+'.html', page.content, 'w');
            phantom.exit();  
        }, 1200);  

        }  
    });  
}else{  
    console.log('error!!!');  
}

```

[PhantomJs官网](http://phantomjs.org/)
[PhantomJs官网 API](http://phantomjs.org/api/)
[PhantomJs官网 文档](http://phantomjs.org/documentation/)