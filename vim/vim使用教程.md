使用 VI/VIM 编辑器打开多个文件
要打开多个文件，命令将与打开单个文件相同。我们只要添加第二个文件的名称。
```
 $ vi file1 file2 file 3
 ```
要浏览到下一个文件，我们可以（在 vim 命令模式中）使用：
```
# 下一个文件
:n 
# 上一个文件
:N
```
或者我们也可以使用
```
:e filename
```
在编辑器中运行外部命令
我们可以在 vi 编辑器内部运行外部的 Linux/Unix 命令，也就是说不需要退出编辑器。要在编辑器中运行命令，如果在插入模式下，先返回到命令模式，我们使用 BANG 也就是 ! 接着是需要使用的命令。运行命令的语法是：
```
:! command
```
这是一个例子：
```
:! df -H
```
根据模板搜索
要在文本文件中搜索一个单词或模板，我们在命令模式下使用以下两个命令：
```
命令 / 代表正向搜索模板
命令 ? 代表反向搜索模板
```
这两个命令都用于相同的目的，唯一不同的是它们搜索的方向。一个例子是：

如果在文件的开头向前搜索，
```
:/ search pattern 
```
如果在文件末尾向后搜索，
```
:? search pattern
```
搜索并替换一个模式
我们可能需要搜索和替换我们的文本中的单词或模式。我们不是从整个文本中找到单词的出现的地方并替换它，我们可以在命令模式中使用命令来自动替换单词。使用搜索和替换的语法是：
```
:s/pattern_to_be_found/New_pattern/g
```
假设我们想要将单词 “alpha” 用单词 “beta” 代替，命令就是这样：
```
:s/alpha/beta/g
```
如果我们只想替换第一个出现的 “alpha”，那么命令就是：
```
$ :s/alpha/beta/
```
使用 set 命令
我们也可以使用 set 命令自定义 vi/vim 编辑器的行为和外观。下面是一些可以使用 set 命令修改 vi/vim 编辑器行为的选项列表：
```
:set ic  ' 在搜索时忽略大小写
:set smartcase ' 搜索强制区分大小写
:set nu ' 在每行开始显示行号
:set hlsearch ' 高亮显示匹配的单词
:set ro ' 将文件类型更改为只读
:set term ' 打印终端类型
:set ai ' 设置自动缩进
:set noai ' 取消自动缩进
```
其他一些修改 vi 编辑器的命令是：
```
:colorscheme ' 用来改变编辑器的配色方案 。（仅适用于 VIM 编辑器）
:syntax on ' 为 .xml、.html 等文件打开颜色方案。（仅适用于VIM编辑器）
```

Vim 是一个上古神器，本篇文章主要持续总结使用 Vim 的过程中不得不了解的一些指令和注意事项，以及持续分享一个前端工作者不得不安装的一些插件，而关于 Vim 的简介，主题的选择，以及为何使用 vim-plug 来管理插件等内容，有兴趣的同学下来可以自己了解和对比下。

安装
```
sudo apt-get install vim  // Ubuntu
```
其他平台，可以自行谷歌。


移动光标
```
hjkl
2w 向前移动两个单词
3e 向前移动到第 3 个单词的末尾
0 移动到行首
$ 当前行的末尾
gg 文件第一行
G 文件最后一行
行号+G 指定行
<ctrl>+o 跳转回之前的位置
<ctrl>+i 返回跳转之前的位置
```
退出
```
<esc> 进入正常模式
:q! 不保存退出
:wq 保存后退出
```
删除
```
x 删除当前字符
dw 删除至当前单词末尾
de 删除至当前单词末尾，包括当前字符
d$ 删除至当前行尾
dd 删除整行
2dd 删除两行
```
修改
```
i 插入文本
A 当前行末尾添加
r 替换当前字符
o 打开新的一行并进入插入模式
```
撤销
```
u 撤销
<ctrl>+r 取消撤销
```
复制粘贴剪切
```
v 进入可视模式
y 复制
p 粘贴
yy 复制当前行
dd 剪切当前行
```
状态
```
<ctrl>+g 显示当前行以及文件信息
```
查找
```
/ 正向查找（n：继续查找，N：相反方向继续查找）
? 逆向查找
% 查找配对的 {，[，(
:set ic 忽略大小写
:set noic 取消忽略大小写
:set hls 匹配项高亮显示
:set is 显示部分匹配
```
替换
```
:s/old/new 替换该行第一个匹配串
:s/old/new/g 替换全行的匹配串
:%s/old/new/g 替换整个文件的匹配串
```
折叠
```
zc 折叠
zC 折叠所有嵌套
zo 展开折叠
zO 展开所有折叠嵌套
```
执行外部命令
```
:!shell 执行外部命令
.vimrc
.vimrc 是 Vim 的配置文件，需要我们自己创建：

cd Home               // 进入 Home 目录
touch .vimrc          // 配置文件

# Unix
# vim-plug
# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
其他平台，可以查看 vim-plug。
```
基本配置

