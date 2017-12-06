# docker logs 日志原理
## 参数说明
```
$ docker logs [OPTIONS] CONTAINER
  Options:
        --details        显示更多的信息
    -f, --follow         跟踪日志输出，最后一行为当前时间戳的日志
        --since string   显示自具体某个时间或时间段的日志
        --tail string    从日志末尾显示多少行日志， 默认是all
    -t, --timestamps     显示时间戳
```
## 使用方法
```
$ docker logs 26b12d17fefc
  nohup: appending output to 'nohup.out'
  nohup: appending output to 'nohup.out'

$ docker logs -t 26b12d17fefc
  2017-07-03T12:12:29.909710295Z nohup: appending output to 'nohup.out'
  2017-07-03T13:58:54.232003809Z nohup: appending output to 'nohup.out'

$ docker logs --tail 1 26b12d17fefc
  nohup: appending output to 'nohup.out'

$ docker logs -t --tail 1 26b12d17fefc
  2017-07-03T13:58:54.232003809Z nohup: appending output to 'nohup.out'

$ docker logs --since 30m 26b12d17fefc
  nohup: appending output to 'nohup.out'
$ docker logs -t --since="2017-07-03T13:58:54.232003809Z" 26b12d17fefc
  2017-07-03T13:58:54.232003809Z nohup: appending output to 'nohup.out'
$ docker logs -t --since="2017-07-03T12:12:29.909710295Z" 26b12d17fefc
  2017-07-03T12:12:29.909710295Z nohup: appending output to 'nohup.out'
  2017-07-03T13:58:54.232003809Z nohup: appending output to 'nohup.out'
```

## 容器日志的输出形式

stdout 标准输出
stderr 标准错误
以json格式存放在容器对于到日志文件中
docker日志内容类型

docker自身运行时Daemon的日志内容
docker容器的日志内容
docker logs的实现原理

“Docker Daemon是Docker架构中一个常驻在后台的系统进程，它在后台启动了一个Server，Server负责接受Docker Client发送的请求；接受请求后，Server通过路由与分发调度，找到相应的Handler来执行请求。–《Docker源码分析》”

当我们输入docker logs的时候会转化为Docker Client向Docker Daemon发起请求,Docker Daemon 在运行容器时会去创建一个协程(goroutine)，绑定了整个容器内所有进程的标准输出文件描述符。因此容器内应用的所有只要是标准输出日志，都会被 goroutine 接收，Docker Daemon会根据容器id和日志类型读取日志内容，最终会输出到用户终端上并且通过json格式存放在/var/lib/docker/containers目录下。

容器日志文件的生命周期

docker logs是跟随容器而产生的，如果删除了某个容器，相应的日志文件也会随着被删除