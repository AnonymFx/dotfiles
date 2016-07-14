" ------- Plugins -------
" Pathogen package manager
execute pathogen#infect()
" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g_ctrlp_working_path_mode = 'ra'
" Table Mode
let g:table_mode_header_fillchar= '='
" Vim-Latex
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

" ------- Default vim -------
" Use default clipboard
" set clipboard=unnamedplus
set nocompatible 
syntax on
set relativenumber

" Indent configuration
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set nu
set autoindent

" Search
set ignorecase
set smartcase

" Always show status line
set laststatus=2

" ------- Key bindings -------
" New line without insert
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<ESC>j
" Split switches
nnoremap <a-j> <C-W><C-J>
nnoremap <a-k> <C-W><C-K>
nnoremap <a-h> <C-W><C-H>
nnoremap <a-l> <C-W><C-L>
" go to next class definition
nnoremap <A-b> ?\sclass\s<Enter>
" Ctrl+s for saving
nnoremap <C-s> :w<Enter>
" Delete entire words in insert mode with Ctrl+Backspace
inoremap <C-BS> <C-W>
" Switch tabs with Ctrl+tab
noremap <C-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprevious<CR>
" Delete without yanking
noremap <leader>d "_d
" Ctrl+Shift+b for building
noremap <C-S-b> :w<CR>:make<CR>
" Keybinding for yanking and pasting from system keyboard
noremap <leader>p "+p
noremap <leader>y "+y
" Correct line movement with line wraps
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
" ------- Abbreviations -------
" If statements
iab iff if () {<CR>}<ESC>?if<CR>jdt}?(<CR>
iab ifelse if () {<CR>} else {<CR>}<Esc>kk^jdt}jdt}?(<CR>
iab beginenv \begin{}<CR>\end{}<Esc>?{<CR>n


" ------- GVim options -------
" Good color alts: monokai (sublime default), one (atom default)
colo one 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set spell
