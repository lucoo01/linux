# 在ubuntu中安装及使用rvm管理ruby版本


> RVM的主要作用是方便的管理系统中的多个ruby版本而不至于混乱。
我们来看看如何安装RVM，我使用的ubuntu12.04LTS。

## 安装rvm

用rvm官方推荐的方式安装 
```
curl -L get.rvm.io | bash -s stable
```
回显提示我们，RVM被安装在$HOME/.vrm中；并且需要在终端中加载脚本$HOME/.rvm/scripts/rvm
```
loen@loen-ubuntu:~$ curl -L get.rvm.io | bash -s stable  
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current  
                                 Dload  Upload   Total   Spent    Left  Speed  
100   185  100   185    0     0    144      0  0:00:01  0:00:01 --:--:--   906  
100 10235  100 10235    0     0   3929      0  0:00:02  0:00:02 --:--:-- 10888  
Downloading RVM from wayneeseguin branch stable  
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current  
                                 Dload  Upload   Total   Spent    Left  Speed  
100   131  100   131    0     0     62      0  0:00:02  0:00:02 --:--:--   143  
100 1124k  100 1124k    0     0   127k      0  0:00:08  0:00:08 --:--:--  269k  
  
Installing RVM to /home/loen/.rvm/  
    RVM PATH line found in /home/loen/.bashrc /home/loen/.zshrc.  
    RVM sourcing line found in /home/loen/.bash_profile /home/loen/.zprofile.  
  
# RVM:  Shell scripts enabling management of multiple ruby environments.  
# RTFM: https://rvm.io/  
# HELP: http://webchat.freenode.net/?channels=rvm (#rvm on irc.freenode.net)  
# Cheatsheet: http://cheat.errtheblog.com/s/rvm/  
# Screencast: http://screencasts.org/episodes/how-to-use-rvm  
  
# In case of any issues read output of 'rvm requirements' and/or 'rvm notes'  
  
Installation of RVM in /home/loen/.rvm/ is almost complete:  
  
  * To start using RVM you need to run `source /home/loen/.rvm/scripts/rvm`  
    in all your open shell windows, in rare cases you need to reopen all shell windows.  
  
# loen,  
#  
#   Thank you for using RVM!  
#   I sincerely hope that RVM helps to make your life easier and more enjoyable!!!  
#  
# ~Wayne  
```
应该请把这句话加在$HOME/.bash_profile文件中，以便在开启一个终端会话时候加载RVM
```
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.  
```

```
loen@loen-ubuntu:~$ rvm -v  
  
rvm 1.16.20 (stable) by Wayne E. Seguin <wayneeseguin@gmail.com>, Michal Papis <mpapis@gmail.com> [https://rvm.io/]  
```

```
Additional Dependencies:  
# For Ruby / Ruby HEAD (MRI, Rubinius, & REE), install the following:  
  ruby: /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config  
```

```
loen@loen-ubuntu:~$ rvm list  
  
rvm rubies  
  
# No rvm rubies installed yet. Try 'rvm help install'.  
```
察看RVM可供安装的ruby版本
```
loen@loen-ubuntu:~$ rvm list known  
# MRI Rubies  
[ruby-]1.8.6[-p420]  
[ruby-]1.8.7-p370  
[ruby-]1.8.7[-p371]  
[ruby-]1.9.1[-p431]  
[ruby-]1.9.2-p180  
[ruby-]1.9.2-p290  
[ruby-]1.9.2-p318  
[ruby-]1.9.2[-p320]  
[ruby-]1.9.2-head  
[ruby-]1.9.3-preview1  
[ruby-]1.9.3-rc1  
[ruby-]1.9.3-p0  
[ruby-]1.9.3-p125  
[ruby-]1.9.3-p194  
[ruby-]1.9.3-p286  
[ruby-]1.9.3-[p327]  
[ruby-]1.9.3-head  
[ruby-]2.0.0-preview1  
ruby-head  
```
```
loen@loen-ubuntu:~$ rvm install 1.9.3-head  
```
```
loen@loen-ubuntu:~$ rvm list  
  
rvm rubies  
  
   ruby-1.8.7-p371 [ i686 ]  
   ruby-1.9.3-head [ i686 ]  
  
# Default ruby not set. Try 'rvm alias create default <ruby>'.  
```

```
loen@loen-ubuntu:~$ rvm use ruby-1.9.3-head --default  
Using /home/loen/.rvm/gems/ruby-1.9.3-head  
```
设置好之后察看ruby版本

```
loen@loen-ubuntu:~$ ruby -v  
ruby 1.9.3p327 (2012-11-10) [i686-linux]  
```
察看ruby的路径，就是RVM帮我们安装的
```
loen@loen-ubuntu:~$ which ruby  
/home/loen/.rvm/rubies/ruby-1.9.3-head/bin/ruby  
```
短路RVM

刚才是用RVM进行ruby版本管理，当然了通过其他渠道例如apt-get也可以安装ruby，可以对RVM设置短路以便使用系统默认的ruby版本。
```
loen@loen-ubuntu:~$ rvm use system  
Now using system ruby.  
loen@loen-ubuntu:~$ ruby -v  
ruby 1.8.7 (2011-06-30 patchlevel 352) [i686-linux]  
loen@loen-ubuntu:~$ which ruby  
/usr/bin/ruby  
```
卸载RVM

不想玩了，我要卸载。这个命令会移除$HOME/.rvm目录下面的所有东西即RVM管理的版本们。
```
rvm implode  
```