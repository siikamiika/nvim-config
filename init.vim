" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'justinmk/molokai'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-python/python-syntax'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-commentary'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'siikamiika/ranger.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/Tabmerge'
Plugin 'dense-analysis/ale'
Plugin 'itchyny/vim-cursorword'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'FooSoft/vim-argwrap'
" Plugin 'ambv/black'
Plugin 'Shougo/deoplete.nvim'
Plugin 'mileszs/ack.vim'
Plugin 'siikamiika/php.vim'
Plugin 'jwalton512/vim-blade'
Plugin 'editorconfig/editorconfig-vim'
" Plugin 'jparise/vim-graphql'
Plugin 'leafgarland/typescript-vim'
Plugin 'MaxMellon/vim-jsx-pretty'


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
    if len(filter(map(getbufinfo(), 'v:val.changed'), 'v:val')) == 0 || confirm("Discard changes?", "&y\n&N", 2) == 1
        if g:confirmoverwrite == 0 || confirm("Overwrite Session.vim?", "&y\n&N", 2) == 1
            execute "mks!"
            execute "qa!"
        endif
    endif
endfunction
au VimEnter * call DecideSessionProtection()
function! DecideSessionProtection()
    let g:confirmoverwrite = 0
    let l:argv = split(readfile("/proc/".getpid()."/cmdline", "b")[0], "\0")
    let l:sessionexists = index(systemlist("ls"), "Session.vim") != -1
    if l:sessionexists && index(l:argv, "Session.vim") == -1
        let g:confirmoverwrite = 1
    endif
endfunction


" environment
set shell=bash


" file
set fileencodings=ucs-bom,utf-8,shift-jis,gbk,default,latin1


" navigation
" space between cursor and up/down
set scrolloff=5
" scroll with cursor
nnoremap <silent> <C-d> :call ScrollCursor('d', 1)<CR>
nnoremap <silent> <C-u> :call ScrollCursor('u', 1)<CR>
nnoremap <silent> <C-e> :call ScrollCursor('u', 1)<CR>
nnoremap <silent> <A-d> :call ScrollCursor('d', 0)<CR>
nnoremap <silent> <A-u> :call ScrollCursor('u', 0)<CR>
nnoremap <silent> <A-e> :call ScrollCursor('u', 0)<CR>
vnoremap <silent> <C-e> <C-u>
function! ScrollCursor(dir, half)
    let l:dir = a:dir == 'u' ? 'k' : 'j'
    let l:height = winheight('%') / (a:half ? 2 : 1)
    " fix issue with scrolloff by going a bit at a time
    while l:height
        let l:motion = l:height > 5 ? 5 : l:height
        execute "normal ".l:motion.l:dir
        let l:height -= l:motion
    endwhile
endfunction
" cursor in middle when searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
" horizontal scrolling
nnoremap L zL
nnoremap H zH
" next location (inverse of <C-o>)
nnoremap <C-k> <C-i>


" keybinds
map <F8> :TagbarOpenAutoClose<CR>


" for visual mode
vnoremap // y/<C-r>"<CR>


" commands
set history=100


" display
set ruler
set showcmd
set cursorline
" some bug makes cursorline turn all syntax white without this
au VimEnter * execute 'hi CursorLine ctermfg=none ctermbg=233'
au VimEnter * execute 'hi CursorLine guifg=none guibg=233'
set number
set relativenumber
set nowrap
set list listchars=tab:\ \ ,trail:·,nbsp:·,precedes:<,extends:>
set display+=uhex
syntax on
set lazyredraw
nnoremap <silent> <C-l> :nohl<CR><C-l>


" font
set guifont="Sarasa Term J:pixelsize=14"


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
" preserve visual mode when changing indentation
vnoremap < <gv
vnoremap > >gv


" clipboard
set clipboard=unnamedplus


" tabs and splits
set splitbelow
set splitright
nnoremap <C-t> :tabnew<CR>
nnoremap <A-t> :tab split<CR>
" new split
nnoremap <C-n> :vnew<CR>
nnoremap <A-n> :vsplit<CR>
nnoremap <C-m> :new<CR>
nnoremap <A-m> :split<CR>
" terminal
nnoremap <C-A-n> :vnew<CR>:term fish<CR>i
nnoremap <C-A-m> :new<CR>:term fish<CR>i
tmap <C-A-n> <C-\><C-n>:vnew<CR>:term fish<CR>i
tmap <C-A-m> <C-\><C-n>:new<CR>:term fish<CR>i
tmap <A-h> <C-\><C-n><A-h>
tmap <A-j> <C-\><C-n><A-j>
tmap <A-k> <C-\><C-n><A-k>
tmap <A-l> <C-\><C-n><A-l>
" close tab or window
nnoremap <silent> <C-w> :call BeforeClosingWindow()<CR><C-w>q:call AfterClosingWindow()<CR>
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
nnoremap <C-y> <C-w>T
nnoremap <C-A-y> :Tabmerge<CR>
" reopen closed window
nnoremap <A-T> :call RestoreClosedWindow()<CR>
" resize split
nnoremap <silent> <C-A-h> :vertical resize -2<CR>
nnoremap <silent> <C-A-j> :resize +2<CR>
nnoremap <silent> <C-A-k> :resize -2<CR>
nnoremap <silent> <C-A-l> :vertical resize +2<CR>
" keep track of previously closed windows
let g:lastwindows = []
function! BeforeClosingWindow()
    let l:type = winnr('$') == 1
    " if tab was closed, use it to do tabprev
    let g:tabclosed = l:type && tabpagenr() != tabpagenr('$')
    let l:win = expand('%p')
    for i in range(2)
        let l:idx = index(g:lastwindows, [l:win, i])
        if l:idx != -1
            call remove(g:lastwindows, l:idx)
        endif
    endfor
    call add(g:lastwindows, [l:win, l:type])
endfunction
function! AfterClosingWindow()
    if g:tabclosed
        execute 'tabprevious'
    endif
endfunction
function! RestoreClosedWindow()
    if len(g:lastwindows) != 0
        let l:closed = g:lastwindows[-1]
        let g:lastwindows = g:lastwindows[:-2]
        if l:closed[1]
            tabnew
        else
            vnew
        endif
        execute 'buffer ' . l:closed[0]
    endif
endfunction

function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction


" tab title
let g:lightline = {
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabname'
      \  }
      \ }
function LightlineTabname(n)
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:parts = split(bufname(l:buflist[l:winnr - 1]), '/')
    if len(l:parts) > 1
        return l:parts[-2] . '/' . l:parts[-1]
    elseif len(l:parts) == 1
        return l:parts[0]
    else
        return '[No Name]'
    endif
endfunction


" styles
colorscheme molokai


" linting
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1


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
let g:tagbar_autofocus = 1


" ranger.vim
nmap <A-p> :Ranger<CR>


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

let g:deoplete#enable_at_startup = 1

let g:ackprg = 'rg --vimgrep --smart-case'
nnoremap <A-f> :Ack! 
function! AckClipboard()
    execute printf('Ack! -F -- "%s"', substitute(@", '\([%"\$\\]\)', '\\\1', 'g'))
endfunction
vnoremap <A-f> y:call AckClipboard()<CR>
