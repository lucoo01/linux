#在CentOS 下使用nvm安装Node.js

mkdir -p ~/soft/nvm;cd ~/soft/nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

source ~/.bashrc

#查看所有node版本
#nvm ls-remote 
nvm install v6.12.0

nvm use v6.12.0

# 当前稳定版本是
v8.11.4   (Latest LTS: Carbon)
