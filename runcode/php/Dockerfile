# Pull base image
FROM docker.io/ubuntu:latest

MAINTAINER loen wang "425389019@qq.com"

# update source
ADD sources.list /etc/apt/sources.list
RUN apt-get update

# Install curl
RUN apt-get -y install curl
RUN apt-get -y install wget
RUN apt-get -y install vim
RUN apt-get -y install php

RUN mkdir -p /code
RUN mkdir -p /soft/nodejs
WORKDIR /soft/nodejs
RUN wget https://npm.taobao.org/mirrors/node/v6.11.2/node-v6.11.2-linux-x64.tar.xz
RUN apt-get install -y xz-utils
RUN tar -xJf node-v6.11.2-linux-x64.tar.xz
RUN mv node-v6.11.2-linux-x64 /opt/
RUN ln -s /opt/node-v6.11.2-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /opt/node-v6.11.2-linux-x64/bin/npm /usr/local/bin/npm
RUN npm config set registry https://registry.npm.taobao.org

ENV PATH /opt/node-v6.11.2-linux-x64/bin/:$PATH




RUN mkdir -p /server
WORKDIR /server


ADD package.json ./package.json
RUN npm install

ADD index.js ./index.js



CMD ["node", "/server/index.js"]
