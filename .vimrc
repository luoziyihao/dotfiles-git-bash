"*********************************************编码设置*****************************************
set fileencodings=UTF-8,GBK,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1,ISO-8859-1 
"设置显示文件的编码, 一次检测,直到检测到正确的编码

set encoding=utf-8
"设置工作编码,内部使用的字符编码方式,包括 Vim 的 buffer (缓冲区)、菜单文本、消息文本等。在中文环境下这个编码经常会导致vim自身的乱码
"当读文件时,文件会被默认转化成当前编码显示,显示出错就会寻找fileencodings

"set fileencoding=gbk
set fileencoding=utf-8
"在windows机器上用 gbk
"linux上用 utf-8
"Vim 中当前编辑的文件的字符编码方式
"文件保存时并不会更改文件的默认编码 只有新创建时才启用
"但是有一种问题,新建空文本,将数据复制到文本里面,然后保存,数据会正常显示,因为文件是新建的,当保存后数据会以默认的fileencoding保存
"实际上复制过来的数据并不是这个格式的,当保存后,然后读取的时候就会识别错误。将iso的数据以utf-8的形式去保存,实际上在保存的过
"程就损坏了数据
"即在编辑非fileencoding 类型的文件时 可能会有转换错误,一般是由于新创建文件直接操作复制文件引起的
"为了解决这个问题,应该不设置 fileencoding
"通过set fileencoding可以查看当前文件的编码,当然,如果vim识别错误 这时候就需要先识别 现在会用用其他工具去识别

set termencoding=utf-8
"设置终端的编码方式

set ambiwidth=double 
"防止特殊符号无法正常显示。在 Unicode 中,许多来自不同语言的字符,如果字型足够近似的话,会把它们放在同一个编码中。但在不同编码中,字符的宽度是不一样的。例如中文汉语拼音中的 ā 就很宽,而欧洲语言中同样的字符就很窄。当 VIM 工作在 Unicode 状态时,遇到这些宽度不明的字符时,默认使用窄字符,这会导致中文的破折号"——”非常短,五角星"★”等符号只能显示一半。因此,我们需要设置 ambiwidth=double 来解决这个问题。


" ============================================================================
" Vundle initialization
" Avoid modify this section, unless you are very sure of what you are doing

" no vi-compatible
set nocompatible

" Setting up Vundle - the vim plugin Pluginr
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/Plugin/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/Plugin
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/Plugin/Vundle.vim
    let iCanHazVundle=0
endif

filetype off

set rtp+=~/.vim/Plugin/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" file browser
Plugin 'scrooloose/nerdtree'
"auto_pairs
Plugin 'jiangmiao/auto-pairs'
"markdown
Plugin 'iamcco/markdown-preview.vim'
Plugin 'wombat256.vim'
Plugin 'altercation/vim-colors-solarized'
"Valloric/YouCompleteMe
"Plugin 'Valloric/YouCompleteMe'
"Shougo/neocomplete.vim
Plugin 'Shougo/neocomplete.vim'
"Tagbar
Plugin 'majutsushi/tagbar'
"ariline
"Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"nerdcommenter
Plugin 'scrooloose/nerdcommenter'
"git-vim , run git cmd
Plugin 'tpope/vim-fugitive'
"vim-gitgutter, realtime view the change in diff
Plugin 'airblade/vim-gitgutter'
"Shougo/unite.vim
Plugin 'Shougo/unite.vim'
" Python and other languages code checker
Plugin 'scrooloose/syntastic'
" markdown colorscheme
"Plugin 'tpope/vim-markdown'

call vundle#end()               " required
filetype plugin indent on    " required

" ==========================install plugin==================================================
" Install plugins the first time vim runs
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" ==========================install plugin==================================================

" ============================pre plugin cfg================================================
"leader
let mapleader=','
"设置命令映射,按下映射,再按下其他定义的键位,就可以调用想调用的命令或者方法了

