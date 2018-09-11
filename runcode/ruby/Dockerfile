# Pull base image
FROM docker.io/ubuntu:latest

MAINTAINER loen wang "425389019@qq.com"

# update source
ADD sources.list /etc/apt/sources.list
RUN apt-get update

RUN mkdir -p /code
RUN mkdir -p /root/soft/nodejs
WORKDIR /root/soft/nodejs
RUN wget https://npm.taobao.org/mirrors/node/v6.11.2/node-v6.11.2-linux-x64.tar.xz
RUN apt-get install -y xz-utils
RUN tar -xJf node-v6.11.2-linux-x64.tar.xz
RUN mv node-v6.11.2-linux-x64 /opt/
RUN ln -s /opt/node-v6.11.2-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /opt/node-v6.11.2-linux-x64/bin/npm /usr/local/bin/npm
RUN npm config set registry https://registry.npm.taobao.org

# Install curl
RUN apt-get -y install curl
RUN apt-get -y install wget
RUN apt-get -y install vim
RUN apt-get -y install ruby


RUN mkdir -p /root/soft/rc
WORKDIR /root/soft/rc

ADD index.js ./index.js

ENV PATH /opt/node-v6.11.2-linux-x64/bin/:$PATH

CMD ["node","index.js"]
