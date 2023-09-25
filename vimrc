" We are using vim, not vi
set nocompatible

" Make Neovim find python
if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
endif

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

Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'thiagoalessio/rainbow_levels.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'github/copilot.vim'

Plugin 'trevordmiller/nova-vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'
Plugin 'sonph/onehalf', { 'rtp': 'vim' }
Plugin 'rakr/vim-one'
Plugin 'kyoz/purify', { 'rtp': 'vim' }
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'embark-theme/vim', { 'as': 'embark' }

call vundle#end()

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc nested source %

" Set leader to ,
let mapleader=","

" Quicksave
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Easy indent in visual mode
vnoremap < <gv
vnoremap > >gv

" Show whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
set termguicolors
" Bug in gruvbox scheme on startup. Need to load another scheme first
colorscheme nova
colorscheme gruvbox
nmap <silent> <leader>1 :colorscheme nova<CR>
nmap <silent> <leader>2 :colorscheme nord<CR>
nmap <silent> <leader>3 :colorscheme gruvbox<CR>
nmap <silent> <leader>4 :colorscheme molokai<CR>
nmap <silent> <leader>5 :colorscheme onehalfdark<CR>
nmap <silent> <leader>6 :colorscheme one<CR>
nmap <silent> <leader>7 :colorscheme purify<CR>
nmap <silent> <leader>8 :colorscheme palenight<CR>
nmap <silent> <leader>9 :colorscheme embark<CR>

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on
augroup SyntaxHighlighting
  autocmd BufNewFile,BufRead *.mako set syntax=mako
augroup end

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

" Settings for ctrlp
let g:ctrlp_max_height=30
set wildignore+=*.pyc

" Airline settings
let g:airline_powerline_fonts = 1

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
augroup OnFileChanged
  au FocusGained * :checktime
augroup end

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
  set guifont=SauceCodePro\ Nerd\ Font\ 10,SauceCodePro\ Nerd\ Font:h11,Sauce_Code_Powerline:h9:cANSI
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

" Rainbow levels short keys
nnoremap <leader>r :RainbowLevelsToggle<CR>

" Use NERDtree for :e. and the likes
let NERDTreeHijackNetrw=1

" EasyMotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Goyo and Limelight
map <Leader>l :Limelight<CR>
map <Leader>g :Goyo<CR>
let g:goyo_width = 100

" Fix formatting for AsciiDoc
autocmd FileType asciidoc set fo=want

" Store backup and swap files in central location
set directory=$HOME/.vim/tmp/swap//
set backupdir=$HOME/.vim/tmp/backup//
set undodir=$HOME/.vim/tmp/undo//
