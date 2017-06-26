" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif


"==================插件管理插件: Vundle==================="
" 插件的管理在文件开头设置
set nocompatible               " be iMproved
filetype off                         " required! turn off
if g:islinux
    set rtp+=~/.vim/bundle/Vundle.vim
else
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim
endif
" set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" 插件的一些操作说明
" ################### Bundles 配置 #########################
" 使用Vundle来管理插件
" vim plugin bundle control, command model
"     :BundleInstall     install 安装配置的插件
"     :BundleInstall!    update  更新
"     :BundleClean       remove plugin not in list 删除本地无用插件
" ##### 插件管理工具
Plugin 'VundleVim/Vundle.vim'


" 更酷的启动界面
"Plugin 'mhinz/vim-startify'

" 协作编程
"Plugin 'FredKSchott/CoVim'

" 代码补全
" Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'YanhaoMo/snippets'
" 多语言语法检测插件：syntastic
Plugin 'scrooloose/syntastic'
" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀
" Plugin 'msanders/snipmate.vim'




" 文件搜索
Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/mru.vim'


" 代码浏览
Plugin 'majutsushi/tagbar'


" git支持
" Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'


" 美化主题
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jpo/vim-railscasts-theme'
"Plugin 'fholgado/minibufexpl.vim'


" 代码bug追踪
Plugin 'ZenCoding.vim'


" 模仿sublime text 的 ctrl + shift + f 在工程中全局查找某字符
" 需先安装ack: sudo apt-get install ack
Plugin 'dyng/ctrlsf.vim'

" 编辑增强
" 多光标操作
Plugin 'terryma/vim-multiple-cursors'
" 成对符号编辑
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" 快速注释
Plugin 'scrooloose/nerdcommenter'
" 自动对齐
Plugin 'godlygeek/tabular'
" 快速移动
Plugin 'Lokaltog/vim-easymotion'
" 代码块对齐用
Plugin 'Yggdroot/indentLine'
" 增强状态栏
" Plugin 'rstatusline'


" tmux支持
Plugin 'benmills/vimux'


" 用ack代替grep搜索
Plugin 'mileszs/ack.vim'
"Plugin 'vimwiki/vimwiki'
"Plugin 'vim-scripts/bufexplorer.zip'
"Plugin 'terryma/vim-smooth-scroll'




" org-mode
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'

" markdown
" Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" 可以通过浏览器实时预览，但是要安装额外依赖，详见官网
" Plugin 'suan/vim-instant-markdown'
Plugin 'dhruvasagar/vim-table-mode'


" 网页开发
Plugin 'mattn/emmet-vim'


" js
Plugin 'coolwanglu/vim.js'


" golang
"Plugin 'fatih/vim-go'


" C++/C
" 自动补全
Plugin 'vim-scripts/AutoComplPop'
" 主要用于 C/C++ 代码补全，需要 ctag 支持
Plugin 'vim-scripts/OmniCppComplete'
" 增加对 STL\C++14等的C++语法高亮
Plugin 'Mizuchi/STL-Syntax'
" *.cpp 和 *.h 间切换
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/c.vim'



" Python
" Python 代码补全
Plugin 'vim-scripts/Pydiction'
" Python 快捷操作
Plugin 'yssource/python.vim'
Plugin 'kevinw/pyflakes-vim'
" pythgon的语法高亮 for python.vim syntax highlight
Plugin 'hdima/python-syntax'
"python自动缩进"
Plugin 'vim-scripts/indentpython.vim'

" 符号自动补全
Plugin 'Raimondi/delimitMate'
Plugin 'klen/python-mode'
"Plugin 'python-imports.vim'


" 自动注释插件
Plugin 'vim-scripts/DoxygenToolkit.vim'


" php
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Shougo/neocomplcache.vim'


" ==========================================
"  bundle 插件管理和配置项
" -----------------#github
"   插件来自 github，只需要 ： 作者名/项目名
"  Bundle 'tomasr/molokai'
"   插件来自 vim-scripts，直接写插件名就行了
"  Bundle 'L9'
"   如使用自己的git库的插件，像下面这样做
"  Bundle 'git://git.wincent.com/command-t.git'
" ---------------#git库在本地机器的情况
"   如使用自己的git库在本地机器，像下面这样做
"  Bundle 'file:///Users/gmarik/path/to/plugin'
" ==========================================
call vundle#end()            " required
filetype plugin indent on    " required


