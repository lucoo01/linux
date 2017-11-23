# Docker搭建可一键部署的多域名LNMP环境

本文介绍在Docker容器中，快速部署LNMP环境的完整步骤。

最终完成的环境我们暂且叫：DNMP（即 Docker + Nginx + MySQL + PHP）。

最终实现一键部署LNMP环境的目的，特点：

完全开源
支持PHP7（及任何其他PHP版本）
支持绑定任意多个域名
支持HTTPS和HTTP/2
PHP源代码位于host中
MySQL data位于host中
所有配置文件可在host中直接修改
所有日志文件可在host中直接查看
本站实际使用，确保100%可行
实现一次配置，可在任何支持Docker系统使用
github仓库地址：https://github.com/yeszao/dnmp

1 快速使用
1、安装git、docker和docker-compose。

2、使用git下载完整代码：
```
$ git clone https://github.com/yeszao/dnmp.git
```
3、用docker-compose命令启动容器，首次使用需要下载镜像，会稍慢：
```
$ docker-compose up
```
4、然后在浏览器中访问localhost，就可以看到如下页面：



5、源代码在：./www/site1/ 目录下。

2 安装docker和docker-compose
具体安装步骤：
```
docker：https://docs.docker.com/engine/installation/
docker-compose：https://docs.docker.com/compose/install/
```
注意：Docker安装要求Linux 3.10以上版本，用uname -a命令可查看到。

安装之后，可查看版本：
```
$ docker -v
$ docker-compose -v
```
然后把当前用户加到docker用户组里面：
```
$ sudo gpasswd -a ${USER} docker
```
就不用每次启动Docker都得加sudo了。

注意，执行gpasswd命令之后要重新登陆才有效。

3 使用国内镜像仓库
在没有梯子的情况下，Docker默认从Docker Hub仓库下载镜像，完整的LNMP镜像估计需要一两天时间。

所以只能换个途径，比如使用阿里云的加速仓库。

首先注册一个阿里云账号，然后访问阿里云的Docker镜像仓库，能找到加速器地址。

对于Docker 1.10+，打开配置文件 /etc/docker/daemon.json（没有时新建该文件）：

{
    "registry-mirrors": ["https://6evg8u3r.mirror.aliyuncs.com"]
}
以上是我的加速地址。

然后重启Docker Daemon就可以了。

Docker 1.10以下请看：https://yq.aliyun.com/articles/29941。

4 目录说明
大致框架如下：



（图片使用UMLet绘制，下载原文件）

4.1 目录结构
目录结构如下：
```
.
├── docker-compose.yml          容器启动配置文件
├── Dockerfile                  PHP-FPM构建配置文件
├── conf                        配置目录
│   ├── mysql                   MySQL配置文件目录
│   │   └── my.cnf              MySQL配置文件
│   ├── nginx                   Nginx配置文件目录
│   │   ├── conf.d              站点配置文件目录
│   │   │   ├── certs           SSL认证文件、密钥和加密文件目录
│   │   │   │   └── site2       站点2的认证文件目录
│   │   │   ├── site1.conf      站点1 Nginx配置文件
│   │   │   └── site2.conf      站点2 Nginx配置文件
│   │   └── nginx.conf          Nginx通用配置文件
│   └── php                     PHP配置目录
│       ├── php-fpm.d           PHP-FPM配置目录
│       │   └── www.conf        PHP-FPM配置文件
│       └── php.ini             PHP配置文件
├── log                         日志目录
│   ├── mysql                   MySQL日志目录
│   ├── nginx                   Nginx日志目录
│   └── php-fpm                 PHP-FPM日志目录
├── mysql                       MySQL数据文件目录
└── www                         站点根目录
    ├── site1                   站点1根目录
    └── site2                   站点2根目录
```
4.2 站点部署
本文有默认加了两个站点：www.site1.com（同localhost）和www.site2.com。

