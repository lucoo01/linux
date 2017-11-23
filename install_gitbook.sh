# 下载安装，安装包位置随意
wget https://npm.taobao.org/mirrors/node/v7.2.1/node-v7.2.1-linux-x64.tar.gz
tar zxvf node-v7.2.1-linux-x64.tar.gz
cd node-v7.2.1-linux-x64
# 命令设置全局，因为安装node自带npm，所以不需要安装
sudo ln -s /home/apps/node-v7.2.1-linux-x64/bin/node /usr/local/bin/node
sudo ln -s /home/apps/node-v7.2.1-linux-x64/bin/npm /usr/local/bin/npm
# 查看安装版本
node -v
# 查看npm版本
npm -v


