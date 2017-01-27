set nocompatible

" Bundle {
    " git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    filetype off                   " required!

    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()

    " required!
    Plugin 'gmarik/Vundle.vim'

    Plugin 'altercation/vim-colors-solarized'

    Plugin 'openssl.vim'
    Plugin 'YankRing.vim'

    Plugin 'bogado/file-line'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'kien/ctrlp.vim'
    Plugin 'msanders/snipmate.vim'
    Plugin 'vti/snipmate-snippets-perl'
    "Plugin 'majutsushi/tagbar'
    "Plugin 'mileszs/ack.vim'

    Plugin 'VisIncr'

    "Plugin 'vimwiki/vimwiki'

    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'mbbill/undotree'
    Plugin 'kshenoy/vim-signature'
    Plugin 'justinmk/vim-sneak'

    Plugin 'moll/vim-bbye'
    Plugin 'bufkill.vim'
    "Plugin 'c9s/perlomni.vim'
    "Plugin 'cespare/vim-toml'
    "Plugin 'LargeFile'

    Plugin 'mileszs/ack.vim'
    Plugin 'vim-perl/vim-perl'

    call vundle#end()

    filetype plugin indent on     " required!
" }

set modelines=0

set autoindent
set smartindent
set smarttab

set wrap
set linebreak

set tabstop    =4
set shiftwidth =4
set expandtab
set textwidth  =120
set formatoptions=qrn1

"set colorcolumn=85
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%121v', 120)

set showmatch

set incsearch
set ignorecase
set smartcase
set hlsearch

" can switch between buffers without saving them
set hidden

set ttyfast

set title
set visualbell

set nobackup
"set noswapfile

if has("persistent_undo")
    set undodir=~/.vimundo
    set undofile
endif

syntax on
set number

set t_Co=256

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Use SHIFT to switch back to mouse selection
set mouse=a
set clipboard+=unnamed
"set clipboard=unnamed,exclude:cons\\\|linux

set browsedir=current
set backspace=indent,eol,start
set foldmethod=marker
set showcmd

set visualbell t_vb=

filetype plugin indent on

"set statusline=%F%m%r%h%w\ [%l,%v][%p%%]\ (enc[%{&enc}]\ fenc[%{&fenc}]\ ff[%{&ff}]){%Y}
set laststatus=2

" Encoding {
    set encoding=utf-8
    set fileencoding=utf-8

    " Encoding on the fly
    set wildmenu
    set wcm=<Tab>
    menu Encoding.koi8-u :e ++enc=koi8-u<CR>
    menu Encoding.windows-1251 :e ++enc=cp1251<CR>
    menu Encoding.cp866 :e ++enc=cp866<CR>
    menu Encoding.utf-8 :e ++enc=utf8 <CR>
    map ,en :emenu Encoding.<TAB>
" }

"Trailing spaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
"set listchars=tab:▸\ ,eol:¬

" Autoreload .vimrc
autocmd! BufWritePost $MYVIMRC source %

" General mappings {
    let mapleader = ","

    " invert paste mode (when pasting lots of text and don't want it to be indented)
    map <leader>pp :set invpaste<cr>

    " switch off search hightlighting when done
    nnoremap <leader><space> :noh<cr>

    " run sudo when not enough rights
    command! Wsudo set buftype=nowrite | silent execute ':%w !sudo tee %' | set buftype= | e! %

    " easily switch between buffers
    nmap <C-l> :bn<CR>
    nmap <C-h> :bp<CR>
" }

