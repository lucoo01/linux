# 解决 Navicat for Mysql连接mysql出现10038问题


设置mysql服务允许外网访问，修改mysql的配置文件，有的是my.ini，有的是my.cnf【linux】.

1：设置mysql的配置文件
     /etc/my.cnf
     找到 bind-address  =127.0.0.1  将其注释掉；//作用是使得不再只允许本地访问；
也可以改成bind-address  =0.0.0.0   // 如果没有这个 就不用管
 
　　lnmp restart
 
2：在Linux端登录mysql数据库：mysql -u root -p
　　mysql> use mysql;
 
　　查询host值：
mysql> select user,host from user;
 
如果没有"%"这个host值,就执行下面这两句:
mysql> grant all privileges on *.*  to  'root'@'%'  identified by 'youpassword'  with grant option;
mysql> flush privileges;


LINUX防火墙的打开与关闭方法
1) 重启后生效 

　　开启： chkconfig iptables on 

　　关闭： chkconfig iptables off 



2) 即时生效，重启后失效 

　　开启： service iptables start 

　　关闭： service iptables stop 

　　需要说明的是对于Linux下的其它服务都可以用以上命令执行开启和关闭操作。 

　　在开启了防火墙时，做如下设置，开启相关端口， 

　　修改/etc/sysconfig/iptables 文件，添加以下内容： 

　　-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT 

　　-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT 