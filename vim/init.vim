" PLUG
  call plug#begin('~/.config/nvim/plugged')

  " CODING "
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdcommenter'

    Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger='<c-j>'
    let g:UltiSnipsJumpForwardTrigger='<c-b>'
    let g:UltiSnipsJumpBackwardTrigger='<c-z>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips']

    " Snippets
    Plug 'honza/vim-snippets'

    " Autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup=1
    "autocmd CompleteDone * silent! pclose!
    Plug 'zchee/deoplete-jedi'
    let g:deoplete#sources#jedi#show_docstring=1
    let g:deoplete#sources#jedi#python_path=$HOME . '/.pyenv/.shims/python'
    Plug 'shougo/neco-vim'
    Plug 'wellle/tmux-complete.vim'

  " INTERFACE "
    Plug 'Yggdroot/indentLine'
    let g:indentLine_char = '▏'
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
    Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled=['latex']

  " FILE EXTENSIONS "
    Plug 'elzr/vim-json'
    let g:vim_json_syntax_conceal=1
    Plug 'konfekt/fastfold'
    nmap zuz <Plug>(FastFoldUpdate)
    let g:fastfold_savehook = 1

    " Python "
        Plug 'tmhedberg/simpylfold', {'for': ['python', 'python3']}
        let g:SimpylFold_docstring_preview=1

        Plug 'vim-python/python-syntax', {'for': ['python', 'python3']}

    Plug 'JamshedVesuna/vim-markdown-preview'
    let vim_markdown_preview_github=1
    let vim_markdown_preview_toggle=2

  " THEME "
    Plug 'dracula/vim', { 'as': 'dracula' }

  " TOOLS "
    Plug 'tpope/vim-fugitive'

    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    let g:vimwiki_folding='list'
    let g:vimwiki_list = [{
      \ 'path': '$HOME/notes/',
      \ 'template_path': '$HOME/Dropbox/notes/templates',
      \ 'template_default': 'default',
      \ 'path_html': '$HOME/notes/html/',
      \ 'template_ext': '.html'}]
    nmap <Leader>wg ':VimwikiGoto '

    set nocompatible

    Plug 'othree/html5.vim'
    Plug 'lervag/vimtex'
    augroup vimtex
      autocmd!
      autocmd BufWritePost *.tex call vimtex#toc#refresh()
    augroup END


    Plug 'w0rp/ale'
    let g:airline#extensions#ale#enabled=1
    let virtual_env_path = $HOME . '/.pyenv/versions/neovim3/bin/'
    let g:ale_lint_on_save=1
    let g:ale_lint_on_text_changed=0
    let g:ale_fixers = {'python': ['black', 'trim_whitespace', 'isort']}
    let g:ale_python_black_executable = virtual_env_path . 'black'
    let g:ale_python_isort_executable = virtual_env_path . 'isort'
    let g:ale_linters = {'python': ['pylint']}
    "let g:ale_linters = {'python': ['prospector', 'pycodestyle', 'pylint']}
    "let g:ale_python_prospector_executable = virtual_env_path . 'prospector'
    "let g:ale_python_pycodestyle_executable = virtual_env_path . 'pycodestyle'
    let g:ale_python_pylint_executable = virtual_env_path . 'pylint'
    nmap <silent> [e <Plug>(ale_previous_wrap)
    nmap <silent> ]e <Plug>(ale_next_wrap)
    set statusline=%{fugitive#statusline()}+statusline

    Plug 'janko-m/vim-test'
    let test#python#runner='pytest'
    nmap <silent> <leader>T :TestFile<CR>
    nmap <silent> <leader>t :TestNearest<CR>
    nmap <silent> <leader>tl :TestLast<CR>

    Plug 'rhysd/vim-grammarous'

  " NAVIGATION "
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    " Advanced customization using autoload functions
    inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
    Plug 'easymotion/vim-easymotion'
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'scrooloose/nerdtree'

  call plug#end()

" SYSTEM
  let g:python3_host_prog = '/Users/oguz/.pyenv/versions/neovim3/bin/python'
  let g:python_host_prog = '/Users/oguz/.pyenv/versions/neovim2/bin/python'

" INTERFACE
  set cursorline
  syntax on
  set t_Co=256
  colorscheme dracula
  set termguicolors
  let g:airline_theme='dracula'

  " Italics
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    let g:dracula_italic = 1

" GENERAL LAYOUT
  set splitbelow
  set splitright
  set relativenumber

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

  " INDENT
    set foldmethod=indent
    set foldnestmax=10
    " Enable folding with the spacebar
    nnoremap <space> za

" SETUP "
  set mouse=a
  set undolevels=1000
  set number
  set ruler
  set showcmd
  set clipboard+=unnamedplus
  set encoding=utf-8
  set autochdir

" SEARCH "
  set ignorecase
  set wildignorecase
  set hlsearch
  set incsearch
  set wildmode=longest,list,full
  set wildmenu

" MAPS "
  nnoremap ; :
  imap jk <esc>
  map <Up>   <C-W>k
  map <Down> <C-W>j
  map <Left> <C-W>h
  map <Right> <C-W>l
  nmap <Leader>gg :silent !gitup<CR>
  nmap <Leader>gc :Gcommit -m
  nmap <Leader>gs :Gstatus<CR>

" PANES
  set splitbelow
  set splitright

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
  set wildignore+=*.aux,*.fls,*.out,*.bbl,*.bcf,*.blg,*.latexmain,*.upa,*.upb,*.dvi,*.fdb_latexmk,*.pdf,*.ipynb

" PERFORMANCE "
  set lazyredraw
