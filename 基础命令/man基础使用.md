# man 的基础使用

```
man mkdir
```
可以使用 空格，d，b 以及上下箭头等来浏览 man 页。要跳转道 man 页的末尾，可以按 End 键而想跳转到 man 页的头部则可以按 Home 键。在当前打开的 man 页中按下 h 键会显示所有有用的键盘快捷键和一般用法。（LCTT 译注：这些快捷键其实是 man 所使用的 less 分页器的快捷键）

按 q 可以退出 man 页。

为了回忆起那个忘记的命令，可以将 man 和 grep 命令联用：
```
man -k directory | grep create
```
输出结果为：
```
CURLOPT_NEW_DIRECTORY_PERMS (3) - permissions for remotely created directories
libssh2_sftp_mkdir_ex (3) - create a directory on the remote file system
mkdir (2) - create a directory
mkdirat (2) - create a directory
mkdtemp (3) - create a unique temporary directory
mkdtemp (3p) - create a unique directory or file
mkfontdir (1) - create an index of X font files in a directory
mklost+found (8) - create a lost+found directory on a mounted Linux second extended file。。。
mkstemp (3p) - create a unique directory
mktemp (1) - create a temporary file or directory
pam_mkhomedir (8) - PAM module to create users home directory

```

你只需要阅读一下每个命令的描述然后挑选出合适的命令就行了。啊，现在你记起来了。mkdir 正式你想要的，对吧？就是那么简单。

在 man 页中搜索
若你在 man 页中想要查找特定字符串。只需要输入 / （前斜线）再加上你想要搜索的字符串，像这样：
```
/<search_string> 或 <pattern>
```
假设你正在查看 mount 命令的 man 页，想要寻找关于 -bind 选项的相关信息。可以输入：
```
/bind
```

当前 man 页中任何匹配搜索字符串的内容都会被高亮显示。



按下 n 和 SHIFT+n 来查看下一个/上一个匹配的地方。

/ 模式（或者说字符串）会向前搜索匹配行。你也可以使用 ? 模式进行向后搜索。这当你在 man 页的末尾或中间位置时非常有用。
```
?bind
```
若想只显示匹配行，输入：
```
&bind
```

使用这种方法，你无需使用 n 和 SHIFT+n 来滚动到下一个/上一个匹配的位置。& 模式只会显示那些包含搜索内容的行，其他的内容全都被省略掉。

不打开 man 页而进行搜索
也可以在不打开 man 页的前提下搜索指定选项的信息。

比如，你想了解 mkdir 命令中的 -m 选项的相关信息。可以运行：
```
man mkdir | grep -e '-m'
```
或者，
```
man mkdir | grep -- '-m'
```

这个命令会显示出 mkdir 命令 man 页中第一次出现 -m 时的内容。从上面命令中我们可以看到 -m 表示的是 “MODE”（chmod）。

如果你想阅读 mkdir 命令的完整 man 页，但是要跳过第一次出现 -m 之前的内容，可以使用下面命令：
```
man mkdir | less +/-m
```

这是另一个例子：
```
man mount | less +/--bind
```

按下 n 或 SHIFT+n 可以浏览下一个/上一个匹配的位置。