filetype off

set rtp+=~/.vim/bundle/vundle/  
call vundle#rc('~/.vim/bundle/')

Bundle 'gmarik/Vundle.vim'
Bundle 'UltiSnips'
Bundle 'mbriggs/mark.vim'
Bundle 'python.vim'
Bundle 'taglist.vim'
"Bundle 'The-NERD-Commenter'
"Bundle 'vimcn/NERD_commenter.cnx'
Bundle 'molokai'
Bundle 'a.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Markdown'
Bundle 'Markdown-syntax'
Bundle 'altercation/vim-colors-solarized'

let g:ycm_auto_start_csharp_server = 0
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

set history=100
filetype plugin on
filetype indent on 

set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
inoremap <S-Enter> <End><Enter>

command W w !sudo tee % > /dev/null

set so=7

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu

set guifont=Source\ Code\ Pro
set ruler 
set cmdheight=2
set hid 

set ignorecase
set smartcase
set hlsearch 
set incsearch 
set lazyredraw

set nocompatible
syntax on
set showcmd
set showmode
set magic
set guioptions-=T
set guioptions-=m
set number
set mouse=a

set tabstop=4
set smartindent
set autoindent
set cindent
set shiftwidth=4
set expandtab
set softtabstop=4
set et
set smarttab

"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"colo molokai
"let g:molokai_original=1

set background=dark
colo molokai
let g:solarized_termcolors=256

set t_Co=256


"start of map
nmap fd :YcmCompleter GoToDeclaration<CR>
nmap fi :YcmCompleter GoToDefinition<CR>
nmap <Space><Space> :silent! Tlist<CR>
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<Esc>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { {}<Esc>i
inoremap } <c-r>=ClosePair('}')<CR>

inoremap g <c-r>=RetPair()<CR>

function RetPair()
    if getline('.')[col('.') - 1] == "}" 
        return "\<CR>\<Esc>O"
    else 
        return "g"
    endif 
endfunction

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char 
        return "\<Right>"
    else 
        return a:char 
    endif 
endfunction

nmap mq <C-q>
nmap tn :bn<CR>
nmap tp :bp<CR>
nmap <Space>h <C-w>h
nmap <Space>l <C-w>l
nmap <Space>k <C-w>k
nmap <Space>j <C-w>j

map <leader>cd :cd %:p:h<cr>:pwd<cr>


autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%


map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>


" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

map 0 ^



" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

set tags=tags
set tags+=./tags
