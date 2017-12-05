## 安装
## 获取QueryList

### 方式一:到QueryList官网下载QueryList完整压缩包
```
QueryList官网地址:http://querylist.cc/
到官网找到对应的下载链接，然后选择想要下载的QueryList版本，下载压缩包，解压后即可使用。
```
### 方式二:手动从GIT上获取
```
QueryList V3地址:https://github.com/jae-jae/QueryList/tree/V3.2.1

phpQuery GIT地址:https://github.com/jae-jae/phpQuery-single

手动只下载QueryList.php和phpQuery.php这两个文件即可。
```

### 方式三:通过composer安装 （推荐）

执行命令:
```
composer require jaeger/querylist:V3.2.1
```

## 获取QueryList插件

QueryList扩展需要选择性的单独安装,以下是几个插件是默认的演示插件，更多插件请关注QueryList社区和交流群:

Request网络操作扩展:
```
composer require jaeger/querylist-ext-request
```
Multi多线程扩展:
```
composer require jaeger/querylist-ext-multi
```
Login模拟登陆扩展:
```
composer require jaeger/querylist-ext-login
```
包含QueyListy以及扩展的完整Composer配置如下:
```
{
    "require": {
        "jaeger/querylist": "^3.1",
        "jaeger/querylist-ext-request":"^1.0",
        "jaeger/querylist-ext-multi":"^1.0",
        "jaeger/querylist-ext-login":"^1.0"
    }
}
```
以下类库是上面扩展的依赖，安装扩展的时候会自动安装，也可以选择单独引入使用:

## Http类:
```
composer require jaeger/http
```
CurlMulti多线程类:
```
composer require jaeger/curlmulti
```
---

##　通过Composer安装的

只需要引入vendor/autoload.php文件就可以使用QueryList及其所有插件了（如果安装了插件的话）。

例:
```
<?php
require 'vendor/autoload.php';
use QL\QueryList;
$hj = QueryList::Query('http://mobile.csdn.net/',array("url"=>array('.unit h1 a','href')));
$data = $hj->getData(function($x){
    return $x['url'];
});
print_r($data);
```
手动安装的

手动下载phpQuery.php和QueryList.php这两个文件，然后手动引入这两个文件就可以了。
例:
```
<?php
require 'phpQuery.php';
require 'QueryList.php';
use QL\QueryList;
$hj = QueryList::Query('http://mobile.csdn.net/',array("url"=>array('.unit h1 a','href')));
$data = $hj->getData(function($x){
    return $x['url'];
});
print_r($data);
```
手动安装QueryList插件

假设QueryList所在目录为:
```
path/to/QueryList/
```
则插件目录应该为:
```
path/to/QueryList/Ext/
```
所有插件都依赖一个基类AQuery,也存放在插件目录，下载地址:
```
https://github.com/jae-jae/QueryList-Ext-AQuery
```
插件所依赖的类库存放目录为:
```
path/to/QueryList/Ext/Lib/
```
目录不存在的话手动创建这些目录即可。
然后需要手动引入需要用到的插件文件，就可以使用插件了。
在各大框架中使用QueryList

遵循当前使用的框架的引入类库的规则引入即可使用，后面将做专题讲解。

[教程链接](http://v3.querylist.cc/site/index/doc/11)