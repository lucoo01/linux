# 安装ruby2.4
cd ~/soft

wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz

tar -xzvf ruby-2.4.2.tar.gz

cd ruby-2.4.2

./configure

make
make install

# 设置环境变量
echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc
source ~/.bashrc

ruby -v