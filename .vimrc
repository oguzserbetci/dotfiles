" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" CODING "
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" INTERFACE "
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk

Plug 'scrooloose/nerdtree'

" CODE STYLE "
Plug 'chiel92/vim-autoformat'
Plug 'nathanaelkane/vim-indent-guides'


" TOOLS "
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-rhubarb'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
:let g:notes_directories = ['~/Dropbox/notes']
:let g:notes_suffix = '.notes'

Plug 'othree/html5.vim'
Plug 'jcf/vim-latex'
Plug 'scrooloose/syntastic'

let g:ackprg = 'ag --vimgrep'

" Initialize plugin system
call plug#end()

" THEME "
syntax enable
set background=dark
colorscheme solarized

" GENERAL LAYOUT
set splitbelow
set splitright

" CODING LAYOUT "
set tabstop=4                   " the visible width of tabs	
set copyindent 
set colorcolumn=180
set showmode
set nowrap  " No Wrap lines

" CODING HELPERS
set ai      " Auto indent
set si      " Smart indent
set foldmethod=syntax
set foldnestmax=10

" CODING PREFS
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" SETUP "
set mouse=a
set undolevels=1000
set ignorecase
set number
set ruler
set showcmd
set clipboard+=unnamedplus
set encoding=utf-8
set autochdir
set wildmode=longest,list,full
set wildmenu

" SHORTCUTS "
nnoremap ; :
imap jk <esc>
map <Up>   <C-W>k
map <Down> <C-W>j
map <Left> <C-W>h
map <Right> <C-W>l

" Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
		
" Vim’s “very magic” search mode
nnoremap / /\v
vnoremap / /\v
" For regular expressions turn magic on
set magic
