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
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'francoiscabrol/ranger.vim'
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
nmap <A-Q> :call DoExit()<CR>
function! DoExit()
    if g:confirmexit == 0 || confirm("Overwrite Session.vim?", "&y\n&N", 2) == 1
        execute "mks!"
        execute "qa!"
    endif
endfunction
au VimEnter * call DecideSessionProtection()
function! DecideSessionProtection()
    let g:confirmexit = 0
    let l:argv = split(readfile("/proc/".getpid()."/cmdline", "b")[0], "\0")
    let l:hassess = index(systemlist("ls"), "Session.vim") != -1
    if l:hassess && index(l:argv, "Session.vim") == -1
        let g:confirmexit = 1
    endif
endfunction

" environment
set shell=bash


" navigation
" cursor in middle when scrolling
nnoremap <C-e> <C-u>zz
" also in visual mode
vnoremap <C-e> <C-u>zz
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
" new split
nnoremap <C-n> :vnew<CR>
nnoremap <A-n> :vsplit<CR>
nnoremap <C-m> :new<CR>
nnoremap <A-m> :split<CR>
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
" move split to new tab and vice versa
nnoremap <A-t> <C-w>T
nnoremap <C-A-t> :Tabmerge<CR>
" reopen closed file to a split
nnoremap <A-T> :call RestoreClosedFile()<CR>
" resize split
nnoremap <silent> <C-A-h> :vertical resize -2<CR>
nnoremap <silent> <C-A-j> :resize +2<CR>
nnoremap <silent> <C-A-k> :resize -2<CR>
nnoremap <silent> <C-A-l> :vertical resize +2<CR>
" keep track of previously closed buffers
let g:lastbufs = []
function! UpdateClosedBuffers()
    let l:closedbuf = expand('%p')
    if l:closedbuf !~ '^term://' && l:closedbuf != '' && index(g:lastbufs, l:closedbuf) == -1
        call add(g:lastbufs, l:closedbuf)
    endif
endfunction
" also called when not closing a buffer, cleanup handled separately
au BufLeave * call UpdateClosedBuffers()
" remove entry for the previous tab
au TabNewEntered * let g:lastbufs = g:lastbufs[:-2]
function! RestoreClosedFile()
    if len(g:lastbufs) != 0
        let l:closedbuf = g:lastbufs[-1]
        let g:lastbufs = g:lastbufs[:-2]
        vnew
        execute 'buffer ' . l:closedbuf
        " remove entry for the previous buffer
        let g:lastbufs = g:lastbufs[:-2]
    endif
endfunction


" styles
colorscheme molokai


" indent guides
au TermOpen * execute 'IndentGuidesDisable'
au TermClose * execute 'IndentGuidesEnable'
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


" ranger.vim
:nmap <A-p> :tab split<CR>:Ranger<CR>
:nmap <C-p> :Ranger<CR>


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
