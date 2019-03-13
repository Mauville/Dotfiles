"Use x as colorscheme for Vim
colorscheme torte

let mapleader = " "
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Set smartcase
set smartcase

"Don't redraw while executing macros
set lazyredraw

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

" do not keep a backup file, use versions instead
set nobackup		

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

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif"

" Switch syntax highlighting on, when the terminal has olors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

"intgration with vundle"
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'L9'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'tpope/vim-surround'

Plugin 'vim-syntastic/syntastic'

Plugin 'francoiscabrol/ranger.vim'

Plugin 'mbbill/undotree'

Plugin 'tpope/vim-commentary'

Plugin 'easymotion/vim-easymotion'

Plugin 'Yggdroot/indentLine'

"Colorschemes and appearance

Plugin 'dracula/vim'

Plugin 'itchyny/lightline.vim'

Plugin 'rudrab/vim-coogle'

Plugin 'junegunn/limelight.vim'

Plugin 'junegunn/goyo.vim'

Plugin 'crusoexia/vim-monokai'

Plugin 'sfi0zy/atlantic-dark.vim'

Plugin 'szorfein/fromthehell.vim'

Plugin 'vim-scripts/inkpot'

"Plugin 'chriskempson/base16-vim'

call vundle#end()

filetype plugin indent on

set number
set relativenumber

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }
set laststatus=2
if !has('gui_running')
	  set t_Co=256
  end

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

"Ranger.vim mappings
map <leader>f :Ranger<CR>
let g:ranger_open_new_tab = 1

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

"Disable escape to learn habit
imap <Esc> :echo "There's no Escape!"<CR>
imap OD h
imap OB j
imap OA k
imap OC l

"Map <C-H> and <C-L> to Home and End         
let g:BASH_Ctrl_j = 'off'
map!  0
map!  $ 

"Map <leader>j  to find the next placeholder and replace
noremap <leader><leader> <Esc>/<++><CR>c4l

"Map <leader>s to reload $MYVIMRC
nnoremap <leader>s :so $MYVIMRC <CR>

"Map <leader>w to write
nnoremap <leader>w :w <CR>

"Map <leader>e to edit $MYVIMRC
nnoremap <leader>e :tabedit $MYVIMRC <CR>

"Map <leader>p to run with python3
nnoremap <leader>p :below term python3 %<CR>

"Map <leader>v to register paste
nnoremap <leader>v "+p

"Allow saving of files as sudo 
cmap w!! w !sudo tee > /dev/null %

"Map leader enter to insert whitespace after cursor
nnoremap <leader><CR> A<CR>

"Map leader backspace to insert whitespace before cursor
nnoremap <leader><BS> I<CR>

"Map leader j to compile with javac
nnoremap <leader>j :below term javac %<CR>

"Map leader qq to quit
nnoremap <leader>qq :q!<CR>

"Map <F8> to show revision marks 
nmap <F8> :set list!<CR>
set listchars=tab:⇒\ ,eol:¶,space:·

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

"Auto-style for filetypes using astyle
"autocmd BufNewFile,BufRead *.java set formatprg=/.vim/astyle/as-gcc-exe/astyle -A14 -T4pb

"let g:syntastic_java_checkers = ['syntastic-java-checkstyle']
"let g:syntastic_aggregate_errors = 1


"Change character for indent lines
let g:indentLine_char = '▏'
let g:indentLine_color_term = 239

"Use different cursor for each mode. Not available in  
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

