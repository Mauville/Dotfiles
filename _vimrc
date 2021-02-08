"              ,,
"`7MMF'   `7MF'db
"  `MA     ,V
"   VM;   ,V `7MM  `7MMpMMMb.pMMMb.     `7Mb,od8 ,p6"bo
"    MM.  M'   MM    MM    MM    MM       MM' "'6M'  OO
"    `MM A'    MM    MM    MM    MM       MM    8M
"     :MM;     MM    MM    MM    MM  ,,   MM    YM.    ,
"      VF    .JMML..JMML  JMML  JMML.db .JMML.   YMbmd'
"
"
let mapleader = " "

if has('nvim')
    " Enable actually working mouse stuff
    set mouse=a
    set title
    behave xterm
    " Make Right Click behave like Powershell
    nnoremap <RightRelease> i"+p
    inoremap <RightRelease> <C-R>"+p
    vnoremap <RightRelease> d"+p
    cnoremap <RightRelease> <C-R>+
    nnoremap <leader>e :tabedit ~/_vimrc <CR>
endif

set title
set nocompatible
set fdm=syntax
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set autoread
set scrolloff =5
set textwidth=0
set wrapmargin=0
set mousemodel=popup

nnoremap zm zz

"Map <BS> to delete selection
vnoremap <BS> d

"Set smartcase
set ignorecase
set smartcase

" Silence bells
set noerrorbells
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

"Add a bit extra margin to the left
set foldcolumn=1

"Use spaces instead of tabs
set expandtab

"Use smart tabs
set smarttab

"Use tabstop to specify width of tab in columns
set tabstop=4

"These two need linking for BS to work

"Use shiftwidth to make backspace delete a tab
set shiftwidth=4

"Use softtabstop to specify whitespace of a tab
set softtabstop=4

set backspace=indent,eol,start

" keep a backup file (restore to previous version)
set backup

" keep an undo file (undo changes after closing)
set undofile

" keep n lines of command line history
set history=10000

" show the cursor position all the time
set ruler

" do incremental searching
set incsearch


set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call plug#begin('$HOME/.vim/plugged/')

" Colorschemes
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" Plug 'SirVer/ultisnips'

Plug 'dense-analysis/ale'

Plug 'jiangmiao/auto-pairs'

Plug 'arp242/auto_mkdir2.vim'

Plug 'junegunn/goyo.vim'

Plug 'vim-scripts/L9'

Plug 'bkad/CamelCaseMotion'

Plug 'tpope/vim-surround'

Plug 'mbbill/undotree'

Plug 'tpope/vim-commentary'

Plug 'Yggdroot/indentLine'

Plug 'vim-scripts/VisIncr'

Plug 'qpkorr/vim-renamer'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-repeat'


"ADOC

Plug 'dahu/Asif'

Plug 'dahu/vimple'

Plug 'Raimondi/VimRegStyle'

Plug 'sheerun/vim-polyglot'

Plug 'vim-scripts/SyntaxRange'

Plug 'Mauville/vim-asciidoc'

Plug 'habamax/vim-asciidoctor'

call plug#end()

filetype plugin indent on

set number
set relativenumber

if has("patch-7.4.354")
    " Indents word-wrapped lines as much as the 'parent' line
    set breakindent
	    " Ensures word-wrap does not split words
    set formatoptions=l
    set lbr
endif

"Turn on syntax
syntax on

"Since we use powerline, do not show the default status bar
set noshowmode

"Map <j> and <k> to their better alternatives <gj> and <gk>
map j gj
map k gk

