# 常用命令

## 安装
安装 - *nix
下载 Composer 的可执行文件


### 局部安装
要真正获取 Composer，我们需要做两件事。首先安装 Composer （同样的，这意味着它将下载到你的项目中）：
```
curl -sS https://getcomposer.org/installer | php
```
注意： 如果上述方法由于某些原因失败了，你还可以通过 php >下载安装器：
```
php -r "readfile('https://getcomposer.org/installer');" | php
```
这将检查一些 PHP 的设置，然后下载 composer.phar 到你的工作目录中。这是 Composer 的二进制文件。这是一个 PHAR 包（PHP 的归档），这是 PHP 的归档格式可以帮助用户在命令行中执行一些操作。

你可以通过 --install-dir 选项指定 Composer 的安装目录（它可以是一个绝对或相对路径）：
```
curl -sS https://getcomposer.org/installer | php -- --install-dir=bin
```
全局安装
你可以将此文件放在任何地方。如果你把它放在系统的 PATH 目录中，你就能在全局访问它。 在类Unix系统中，你甚至可以在使用时不加 php 前缀。

你可以执行这些命令让 composer 在你的系统中进行全局调用：
```
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
```
注意： 如果上诉命令因为权限执行失败， 请使用 sudo 再次尝试运行 mv 那行命令。

现在只需要运行 composer 命令就可以使用 Composer 而不需要输入 php composer.phar。


### 全局安装 (on OSX via homebrew)
Composer 是 homebrew-php 项目的一部分。
```
brew update
brew tap josegonzalez/homebrew-php
brew tap homebrew/versions
brew install php55-intl
brew install josegonzalez/php/composer
```

## 检查常见的问题
```
composer diagnose
```

更新到最新版本
```
composer self-update
```

清除缓存
```
composer clear-cache
```

## require命令
在《Composer快速入门》中已经简单介绍过使用install命令安装依赖的方式。除了install命令，我们还可以使用require命令快速的安装一个依赖而不需要手动在composer.json里添加依赖信息：
```
$ composer require monolog/monolog
Using version ^1.19 for monolog/monolog
./composer.json has been updated
Loading composer repositories with package information
Updating dependencies (including require-dev)
  - Installing psr/log (1.0.0)
    Downloading: 100%         

  - Installing monolog/monolog (1.19.0)
    Downloading: 100%         

monolog/monolog suggests installing graylog2/gelf-php (Allow sending log messages to a GrayLog2 server)
......
monolog/monolog suggests installing php-console/php-console (Allow sending log messages to Google Chrome)
Writing lock file
Generating autoload files
```
Composer会先找到合适的版本，然后更新composer.json文件，在require那添加monolog/monolog包的相关信息，再把相关的依赖下载下来进行安装，最后更新composer.lock文件并生成php的自动加载文件。

## update命令
通过update命令，可以更新项目里所有的包，或者指定的某些包。
```
# 更新所有依赖
$ composer update

# 更新指定的包
$ composer update monolog/monolog

# 更新指定的多个包
$ composer update monolog/monolog symfony/dependency-injection

# 还可以通过通配符匹配包
$ composer update monolog/monolog symfony/*
```
需要注意的时，包能升级的版本会受到版本约束的约束，包不会升级到超出约束的版本的范围。例如如果composer.json里包的版本约束为^1.10，而最新版本为2.0。那么update命令是不能把包升级到2.0版本的，只能最高升级到1.x版本。关于版本约束请看后面的介绍。

## remove命令
使用remove命令可以移除一个包及其依赖（在依赖没有被其他包使用的情况下）：
```
$ composer remove monolog/monolog
Loading composer repositories with package information
Updating dependencies (including require-dev)
  - Removing monolog/monolog (1.19.0)
  - Removing psr/log (1.0.0)
Writing lock file
Generating autoload files
```
## search命令
使用search命令可以进行包的搜索：
```
$ composer search monolog
monolog/monolog Sends your logs to files, sockets, inboxes, databases and various web services

# 如果只是想匹配名称可以使用--only-name选项
$ composer search --only-name monolog
show命令
使用show命令可以列出项目目前所安装的包的信息：

# 列出所有已经安装的包
$ composer show

# 可以通过通配符进行筛选
$ composer show monolog/*

# 显示具体某个包的信息
$ composer show monolog/monolog
```
## 版本约束
前面说到，我们可以指定要下载的包的版本。例如我们想要下载版本1.19的monolog。我们可以通过composer.json文件：
```
{
    "require": {
        "monolog/monolog": "1.19"
    }
}
```
然后运行install命令，或者通过require命令达到目的：
```
$ composer require monolog/monolog:1.19

# 或者
$ composer require monolog/monolog=1.19

# 或者
$composer require monolog/monolog 1.19
```
除了像上面那样指定具体的版本，我们还可以通过不同的约束方式去指定版本。

