set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1  
set termencoding=utf-8
set encoding=utf-8 " 编码设置 
set langmenu=zn_CN.UTF-8 
set helplang=cn " 语言设置  

" 显示行号
set number
set tabstop=4

syntax on
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul


set ruler " 打开状态栏标尺

set smartindent " 智能对齐
set autoindent " 自动对齐  

" 搜索相关
set incsearch " 输入搜索内容时就显示搜索结果  
set hlsearch " 搜索时高亮显示被找到的文本 

" 代码 智能
set showmatch " 高亮显示对应的括号 
set matchtime=5 " 对应括号高亮的时间（单位是十分之一秒） 

" 其他
set noerrorbells " 关闭错误信息响铃  
set novisualbell " 关闭使用可视响铃代替呼叫  
set t_vb= " 置空错误铃声的终端代码  
set noexpandtab " 不要用空格代替制表符  
set history=500 " 历史纪录数  
set laststatus=2 " 总是显示状态行  
set showcmd " 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来  


"set confirm " 在处理未保存或只读文件的时候，弹出认
"set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4  
"set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格  
"set autochdir " 自动切换当前目录为当前文件所在的目录 
"filetype plugin indent on " 开启插件
"set backupcopy=yes " 设置备份时的行为为覆盖  
"set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感  
"set nowrapscan " 禁止在搜索到文件两端时重新搜索  
"set gdefault " 行内替换  
"set cmdheight=2 " 命令行（在状态行）的高度，默认为1,这里是2  
"set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离  
"set wildmenu " 增强模式中的命令行自动完成操作  
"set linespace=2 " 字符间插入的像素行数目  
