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

" 中文 vim 帮助
Plugin 'asins/vimcdoc'
" 自动根据当前打开文件切换工作目录
Plugin 'airblade/vim-rooter'
" 缩进标识
Plugin 'nathanaelkane/vim-indent-guides'
" 多语言语法检测插件：syntastic
Plugin 'scrooloose/syntastic'
" 自动补全
Plugin 'vim-scripts/AutoComplPop'
" 主要用于 C/C++ 代码补全，需要 ctag 支持
Plugin 'vim-scripts/OmniCppComplete'
" Python 代码补全
Plugin 'vim-scripts/Pydiction'
" Python 快捷操作
Plugin 'yssource/python.vim'
" 自动补全单引号，双引号等
Plugin 'scrooloose/nerdcommenter'
" 快速去行尾空格
Plugin 'bronson/vim-trailing-whitespace'
" 更高效的移动 [,, + w/fx]
Plugin 'Lokaltog/vim-easymotion'
" 快速的匹配 https://github.com/vim-scripts/matchit.zip
Plugin 'vim-scripts/matchit.zip'
" python fly check, 弥补syntastic只能打开和保存才检查语法的不足
Plugin 'kevinw/pyflakes-vim'
" pythgon的语法高亮 for python.vim syntax highlight
Plugin 'hdima/python-syntax'
" 增加对 STL\C++14等的C++语法高亮
Plugin 'Mizuchi/STL-Syntax'
" *.cpp 和 *.h 间切换
Plugin 'vim-scripts/a.vim'

"==================选中区块和多光标选中编辑==================="
" 选中区块
Plugin 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" ##### 多光标选中编辑
Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀
Plugin 'msanders/snipmate.vim'


"==================目录导航==================="
" ##### 目录导航
Plugin 'scrooloose/nerdtree'
map <F3> :NERDTreeToggle<CR>
" let NERDTreeHighlightCursorline=0
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
" 设置快捷键关闭和显示NERDTree"
nmap <F2> :NERDTree <CR>


" ##### 目录导航
Plugin 'jistr/vim-nerdtree-tabs'
""""""
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" 关闭同步
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0
" 自动开启nerdtree
"let g:nerdtree_tabs_open_on_console_startup=1

"==================vim状态栏美化：powerline==================="
" ##### vim-powerline
" Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Always show the status line - use 2 lines for the status bar
:set laststatus=2
" let g:airline_powerline_fonts = 1





"python自动缩进"
Plugin 'vim-scripts/indentpython.vim'

"git setting"
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0


" Plugin 'Valloric/YouCompleteMe'



" setting theme 'altercation/vim-colors-solarized'"
Plugin 'altercation/vim-colors-solarized'


Plugin 'Yggdroot/indentLine'
" -----------------------------------------------------------------------------
"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 在终端上会有屏幕刷新的问题，这个问题能解决有更好了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>

" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_char = "┊ "
    let g:indentLine_first_char = "┊ "
endif

" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
" let g:indentLine_color_gui = '#A4E57E'


" -----------------------------------------------------------------------------
"  < vim-php-wrapper 插件配置 >
" -----------------------------------------------------------------------------
Plugin 'diepm/vim-php-wrapper'
let g:vphpw_use_default_mapping = 1
let g:vphpw_use_dispatch = 1





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


"===================插件设置==================="
" airblade/vim-rooter
let g:rooter_disable_map=1

" nathanaelkane/vim-indent-guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=1
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" 多语言语法检查 scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" 检测到错误和警告时的标志
let g:syntastic_error_symbol='✘✘'
let g:syntastic_warning_symbol='➤➤'
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

" python代码补全设置vim-scripts/Pydiction
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" 自动补全单引号，双引号等 'scrooloose/nerdcommenter' setting
" <leader>cc 注释选中内容
" <leader>cu 取消选中注释
" <leader>c$ 从当前光标开始到行尾注释掉
let g:NERDSpaceDelims=1

" 快速去行尾空格 'bronson/vim-trailing-whitespace' setting
" 下列文件类型中的行尾空格tab不高亮显示
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'h', 'hpp', 'c', 'cpp', 'py']
map <leader>, :FixWhitespace<cr>

" 更高效的移动 [,, + w/fx] 'Lokaltog/vim-easymotion' setting
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

" python fly check, 弥补syntastic只能打开和保存才检查语法的不足 'kevinw/pyflakes-vim' setting
let g:pyflakes_use_quickfix = 0
" pythgon的语法高亮 for python.vim syntax highlight 'hdima/python-syntax' setting
let python_highlight_all = 1
" *.cpp 和 *.h 间切换 'vim-scripts/a.vim' setting
nmap <Leader>ch :A<CR>
    " 子窗口中显示 *.cpp 或 *.h
nmap <Leader>sch :AS<CR>
map <F4> :A<CR>
map <leader><F4> :AS<CR>




"==================在代码中做标记: signature==================="
" 书签设定。mx，设定/取消当前行名为 x 的标签；m,，自动设定下一个可用书签名,
"   前面提说，独立书签名是不能重复的，在你已经有了多个独立书签，
"   当想再设置书签时，需要记住已经设定的所有书签名，否则很可能会将已有的书签冲掉，这可不好，
"   所以，vim-signature 为你提供了 m, 快捷键，
"   自动帮你选定下一个可用独立书签名；mda，删除当前文件中所有独立书签。
" 书签罗列。ms，罗列出当前文件中所有书签，选中后回车可直接跳转；
" 书签跳转。mn，按行号前后顺序，跳转至下个独立书签；
"   mp，按行号前后顺序，跳转至前个独立书签。
"   书签跳转方式很多，除了这里说的行号前后顺序，
"   还可以基于书签名字母顺序跳转、分类书签同类跳转、分类书签不同类间跳转等等。
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }"]]]']"}



" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码，默认不更改
set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码
 
" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if g:isGUI
    " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
    winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif

if g:iswindows
    " :set guifont=Courier:14
endif


if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                              "设置无临时文件
" set vb t_vb=                                "关闭提示音


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
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif



"===================基础设置==================="
" 语法高亮
if has("syntax")
   syntax on
endif


" 设置一个配色方案
" colorscheme desert
set background=dark
colorscheme solarized
let g:solarized_termcolors=256


" 检查文件类型 detect file type
filetype on
filetype plugin on

" 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
" set autoindex

" 设置制表符(tab键)的宽度
" set tabstop=4

" 设置软制表符的宽度
" set softtabstop=4

" (自动) 缩进使用的4个空格
" set shiftwidth=4

" 设置匹配模式，显示匹配的括号
set showmatch
" 整词换行
set linebreak
" 光标从行首和行末时可以跳到另一行去
set whichwrap=b,s,<,>,[,]
" Enable mouse usage (all modes) "使用鼠标
set mouse=a
" Enable line number "显示行号
set number

"====================状态行设置===================="
" 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set laststatus=2
" 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。
set ruler

"====================命令行设置===================="
" 命令行显示输入的命令
set showcmd
" 命令行显示vim当前模式
set showmode

"====================find setting===================="
" 输入字符串就显示匹配点
set incsearch
set hlsearch

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 设置括号,{},[], "",''....
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i

" PEP8风格的缩进*.py文件
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=69 |
\ set expandtab |
\ set fileformat=unix


" 设置web类型页面色tab空格长度"
au BufNewFile,BufRead *.js,*.html,*.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

"标示不必要的空白字符"
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"设置编码"
" set encoding=utf-8

" setting ctags "
" set tags=./tags,tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
set autochdir
set tags=tags;


