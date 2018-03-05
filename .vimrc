" PLUG
  call plug#begin('~/.config/nvim/plugged')

  " CODING "
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdcommenter'
    Plug 'bronson/vim-trailing-whitespace'

    " Snippets, Autocomplete and tab overload
    "Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup=1
    Plug 'zchee/deoplete-jedi'
    Plug 'shougo/neco-vim'
    Plug 'zchee/deoplete-zsh'
    Plug 'wellle/tmux-complete.vim'

    Plug 'shougo/echodoc'
    let g:echodoc#enable_at_startup=1

    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'

    " UltiSnips setup
    let g:UltiSnipsExpandTrigger='<c-j>'
    let g:UltiSnipsJumpForwardTrigger='<c-n>'
    let g:UltiSnipsJumpBackwardTrigger='<c-p>'
    let g:UltiSnipsSnippetsDir='~/.config/nvim/plugged/vim-snippets/UltiSnips'

    set relativenumber
    Plug 'junegunn/vim-easy-align'

  " INTERFACE "
    Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup=1
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline_section_z='%l/%L:%c'
    let g:airline_section_x='.%y'

    Plug 'airblade/vim-gitgutter'
    nmap ]h <Plug>GitGutterNextHunk
    nmap [h <Plug>GitGutterPrevHunk
    nmap <Leader>hr <Plug>GitGutterUndoHunk

  " CODE STYLE "
    Plug 'chiel92/vim-autoformat'
    Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled=['latex']

  " FILE EXTENSIONS "
    Plug 'elzr/vim-json'
    let g:vim_json_syntax_conceal=1
    " Python folding "
    Plug 'tmhedberg/simpylfold'
    Plug 'JamshedVesuna/vim-markdown-preview'
    let vim_markdown_preview_github=1
    let vim_markdown_preview_toggle=2

  " THEME "
    Plug 'dracula/vim'
    syntax on
    set t_Co=256
    colorscheme dracula
    let g:airline_theme='dracula'
    "Plug 'altercation/vim-colors-solarized'
    "Plug 'nlknguyen/papercolor-theme'
    "set background=light
    "colorscheme PaperColor
    "let g:airline_theme='papercolor'

  " TOOLS "
    Plug 'tpope/vim-fugitive'
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-rhubarb'
    Plug 'xolox/vim-notes'
    Plug 'xolox/vim-misc'
    let g:notes_directories=['~/Dropbox/notes']
    let g:notes_suffix='.notes'

    Plug 'othree/html5.vim'
    Plug 'lervag/vimtex'
    augroup vimtex
      autocmd!
      autocmd BufWritePost *.tex call vimtex#toc#refresh()
    augroup END


    Plug 'amperser/proselint'
    Plug 'w0rp/ale'
    let g:airline#extensions#ale#enabled=1
    nmap <silent> [e <Plug>(ale_previous_wrap)
    nmap <silent> ]e <Plug>(ale_next_wrap)
    set statusline=%{fugitive#statusline()}+statusline

    Plug 'mileszs/ack.vim'
    let g:ackprg='ag --vimgrep'

    Plug 'janko-m/vim-test'
    let test#python#runner='pytest'
    nmap <silent> <leader>T :TestFile<CR>
    nmap <silent> <leader>t :TestNearest<CR>
    nmap <silent> <leader>tl :TestLast<CR>

    Plug 'rhysd/vim-grammarous'
    Plug 'rizzatti/dash.vim'

  " NAVIGATION "
    Plug 'xolox/vim-easytags'
    let g:easytags_async=1
    let g:easytags_cmd='/usr/local/bin/ctags'
    let g:easytags_languages={
    \   'latex': {
    \     'cmd': g:easytags_cmd,
    \        'args': [],
    \        'fileoutput_opt': '-f',
    \        'stdout_opt': '-f-',
    \        'recurse_flag': '-R'
    \   }
    \}
    Plug 'easymotion/vim-easymotion'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'majutsushi/tagbar'
    let g:tagbar_type_latex={
    \ 'ctagstype': 'latex',
    \ 'kinds' : [
        \'l:labels',
        \'s:sections',
        \'ss:subsections',
        \'sss:subsubsections'
    \]
    \}

  call plug#end()


" INTERFACE
  set cursorline

" GENERAL LAYOUT
  set splitbelow
  set splitright

" CODING LAYOUT "
  set tabstop=4 " the visible width of tabs
  set expandtab
  set copyindent
  set autoindent
  set shiftwidth=4
  set colorcolumn=180
  set showmode
  set nowrap " No Wrap lines

" CODING HELPERS
  set ai " Auto indent
  set si " Smart indent
  set foldmethod=indent
  set foldnestmax=10

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
  nmap <Leader><Leader>g :!gitup<CR>

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
  set wildignore+=*.aux,*.fls,*.out,*.bbl,*.bcf,*.blg,*.latexmain,*.upa,*.upb,*.dvi,*.fdb_latexmk

" PERFORMANCE "
  set lazyredraw
