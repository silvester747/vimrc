" We are using vim, not vi
set nocompatible

" Vundle
filetype off
if has("win32") || has("win16")
  set rtp+=~/vimfiles/bundle/Vundle.vim
  call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
  set rtp+=~/.vim/bundle/Vundle.vim
  set shell=/bin/bash
  call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'

Plugin 'michalbachowski/vim-wombat256mod'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'thiagoalessio/rainbow_levels.vim'
Plugin 'sheerun/vim-polyglot'

call vundle#end()

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc nested source %

" Set leader to ,
let mapleader=","

" Quicksave
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Easy indent in visual mode
vnoremap < <gv
vnoremap > >gv

" Show whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
set t_Co=256  " limit to 256 colors
color wombat256mod

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

" Show line numbers and length
set number
set tw=99
set nowrap
set fo-=t
set colorcolumn=100
highlight ColorColumn ctermbg=233

" Set history and undo length
set history=700
set undolevels=700

" Set tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noshiftround
set expandtab
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4

" C options
" Scope declarations at 1 indent
set cinoptions+=g1
" When putting function arguments on next line, indent with 4
set cinoptions+=(0W4
" Do not indent namespace blocks
set cinoptions+=N-s
" Ident base class declarations and constructor initializers at 4
set cinoptions+=i4
" Support doxygen comments
autocmd FileType cpp setlocal comments-=:// comments+=://!,://

" Enable powerline
set laststatus=2
silent! python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set noshowmode

" Settings for ctrlp
let g:ctrlp_max_height=30
set wildignore+=*.pyc

" Easy window navigation
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Search settings
" Enable Python compatible regex search
nnoremap / /\v
vnoremap / /\v
" Smart handling of case in search
set ignorecase
set smartcase
" By default do global replace on lines
set gdefault
" Do direct highlight on search
set incsearch
set showmatch
set hlsearch
" But allow easy disabling of highlight
nnoremap <leader><space> :nohlsearch<cr>

" Enable easy paste from clipboard
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Shortcuts to use system clipboard
map <leader>x "+d
map <leader>c "+y
map <leader>v "+p

" Enable NERDtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.bak']

" P4 shortcuts
nmap <silent> <leader>pe :!p4 edit %<CR>
nmap <silent> <leader>pa :!p4 add %<CR>
nmap <silent> <leader>pr :!p4 revert %<CR>

" HG shortcuts
nmap <silent> <leader>ha :!hg add %<CR>
nmap <silent> <leader>hr :!hg revert %<CR>

" When opening files for edit, automatically reload them
set autoread

" Keep some lines around the cursor when scrolling
set scrolloff=3

" Show list of available commands when auto completing vim command
set wildmenu

" Auto complete only the common part between options
set wildmode=list:longest

" We are on a fast connection, do fast redrawing
set ttyfast

" Keep an undofile for every file edited, so I can undo even after closing
set undofile

" Let backspace work as expected
set backspace=indent,eol,start

" Short key for ack-grep
nnoremap <leader>a :Ack<space>

" Python folding
set nofoldenable

" GUI font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 9
  elseif has("gui_macvim")
    set guifont=SauceCodePro\ Nerd\ Font:h11
  elseif has("gui_win32")
    set guifont=Sauce_Code_Powerline:h9:cANSI
  endif
endif

" Make view not modifiable if file is read-only
function UpdateModifiable()
  if !exists("b:setmodifiable")
    let b:setmodifiable = 0
  endif
  if &readonly
    if &modifiable
      setlocal nomodifiable
      let b:setmodifiable = 1
    endif
  else
    if b:setmodifiable
      setlocal modifiable
    endif
  endif
endfunction
autocmd BufReadPost * call UpdateModifiable()

" YouCompleteMe options
" disables question when loading cfg files
let g:ycm_confirm_extra_conf = 0
" min chars for completion
let g:ycm_min_num_of_chars_for_completion = 2
" auto compiler identifier
let g:ycm_auto_trigger = 1
" use all completion engines
let g:ycm_cache_omnifunc = 1
" logging level
let g:ycm_server_log_level = 'info'
" loads programming lagnuage keywords
let g:ycm_seed_identifiers_with_syntax = 1
" show preview
let g:ycm_add_preview_to_completeopt = 0
" force diagnostic
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" YCM short keys
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yi :YcmCompleter GoToInclude<CR>
nnoremap <leader>yd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>yf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yt :YcmCompleter GetType<CR>
nnoremap <leader>yp :YcmCompleter GetParent<CR>

" Nice relative line numbers
set relativenumber

" Rainbow levels short keys
nnoremap <leader>l :RainbowLevelsToggle<CR>

" Use NERDtree for :e. and the likes
let NERDTreeHijackNetrw=1

