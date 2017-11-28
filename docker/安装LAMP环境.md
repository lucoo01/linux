# 安装LAMP环境

## 我们使用比较热门的 tutum/lamp 来安装

### 获取和安装
```
# 拉取lamp镜像
docker pull tutum/lamp
```

### 测试运行
```
# 我的环境中 80端口 和 3306 端口均已被占用 所以我们用8081 和3307 端口
docker run -d -p 8081:80 -p 3307:3306 tutum/lamp
```

```
# 测试环境是否正常运行
curl http://127.0.0.1:8081
```
## 自己构建镜像
> 编写Dockerfile 文件
```
FROM tutum/lamp:latest
RUN rm -fr /app && git clone https://github.com/lucoo01/think.git /app

RUN apt-get install -y vim
# 让容器访问宿主机上的目录
VOLUME ["/app"]
EXPOSE 80 3306
CMD ["/run.sh"]
```

## 构建镜像
```
docker build -t loen/lamp .
```

```
# 运行一个容器
docker run -d -p 8081:80 -p 3307:3306 loen/lamp
```

```
# 测试
curl http://127.0.0.1:8081
```

## 连接Mysql

### 在容器中访问 mysql 数据库
这个镜像的 mysql 数据库有个默认的 root 用户，本地连接时可以不用密码，所以在代码访问非常简单。

```php
<?php
$mysql = new mysqli("localhost", "root");
echo "MySQL Server info: ".$mysql->host_info;
?>
```

### 在容器外部访问 mysql 数据库

当我们第一次以 tutum/lamp 镜像启动容器的时候，它会自动创建一个叫 admin 的 mysql 用户，并生成一个随机密码，使用「docker logs +容器ID」可以获取到这个密码。
```
core@localhost ~/php $ docker logs 9cb
=> An empty or uninitialized MySQL volume is detected in /var/lib/mysql
=> Installing MySQL ...
=> Done!
=> Waiting for confirmation of MySQL service startup
=> Creating MySQL admin user with random password
=> Done!
========================================================================
You can now connect to this MySQL Server using:

    mysql -uadmin -p2Ijg6gvmM0N3 -h<host> -P<port>

Please remember to change the above password as soon as possible!
MySQL user 'root' has no password but only allows local connections
========================================================================
```
默认的 root 用户无法远程登陆，所以要使用 admin 用户，它同样具有 root 权限。

