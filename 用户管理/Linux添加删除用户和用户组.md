1、建用户：
```
adduser loen                             
passwd Iamloenisaphper                               //给phpq用户设置密码
```
2、建工作组
```
groupadd work                          //新建work工作组
```
3、新建用户同时增加工作组
```
useradd -g work loen                      //新建loen用户并增加到work工作组
```
注：：-g 所属组 -d 家目录 -s 所用的SHELL

4、给已有的用户增加工作组
```
usermod -G groupname username  （这个会把用户从其他组中去掉）

usermod -a groupname username
```
或者：gpasswd -a user group

如果添加了用户，添加了组，然后使这个组里的人都可以sudo 到公共账号下

可以/etc/sudoers.d 下面建立一个文件内容如下 ，就可以是etl组的所有用户都可以无密码的切到etl用户下。
```
%etl ALL=(ALL) NOPASSWD: /bin/su etl
%etl ALL=(ALL) NOPASSWD: /bin/su - etl
```
sudo 具体参考 http://www.cnblogs.com/xd502djj/p/6641475.html

5、临时关闭：在/etc/shadow文件中属于该用户的行的第二个字段（密码）前面加上*就可以了。想恢复该用户，去掉*即可。

或者使用如下命令关闭用户账号：
```
passwd peter –l
```
重新释放：
```
passwd peter –u
```
6、永久性删除用户账号
```
userdel peter

groupdel peter

usermod –G peter peter   （强制删除该用户的主目录和主目录下的所有文件和子目录）
```
7、从组中删除用户
编辑/etc/group 找到GROUP1那一行，删除 A
或者用命令
```
gpasswd -d A GROUP
```
8、显示用户信息
```
id user
cat /etc/passwd
```