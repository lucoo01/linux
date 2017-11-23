## 格式
```
if ....; then
....
elif ....; then
....
else
....
fi
```

```
[ -f "somefile" ] ：判断是否是一个文件
[ -x "/bin/ls" ] ：判断/bin/ls是否存在并有可执行权限
[ -n "$var" ] ：判断$var变量是否有值
[ "$a" = "$b" ] ：判断$a和$b是否相等
-r file　　　　　用户可读为真
-w file　　　　　用户可写为真
-x file　　　　　用户可执行为真
-f file　　　　　文件为正规文件为真
-d file　　　　　文件为目录为真
-c file　　　　　文件为字符特殊文件为真
-b file　　　　　文件为块特殊文件为真
-s file　　　　　文件大小非0时为真
-t file　　　　　当文件描述符(默认为1)指定的设备为终端时为真
含条件选择的shell脚本 对于不含变量的任务简单shell脚本一般能胜任。但在执行一些决策任务时，就需要包含if/then的条件判断了。shell脚本编程支持此类运算，包括比较运算、判断文件是否存在等。
基本的if条件命令选项有： - eq —比较两个参数是否相等（例如，if [ 2 –eq 5 ]）
-ne —比较两个参数是否不相等
-lt —参数1是否小于参数2
-le —参数1是否小于等于参数2
-gt —参数1是否大于参数2
-ge —参数1是否大于等于参数2
-f — 检查某文件是否存在（例如，if [ -f "filename" ]）
-d — 检查目录是否存在
-z 字符串是否为空
-n 字符串是否不为空
几乎所有的判断都可以用这些比较运算符实现。脚本中常用-f命令选项在执行某一文件之前检查它是否存在。
```

```
# 判断字符串为空的方法有三种：
if [ "$str" =  "" ] 
if [ x"$str" = x ]
if [ -z "$str" ] （-n 为非空）
```

### 下面举二个例子吧，以方便大家的理解。
1、判断文件是否存在
```
#!/bin/sh
# 判断文件是否存在
YACCESS=`date -d yesterday +%Y%m%d`
FILE="access_$YACCESS.log.tgz"
cd /data/nginx/logs
if [ -f "$FILE" ];then
echo "OK"
else
echo "error $FILE" > error.log
mail -s "$FILE backup fail" test123@jb51.net <error.log
fi
```
```
#!/bin/sh
# 清除相关文件，并按时间段记录日志
#
DIR=/data/img_cache
DAY=`date +"%Y-%m-%d %H:%M"`
NUM=`ls $DIR |wc -l`
DIRNAME=`ls $DIR| grep leveldb | head -n 1 | awk '{print $NF}'`
if [[ $NUM -gt 3 ]];then
  rm -rf $DIR/$DIRNAME
  echo "---------$DAY----($DIR)-----------------------" >> /tmp/img_cache.log
  echo "$DIRNAME Deleted successful" >> /tmp/img_cache.log
fi
```
