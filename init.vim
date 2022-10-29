" 必须放置在最顶部，因为会改变之后的代码模式
set nocompatible "使用非兼容模式，就不会默认为vi模式了"

"单词修复与扩展"
:iabbrev retrun return
:iabbrev rertun return
:iabbrev cosnt const
:iabbrev thne then
:iabbrev adn and
:iabbrev atuo auto
:iabbrev flase false
:iabbrev ture true
:iabbrev sjon json
:iabbrev rul url
:iabbrev imoprt import
:iabbrev improt import
:iabbrev ipmrot import
:iabbrev cosnt const
:iabbrev stirng string
:iabbrev flaot float

set backupcopy=yes
" 基础配置 ---------------------- {{{
" 重要的全局配置
set hidden
set termguicolors
let mapleader=","
set mouse=a
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set nobackup
set nowritebackup
set noswapfile
set history=100
" 缓冲文件swp swo等
set directory=/tmp "存放路径
"中文编码
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
filetype off                  " required!
set nu
syntax enable
set hlsearch
set incsearch
set showmode
set ruler
set tabstop=2
set shiftwidth=2
set helplang=cn
set nrformats=octal,hex
"split the screen
set splitbelow
set splitright

"窗口间快速移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"快速行首行尾
vnoremap L $
vnoremap H ^
nnoremap L $
nnoremap H ^
" vnoremap g y/<C-r>0<cr> "快速查找当前选择的部分

" 强化翻页
nnoremap <Up> <c-b>
nnoremap <Down> <c-f>
nnoremap <Left> gT
nnoremap <Right> gt
"折叠
" set foldmethod=manual
set foldlevel=99
set nocompatible              " required
"开启文件类型匹配"
"


augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END


" 快速打开~/.zshrc
command! ConfigEZ execute ":vsplit ~/.bashrc"
command! ReloadEZ execute "source ~/.bashrc"

"快速打开.vimrc
command! Config execute ":vsplit $MYVIMRC"

"重新加载vimrc
command! Reload execute "source $MYVIMRC"


"Y复制到系统粘贴板
vnoremap gy "+y
nnoremap gp "+p

"使用黑洞寄存器删除
nnoremap D "_dd
vnoremap D "_d

"json格式化 需要brew install jq
com! JsonFormat %!jq .

"强化退出
inoremap jk <esc>

augroup base
	autocmd!
	"每次打开文件恢复光标位置
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif

	"当前行高亮，插入模式下取消"
	autocmd InsertLeave,WinEnter * set cursorline
	autocmd InsertEnter,WinLeave * set nocursorline
augroup END

" 快速打印当前文件路径
command! Pwd :call append(line('.'), expand('%'))<CR>

"光标配置
"http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

"加载插件
call plug#begin('~/.vim/plugged')

" -----------------------------------------------
" 代码注释
" -----------------------------------------------
Plug 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_javascript = 1
let g:NERDDefaultNesting = 1

" -----------------------------------------------
" 文件树
" -----------------------------------------------
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <leader>mt :NERDTreeToggle<CR>

let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp'] "忽略以下文件
let NERDTreeShowLinenumbers = 1 "设置行号
let g:nerdtree_tabs_open_on_console_startup=1 "在终端启动vim时共享NERDTree

" -----------------------------------------------
" 括号自动环绕
" -----------------------------------------------
Plug 'tpope/vim-surround'

" -----------------------------------------------
" Git配置"
" -----------------------------------------------
Plug 'tpope/vim-fugitive'

" -----------------------------------------------
" 状态条
" -----------------------------------------------
Plug 'vim-airline/vim-airline'

" 语法高亮缩进压缩包
Plug 'sheerun/vim-polyglot'

call plug#end()
