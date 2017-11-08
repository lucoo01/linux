#如何将Ubuntu16.04 升级到最新版本的内核

#linux 内核官方网站 https://www.kernel.org/


#要升级 Ubuntu 16.04 的内核，打开 http://kernel.ubuntu.com/~kernel-ppa/mainline/ 并选择列表中需要的版本（发布此文时最新内核是 4.10.1）。

mkdir -p ~/soft/linux-kernel
cd ~/soft/linux-kernel
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.1/linux-headers-4.10.1-041001_4.10.1-041001.201702260735_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.1/linux-headers-4.10.1-041001-generic_4.10.1-041001.201702260735_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.1/linux-image-4.10.1-041001-generic_4.10.1-041001.201702260735_amd64.deb

#需要root权限
dpkg -i *.deb

#完成后重启

#若安装失败，提示缺少依赖的包诸如：
#fictx
#fictx-libs等
#然后这两个包又缺少其他的包，其他的包又缺少另外的包。总之很多。
#直接键入命令：
#apt-get install -f
#直接安装所有依赖。完成后，再执行，sudo dpkg -i 文件名.deb，注销系统，搞定。
