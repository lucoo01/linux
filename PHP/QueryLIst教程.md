## 安装

通过Composer安装:
```
composer require jaeger/querylist
```
## 初探

看看PHP用QueryList做采集到底有多简洁吧!
```
<?php

use QL\QueryList;

//采集某页面所有的图片
$data = QueryList::get('http://cms.querylist.cc/bizhi/453.html')->find('img')->attrs('src');
//打印结果
print_r($data->all());

//采集某页面所有的超链接和超链接文本内容
//可以先手动获取要采集的页面源码
$html = file_get_contents('http://cms.querylist.cc/google/list_1.html');
//然后可以把页面源码或者HTML片段传给QueryList
$data = QueryList::html($html)->rules([  //设置采集规则
    // 采集所有a标签的href属性
    'link' => ['a','href'],
    // 采集所有a标签的文本内容
    'text' => ['a','text']
])->query()->getData();
//打印结果
print_r($data->all());

/**
 * 在线测试采集并查看采集结果:http://querylist.cc/page-Querytest.html
 */
```
## 进阶

上面的采集结果有很多“杂质”，一定不会满足你的要求，来获取我们真正想要的结果。
```
<?php

// 采集该页面[正文内容]中所有的图片
$data = QueryList::get('http://cms.querylist.cc/bizhi/453.html')->find('.post_content img')->attrs('src');
//打印结果
print_r($data->all());


// 采集该页面文章列表中所有[文章]的超链接和超链接文本内容
$data = QueryList::get('http://cms.querylist.cc/google/list_1.html')->rules([
    'link' => ['h2>a','href','',function($content){
        //利用回调函数补全相对链接
        $baseUrl = 'http://cms.querylist.cc';
        return $baseUrl.$content;
    }],
    'text' => ['h2>a','text']
])->range('.cate_list li')->query()->getData();
//打印结果
print_r($data->all());
```
## 全貌

正如你看到的那样，使用QueryList做采集只需要编写采集规则即可！
```
<?php
/**
 * 下面来完整的演示采集一篇文章页的文章标题、发布日期和文章内容并实现图片本地化
 */

 //引入自动加载文件
require 'vendor/autoload.php';

use QL\QueryList;


//需要采集的目标页面
$page = 'http://cms.querylist.cc/news/566.html';
//采集规则
$reg = [
    //采集文章标题
    'title' => ['h1','text'],
    //采集文章发布日期,这里用到了QueryList的过滤功能，过滤掉span标签和a标签
    'date' => ['.pt_info','text','-span -a',function($content){
        //用回调函数进一步过滤出日期
        $arr = explode(' ',$content);
        return $arr[0];
    }],
    //采集文章正文内容,利用过滤功能去掉文章中的超链接，但保留超链接的文字，并去掉版权、JS代码等无用信息
    'content' => ['.post_content','html','a -.content_copyright -script']
];
$rang = '.content';
$ql = QueryList::get($page)->rules($reg)->range($rang)->query();

$data = $ql->getData(function($item){
  //利用回调函数下载文章中的图片并替换图片路径为本地路径
  //使用本例请确保当前目录下有image文件夹，并有写入权限
  $content = QueryList::html($item['content']);
  $content->find('img')->map(function($img){
      $src = 'http://cms.querylist.cc'.$img->src;
      $localSrc = 'image/'.md5($src).'.jpg';
      $stream = file_get_contents($src);
      file_put_contents($localSrc,$stream);
      $img->attr('src',$localSrc);
  });
  $item['content'] = $content->find('')->html();
  return $item;
});

//打印结果
print_r($data->all());
```
## 插件

QueryList拥有高度的模块化设计,扩展性强；通过插件可以轻松实现诸如：多线程采集、图片本地化、模拟浏览器行为、网络爬虫等强大功能！
```
<?php
/**
 * 下面来利用QueryList插件来组合上面的例子，实现多线程采集文章
 */
require 'vendor/autoload.php';

use QL\QueryList;
use QL\Ext\AbsoluteUrl;
use QL\Ext\CurlMulti;

// 注册插件
$ql = QueryList::use([
	AbsoluteUrl::class, // 转换URL相对路径到绝对路径
	CurlMulti::class    // Curl多线程采集
]);

// 获取文章列表链接集合，使用AbsoluteUrl插件转换URL相对路径到绝对路径.
$urls = $ql->get('http://cms.querylist.cc/news/list_2.html',[
    'param1' => 'testvalue',
    'params2' => 'somevalue'
],[
    'headers' => [
        'Referer' => 'https://querylist.cc/',
        'User-Agent' => 'testing/1.0',
        'Accept'     => 'application/json',
        'X-Foo'      => ['Bar', 'Baz'],
        'Cookie'    => 'abc=111;xxx=222'
    ]
])->absoluteUrl('http://cms.querylist.cc/news/list_2.html')->find('h2>a')->attrs('href')->all();


//使用CurlMulti多线程插件采集文档内容
$ql->rules([ // 设置采集规则
	   'title'   => ['h1', 'text'],
	   'date'    => ['.pt_info', 'text', '-span -a', function ($content) {
		   //用回调函数进一步过滤出日期
		   $arr = explode(' ', $content);
		   return $arr[0];
	   }],
	   'content' => ['.post_content', 'html','a -.content_copyright -script']
   ])
	// 设置采集任务
   ->curlMulti($urls)
   // 每个任务成功完成调用此回调
   ->success(function (QueryList $ql, CurlMulti $curl, $r) {
	   echo "Current url:{$r['info']['url']} \r\n";
	   $data = $ql->range('.content')->query()->getData();
	   print_r($data->all());
   })
   // 开始执行多线程采集
   ->start([
	   // 最大并发数
	   'maxThread' => 10,
	   // 错误重试次数
	   'maxTry'    => 3
   ]);
```