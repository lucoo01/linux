> 操作系统：ubuntu 16.04 64位，默认安装

1. 添加GPG key：
```
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```
2. 添加源

新建文件：/etc/apt/sources.list.d/docker.list，在里面添加内容：
```
deb https://apt.dockerproject.org/repo ubuntu-xenial main
```
3. 更新源
```
$ sudo apt update
```
安装与测试

安装
```
$ sudo apt install docker-engine
```
启动与测试
```
$ sudo service docker start 
$ sudo docker run hello-world
```
hello-world为镜像，该镜像会从镜像库中下载，执行的结果如下：

20161220153742029.png

配置开机启动

配置
```
$ sudo systemctl enable docker
```
使用当前用户执行

如果使用当前用户执行， 会报如下错误：
```
$ docker run hello-world
Cannot connect to the Docker daemon. Is 'docker daemon' running on this host?
```
所以，需要将当前用户加入到组docker下，该组是在安装docker的时候自动建立的。
```
$ sudo usermod -aG docker ubuntu
```