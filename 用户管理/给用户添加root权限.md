# 赋予root权限

方法一(推荐)： 修改 /etc/sudoers 文件，找到下面一行，在root下面添加一行，如下所示：
```
## Allow root to run any commands anywhere
root    ALL=(ALL)     ALL
loen   ALL=(ALL)     ALL
```
修改完毕，现在可以用loen帐号登录，然后用命令 su – ，即可获得root权限进行操作。

方法二： 修改 /etc/sudoers 文件，找到下面一行，把前面的注释（#）去掉
```
## Allows people in group wheel to run all commands
%wheel    ALL=(ALL)    ALL
```
然后修改用户，使其属于root组（wheel），命令如下：
```
#usermod -g root loen
```
修改完毕，现在可以用loen帐号登录，然后用命令 su – ，即可获得root权限进行操作。

方法三： 修改 /etc/passwd 文件，找到如下行，把用户ID修改为 0 ，如下所示：
```
loen:x:500:500:loen:/home/loen:/bin/bash
```
修改后如下
```
loen:x:0:500:loen:/home/loen:/bin/bash
```
保存，用loen账户登录后，直接获取的就是root帐号的权限。