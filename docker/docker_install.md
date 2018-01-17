#CentOS7安装Docker

## 查看系统版本： 
```
$ cat /etc/redhat-release 
CentOS Linux release 7.0.1406 (Core)
```

## 安装docker 
```
$ yum install docker 
```

## 安装过程中报错： 
>Transaction check error: 
>file /usr/lib/systemd/system/blk-availability.service from install of device-mapper-7:1.02.107-5.el7_2.2.x86_64 conflicts with >file from package lvm2-7:2.02.105-14.el7.x86_64 
>file /usr/sbin/blkdeactivate from install of device-mapper-7:1.02.107-5.el7_2.2.x86_64 conflicts with file from package >lvm2-7:2.02.105-14.el7.x86_64 
>file /usr/share/man/man8/blkdeactivate.8.gz from install of device-mapper-7:1.02.107-5.el7_2.2.x86_64 conflicts with file from >package lvm2-7:2.02.105-14.el7.x86_64

## 解决办法： 
```
$yum install libdevmapper* -y
```