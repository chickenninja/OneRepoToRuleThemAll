set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildignore+=**/node_modules/**
set wildmenu
set ts=4
set shiftwidth=4
set relativenumber

let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_banner=0

set splitbelow
set splitright

inoremap jk <ESC>

map gg=G :Neoformat<CR>

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile Vagrantfile set filetype=ruby 