取消备份
```
set nobackup
set noswapfile
```
文件编码
```
set encoding=utf-8
```
显示行号
```
set number
```
取消换行
```
set nowrap
```
显示光标当前位置
```
set ruler
```
设置缩进
```
set cindent
set tabstop=2
set shiftwidth=2
```
突出显示当前行
```
set cursorline
```
查找
```
set ic
set hls
set is
```
左下角显示当前 vim 模式
```
set showmode
```
代码折叠
# 启动 vim 时关闭折叠代码
```
set nofoldenable
```
主题
```
syntax enable
set background=dark
colorscheme solarized
altercation/vim-colors-solarized
Anthony25/gnome-terminal-colors-solarized
```
插件配置

树形目录
```
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:NERDTreeShowIgnoredStatus = 1
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

# o 打开关闭文件或目录
# e 以文件管理的方式打开选中的目录
# t 在标签页中打开
# T 在标签页中打开，但光标仍然留在 NERDTree
# r 刷新光标所在的目录
# R 刷新当前根路径
# X 收起所有目录
# p 小写，跳转到光标所在的上一级路径
# P 大写，跳转到当前根路径
# J 到第一个节点
# K 到最后一个节点
# I 显示隐藏文件
# m 显示文件操作菜单
# C 将根路径设置为光标所在的目录
# u 设置上级目录为根路径
# ctrl + w + w 光标自动在左右侧窗口切换
# ctrl + w + r 移动当前窗口的布局位置
# :tabc 关闭当前的 tab
# :tabo   关闭所有其他的 tab
# :tabp   前一个 tab
# :tabn   后一个 tab
# gT      前一个 tab
# gt      后一个 tab
scrooloose/nerdtree
vim-nerdtree-tabs
nerdtree-git-plugin
```
代码，引号，路径补全
```
Plug 'Valloric/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Valloric/YouCompleteMe
Raimondi/delimitMate
Shougo/deoplete.nvim
```
语法高亮，检查
```
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'

let g:ale_linters = {
\    'javascript': ['eslint'],
\    'css': ['stylelint'],
\}
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'css': ['stylelint'],
\}
let g:ale_fix_on_save = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '▶'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
w0rp/ale
sheerun/vim-polyglot
```
文件，代码搜索
```
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
kien/ctrlp.vim
ggreer/the_silver_searcher
rking/ag.vim
```
加强版状态栏
```
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'
vim-airline/vim-airline
vim-airline/vim-airline-themes
```
代码注释
```
Plug 'scrooloose/nerdcommenter'

# <leader>cc // 注释
# <leader>cm 只用一组符号注释
# <leader>cA 在行尾添加注释
# <leader>c$ /* 注释 */
# <leader>cs /* 块注释 */
# <leader>cy 注释并复制
# <leader>c<space> 注释/取消注释
# <leader>ca 切换　// 和 /* */
# <leader>cu 取消注释

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
            \ 'javascript': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
            \ 'less': { 'left': '/**', 'right': '*/' }
        \ }
scrooloose/nerdcommenter
git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
airblade/vim-gitgutter
tpope/vim-fugitive
Markdown
Plug 'suan/vim-instant-markdown'

let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
# :InstantMarkdownPreview
suan/vim-instant-markdown
Emmet
Plug 'mattn/emmet-vim'

let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
         \ 'javascript.jsx' : {
            \ 'extends' : 'jsx',
         \ },
      \ }
mattn/emmet-vim
html 5
Plug'othree/html5.vim'
othree/html5.vim
css 3


Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END
hail2u/vim-css3-syntax
ap/vim-css-color
JavaScipt
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = " "
let g:javascript_conceal_underscore_arrow_function = " "
set conceallevel=1
pangloss/vim-javascript
（注：上述脚本中存在特殊字符，有的情况下显示不正确，请直接用上述链接的内容。）
```
React
```
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
mxw/vim-jsx
```
Prettier
```
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
# :Prettier
prettier/vim-prettier
```