"=================VIM 的基本设置============"
set nocompatible                                                " 不使用vi的键盘模式，而是vim自己的
"syntax enable                                                   " 开启语法高亮功能
syntax on                                                       " 语法高亮支持
set nu                                                          " 显示行号
set rnu                                                         " 显示相对行号
set wrap                                                        " 当一行文字很长时换行
"set nowrap                                                      " 当一行文字很长时取消换行
set showmatch                                                   " 当光标移动到一个括号时高亮显示对应的另一个括号
set showcmd                                                     " 回显输入的命令
set showmode                                                    " 显示当前的模式
set clipboard+=unnamed                                          " 关联系统的剪贴板
set ruler                                                       " 在编辑过程中右下角显示光标的行列信息
set nocp                                                        " 让Vim工作在不兼容模式下
set shortmess=atI                                               " 启动时不显示捐助乌干达儿童的提示
set so=6                                                        " 上下滚行时空余6行
set autoindent                                                  " 自动套用上一行的缩进方式
set smartindent                                                 " 智能缩进
set mouse=a                                                     " 开启鼠标支持
set laststatus=2                                                " 总是显示状态行
set backspace=indent,eol,start                                  " 对退格键提供更好的支持
set ts=4                                                        " 设置tab长度为4
set sts=4                                                       " 设置制表符宽度
set shiftwidth=4                                                " 设置缩进空格数
set expandtab                                                   " 用空格代替tab键
set smarttab                                                    " 更加智能的tab键
set hid                                                         " 当buffer被丢弃时隐藏它
set encoding=utf-8                                              " 默认使用utf-8编码格式
set fileencodings=utf-8,cp936,gb18030,big5,euc-kr,latin1        " 自动判断编码时 依次尝试一下编码
set ffs=unix,dos,mac                                            " 设置文件类型
set hlsearch                                                    " 高亮搜索内容
set ignorecase                                                  " 搜索模式里忽略大小写
set smartcase                                                   " 如果搜索字符串里包含大写字母，则禁用 ignorecase
set incsearch                                                   " 显示搜索的动态匹配效果
set lazyredraw                                                  " 解决某些类型的文件由于syntax导致vim反应过慢的问题
set ttyfast                                                     " 平滑地变化
set cc=160                                                       " 第80字符处显示分隔符
set foldmethod=indent                                           " 折叠方式
set nofoldenable                                                " 不自动折叠
set foldcolumn=1                                                " 在行号前空出一列的宽度
set t_Co=256                                                    " 设置256真彩色
set history=1000                                                " 设置历史记录条数
"set autoread                                                   " 当文件在外部被修改时自动载入
"set cindent                                                    " 使用c语言的缩进格式
"set whichwrap+=<,>,h,l                                         " 允许backspace和光标键跨越行边界
"set cmdheight=2                                                " 显示两行命令行

" set list lcs=tab:\♠\ ,trail:•                                   " 显示tab键为♠，并且显示每行结尾的空格为'•'
" 一些备用字符:›┆┇┊┋♠♦•

" 格式化状态行显示的内容
" set statusline=[%t]\ %y\ %m%=%{&fileencoding}\ [%{&ff}]\ [%l,\ %c]\ [%L]\ [%p%%]

" 打开一个文件自动定位到上一次退出的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 保存.vim文件后不用退出即可生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC
"au! bufwritepost .vimrc source %


" ************** 备份设置 ****************
"set nobackup                                                   " 不进行备份
"set nowb                                                       " 重新载入文件时不要备份
"set noswapfile                                                 " 不使用swf文件，可能导致错误无法恢复


" *************** 关闭错误声音 **************
set noerrorbells
set novisualbell
set  t_vb=


"  设置多个字体
set guifont=Monaco:h12,Courier_new:h12:b:cDEFAULT


if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set0t guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"=================VIM 自己的配置============"
" PEP8风格的缩进*.py文件
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=350 |
\ set expandtab |
\ set fileformat=unix


" 设置web类型页面色tab空格长度"
au BufNewFile,BufRead *.js,*.html,*.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |





" 设置括号,{},[], "",''....
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		return a:char
	elseif line[col - 1] == a:char
		return "\<Right>"
	else
		return a:char.a:char."\<Esc>i"
	endif
endf



"=================VIM 安装插件的配置============"


" **************** 设置vim主题外观 ***************
"set background=light                                           " 设置vim背景为浅色
set background=dark                                             " 设置vim背景为深色
set cursorline                                                  " 突出显示当前行
set cursorcolumn                                                " 突出显示当前列

"colorscheme molokai                                             " 设置molokai高亮主题
"colorscheme desert                                              " 设置desert高亮主题
"let g:solarized_termcolors=256
"colorscheme solarized                                           " 设置solarized高亮主题
"let g:gruvbox_termcolors=16
colorscheme gruvbox                                             " 设置gruvbox高亮主题


" ************** vim的配色 **************
"hi CursorLine cterm=NONE ctermbg=237 ctermfg=NONE
"hi CursorColumn cterm=NONE ctermbg=237 ctermfg=NONE
hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg



" *********** NERDTree插件配置 ***********
let NERDTreeChDirMode=2                                         " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1                                         " 使得窗口有更好看的效果
let NERDTreeMouseMode=1                                         " 双击鼠标左键打开文件
let NERDTreeWinSize=25                                          " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1                                        " 打开一个文件时nerdtree分栏自动关闭
" <F3>关闭打开目录树
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
" 打开树状文件目录
map <C-F3> \be



" *********** ctags插件配置 ***********
" set tags+=/usr/include/tags
set autochdir
set tags+=./tags
set tags+=tags;



" ********* cscope插件配置 **********
if has("cscope")
    "set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e- "在quickfix窗口中显示搜索结果


    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif



