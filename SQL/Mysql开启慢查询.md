# mysql 开启mysql慢查询
## windows下：

找到mysql的my.ini文件，打开找到[mysqld]下面添加如下语句
```
slow_query_log=on   开启慢查询
slow_query_log_file=d:/wamp/logs/mysql_slow_query.log   记录慢查询的sql到文件中
long_query_time = 1   高于查询多少秒的语句记录日志
log-queries-not-using-indexes  没有索引的sql语句也进入日志
```

## 重启mysql；


是否启动：
进入cmd到mysql的bin目录下
```
show variables like "%slow%";
```
查看是否开启，文件日志保存路径
```
show variables like "%long%";
```
查看高于多长时间才进行保存