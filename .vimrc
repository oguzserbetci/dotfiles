" PLUG
  call plug#begin('~/.config/nvim/plugged')

  " CODING "
    Plug 'Valloric/YouCompleteMe'
    Plug 'tpope/vim-surround'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'ervandew/supertab'
    Plug 'bronson/vim-trailing-whitespace'

    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

    " better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    set relativenumber
    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    Plug 'junegunn/vim-easy-align'

  " INTERFACE "
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline_section_z = '%l/%L:%c'
    let g:airline_section_x = '.%y'

    Plug 'airblade/vim-gitgutter'
    nmap ]h <Plug>GitGutterNextHunk
    nmap [h <Plug>GitGutterPrevHunk
    nmap <Leader>hr <Plug>GitGutterUndoHunk

    Plug 'scrooloose/nerdtree'
    Plug 'majutsushi/tagbar'

  " CODE STYLE "
    Plug 'chiel92/vim-autoformat'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'sheerun/vim-polyglot'

  " FILE EXTENSIONS "
    Plug 'elzr/vim-json'
    let g:vim_json_syntax_conceal = 1
    " Python folding "
    Plug 'tmhedberg/simpylfold'

  " THEME "
    "Plug 'dracula/vim'
    "syntax on
    "set t_Co=256
    "colorscheme dracula
    Plug 'altercation/vim-colors-solarized'
    Plug 'nlknguyen/papercolor-theme'
    set background=light
    colorscheme PaperColor
    let g:airline_theme='papercolor'

  " TOOLS "
    Plug 'tpope/vim-fugitive'
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-rhubarb'
    Plug 'xolox/vim-notes'
    Plug 'xolox/vim-misc'
    let g:notes_directories = ['~/Dropbox/notes']
    let g:notes_suffix = '.notes'

    Plug 'othree/html5.vim'
    Plug 'jcf/vim-latex'
    Plug 'scrooloose/syntastic'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    Plug 'mileszs/ack.vim'
    let g:ackprg = 'ag --vimgrep'

    Plug 'janko-m/vim-test'
    nmap <silent> <leader>T :TestFile<CR>
    nmap <silent> <leader>t :TestNearest<CR>
    nmap <silent> <leader>tl :TestLast<CR>

    Plug 'rhysd/vim-grammarous'

  " NAVIGATION "
    Plug 'xolox/vim-easytags'
    let g:easytags_cmd = '/usr/local/bin/ctags'
    let g:easytags_languages = {
    \   'latex': {
    \     'cmd': g:easytags_cmd,
    \        'args': [],
    \        'fileoutput_opt': '-f',
    \        'stdout_opt': '-f-',
    \        'recurse_flag': '-R'
    \   }
    \}
    Plug 'easymotion/vim-easymotion'
    Plug 'majutsushi/tagbar'
    let g:tagbar_type_latex = {
    \ 'ctagstype': 'latex',
    \ 'kinds' : [
        \'l:labels',
        \'s:sections',
        \'ss:subsections',
        \'sss:subsubsections'
    \]
    \}

  call plug#end()

" GENERAL LAYOUT
  set splitbelow
  set splitright

" CODING LAYOUT "
  set tabstop=4 " the visible width of tabs
  set copyindent
  set colorcolumn=180
  set showmode
  set nowrap " No Wrap lines

" CODING HELPERS
  set ai " Auto indent
  set si " Smart indent
  set foldmethod=indent
  set foldnestmax=10

" CODING PREFS
  set autoindent
  set expandtab
  set tabstop=4
  set shiftwidth=4

" SETUP "
  set mouse=a
  set undolevels=1000
  set ignorecase
  set wildignorecase
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

" FILE SETTINGS "
  filetype on
  filetype plugin indent on
  let g:tex_flavor='latex'