" Filetype specific {
    " Perl {
        au BufRead,BufNewFile *.t setfiletype=perl
        autocmd BufNewFile,BufRead *.p? compiler perl
        let perl_include_pod   = 1    "include pod.vim syntax file with perl.vim"
        let perl_extended_vars = 1    "highlight complex expressions such as @{[$x, $y]}"
        let perl_sync_dist     = 250  "use more context for highlighting"

        set path+=$PWD/lib
        set includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.pm','')

        " Tidy selected lines (or entire file) with ,pt
        nnoremap <silent> <leader>pt :%!perltidy -q<cr>
        vnoremap <silent> <leader>pt :!perltidy -q<cr>

        function! Alternative ()
            let l:file = @%

            if l:file == "t/*.t" || l:file =~ "\.t$"
                let l:file = substitute(l:file, "\.t$", ".pm", "")
                let l:file = substitute(l:file, "^t/", "lib/", "")

                "let l:parts = split(l:file, '/');
                "for part in l:parts
                    "part = substitute(part, '\(.*\)', '\L\1', '')
                "endfor
                "let l:file = join(l:parts, '/');

                "let l:file = substitute(l:file, '\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)', '\u\1\2', "g")
                let l:file = substitute(l:file, '_\([a-z]\)', '\u\1', "")
            else
                let l:file = substitute(l:file, "\.pm$", ".t", "")
                let l:file = substitute(l:file, "^lib/", "t/", "")
                "let l:file = substitute(l:file, "\\(.*\\)", "\\L\\1", "")
                "let l:file = substitute(l:file, '\(\<\u\l\+\|\l\+\)\(\u\)', '\l\1_\l\2', "g")
                let l:file = substitute(l:file, '\(.*\)', '\L\1', "g")
            endif

            return l:file
        endfunction

        " Test
        function! Prove ()
            let l:file = @%

            if l:file == "t/*.t" || l:file =~ "\.t$"
            else
                let l:file = Alternative()
            endif

            if !filereadable(l:file)
                echoerr "File '" . l:file . "' does not exist"
            else
                let l:params = "l"
                execute "!prove -" . l:params . " " . l:file
            endif
        endfunction

        " Switch between .pm and .t
        function! OpenAlternative ()
            let l:file = Alternative()

            if !filereadable(l:file)
                echoerr "File '" . l:file . "' does not exist"
            else
                execute ":e " . fnameescape(l:file)
            endif
        endfunction

        nnoremap <leader>rt :call Prove()<cr>
        nnoremap <leader>ga :call OpenAlternative()<cr>

        " Deparse
        vnoremap <silent> <leader>d :!perl -MO=Deparse 2>/dev/null<CR>

        let perl_sub_signatures = 1
    " }

    " Go {
        au BufRead,BufNewFile *.go setfiletype go
        nnoremap <silent> <leader>gt :%!goimports <cr>
        vnoremap <silent> <leader>gt :!goimports <cr>
    " }
" }

" Plugins {
    " openssl {
        let g:openssl_backup = 1
    " }

    " NERDCommenter {
        let NERDShutUp=1
    " }

    " NERDTree {
        let NERDTreeIgnore=['\.o$', '\.lo$', '\.la$', '\.in$', '^moc_', '\.ui$']
        let NERDTreeShowLineNumbers=0
        nnoremap <silent> <leader>nt :NERDTreeToggle<CR><C-W>w
        nnoremap <silent> <leader>nf :NERDTreeFind<CR><C-W>w
    " }

    " visincr {
        vnoremap <c-a> :I<CR>
    " }

    " ctrlp {
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/cover_db/*,*/local/*
        let g:ctrlp_working_path_mode = 0

        nnoremap <silent> <C-M> :CtrlPMRU<CR>
    " }

    " Yankring {
        nnoremap <silent> <leader>y :YRShow<cr>
        let g:yankring_manual_clipboard_check = 1
    " }

    " Vimwiki {
        let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.markdown'}]
        au! BufRead ~/vimwiki/index.markdown :silent execute "!git -C ~/vimwiki/pull" | redraw!
        au! BufWritePost ~/vimwiki/* silent execute '!git -C ~/vimwiki/ add .;git -C ~/vimwiki/ commit -m "Auto commit + push.";git -C ~/vimwiki/ push' | redraw!
    " }

    " Airline {
        let g:airline#extensions#tabline#enabled = 1
        "let g:airline_powerline_fonts = 1
        "let g:airline_theme='monochrome'
    " }

    " UndoTree {
        nnoremap <silent> <leader>ut :UndotreeToggle <cr>
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Ack {
        nnoremap <leader>a :Ack 
    " }

    " Bbye {
        nnoremap <leader>bd :Bdelete<CR>
    " }
" }

" Local settings {
    if filereadable(expand(".vimrc.local"))
        source .vimrc.local
    endif
" }

nnoremap <silent> ,tr :%!tr <cr>
