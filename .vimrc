set nocompatible
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" required!
Bundle 'gmarik/vundle'

Bundle 'openssl.vim'
Bundle 'YankRing.vim'

Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-localrc'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'vti/snipmate-snippets-perl'

filetype plugin indent on     " required!

set modelines=0

set autoindent
set smartindent
set smarttab

set wrap
set linebreak

set tabstop    =4
set shiftwidth =4
set expandtab
set textwidth  =80
set formatoptions=qrn1
set colorcolumn=85

set showmatch

set incsearch
set ignorecase
set smartcase
set hlsearch

set hidden

set ttyfast

set title
set visualbell

set nobackup
"set noswapfile

set undofile
set undodir=~/.vimundo

syntax on
set number

set t_Co=256

set background=light
colorscheme solarized
let g:solarized_termcolors=256

let mapleader = ","

" Use SHIFT to switch back to mouse selection
set mouse=a
"set clipboard=unnamed,exclude:cons\\\|linux

set browsedir  =current   
set backspace=indent,eol,start
set foldmethod=marker
set showcmd

set visualbell t_vb=

filetype plugin indent on

nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

set clipboard=autoselect,exclude:cons\\\|linux,unnamed " for unnamed

set statusline=%F%m%r%h%w\ [%l,%v][%p%%]\ (enc[%{&enc}]\ fenc[%{&fenc}]\ ff[%{&ff}]){%Y}
set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

set wildmenu
set wcm=<Tab>
menu Encoding.koi8-u :e ++enc=koi8-u<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
map ,en :emenu Encoding.<TAB>

command! Wsudo set buftype=nowrite | silent execute ':%w !sudo tee %' | set buftype= | e! %

"Trailing spaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
"set listchars=tab:▸\ ,eol:¬

map <leader>pp :set invpaste<cr>

" Autoreload .vimrc
autocmd! BufWritePost $MYVIMRC source %

" Perl
au BufRead,BufNewFile *.t setfiletype=perl
autocmd BufNewFile,BufRead *.p? compiler perl
let perl_include_pod   = 1    "include pod.vim syntax file with perl.vim"
let perl_extended_vars = 1    "highlight complex expressions such as @{[$x, $y]}"
let perl_sync_dist     = 250  "use more context for highlighting"

set path+=$PWD/lib
"set includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.pm','')

" Tidy selected lines (or entire file) with ,pt
nnoremap <silent> ,pt :%!perltidy -q<cr>
vnoremap <silent> ,pt :!perltidy -q<cr>

" Deparse
vnoremap <silent> <leader>d :!perl -MO=Deparse 2>/dev/null<CR>

" Test::Class
noremap <buffer> <leader>rt :!prove %<cr>
noremap <buffer> <leader>rm ?^sub.*:.*Test<cr>w"zye:!TEST_METHOD='<c-r>z' prove %<cr>

nnoremap <leader><space> :noh<cr>

" Plugins --------------------------------------------------------------------------

" openssl
let g:openssl_backup = 1 

" NERDCommenter
let NERDShutUp=1

" NERDTree
let NERDTreeIgnore=['\.o$', '\.lo$', '\.la$', '\.in$', '^moc_', '\.ui$']
let NERDTreeShowLineNumbers=1
nnoremap <silent> ,nt :NERDTreeToggle<CR><C-W>w
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
"autocmd BufEnter * NERDTreeMirror
"autocmd BufEnter * wincmd p

" Ack
nnoremap <silent> ,a :Ack 

" Tagbar
nnoremap <silent> ,tb :TagbarToggle<cr>

" visincr
vnoremap <c-a> :I<CR>

" ctrlp
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_working_path_mode = 0
nnoremap <silent> <leader>f :CtrlP<cr>
nnoremap <silent> <leader>s :CtrlPB<cr>
nnoremap <silent> <leader>m :CtrlPMRU<cr>

" Yankring
"nnoremap <silent> <leader>y :YRToggle<cr>
nnoremap <silent> <leader>y :YRShow<cr>
let g:yankring_manual_clipboard_check = 1

let g:syntastic_perl_lib_path = './lib'
