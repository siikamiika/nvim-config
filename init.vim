" backup
set backupdir=~/.cache/nvim/backup
set dir=~/.cache/nvim/swap
set backup
set undofile

" commands
set history=50

" display
set ruler
set showcmd
set hlsearch
set number
set relativenumber
syntax on
nnoremap <silent> <C-l> :nohl<CR><C-l>

" search
set incsearch
set hlsearch

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" splits
set splitbelow
set splitright

" tabs
map <C-t> :tabnew<CR>
map <C-t> :tabnew<CR>
map <C-w> :tabclose<CR>
map <Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" mouse
if has('mouse')
    set mouse=a
endif

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'hdima/python-syntax'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

call vundle#end()
filetype plugin indent on

" styles
colorscheme molokai

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" comment
map <C-_> gcc
vmap <C-_> gc

" ctrlp & fzf
let g:ctrlp_cmd = 'Files'
