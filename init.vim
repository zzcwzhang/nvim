" 必须放置在最顶部，因为会改变之后的代码模式
set nocompatible "使用非兼容模式，就不会默认为vi模式了"

"单词修复与扩展"
:iabbrev retrun return
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
command! ConfigEZ execute ":vsplit ~/.zshrc"
command! ReloadEZ execute "source ~/.zshrc"

"快速打开.vimrc
command! Config execute ":vsplit $MYVIMRC"

command! ConfigSSH execute ":vsplit ~/.ssh/config"

"重新加载vimrc
command! Reload execute "source $MYVIMRC"


"Y复制到系统粘贴板
vnoremap gy "+y
nnoremap gp "+p

"使用黑洞寄存器删除
nnoremap D "_dd
vnoremap D "_d

"删除当前行到黑洞并用粘贴
vnoremap P "_dP

"json格式化 需要brew install jq
com! JsonFormat %!jq .

"强化退出
inoremap jk <esc>

"选择强化"
onoremap p i(
onoremap " F"f"
onoremap ' F'f'


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

"到同名后缀文件"

"光标配置
"http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"


"加载插件
call plug#begin('~/.vim/plugged')

" 加载lua工具库

" 开始菜单
Plug 'mhinz/vim-startify'


Plug 'vim-scripts/keepcase.vim'

"""
" CtrlSF
"""
Plug 'dyng/ctrlsf.vim'
" https://github.com/dyng/ctrlsf.vim

" Set "<leader>s" to substitute the word under the cursor. Works great with
" CtrlSF!
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set up some handy CtrlSF bindings
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

Plug 'styled-components/vim-styled-components'
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" -----------------------------------------------
" 多重选择
" -----------------------------------------------
" Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_select_all_word_key = '<C-s>'
" Default mapping
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'
"

" -----------------------------------------------
" 代码注释
" -----------------------------------------------
Plug 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
			\ 'javascript': { 'left': '//' },
			\ 'less': { 'left': '/*', 'right': '*/' }
			\ }

let g:NERDAltDelims_javascript = 1
let g:NERDDefaultNesting = 1


Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'


" " -----------------------------------------------
" " Telescope
" " -----------------------------------------------
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fg <cmd>Telescope git_status<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>



" " -----------------------------------------------
" " FZF
" " -----------------------------------------------

" " linux fzf搜索
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" " 自动寻找目录根路径
" function! s:find_git_root()
"   echo 'find root'
"   return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
" endfunction
" command! ProjectFiles execute 'Files' s:find_git_root()