### 基本约束
### 精确版本

可以指定具体的版本，告诉Composer只能安装这个版本。但是如果其他的依赖需要用到其他的版本，则包的安装或者更新最后会失败并终止。

例子：1.0.2

范围

使用比较操作符你可以指定包的范围。这些操作符包括：>，>=，<，<=，!=。

你可以定义多个范围，使用空格 或者逗号,表示逻辑上的与，使用双竖线||表示逻辑上的或。其中与的优先级会大于或。

需要注意的是，使用没有边界的范围有可能会导致安装不可预知的版本，并破坏向下的兼容性。建议使用折音号操作符。
例子：

>=1.0
>=1.0 <2.0
>=1.0 <1.1 || >=1.2

范围（使用连字符）

带连字符的范围表明了包含的版本范围，意味着肯定是有边界的。其中连字符的左边表明了>=的版本，而连字符的右边情况则稍微有点复杂。如果右边的版本不是完整的版本号，则会被使用通配符进行补全。例如1.0 - 2.0等同于>=1.0.0 <2.1（2.0相当于2.0.*），而1.0.0 - 2.1.0则等同于>=1.0.0 <=2.1.0。

例子：1.0 - 2.0

通配符

可以使用通配符去定义版本。1.0.*相当于>=1.0 <1.1。

例子：1.0.*

下一个重要版本操作符
波浪号~

我们先通过后面这个例子去解释~操作符的用法：~1.2相当于>=1.2 <2.0.0，而~1.2.3相当于>=1.2.3 <1.3.0。对于使用Semantic Versioning作为版本号标准的项目来说，这种版本约束方式很实用。例如~1.2定义了最小的小版本号，然后你可以升级2.0以下的任何版本而不会出问题，因为按照Semantic Versioning的版本定义，小版本的升级不应该有兼容性的问题。简单来说，~定义了最小的版本，并且允许版本的最后一位版本号进行升级（没懂得话，请再看一边前面的例子）。

例子：~1.2

需要注意的是，如果~作用在主版本号上，例如~1，按照上面的说法，Composer可以安装版本1以后的主版本，但是事实上是~1会被当作~1.0对待，只能增加小版本，不能增加主版本。
折音号^

^操作符的行为跟Semantic Versioning有比较大的关联，它允许升级版本到安全的版本。例如，^1.2.3相当于>=1.2.3 <2.0.0，因为在2.0版本前的版本应该都没有兼容性的问题。而对于1.0之前的版本，这种约束方式也考虑到了安全问题，例如^0.3会被当作>=0.3.0 <0.4.0对待。

例子：^1.2.3

版本稳定性
如果你没有显式的指定版本的稳定性，Composer会根据使用的操作符，默认在内部指定为-dev或者-stable。例如：

约束	内部约束
```
1.2.3	=1.2.3.0-stable
>1.2	>1.2.0.0-stable
>=1.2	>=1.2.0.0-dev
>=1.2-stable	>=1.2.0.0-stable
<1.3	<1.3.0.0-dev
<=1.3	<=1.3.0.0-stable
1 - 2	>=1.0.0.0-dev <3.0.0.0-dev
~1.3	>=1.3.0.0-dev <2.0.0.0-dev
1.4.*	>=1.4.0.0-dev <1.5.0.0-dev
```
如果你想指定版本只要稳定版本，你可以在版本后面添加后缀-stable。

minimum-stability 配置项定义了包在选择版本时对稳定性的选择的默认行为。默认是stable。它的值如下（按照稳定性排序）：dev，alpha，beta，RC和stable。除了修改这个配置去修改这个默认行为，我们还可以通过稳定性标识（例如@stable和@dev）来安装一个相比于默认配置不同稳定性的版本。例如：
```
{
    "require": {
        "monolog/monolog": "1.0.*@beta",
        "acme/foo": "@dev"
    }
}

```