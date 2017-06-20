"==================插件管理插件: Vundle==================="
" 插件的管理在文件开头设置
set nocompatible               " be iMproved
filetype off                         " required! turn off
set rtp+=~/.vim/bundle/Vundle.vim
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



"==================目录导航==================="
" ##### 目录导航
Plugin 'scrooloose/nerdtree'
map <F3> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=0
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
Plugin 'Lokaltog/vim-powerline'
" Bundle ' bling/vim-airline'
" Always show the status line - use 2 lines for the status bar
set laststatus=2

"python自动缩进"
Plugin 'vim-scripts/indentpython.vim'

"git setting"
Plugin 'tpope/vim-fugitive'
" Plugin 'Valloric/YouCompleteMe'
" setting theme 'altercation/vim-colors-solarized'"
Plugin 'altercation/vim-colors-solarized'






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





"===================基础设置==================="
" 语法高亮
if has("syntax")
   syntax on
endif


" 设置一个配色方案
" colorscheme desert

set background=dark
colorscheme solarized


" 检查文件类型 detect file type
filetype on
filetype plugin on

" 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
set autoindex

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
\ set autoindex |
\ set fileformat=unix

" 设置web类型页面色tab空格长度"
au BufNewFile,BufRead *.js,*.html,*.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

"标示不必要的空白字符"
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"设置编码"
set encoding=utf-8




