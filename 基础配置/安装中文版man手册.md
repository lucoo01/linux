## 下载
```
wget http://pkgs.fedoraproject.org/repo/pkgs/man-pages-zh-CN/manpages-zh-1.5.1.tar.gz/13275fd039de8788b15151c896150bc4/manpages-zh-1.5.1.tar.gz

## 最新
http://pkgs.fedoraproject.org/repo/pkgs/man-pages-zh-CN/v1.6.2.1.tar.gz/sha512/e5bdc98fdc3caba8b82d99a59eb37d60cf53c082a3a4bd07bbcd800d1a87130fa9cdfe26d5426486c30d461db1d1ee2fcc2621d615925498e725665483acf688/v1.6.2.1.tar.gz

```

2、编译安装
```
tar xf manpages-zh-1.5.1.tar.gz

cd manpages-zh-1.5.1

./configure --disable-zhtw

make && make install
```
3、设置环境变量；
```
vim /etc/profile.d/cman.sh

alias cman='man -M /usr/local/share/man/zh_CN'
```
退出重新执行一下这个设置的别名文件
```
source /etc/profile.d/cman.sh
```
(说明：cman.sh是自定义的脚本执行文件)

4、一切OK，现在只需要验证即可；
```
cman iptables
```