要在本地访问这两个域名，需要修改你的hosts文件，添加以下两行：
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```
其中，www.site2.com为支持SSL/https和HTTP/2的示例站点。

因为站点2的SSL采用自签名方式，所以浏览器有安全提示，继续访问就可以了，自己的站点用第三方SSL认证证书替换即可。

如果只用到站点1，把站点2相关的目录和配置文件删除：
```
./conf/nginx/conf.d/certs/site2/
./conf/nginx/conf.d/site2.conf
./www/site2/
```
重启容器内的Nginx生效：
```
docker exec -it dlnmp_nginx_1 nginx -s reload
```
4.3 HTTPS使用
在容器中我们也是可以用HTTPS的，具体的配置请参考如下文件：
```
./conf/nginx/conf.d/site2.conf
```
如果是自签名，可以用廖雪峰提供的一个自动生成认证文件、私钥脚本：gencert.sh，

这个脚本已经放在项目中，在这个目录下：
```
./conf/nginx/conf.d/certs/site2/
```
在Bash中输入：

$ ./gencert.sh
输入一次域名，和几次密码（内容随意）后，就会生成几个认证文件。

其中自签名情况不需要.csr和.origin.key后缀的文件。

然后修改Nginx配置文件，配置SSL支持就可以了。

5 docker-compose.yml文件
如下是docker容器的运行配置docker-compose.yml的内容：
```
nginx:
  image: nginx:alpine
  ports:
    - "80:80"
    - "443:443"
  volumes:
    - ./www/:/var/www/html/:rw
    - ./conf/nginx/conf.d:/etc/nginx/conf.d/:ro
    - ./conf/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    - ./log/nginx/:/var/log/nginx/:rw
  links:
    - php-fpm:fpm

php-fpm:
  build: .
  expose:
    - "9000"
  volumes:
    - ./www/:/var/www/html/:rw
    - ./conf/php/php.ini:/usr/local/etc/php/php.ini:ro
    - ./conf/php/php-fpm.d/www.conf:/usr/local/etc/php-fpm.d/www.conf:rw
    - ./log/php-fpm/:/var/log/php-fpm/:rw
  links:
    - mysql:mysql
    - redis:redis

mysql:
  image: mysql:latest
  ports:
    - "3306:3306"
  volumes:
    - ./conf/mysql/my.cnf:/etc/mysql/my.cnf:ro
    - ./mysql/:/var/lib/mysql/:rw
    - ./log/mysql/:/var/log/mysql/:rw
  environment:
    MYSQL_ROOT_PASSWORD: "123456"

redis:
  image: redis:latest
  ports:
    - "6379:6379"
```
这里我们用了nginx的alpine镜像，以及php-fpm和MySQL的最新镜像。

这里默认加了redis容器，不需要的话可以把文件的最后4行以及php-fpm块下的- redis:redis删除。

5.1 为什么用nginx:alpine？
因为相比nginx:latest，nginx:alpine有几点优势：

用的是最新版nginx镜像，功能与nginx:latest一模一样
alpine镜像用的是Alpine Linux内核，比ubuntu内核要小很多。
nginx:alpine默认支持http2。
Alpine的更多请看《Alpine Linux，一个只有5M的Docker镜像》。

如要进入alpine容器，命令是（后面的路径不是/bin/bash）：
```
$ docker exec -it dnmp_nginx_1 /bin/sh
```
5.2 站点根目录挂载
为什么站点根目录在Nginx和PHP-FPM都这样挂载？
```
./www/:/var/www/html/
```
我们知道，Nginx配置都有这样一项：
```
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
```
其中，$document_root就是server块下root所指的路径：
```
server {
    #...
    root /var/www/html;
    #...
}
```
这里$document_root就是/var/www/html。

如果Nginx和PHP-FPM在同一主机，Nginx会通过9000端口把这个目录值和脚本URI传给PHP-FPM。

PHP-FPM再通过9000端口接收Nginx发过来的目录值和脚本URI，发给PHP解析。

PHP收到后，就到指定的目录下查找PHP文件并解析，完成后再通过9000端口返回给Nginx。

如果Nginx和PHP-FPM在同一个主机里面，PHP就总能找到Nginx指定的目录。

但是，如果他们在不同的容器呢？

未做任何处理的情况，Nginx容器中的站点根目录，PHP-FPM容器肯定不存在。

所以，这里需要保证Nginx和PHP-FPM都挂载了Host的./www/，并且都挂载在容器的：/var/www/html。

（当然，你也可以指定别的目录，确保统一即可）

5.3 修改docker-compose.yml文件之后？
如果容器已经生成，回头再编辑docker-compose.yml，用
```
docker-compose up
```
命令会直接启动原来的容器，修改的内容不会体现在启动的容器里。

所以，要使修改的docker-compose.yml生效，需要以下4步：
```
$ docker stop dnmp_nginx_1                      # 第一步：停止容器
$ docker rm dnmp_nginx_1                        # 第二步：删除容器
```
# !!第三步：重启Docker服务!!
```
$ docker-compose up -d --no-deps --build mysql  # 第四步：重新启动容器
```
其中最后一条命令参数作用：
```
-d：后台执行
--no-deps：不启动link的容器
--build：启动容器前先构建镜像
```
6 Dockerfile文件
因为PHP-FPM构建稍微复杂，涉及到很多扩展。

所以单独用Dockerfile文件构建PHP-FPM：
```
FROM php:fpm

