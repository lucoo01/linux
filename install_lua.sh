mkdir -p ~/soft/lua
cd ~/soft/lua
# 先安装依赖的软件
apt-get install -y libreadline-dev
# centos 系统 yum install readline-devel
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make linux test
make install