## 局部安装

要真正获取 Composer，我们需要做两件事。首先安装 Composer （同样的，这意味着它将下载到你的项目中）：
```
curl -sS https://getcomposer.org/installer | php
```
注意： 如果上述方法由于某些原因失败了，你还可以通过 php >下载安装器：
```
php -r "readfile('https://getcomposer.org/installer');" | php
```
## 全局安装

你可以将此文件放在任何地方。如果你把它放在系统的 PATH 目录中，你就能在全局访问它。 在类Unix系统中，你甚至可以在使用时不加 php 前缀。

你可以执行这些命令让 composer 在你的系统中进行全局调用：
```
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
```