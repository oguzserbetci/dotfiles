" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')


" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" INTERFACE "
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim'
Plug 'airblade/vim-gitgutter'

" CODE STYLE "
Plug 'chiel92/vim-autoformat'

" TOOLS "
Plug 'tpope/vim-fugitive'

Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
:let g:notes_directories = ['~/Dropbox/notes']

Plug 'othree/html5.vim'
Plug 'jcf/vim-latex'
Plug 'scrooloose/syntastic'

" Initialize plugin system
call plug#end()

" SETUP "
set ignorecase
set number
set ruler
set showcmd

" SHORTCUTS "
nnoremap ; :

" relative numbering "
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

nnoremap <leader>r :call NumberToggle()<cr>

