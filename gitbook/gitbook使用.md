# 如何用gitbook写书

##　目标

生成一本小书，它有前言，章节1，章节2，后记。例如：

```
简介
第一章：如何造火箭
     1. 燃料学
     2. 空气动力学
     3. 总装工程学
第二章：如何回收火箭
     1. 自动控制原理
     2. 二次利用要点
结束
```

### 准备工作

建一个写书的目录，以后所有工作都在这个目录下搞。例如
```
/Users/raywill/gitbook/first
```

开干！生成书籍框架

在电脑上建立整本书的目录结构，以及文件结构。

我们可以自己一步步用文件管理器新建文件夹，新建文件，不过这么做太累了，gitbook可以帮我们自动生成。我们需要做的是提供一个叫做SUMMARY.md的文件给gitbook，然后调用
```
gitbook init
```
就能自动生成目录结构及每个章节的markdown文件。

我们先为我们的新书写SUMMARY.md，内容如下：
```
[简介](README.md)
* [第一章：如何造火箭](ch1/build.md)
 - [1. 燃料学](ch1/fuel.md)
 - [2. 空气动力学](ch1/air.md)
 - [3. 总装工程学](ch1/enginer.md)
 - [小结](ch1/WRAPUP.md)
* [第二章：如何回收火箭](ch2/recycle.md)
 - [1. 自动控制原理](ch2/ac.md)
 - [2. 二次利用要点](ch2/key.md)
* [结束](end/SUMMARY.md)
```
写好后，执行
```
gitbook init
```
可以看到屏幕输出如下：
```
raywill:first raywill$ gitbook init
info: init book at /Users/raywill/gitbook/first
info: detect structure from SUMMARY (if it exists)
info: create README.md
info: create ch1/build.md
info: create ch1/fuel.md
info: create ch1/air.md
info: create ch1/enginer.md
info: create ch1/WRAPUP.md
info: create ch2/recycle.md
info: create ch2/ac.md
info: create ch2/key.md
info: create end/SUMMARY.md
info: initialization is finished

Done, without error
```
可见，gitbook按照我们的要求，帮我们生成好了所有文件。生成的文件结构如下：
```
.
├── README.md
├── SUMMARY.md
├── ch1
│   ├── WRAPUP.md
│   ├── air.md
│   ├── build.md
│   ├── enginer.md
│   └── fuel.md
├── ch2
│   ├── ac.md
│   ├── key.md
│   └── recycle.md
└── end
    └── SUMMARY.md
```
每个文件的第一行就是我们写的章节标题。

写书

这个时候，按照markdown的格式逐个填充内容到文件即可。至于用什么编辑器写Markdown文件，随你了。本地的，在线的，都成。

生成电子书

执行如下命令生成pdf格式电子书：
```
gitbook pdf .
```
命令由三部分组成：命令（gitbook），生成的格式（pdf），markdown源文件位置（.，点表示当前目录）。

命令运行后可以看到如下输出，表示生成pdf成功。这时候，目录里面多了一个pdf文件。
```
raywill:first raywill$ gitbook pdf .
info: loading book configuration....OK
info: load plugin gitbook-plugin-highlight ....OK
info: load plugin gitbook-plugin-search ....OK
info: load plugin gitbook-plugin-sharing ....OK
info: load plugin gitbook-plugin-fontsettings ....OK
info: >> 4 plugins loaded
info: start generation with pdf generator
info: clean pdf generatorOK
info: write SUMMARY.html
info: start conversion to pdf ....OK
info: generation is finished
info: >> 1 file(s) generated

Done, without error
```
如果希望生成epub或者mobi格式的，分别执行下面的命令即可：
```
gitbook epub .

gitbook mobi .
```