" colorscheme https://github.com/altercation/vim-colors-solarize
syntax on 
colorscheme solarized 
set background=dark

let color_readme=expand('~/.vim/Plugin/vim-colors-solarized/README.mkd')
if !filereadable(color_readme)
    echo "Installing vim-colors-solarized ..."
    echo ""
    silent !git clone https://github.com/altercation/vim-colors-solarized ~/.vim/Plugin/vim-colors-solarized
    let iCanHazVundle=0
endif

" ============================pre plugin cfg================================================

"*********************************************插件配置*****************************************
"neocomplete------------------------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"neocomplete------------------------------

"syntastic------------------------------
" need install rely 
" sudo pip install dbgp vim-debug pep8 flake8 pyflakes isort
" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'
"syntastic------------------------------

"nerdcommenter------------------------------
"" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
"默认的快捷键, 不需要自己绑定
"<leader>cc   加注释
"<leader>cu   解开注释
"<leader>c<space>  加上/解开注释, 智能判断
"<leader>cy   先复制, 再注解(p可以进行黏贴)
"nerdcommenter------------------------------
"
"Unite------------------------------
nmap <leader>b ::Unite file buffer<CR>
"Unite------------------------------
"
"
"airline------------------------------
"sybmbor
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
"end line
set laststatus=2
let g:airline_theme="luna" 
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
 "打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
 "我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#buffer_nr_show = 1
 "设置切换Buffer快捷键"
 nnoremap <C-N> :bn<CR>
 nnoremap <C-P> :bp<CR>
 " 关闭状态显示空白符号计数,这个对我用处不大"
 let g:airline#extensions#whitespace#enabled = 0
 let g:airline#extensions#whitespace#symbol = '!'
" enable/disable fugitive/lawrencium integration >
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
" change the text for when no branch is detected >
let g:airline#extensions#branch#empty_message = ''
" enable/disable syntastic integration >
let g:airline#extensions#syntastic#enabled = 1
"airline------------------------------
"
"Tagbar------------------------------
"nmap <Leader>tb :TagbarToggle<CR>		"快捷键设置
let g:tagbar_ctags_bin='ctags'			"ctags程序的路径
let g:tagbar_width=30					"窗口宽度的设置
map <F2> :Tagbar<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() 	"如果是c语言的程序的话，tagbar自动开启
"Tagbar------------------------------
"
"EclimComplete ------------------------------
let g:EclimJavaCompleteCaseSensitive = 1
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimMakeLCD = 1
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>c :JavaCorrect<cr>
nnoremap <silent> <buffer> <leader>co :JavaConstructor<cr>
"nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
"nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
"EclimComplete ------------------------------
"
"  YouCompleteMe------------------------------
"  YouCompleteMe------------------------------
"" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=1	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
let g:syntastic_ignore_files=[".*\.py$"]
"
"  YouCompleteMe ------------------------------
"  YouCompleteMe ------------------------------
"
"
" NERDTree ----------------------------- 
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.swp$']
"let NERDTreeWinPos='right'
let NERDTreeWinSize=30
" NERDTree ----------------------------- 

"AutoPairs括号自动补全----------------------------- 
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
"
"markdown----------------------------- 
let g:mkdp_path_to_chrome = "chromium-browser"
" path to the chrome or the command to open chrome(or other modern browsers)

let g:mkdp_auto_start = 0
" set to 1, the vim will open the preview window once enter the markdown
" buffer

let g:mkdp_auto_open = 0
" set to 1, the vim will auto open preview window when you edit the
" markdown file

let g:mkdp_auto_close = 1
" set to 1, the vim will auto close current preview window when change
" from markdown buffer to another buffer

let g:mkdp_refresh_slow = 0
" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
"
"*********************************************基础显示设置*****************************************

set nocompatible
"设置与vi的不兼容 vim是vi的增强版 vim的部分快捷键的执行模式与vi是不一样的,关闭兼容,就将所有快捷键改成vim的执行模式