## Copy sources.list to container.
## Here we use 163.com sources list.
##     PHP 5.6.31+ should use jessie sources list
##     PHP 7.2.0+ should use stretch sources list
## For more please check:
## PHP official docker repository: https://hub.docker.com/r/library/php/
#COPY ./files/sources.list.stretch /etc/apt/sources.list
#COPY ./files/sources.list.jessie /etc/apt/sources.list

## Update Ubuntu
RUN apt-get update

## mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

## GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

## Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl

## General
RUN docker-php-ext-install zip
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mbstring

## ...
```
完整Dockerfile请移步本项目GitHub仓库。

7 nginx配置文件
这里，我们还需要稍微修改nginx配置文件：
```
location ~ \.php$ {
    fastcgi_pass   fpm:9000;
    fastcgi_index  index.php;
    include        fastcgi_params;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
}
```
这里，我们仅需把fastcgi_pass改成：fpm:9000。

也就是，PHP-FPM的侦听主机改成：Nginx links PHP-FPM容器的别名，在docker-compose.yml文件里面我们设置为fpm。

这样Nginx容器启动的时候，就会自动修改自己的/etc/hosts，让fpm指向php-fpm容器的IP。

修改之后，重启容器中的nginx：
```
$ docker exec dlnmp_nginx_1 nginx -s reload
```
其中，dlnmp_nginx_1是容器的名称，也可以指定容器的ID。

8 站点根目录写权限
有时候，我们的PHP代码需要某个目录的写权限。

比如，Wordpress的wp-content/uploads目录，只有写权限我们才能正常上传文件。

默认的，容器中的/var/www/html目录属于root，我们需要修改为www-data，PHP才能正常写目录。

先进入到容器中：
```
$ docker exec -it dlnmp_php-fpm_1 /bin/bash
```
然后修改目录权限：
```
$ chown -R www-data:www-data /var/www/html
```
这样PHP就能正常读写目录了。

9 数据库
9.1 使用MySQL
在docker-compose.yml文件中，我们指定了MySQL数据库root用户的密码为123456。

所以，我们就可以在主机中通过：
```
$ mysql -h 127.0.0.1 -u root -p
```
输入密码，就可以进入MySQL命令行。

说明：这里MySQL的连接主机不能用localhost，因为MySQL客户端默认使用unix socket方式连接，应该直接用本地IP。

在PHP代码中的使用方式与在主机中使用稍有不同，如下：
```
$pdo = new PDO('mysql:host=mysql;dbname=site1', 'root', '123456');
```
其中，host的值就是在docker-compose.yml里面指定的MySQL容器的名称。

这是因为PHP代码是在FPM容器中，FPM容器启动时会自动在/etc/hosts中加上：
```
172.17.0.2 mysql 11e55f91c4c3 dlnmp_mysql_1
```
就是说，mysql自动指向了MySQL容器动态生成的IP。

9.2 使用Redis
Redis使用和MySQL类似。

在主机和容器内部都通过地址127.0.0.1，端口6379访问。

PHP则是跨容器访问，host参数用redis（links指定的名称），端口用6379。

 

Docker相关的有用文章：

Docker 常用命令
docker-compose中ports和expose的区别
手动用Docker一步步部署LNMP完整教程
Docker容器使用十大注意事项
 

标签： Docker, MySQL, Nginx, PHP-FPM