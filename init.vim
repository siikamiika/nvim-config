" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Plugin 'nanotech/jellybeans.vim'
" Plugin 'tomasr/molokai'
Plugin 'justinmk/molokai'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-python/python-syntax'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'mattn/emmet-vim'
Plugin 'vim-scripts/Tabmerge'
Plugin 'w0rp/ale'
Plugin 'itchyny/vim-cursorword'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'FooSoft/vim-argwrap'

call vundle#end()
filetype plugin indent on


" backup & save
set backupdir=~/.cache/nvim/backup
set dir=~/.cache/nvim/swap
set backup
set undofile
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>gv
inoremap <C-S> <C-O>:update<CR>

" exit
nmap <A-Q> :mks!<CR>:qa!<CR>


" navigation
" cursor in middle when scrolling
nnoremap <C-e> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
" ...searching
nnoremap n nzz
nnoremap N Nzz
" horizontal scrolling
nnoremap L zL
nnoremap H zH
" replacements for L/H (top/bottom)
nnoremap K H
nnoremap J L
" next location
nnoremap <C-k> <C-i>


" keybinds
map <F8> :TagbarToggle<CR>
map <A-e> :NERDTreeToggle<CR>
map <A-E> :NERDTreeFind<CR>


" for visual mode
vnoremap // y/<C-r>"<CR>


" commands
set history=50
nmap <A-r> :! urxvt -hold -e %:p<CR>
nmap <A-R> :! urxvt -hold -e %:p


" display
set ruler
set showcmd
set hlsearch
set number
set relativenumber
set nowrap
set list listchars=tab:\ \ ,trail:·,nbsp:·,precedes:<,extends:>
set display+=uhex
syntax on
nnoremap <silent> <C-l> :nohl<CR><C-l>


" search
set incsearch
set hlsearch
set ignorecase
set smartcase


" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


" clipboard
set clipboard=unnamedplus


" tabs and splits
set splitbelow
set splitright
nnoremap <C-t> :tabnew<CR>
" close tab or window
nnoremap <C-w> <C-w>q
" move between tabs
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
" move tabs
nnoremap <A-Tab> :tabmove +1<CR>
nnoremap <A-S-Tab> :tabmove -1<CR>
" move between splits
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" move split around
nnoremap <A-H> <C-w>H
nnoremap <A-J> <C-w>J
nnoremap <A-K> <C-w>K
nnoremap <A-L> <C-w>L
" move split to new tab
nnoremap <A-t> <C-w>T
" reopen closed file to a split
nnoremap <A-T> :vs<bar>:b#<CR>
" resize split
nnoremap <silent> <C-A-h> :vertical resize -2<CR>
nnoremap <silent> <C-A-j> :resize +2<CR>
nnoremap <silent> <C-A-k> :resize -2<CR>
nnoremap <silent> <C-A-l> :vertical resize +2<CR>


" mouse
" if has('mouse')
"     set mouse=a
" endif


" styles
colorscheme molokai


" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=236
hi IndentGuidesEven ctermbg=235


" comment
map <C-_> gcc
vmap <C-_> gc


" tagbar
let g:tagbar_sort = 0


" ctrlp
let g:ctrlp_match_current_file = 1


" tabular
" visual
vmap <Space>t: :Tabularize /:\zs/l0r1<CR>
vmap <Space>t, :Tabularize /,\zs/l0r1<CR>
vmap <Space>t= :Tabularize /=<CR>
vmap <Space>t? :Tabularize /
vmap <Space>t<Space> :Tabularize /^.\{-}\>\s\+\zs/l1r0<CR>
" normal
nmap <Space>t: :Tabularize /:\zs/l0r1<CR>
nmap <Space>t, :Tabularize /,\zs/l0r1<CR>
nmap <Space>t= :Tabularize /=<CR>
nmap <Space>t? :Tabularize /


" argwrap
nmap <Space>a :ArgWrap<CR>