set ru 
"该命令打开 VIM 的状态栏标尺。默认情况下,VIM "的状态栏标尺在屏幕底部,它能即时显示当前光标所在位置在文件中的行号、列号,以及对应的整个文件的百分比。打开标尺可以给文件的编辑工作带来一定方便。

set hls 
"搜索时高亮显示被找到的文本。该指令的功能在 vimtutor 中已经有过介绍,这里就不多说了。其实似乎许多人并不喜欢这个功能。

set is 
"搜索时在未完全输入完毕要检索的文本时就开始检索
"
"set ignorecase
"设置搜索时忽略大小写
set ignorecase smartcase
"设置搜索时智能忽略大小写

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

set cursorline
"突出显示当前行

set cursorcolumn
"突出显示当前列

"浅色高亮
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
"autocmd InsertEnter * se cul    " 用浅色高亮当前行  

"*********************************************文本编辑设置*****************************************
set backspace=start,eol,indent
"自定义退格键 bs 在vim中,每次bs都只能删除本次编辑模式键入的字符 需要添加对上一次键入文件的删除
"start 删除单行中的上次编辑模式输入的字符
"eol 删除两行中间的空格和换行
"开启删除行首自动缩进

set whichwrap=b,s,<,>,[,],h,l
"默 VIM "中当光标移到一行最左边的时候,我们继续按左键,光标不能回到上一行的最右边。同样地,光标到了一行最右边的时候,我们不能通过继续按右跳到下一行的最左边。但是,通过设
"置 whichwrap 我们可以对一部分按键开启这项功能。如果想对某一个或几个按键开启到头后自动折向下一行的功能,可以把需要开启的键的代号写到 whichwrap "的参数列表中,各个键之间使用逗号分隔。以下是 whichwrap 支持的按键名称列表：
"设置新增文件的默认模式 为unix .unix默认的换行符和unix不一样


set sw=4 
"自动缩进的时候,缩进尺寸为 4 个空格。

set ts=4 
"Tab 宽度为 4 个字符。

set et 
"编辑时将所有 Tab 替换为空格。 
"该选项只在编辑时将 Tab 替换为空格,如果打开一个已经存在的文件,并不会将已有的 Tab 替换为空格。如果希望进行这样的替换的话,可以使用这条命令":retab”。

set smarttab 
"当使用 et 将 Tab 替换为空格之后,按下一个 Tab 键就能插入 4 个空格,但要想删除这 4 个空格,就得按 4 下 Backspace,很不方便。设置 smarttab 之后,就可以只按一下 Backspace 就删除 4 个空格了。

"set spell 
"打开拼写检查。拼写有错的单词下方会有红色波浪线,将光标放在单词上,按 z= 就会出现拼写建议,按 ]s 可以直接跳到下一个拼写错误处。中文环境一般无法识别,故注释掉。


"*********************************************断行设置****************************************

"set tw=125 
"设置光标超过 125 列的时候折行。
set lbr 
"不在单词中间断行。设置了这个选项后,如果一行文字非常长,无法在一行内显示完的话,它会在单词与单词间的空白处断开,尽量不会把一个单词分成两截放在两个不同的行里。
set fo+=mB 
"打开断行模块对亚洲语言支持。m 表示允许在两个汉字之间断行,即使汉字之间没有出现空格。B 表示将两行合并为一行的时候,汉字与汉字之间不要补空格。该命令支持的更多的选项请参看用户手册。

"*********************************************其他设置***************************************

"set selection=inclusive 
"指定在选择文本时,光标所在位置也属于被选中的范围。如果指定 selection=exclusive 的话,可能会出现某些文本无法被选中的情况。

set wildmenu 
"在命令模式(此处命令模式是 :命令 )下使用 Tab 自动补全的时候,将补全内容使用一个漂亮的单行菜单形式显示出来。


set nu
"设置行号

set showtabline=2
"设置自动显示标签 :set showtabline=[1,2,3]  =0完全不显示标签栏,=1只有用户新建时才显示,=2总是显示标签栏。

