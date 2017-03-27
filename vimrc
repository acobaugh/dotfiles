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

execute pathogen#infect('plugins/{}')

set background=dark
colorscheme solarized

syntax on
set hlsearch
filetype plugin indent on
autocmd FileType text setlocal textwidth=78
set cmdheight=2

au BufRead,BufNewFile *.cf.in set ft=cf3
au BufRead,BufNewFile *.cf set ft=cf3
let g:DisableCF3Ftplugin=1

au BufRead,BufNewFile *.mustache set syntax=mustache

let g:vim_json_syntax_conceal = 0
