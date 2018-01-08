#Python 安装 第三方库的安装技巧
>我的电脑：Windows 10 64位。 
>Python IDE 软件：PyCharm 2016.1.4 
>Python version : Python 3.5.0

## 安装一个两条建议： 
1. 使用 pip 命令行工具在线下载你需要的第三方库 
2. 手动下载 第三方库，再使用 pip 命令安装

1. 使用 pip 命令行工具在线下载你需要的第三方库
Q： 什么是 pip ？ 
A： pip 是Python的软件包管理系统，Python语言自带的命令行工具，它可以安装和管理第三方软件包。

## 使用 pip 工具安装软件包的命令是：

pip install some-package-name

举例：安装 requests 第三方库
我们现在下载名字为：requests 的第三方库。（这个库是用来处理HTTP的Python第三方库。） 
在命令行窗口中执行下面的命令：
```
pip install requests
```

这样 requests 第三方库就下载和安装完成了。 
在你的脚本中添加：import requests，就可以使用这个 Requests 库。

Q： 如果你在执行pip install some-package-name 命令的时候，它输出：没有找到这样的软件包。比如执行：pip install opencv 命令，它会输出：
```
  Could not find a version that satisfies the requirement opencv (from versions: )
No matching distribution found for opencv
```
遇到这样的情况要然后解决呢？ 
A： 遇到这种情况，多半是：撞墙的原因。这时，我们就需要手动下载相关第三方库的安装包了。

2. 手动下载 第三方库，再使用 pip 命令安装
使用pip 安装时，有时会遇到网上慢或者撞墙的现象，这时我们就到这个网站手动下载你需要的安装包：http://www.lfd.uci.edu/~gohlke/pythonlibs/。这个网站里面的Python第三方库可以说是包罗万象。

举例：安装 opencv 第三方库
Step 1 . 来到这个网站：[python库](http://www.lfd.uci.edu/~gohlke/pythonlibs/)

Step 2 . 按组合键：Ctrl + F 查找关键词：opencv， 点击下面图中的opencv

现在你能看到下面的 opencv 版本，因为我使用的是 Python 3.5.0 版本，并且我的电脑是64位的，所以我选择下载：opencv_python-3.1.0-cp35-cp35m-win_amd64.whl

Step 3 . 下载完成后，在 命令提示符窗口 中，执行下面的命令（其中软件包要输入绝对路径）：
```
pip install D:\Downloads\opencv_python-3.1.0-cp35-cp35m-win_amd64.whl
```
成功安装，输出下面信息：
```
Processing d:\downloads\opencv_python-3.1.0-cp35-cp35m-win_amd64.whl
Installing collected packages: opencv-python
Successfully installed opencv-python-3.1.0
```

## 扩展： 
如果我下载的是：opencv_python-2.4.13-cp27-cp27m-win_amd64.whl，那么我在使用pip 工具安装时：
```
pip install D:\Downloads\opencv_python-2.4.13-cp27-cp27m-win_amd64.whl
```
会输出下面的信息：
```
opencv_python-2.4.13-cp27-cp27m-win_amd64.whl is not a supported wheel on this platform.
```
这说明opencv的软件包我下载错了，这个软件包，不支持Python3.5.0版。

## pip 工具升级
如果你在执行 pip 命令，需要下面的输出：
```
You are using pip version 7.1.2, however version 8.1.2 is available.
You should consider upgrading via the 'python -m pip install --upgrade pip' command.
```

它提示你：你目前的 pip 工具的版本不是最新的，需要更新。你完全可以不用管它，但是我是一个比较讲究的人，所以：更新 pip 工具的命令如下，执行下面的命令：
```
python -m pip install --upgrade pip
```

现在，就不会再出现：提示你更新pip工具 的输出了。

参考网站： 
Python 3.4 & Windows下安装OpenCV 
http://www.ywlib.com/archives/39.html