set showmatch
"显示匹配字符 例如,在输入 ) 时,vim会自动匹配到出现过的 (
set matchtime=1
"匹配响应时间

"设置自动载入 自动刷新 手动方式是 :e!
set autoread


"*********************************************文件备份设置**************************************
" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
"*********************************************key map***************************************

function Xml()
   set filetype=xml
   :%s/></>\r</g
   "把><替换成>回车<
   :normal gg=G<cr>
endfunction
map <leader>xml  :call Xml()
"  格式化xml
"
"设置标签名去掉目录,刚好可以解决路径中出现空格无法正确识别的bug
function ShortTabLabel1()
    let bufnrlist=tabpagebuflist(v:lnum)
    let label = bufname(bufnrlist[tabpagewinnr(v:lnum)-1])
    let filename=fnamemodify(label,':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel1()}

"设置复制映射
vmap <c-c> "+y
nmap <leader>v "+gp
vmap <leader>v "+gp


"设置全选映射
vmap <c-a> <esc>ggVG
nmap <c-a> ggVG
"设置全选

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

"自动补全映射
inoremap < <><ESC>i
inoremap （ （）<ESC>i

"json view
map <leader>json <Esc>:%!python -m json.tool<CR>
"markdown view
map <leader>md <Esc>:MarkdownPreview<CR>

"#####################################file content setting###############################################################
 """"""""""""""""""""""""""""""""""""add from """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 """"""""""""""""""""""""""""http://www.bubuko.com/infodetail-446364.html """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
 """""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
 "新建.c,.h,.sh,.java文件,自动插入文件头 
 
 autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
 
 ""定义函数SetTitle,自动插入文件头 
 
 func SetTitle() 
 
     "如果文件类型为.sh文件 
 
     if &filetype == 'sh' 
 
         call setline(1,"\#!/bin/bash") 
         call append(line("."), "\#########################################################################") 
         call append(line(".")+1, "\# File Name: ".expand("%")) 
         call append(line(".")+2, "\# Author: raoxiang") 
         call append(line(".")+4, "\# mail: wangyiraoxiang@163.com") 
         "call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
         call append(line(".")+4, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
         call append(line(".")+5, "\#########################################################################") 
         call append(line(".")+6, "") 
     endif
 
     if &filetype == 'cpp'
 
         call append(line(".")+6, "#include<iostream>")
 
         call append(line(".")+7, "using namespace std;")
 
         call append(line(".")+8, "")
 
     endif
 
     if &filetype == 'c'
 
         call append(line(".")+6, "#include<stdio.h>")
 
         call append(line(".")+7, "")
 
     endif
 
     "新建文件后,自动定位到文件末尾
 
     autocmd BufNewFile * normal G
 
 endfunc 
 
 " Suzzz：  模仿上面,新建python文件时,添加文件头
 
 autocmd BufNewFile *py exec ":call SetPythonTitle()"
 
 func SetPythonTitle()
     call setline(1,"#!/usr/bin/env python")
     call append( line("."),"#-*- coding: utf-8 -*-" )
     call append(line(".")+1," ")
     call append(line(".")+2, "\# File Name: ".expand("%")) 
     call append(line(".")+3, "\# Author: raoxiang") 
     call append(line(".")+4, "\# mail: wangyiraoxiang@163.com") 
     call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))    
 endfunc
 
 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "#####################################file content setting end###############################################################

"set fileformats=unix,dos
"设置文件的格式读取选项
"这个命令与fens不同 fencs 是来设置读取的文件的
"而ffs还有设置保存文件格式的功能  这里默认保存为unix
"这个命令得放在配置文件的最后面,不然起不到什么作用

"set ff=unix
"设置文件的保存格式/模式 为unix
"这个命令在配置文件里面设置貌似并没有什么用 只有每次收到打开自己设置
"设置新增文件的默认模式 为unix .unix默认的换行符和unix不一样