""" SPELL

"Map F7 to spellchecker
map <F7> :setlocal spell! spelllang=en_us<CR>
map <F8> :setlocal spell! spelllang=es<CR>
"Enable autocomplete from dict
set complete+=kspell
nnoremap <F10> [S
nnoremap <F11> z=1<CR><CR>
nnoremap <F12> ]S

"show commands while you type
set showcmd

"set f5 to look at undo tree.
nnoremap <F5> :UndotreeToggle<cr>

"remap :W to avoid opening WordProcessor mode
:command! W w

"remap :Q to quit
:command! Q q

"Set nospell to leader key
noremap <leader>n :noh<CR>

"Map jj in insert mode to Esc
imap jj 

"Map <leader><leader> to find the next placeholder and replace
noremap <leader><leader> <Esc>/<++><CR>c4l

"Map <leader>s to reload $MYVIMRC
nnoremap <leader>s :so $MYVIMRC <CR>

"Map <leader>w to write
nnoremap <leader>w :w <CR>

if !has('nvim')
    "Map <leader>e to edit $MYVIMRC
    nnoremap <leader>e :tabedit $MYVIMRC <CR>
endif

"Map <leader>p to run with python3
nnoremap <leader>p :below term python %<CR>

"Map <leader>v to register paste
nnoremap <leader>v "+p

"Map <leader>y to register yank
nnoremap <leader>y "+Y
vnoremap <leader>y "+y

"Map leader enter to insert whitespace after cursor
nnoremap <leader><CR> A<CR>

"Map leader backspace to insert whitespace before cursor
nnoremap <leader><BS> I<CR>

"Map leader j to compile with javac
nnoremap <leader>j :!javac %<CR>

"Map leader qq to quit
nnoremap <leader>qq :q!<CR>

"Map <leader>t to prepend :tabdo
nnoremap <leader>t :tabdo

" Motion for "next object". For example, "din(" would go to the next "()" pair
" and delete its contents.

onoremap an :<c-u>call <SID>NextTextObject('a')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i')<cr>

function! s:NextTextObject(motion)
  echo
  let c = nr2char(getchar())
  exe "normal! f".c."v".a:motion.c
endfunction

" Automatically change cwd to the one that the current file is on
autocmd BufEnter * silent! lcd %:p:h

" Open Tree
nnoremap <F4> :NERDTreeToggle<CR>

"Map <leader>m to easymotion
map <Leader>m <Plug>(easymotion-prefix)

" Bubble single lines
nmap <C-K> ddkP
nmap <C-J> ddp

" Bubble multiple lines
vmap <C-K> xkP`[V`]
vmap <C-J> xp`[V`]

" Set common abbreviations

"Put table corner separators in VimTable
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='


""""""""""""
"ASCIIDOCTOR
""""""""""""

"Set encoding to UTF-8 with BOM
autocmd BufNewFile,BufRead *.adoc set fileencoding=utf8 bomb

" What extensions to use for HTML, default `[]`.
let g:asciidoctor_extensions = ['asciidoctor-diagram']

" Set css
let g:asciidoctor_css_path = '~'
let g:asciidoctor_css = 'ADOC.css'

" What extensions to use for PDF, default `[]`.
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']

"Compile
 nnoremap <leader>a :!asciidoctor-latex -b html -r asciidoctor-diagram -a config=..\plantuml.cfg %<CR><CR>
 nnoremap <leader>pa :!  asciidoctor -b pdf -r asciidoctor-diagram -a config=..\plantuml.cfg  -r asciidoctor-pdf % <CR><CR>
 nnoremap <leader>pal :! docker run --rm -v ${pwd}:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf -r asciidoctor-diagram -r -a config=plantuml.cfg asciidoctor-mathematical % <CR><CR>
 nnoremap <leader>aw :Asciidoctor2DOCX<CR>
" Function to create buffer local mappings
"nnoremap <buffer> <leader>a :Asciidoctor2HTML<CR>
"nnoremap <buffer> <leader>pa :Asciidoctor2PDF<CR>

nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <leader>oa :AsciidoctorOpenHTML<CR>

nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>

" Fold sections, default `0`.
let g:asciidoctor_folding = 1

" Fold options, default `0`.
let g:asciidoctor_fold_options = 1

" Conceal *bold*, _italic_, `code` and urls in lists and paragraphs, default `0`.
" See limitations in end of the README
let g:asciidoctor_syntax_conceal = 1

" List of filetypes to highlight, default `[]`
let g:asciidoctor_fenced_languages = ['python', 'cpp', 'java']

" Image pasting
let g:asciidoctor_img_paste_command = 'gm.exe convert clipboard: %s%s'

" first `%s` is a base document name:
" (~/docs/hello-world.adoc => hello-world)
" second `%s` is a number of the image.
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

" Paste image from clipboard
nmap <leader>iv :AsciidoctorPasteImage<CR>

" Avoid vimple collision with jj
imap <c-x><c-c> <plug>vimple_completers_trigger

""""""""""""
"PYTHON CALC
""""""""""""
":command! -nargs=+ Calc :python3 print(<args>)
":python3 from math import *

""""""""""
"WINDOWS
""""""""""

if has("win32")
    set shellpipe=|
    set shellredir=>
endif


" Enable true colors for OneLight
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
" lightline
" let g:lightline.colorscheme='onehalfdark'
let g:lightline = {
    \ 'colorscheme': 'onehalfdark',
    \}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'python': ['autopep8'],
\}
let g:ale_linters = {
\   'markdown': ['writegood'],
\ }

let b:ale_linter_aliases = ['markdown', 'asciidoctor']
" let g:ale_linters_explicit = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_javascript_standard_executable='/path/to/global/standard'

" let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
