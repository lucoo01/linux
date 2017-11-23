npmv=`npm -v`

if [ -z "$npmv" ]; then
	mkdir -p ~/soft/node
	cd ~/soft/node
	echo "准备安装Node.js ~~~"
	# 下载安装，安装包位置随意
	wget https://npm.taobao.org/mirrors/node/v7.2.1/node-v7.2.1-linux-x64.tar.gz
	tar zxvf node-v7.2.1-linux-x64.tar.gz
	cd node-v7.2.1-linux-x64

	# 命令设置全局，因为安装node自带npm，所以不需要安装
	echo "命令设置全局，因为安装node自带npm，所以不需要安装"

	sudo ln -s ~/soft/node/node-v7.2.1-linux-x64/bin/node /usr/local/bin/node
	sudo ln -s ~/soft/node/node-v7.2.1-linux-x64/bin/npm /usr/local/bin/npm

else
	echo "已安装了Nodejs 开始安装 Gitbook"
fi


# 利用npm安装gitbook
npm install gitbook-cli -g
sudo ln -s ~/soft/node/node-v7.2.1-linux-x64/bin/gitbook /usr/local/bin/gitbook


mkdir -p /home/apps/gitbook
cd /home/apps/gitbook
mkdir demo
cd demo

# 初始化之后会看到两个文件，README.md ，SUMMARY.md
gitbook init
# 生成静态站点，当前目录会生成_book目录，即web静态站点
gitbook build ./
# 启动web站点，默认浏览地址：http://localhost:4000
gitbook serve ./

