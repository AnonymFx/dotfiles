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
" SimpylFold
let g:SimpylFold_docstring_preview=1
" YouCompleteMe
" Virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" ------- Default vim -------
" Use default clipboard
" set clipboard=unnamedplus
set nocompatible 
syntax on
set number
set relativenumber

" Indent configuration
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent

" Search
set ignorecase
set smartcase
set gdefault

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
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>
" Delete without yanking
noremap <leader>d "_d
" Ctrl+Shift+b for building
noremap <C-S-b> :w<CR>:!make<CR>
" Keybinding for yanking and pasting from system keyboard
noremap <leader>p "+p
noremap <leader>y "+y
" resize horizontal splits
nnoremap <C-S-r>p :res +5<CR>
nnoremap <C-S-r>m :res -5<CR>
"resize vertical splits
nnoremap <C-r>p :vertical resize +5<CR>
nnoremap <C-r>m :vertical resize -5<CR>
" Autocomplete for vim-latex
nmap <C-space> <Plug>Tex_FastEnvironmentInsert
" Go to definition for YouCompleteMe
nnoremap <C-A-d> :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

" ------- Functions --------
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
