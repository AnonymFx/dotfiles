" ------- Plugins -------
" Pathogen package manager
execute pathogen#infect()
" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g_ctrlp_working_path_mode = 'ra'


" ------- Default vim -------
" Use default clipboard
set clipboard=unnamedplus
set nocompatible 
syntax on

" Indent configuration
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set nu
set autoindent

" ------- Key bindings -------
" New line without insert
nmap oo o<Esc>k
nmap OO O<ESC>j
imap <C-BS> <C-W>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nmap <A-b> ?\sclass\s<Enter>^


" ------- GVim options -------
" Good color alts: monokai (sublime default), one (atom default)
colo one 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set spell
