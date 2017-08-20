set nocompatible
set backspace=indent,eol,start
set autoindent
set smartindent
set history=50
set ruler
set showcmd
set incsearch
"set shiftwidth=3
"set tabstop=3
"set textwidth=120
set ignorecase
set smartcase
set scrolloff=2
set wildmode=longest,list
set showmatch matchtime=3
set modelines=2
set foldlevelstart=99 
set number
execute pathogen#infect()

set background=dark
set t_Co=256
colorscheme molokai
syntax on
filetype plugin indent on
"let g:rehash256 = 1
" set background black
hi Normal ctermbg=black

set hlsearch
autocmd FileType text setlocal textwidth=78
set cmdheight=2

" CFEngine syntax
au BufRead,BufNewFile *.cf.in set ft=cf3
au BufRead,BufNewFile *.cf set ft=cf3
let g:DisableCF3Ftplugin=1

" Mustache syntax
au BufRead,BufNewFile *.mustache set syntax=mustache

" JSON syntax
let g:vim_json_syntax_conceal = 0

" Terraform syntax
let g:terraform_align=1

" Jump to last losition when opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
