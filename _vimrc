"                                                        
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
set nocompatible
set fdm=syntax
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set autoread
set scrolloff =5
:set textwidth=0
:set wrapmargin=0

nnoremap zm zz

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

" keep 50 lines of command line history
set history=700		

" show the cursor position all the time
set ruler		

" do incremental searching
set incsearch		


set nocompatible
filetype off                  

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/plugin/')

Plugin 'VundleVim/Vundle.vim'

Plugin 'Mauville/vim-asciidoc'

Plugin 'habamax/vim-asciidoctor'

Plugin 'lmintmate/blue-mood-vim'

Plugin 'vim-scripts/L9'

Plugin 'bkad/CamelCaseMotion'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'sheerun/vim-polyglot'

Plugin 'tpope/vim-surround'

Plugin 'mbbill/undotree'

Plugin 'tpope/vim-commentary'

Plugin 'easymotion/vim-easymotion'

Plugin 'Yggdroot/indentLine'

Plugin 'vim-scripts/VisIncr'

Plugin 'dhruvasagar/vim-table-mode'

Plugin 'qpkorr/vim-renamer'

Plugin 'vim-airline/vim-airline'

Plugin 'dahu/Asif'

Plugin 'dahu/vimple'

Plugin 'Raimondi/VimRegStyle'

Plugin 'vim-scripts/SyntaxRange'

call vundle#end() 

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

"Map F7 to spellchecker
map <F7> :setlocal spell! spelllang=en_us<CR>

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

"Map <leader>e to edit $MYVIMRC
nnoremap <leader>e :tabedit $MYVIMRC <CR>

"Map <leader>p to run with python3
nnoremap <leader>p :below term python %<CR>

"Map <leader>v to register paste
nnoremap <leader>v "+p

"Map <leader>y to register yank
nnoremap <leader>y "+Y
vnoremap <leader>y "+Y

"Map leader enter to insert whitespace after cursor
nnoremap <leader><CR> A<CR>

"Map leader backspace to insert whitespace before cursor
nnoremap <leader><BS> I<CR>

"Map leader j to compile with javac
nnoremap <leader>j :below term javac %<CR>

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

" Open terminal
nnoremap <leader>r :below terminal<CR>

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
 nnoremap <leader>a :!asciidoctor -r asciidoctor-diagram %<CR><CR> */
 nnoremap <leader>pa :!  asciidoctor -b pdf -r asciidoctor-diagram -r asciidoctor-pdf % <CR><CR> */

" Function to create buffer local mappings
"nnoremap <buffer> <leader>a :Asciidoctor2HTML<CR>
"nnoremap <buffer> <leader>pa :Asciidoctor2PDF<CR>

nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <leader>oa :AsciidoctorOpenHTML<CR>

nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>

" Fold sections, default `0`.
let g:asciidoctor_folding = 1

" Fold options, default `0`.
let g:asciidoctor_fold_options = 1

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
:command! -nargs=+ Calc :py print <args>
:py from math import *

""""""""""
"POWERLINE
""""""""""

let g:airline_powerline_fonts = 1
silent! call airline#extensions#whitespace#disable()
set renderoptions=type:directx,renmode:
let g:python_highlight_space_errors =0

""""""""""
"WINDOWS
""""""""""

if has("win32")
    set shellpipe=|
    set shellredir=>
endif





