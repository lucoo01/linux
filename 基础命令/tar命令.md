## tar 压缩文件
```
$ tar -cvf /home/vivek/projects.tar /home/vivek/projects
```

## find语法
```
find /path/to/search -name "file-to-search" -options
## 找出所有 Perl（*.pl）文件 ##
find $HOME -name "*.pl" -print
## 找出所有 *.doc 文件 ##
find $HOME -name "*.doc" -print
## 找出所有 *.sh（shell 脚本）并运行 ls -l 命令 ##
find . -iname "*.sh" -exec ls -l {} +
```

## 找到文件并压缩
语法是：
```
find $HOME -name "*.doc" -exec tar -rvf /tmp/all-doc-files.tar "{}" \;

或者

find $HOME -name "*.doc" -exec tar -rvf /tmp/all-doc-files.tar "{}" +
```