" *********** nerdcommenter快速注释插件配置 **********
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1



" *********** syntastic插件配置 ***********
" 多语言语法检查 scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" 检测到错误和警告时的标志
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚡'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
" 使用pyflakes,速度比pylint快
" 需要安装 pep8 或者 pyflakes，使用pip安装  ,pep8是python的格式检测神器，建议安装
let g:syntastic_python_checkers=['pep8', 'pyflakes']
let g:syntastic_python_pep8_args='--ignore=E501,E225'
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black
" to see error location list
let g:syntastic_always_populate_loc_list=0
let g:syntastic_auto_loc_list=0
let g:syntastic_loc_list_height=5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
" 跳转到下一个/上一个错误处
nnoremap <Leader>sn :lnext<cr>
nnoremap <Leader>sp :lprevious<cr>
" 关闭 某一语言的（如C/C++） 的语法检测
" let g:syntastic_ignore_files=[".*\.c$", ".*\.h$", ".*\.cpp", ".*\.hpp"]



" ********** pydiction补全设置 **********
"let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'



" SirVer/ultisnips 代码片断
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"
"定义存放代码片段的文件夹，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets/UltiSnips"]

" 参考https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-62941322
" 解决ultisnips和ycm tab冲突，如果不使用下面的办法解决可以参考
" https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-63205056的配置
" begin
" let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
" let g:UltiSnipsExpandTrigger="<Tab>"
" let g:UltiSnipsJumpForwardTrigger="<Tab>"                                           
" let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" end
" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 1
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>



" ********** indentLine插件 **********
let g:indentLine_char = '┊'                                     "代码块对齐用┊符号



" *********** UltiSnips插件配置 **********
let g:UltiSnipsExpandTrigger="<tab>"
""let g:UltiSnipsJumpForwardTrigger="<tab>"
""let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit = "vertical"
"let g:UltiSnipsSnippetDirectories = ["UltiSnips", "bundle/snippets"]
let g:UltiSnipsSnippetDirectories = ["bundle/snippets"]


" ********** rainbow_parentheses插件配置 ***********
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" ********** vim-multiple-cursors插件配置 ***********
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" ********** airline插件配置 ***********
" let g:airline_powerline_fonts=1     "配置airline使用powerline字体
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
:set laststatus=2


" ************ pythom-mode *********
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pymode_floding = 0


" setting git
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0




" ********** Emmet--> html插件 **********
let g:user_emmet_expandabbr_key = '<Tab>'
let g:user_emmet_settings = {
            \ 'php' : {
            \ 'extends' : 'html',
            \ 'filters' : 'c',
            \ },
            \ 'xml' : {
            \ 'extends' : 'html',
            \ },
            \ 'haml' : {
            \ 'extends' : 'html',
            \ },
            \}


" ********** vim write django **********
" au FileType python set ft=python.django
" au FileType html set ft=htmldjango.html


nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>


" <F4>语法检查
map <F4> :SyntasticCheck<CR>
im <F4> <Esc>:SyntasticCheck<CR>


" Unite插件配置
map <Leader>b :Unite -winheight=10 buffer<CR>
map <Leader>r :MRU<CR>
map <leader>f :NERDTreeToggle<CR>


" Tagbar插件配置
let g:tagbar_autoclose=1
"map <leader>t :TagbarToggle<CR>
map <F2> :TagbarToggle<CR>


" 设置文件类型辅助
map <leader>s :setfiletype
" 更方便的窗口间跳转
map <leader>j <c-w>j
map <leader>k <c-w>k
map <leader>l <c-w>l
map <leader>h <c-w>h
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l
map <C-h> <c-w>h


" vimux插件配置
map <Leader>e :VimuxPromptCommand<CR>
map <Leader>x :VimuxCloseRunner<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
" 更方便的页滚动
map <C-j> <C-f>
map <C-k> <C-b>


" 自动插件注释文件配置vim-scripts/DoxygenToolkit.vim
let g:DoxygenToolkit_commentType = "php"
let g:DoxygenToolkit_authorName="coolbaby"
let s:licenseTag = "Copyright(C)\<enter>"
" let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

let g:DoxygenToolkit_briefTag_pre="@desc fun  "
let g:DoxygenToolkit_paramTag_pre="@params [type] "
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="henry"
"let g:DoxygenToolkit_licenseTag="My own license"



" php 设置配置项
" let g:neocomplete#sources#omni#input_patterns.php =
"     \ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:phpcomplete_mappings = {
  \ 'jump_to_def': '<C-]>',
  \ }


"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" php自带的提示插件
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP




"********** 新建.c,.h,.sh,.java文件，自动插入文件头 **********
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetHead()"
"" 定义函数SetHead，自动插入文件头
func! SetHead()
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding=utf-8 -*-")
        call append(line(".")+1, "")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "  > Author: ")
        call append(line(".")+2, "  > Mail: ")
        call append(line(".")+3, "  > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif

    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif

    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif

    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif

    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    " 新建文件后，自动定位到文件末尾
endfunc



