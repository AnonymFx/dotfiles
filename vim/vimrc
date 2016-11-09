" Default location: ~/.vimrc
" ------------------ Plugins ----------------------------------
" Pathogen package manager
execute pathogen#infect()
" Airline
" show always
set laststatus=2
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
nmap <C-space> <Plug>Tex_FastEnvironmentInsert 
" SimpylFold
let g:SimpylFold_docstring_preview=1
" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<tab>'
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
nnoremap <C-A-d> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <C-A-r> :YcmCompleter GoToReferences<CR>
let g:EclimCompletionMethod = 'omnifunc' " Use omnifunc for completion
" autoformat
noremap <C-A-l> :Autoformat<CR>
" Virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" python-import
" Autocomplete
let g:PythonAutoAddImports = 1
" vim-router
let g:rooter_change_directory_for_non_project_files = 'current'


" -------------------------- Genearl ----------------------------
set nocompatible 
syntax on
set number
set relativenumber
set ic " case insensitive search

" Indent configuration
filetype plugin indent on
set tabstop=4
set shiftwidth=0
set smarttab
set expandtab
set autoindent
set breakindent

" Search
set ignorecase
set smartcase
set gdefault


" ------------------- Key bindings -----------------------------
" New line without insert
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<ESC>j
" Split switches
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-h> <C-W><C-H>
nnoremap <A-l> <C-W><C-L>
" Ctrl+s for saving
nnoremap <C-s> :w<Enter>
" Delete entire words in insert mode with Ctrl+Backspace
inoremap <C-BS> <C-W>
" Switch tabs with Ctrl+tab
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>
" Keybinding for yanking and pasting from system keyboard
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>y "+y
" resize horizontal splits
nnoremap <C-S-r>p :res +5<CR>
nnoremap <C-S-r>m :res -5<CR>
"resize vertical splits
nnoremap <C-r>p :vertical resize +5<CR>
nnoremap <C-r>m :vertical resize -5<CR>


" --------------------- Appearance ---------------------------
" Good color alts: monokai (sublime default), one (atom default), OceanicNext
colo OceanicNext
" used for OceanicNext theme
set t_Co=256
set background=dark

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set spell

" --------------------- Functions ----------------------------
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
