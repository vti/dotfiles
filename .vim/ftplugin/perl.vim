" CREDITS
" http://houston.pm.org/talks/2009talks/0901Talk/perl_local.vim

" Tidy selected lines (or entire file) with ,pt
nnoremap <silent> ,pt :%!perltidy -q<cr>
vnoremap <silent> ,pt :!perltidy -q<cr>

" Critic check the current file with ,pc
nnoremap <silent> ,pc :!perlcritic %<cr>

" Allow gf to work with modules
set isfname+=:
set include=\\<\\(use\\\|require\\)\\>
set includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.pm','')
set path+=lib

" Deparse obfuscated code with ,pd
nnoremap <silent> ,pD :.!perl -MO=Deparse 2>/dev/null<cr>
vnoremap <silent> ,pD :!perl -MO=Deparse 2>/dev/null<cr>

"From Ovid
noremap ,pd  :!perldoc %<cr>

" Prove test code
nmap  ,pp :!prove -blv %<cr>