" let $FZF_DEFAULT_COMMAND = 'rg --files --case-sensitive --glob "!.git/*"'
" nnoremap // :BLines!<CR>
" nnoremap ?? :Ag!<CR>
" " 当前路径PWD找
" nnoremap <leader>p :Files!<CR>
" " 当前项目找
" nnoremap <leader>P :GFiles!<CR>
" nnoremap <leader>g :GFiles?<CR>
" nnoremap cc :Commands!<CR>

" -----------------------------------------------
" 文件树
" -----------------------------------------------
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <leader>mt :NERDTreeToggle<CR>
"NERDTree导航设置"
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp'] "忽略以下文件
let NERDTreeShowLinenumbers = 1 "设置行号
let g:nerdtree_tabs_open_on_console_startup=1 "在终端启动vim时共享NERDTree

"代码片段
" 使用新版的代码片段引擎
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Optional:
" let g:UltiSnipsExpandTrigger="<c-space>"
" let g:UltiSnipsJumpForwardTrigger="<c-space>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -----------------------------------------------
" COC 语法自动补全
" -----------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafcamlet/coc-nvim-lua'

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on ener, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>t

" -----------------------------------------------
" coc-bookmark
" -----------------------------------------------
nmap <Leader>bj <Plug>(coc-bookmark-next)
nmap <Leader>bk <Plug>(coc-bookmark-prev)
nmap <Leader>bb :CocCommand bookmark.toggle<CR>
nmap <Leader>bc :CocCommand bookmark.clearForCurrentFile<CR>
nmap <Leader>bl :CocList bookmark<CR>
nmap <Leader>ba :CocCommand annotate

" -----------------------------------------------
" coc-jest
" -----------------------------------------------
nnoremap <leader>te :call CocAction('runCommand', 'jest.fileTest')<CR>

" -----------------------------------------------
" html xml自动闭合标签
" -----------------------------------------------
Plug 'docunext/closetag.vim'

" -----------------------------------------------
" 括号自动环绕
" -----------------------------------------------
Plug 'tpope/vim-surround'

" -----------------------------------------------
" Git配置"
" -----------------------------------------------
Plug 'tpope/vim-fugitive'

" -----------------------------------------------
" Tagbar
" -----------------------------------------------
Plug 'majutsushi/tagbar'
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
let g:tagbar_right=1
nnoremap <F9> :TagbarToggle<CR>

"TagBar配置
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:tagbar_ctags_bin='ctags'

"代码自动格式化
"pydiction 1.2 python auto complete
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
""defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20"

" -----------------------------------------------
" 状态条
" -----------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"注释函数"
function! Vimnote(notetext)
	exec "normal! i\" ".a:notetext." ---------------------- {{{"
	exec "normal! o }}} -".a:notetext." END"
endfunction


let g:prettier#config#single_quote = 'true'
let g:prettier#config#jsx_single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'

" 会导致eslint冲突
" augroup reactgroup
"   autocmd BufWritePre *.js :Prettier
" augroup END
nnoremap <F2> :Prettier<CR>

"复制当前选中的文本到一个新的临时Buffer
function! BufferTemporary()
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	vsplit __Buffer_Temporary__
	normal! ggdG
	setlocal filetype=javascript
	setlocal buftype=nofile
	call append(0, lines)
endfunction

autocmd FileType * vnoremap <buffer> B :call BufferTemporary()<cr>

" 快速添加块包围注释
function! BufferComment()
	let line_start = getpos("'<")[1]
	let line_end = getpos("'>")[1]
	call append(line_start-1, "// --------------------------")
	call append(line_end+1, "// -------------------------- End")
	normal! kw
	startinsert
endfunction

"Node
augroup node
	autocmd!
	autocmd FileType javascript set dictionary+=$VIM.'\vimfiles\dict\node.dict'
	autocmd FileType javascript nnoremap <buffer> <F5> :!node %<cr>
	autocmd FileType javascript nnoremap <buffer> <F6> :!mocha %<cr>
	autocmd FileType javascript nnoremap <buffer> <F7> :call EslintShow()<cr>
	autocmd FileType javascript vnoremap <buffer> ? :<C-u>call BufferComment()<cr>
augroup END


"html
augroup htmlgroup
	autocmd!
	autocmd FileType html nnoremap <buffer> <F5> :call ViewInBrowser("cr")<cr>
augroup END

"PHP"
"在浏览器预览 for Mac
function! ViewInBrowser(name)
	let file = expand("%:p")
	let l:browsers = {
				\"cr":"open -a \"Google Chrome\"",
				\"ff":"open -a Firefox",
				\}
	let htdocs='/Library/WebServer/Documents/'
	let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
	let file = '"'. file . '"'
	exec ":update " .file
	"echo file .' ## '. htdocs
	if strpos == -1
		exec ":silent ! ". l:browsers[a:name] ." file://". file
	else
		let file=substitute(file, htdocs, "http://127.0.0.1:8088/", "g")
		let file=substitute(file, '\\', '/', "g")
		exec ":silent ! ". l:browsers[a:name] file
	endif
endfunction


"JAVA"
augroup javaconfig
	autocmd!
	"java自动补全
	autocmd FileType java setlocal omnifunc=javacomplete#Complete
	autocmd FileType java set omnifunc=javacomplete#Complete
	autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
	autocmd FileType java inoremap <exxpr><CR> pumvisible()?"\<C-Y>":"<CR>"
	autocmd FileType java nnoremap <leader>p oSystem.out.println();<esc>hi
	"java自动运行"
	autocmd FileType java nnoremap <buffer> <F5> :!java %:r<cr>
	autocmd FileType java nnoremap <buffer> <F4> :!javac %<cr>
augroup END

"Makefile
augroup Makefile
	autocmd!
	autocmd FileType make nnoremap <buffer> <leader>r :!make<cr>
	autocmd FileType make nnoremap <buffer> <F5> :!make<cr>
augroup END
"测试用的C
augroup Ctest
	autocmd!
	" 编译本文件，生成和本文件名相同的可执行文件（无后缀）
	autocmd FileType c nnoremap <buffer> <F5> :!make<cr>
	" 清除编译文件
	autocmd FileType c nnoremap <buffer> <F4> :!make clean<cr>
	" 运行本文件编译后的可执行文件
	autocmd FileType c nnoremap <buffer> <leader>r :!%:r<cr>
augroup END

"Go
" 使用coc-go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
" augroup Goconfig
"   autocmd!
"   autocmd FileType go nnoremap <buffer> <leader>r :!go run %<cr>
"   autocmd FileType go iabbrev fpl fmt.Println()
"   autocmd FileType go vnoremap <buffer> ; :<C-u>call BufferComment()<cr>
" augroup END
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" let g:go_bin_path = "/usr/local/go/bin"

"PYTHON"
function! PythonShow(python_command)
	let output = system(a:python_command . " " . bufname("%"))
	vsplit __Python_Output__
	normal! ggdG
	setlocal filetype=pythonoutput
	setlocal buftype=nofile
	call append(0,split(output,'\v\n'))
endfunction
augroup pythonconfig
	autocmd!
	"python3 F4启动"
	autocmd FileType python nnoremap <buffer> <F4> :!python3 %<cr>
	autocmd filetype python nnoremap <buffer> <F5> :!python %<cr>
	autocmd FileType python nnoremap <buffer> <localleader>m :call append(line("$"),"if __name__ == '__main__' :")<esc>
	autocmd FileType python nnoremap <buffer> <localleader>R :call PythonShow('python3')<cr>
	autocmd FileType python nnoremap <buffer> <localleader>r :call PythonShow('python')<cr>
	"表示不必要的空白字符
	autocmd BufNewFile,BufNewFile *.py*.pyw,*.c,*.h match BadWhitespace /\s\+$/
augroup END

"RUBY"
augroup rubyconfig
	autocmd!
	autocmd BufNewFile *.rb :call setline(1,"#coding:utf-8")
	autocmd FileType ruby nnoremap <buffer> <F5> :!ruby %<cr>
augroup END

"  }}} -语言配置 END

"Js eslint"
function! EslintShow()
	let output = system("eslint " . bufname("%"))
	vsplit __Eslinet_Output__
	normal! ggdG
	setlocal filetype=eslintoutput
	setlocal buftype=nofile
	call append(0,split(output,'\v\n'))
endfunction

" emmet 改用coc自带的
Plug 'mattn/emmet-vim'

" 皮肤
Plug 'morhetz/gruvbox'
autocmd vimenter * colorscheme gruvbox
set background=dark

" css颜色显示
Plug 'ap/vim-css-color'

" 语法高亮缩进压缩包
Plug 'sheerun/vim-polyglot'

call plug#end()

"自定义函数
augroup self
	autocmd!
	"用法"
	":%s//\=Pxtovw(submatch(1))
	function! Pxtovw(num)
		let l:a = a:num / 12.0
		return printf('%.2fvw',l:a)
	endfunction
	"JSON格式化
	function! FormatJson()
python << EOF
import vim
import json
try:
    buf = vim.current.buffer
    json_content = '\n'.join(buf[:])
    content = json.loads(json_content)
    sorted_content = json.dumps(content, indent=4, sort_keys=True)
    buf[:] = sorted_content.split('\n')
except Exception, e:
    print e
EOF
endfunction
	function! DeleteIconId()
		:%s/\vid\="[^"]+"//g
	endfunction
augroup END
