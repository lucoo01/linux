set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
" 显示行号
set number
set tabstop=4
set autoindent
syntax on
set nu
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul
set showcmd
set foldenable
set foldmethod=manual
