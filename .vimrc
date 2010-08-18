set nocompatible

set autoindent
set smartindent
set smarttab

set wrap
set linebreak

set tabstop    =4
set shiftwidth =4
set expandtab
set textwidth  =80

set showmatch

set incsearch
set ignorecase
set smartcase

set tf

syntax on
set nu

set background=dark
colorscheme desert

"set mouse=a
"set clipboard=unnamed,exclude:cons\\\|linux

"setlocal list
"setlocal listchars=tab:\ ,trail:<c2><b7>

"set listchars+=precedes:<,extends:>     
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

"set winminheight=0
"set winheight=9999

set encoding=utf-8
set fileencoding=utf-8

"{{{1 text encoding
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-u :e ++enc=koi8-u<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
map ,en :emenu Encoding.<TAB>
"}}}1

command Wsudo set buftype=nowrite | silent execute ':%w !sudo tee %' | set buftype= | e! %

au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78
au BufReadPost *.doc silent %!antiword "%"
au BufReadPost *.odt silent %!odt2txt.py "%"

vmap ,q !par-format 80<CR>
nmap ,q !par-format 80<CR>

"Trailing spaces
set list
set listchars=trail:.,tab:>-

"Perl
au BufRead,BufNewFile *.t setfiletype=perl
autocmd BufNewFile,BufRead *.p? compiler perl

"Inc
"vnoremap <c-a> :Inc<CR>

"openssl
let g:openssl_backup = 1 

"NERDCommenter
let NERDShutUp=1

"NERDTree
let NERDTreeIgnore=['\.o$', '^moc_', '\.ui$']
nnoremap <silent> ,nt :NERDTree<CR>

"taglist
let g:buftabs_only_basename=1 
nnoremap <silent> ,tl :TlistToggle<CR>

"YankRing
nnoremap <silent> <Leader>yr :YRShow<CR>

"Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_put_url_to_clipboard_after_post = 1

set runtimepath=~/.vim-dotfiles,~/.vim,$VIMRUNTIME

"For local customization
"so "~/.vimrcX"
if filereadable(expand("<sfile>") . "X")
    source <sfile>X
endif
