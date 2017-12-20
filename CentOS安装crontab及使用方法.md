## 安装crontab:
```
[root@CentOS ~]# yum install vixie-cron
[root@CentOS ~]# yum install crontabs
```

>说明：
>vixie-cron软件包是cron的主程序；
>crontabs软件包是用来安装、卸装、或列举用来驱动 cron 守护进程的表格的程序。
>//+++++++++++++++++++++++++++++++++++
>cron 是linux的内置服务，但它不自动起来，可以用以下的方法启动、关闭这个服务：
>/sbin/service crond start //启动服务
>/sbin/service crond stop //关闭服务
>/sbin/service crond restart //重启服务
>/sbin/service crond reload //重新载入配置

查看crontab服务状态：
```
service crond status
```

手动启动crontab服务：
```
service crond start
```

查看crontab服务是否已设置为开机启动，执行命令：ntsysv

加入开机自动启动:
```
chkconfig --level 35 crond on
```

## crontab命令

功能说明：设置计时器。
```
语　　法：crontab [-u <用户名称>][配置文件] 或 crontab [-u <用户名称>][-elr]

补充说明：cron是一个常驻服务，它提供计时器的功能，让用户在特定的时间得以执行预设的指令或程序。只要用户会编辑计时器的配置文件，就可以使用计时器的功能。其配置文件格式如下：
Minute Hour Day Month DayOFWeek Command

参　　数： 
　-e 　编辑该用户的计时器设置。 
　-l 　列出该用户的计时器设置。 
　-r 　删除该用户的计时器设置。 
　-u<用户名称> 　指定要设定计时器的用户名称。
```
## crontab 格式

基本格式 :
```
* *　 *　 *　 *　　command
分　时　日　月　周　 命令

第1列表示分钟1～59 每分钟用*或者 */1表示
第2列表示小时1～23（0表示0点）
第3列表示日期1～31
第4列表示月份1～12
第5列标识号星期0～6（0表示星期天）
第6列要运行的命令
```
crontab文件的一些例子：
```
30 21 * * * /usr/local/etc/rc.d/lighttpd restart
上面的例子表示每晚的21:30重启apache。

45 4 1,10,22 * * /usr/local/etc/rc.d/lighttpd restart
上面的例子表示每月1、10、22日的4 : 45重启apache。

10 1 * * 6,0 /usr/local/etc/rc.d/lighttpd restart
上面的例子表示每周六、周日的1 : 10重启apache。

0,30 18-23 * * * /usr/local/etc/rc.d/lighttpd restart
上面的例子表示在每天18 : 00至23 : 00之间每隔30分钟重启apache。

0 23 * * 6 /usr/local/etc/rc.d/lighttpd restart
上面的例子表示每星期六的11 : 00 pm重启apache。

* */1 * * * /usr/local/etc/rc.d/lighttpd restart
每一小时重启apache

* 23-7/1 * * * /usr/local/etc/rc.d/lighttpd restart
晚上11点到早上7点之间，每隔一小时重启apache

0 11 4 * mon-wed /usr/local/etc/rc.d/lighttpd restart
每月的4号与每周一到周三的11点重启apache

0 4 1 jan * /usr/local/etc/rc.d/lighttpd restart
一月一号的4点重启apache

*/30 * * * * /usr/sbin/ntpdate 210.72.145.44
每半小时同步一下时间
```
 

crontab命令主要有3个参数：

　　-e ：编辑用户的crontab。

　　-l　：列出用户的crontab的内容。

　　-r　：删除用户的crontab的内容。

　　执行crontab -e，将自动打开编辑器，你可以编辑自己的crontab文件，语法和 /etc/crontab 文件一样，不同的只是，不必再指出执行的用户，编辑后保存即可。

　　crontab -l用来查看自己的crontab文件内能，crontab -r删除自己的crontab。