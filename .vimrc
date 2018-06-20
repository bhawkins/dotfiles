"
" Turn on syntax highlighting and pick a nice color scheme
"
syntax enable
"colorscheme delek
colorscheme torte
"
" Our Fortran codes are wider than standard f77
"
autocmd FileType fortran setlocal textwidth=132
"
" Indent and comment macros
"
map q 04i 0j
map Q 04xj
map c 0i//0j
map C 02xj
" why doesn't map work?
"map [15~ $a|0jd$k$pjddk
let @j = '$a|0jd$k$pjddk'
"
" Disable tabs, set indenting options
"
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
"set autoindent
"
" Need real tabs for Makefiles, though
"
autocmd FileType make set noexpandtab shiftwidth=8
"
" Enable folding, but unfold everything at the start
"
set foldmethod=syntax
set foldlevel=100
"
" Various improvements (e.g., working arrow keys)
"
set nocompatible 
"
" Turn on line/column indicator.
"
set ruler
"
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
    set t_ut=
endif
