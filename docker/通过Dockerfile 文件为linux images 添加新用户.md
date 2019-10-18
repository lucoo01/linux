### 要求：
（１）增加一个新用户，名为 loen
（２）让这个用户有root权限
（３）设置其密码为 mypasswd123
（４）container启动后以loen登录,并且直接到loen的home目录下

---

将下面代码片段放到Dockerfile里面。
```
RUN useradd --create-home --no-log-init --shell /bin/bash loen
RUN adduser loen sudo
RUN echo 'loen:mypasswd123' | chpasswd
USER loen
WORKDIR /home/loen
```
