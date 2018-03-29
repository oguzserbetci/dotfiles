" PLUG
  call plug#begin('~/.config/nvim/plugged')

  " CODING "
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdcommenter'
    Plug 'bronson/vim-trailing-whitespace'

    Plug 'sirver/ultisnips'

    " Autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup=1
    autocmd CompleteDone * silent! pclose!
    Plug 'zchee/deoplete-jedi'
    Plug 'shougo/neco-vim'
    Plug 'zchee/deoplete-zsh'
    Plug 'wellle/tmux-complete.vim'

    let g:jedi#auto_vim_configuration = 0
    let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
    let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
    let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
    let g:jedi#rename_command = '<Leader>gR'
    let g:jedi#usages_command = '<Leader>gu'
    let g:jedi#smart_auto_mappings = 1

    " Unite/ref and pydoc are more useful.
    let g:jedi#documentation_command = '<Leader>_K'
    let g:jedi#auto_close_doc = 1

    Plug 'shougo/echodoc'
    set noshowmode
    let g:echodoc#enable_at_startup=1

    Plug 'fisadev/FixedTaskList.vim'

    " Snippets
    Plug 'honza/vim-snippets'

    " UltiSnips setup
    let g:UltiSnipsExpandTrigger='<c-j>'
    let g:UltiSnipsJumpForwardTrigger='<c-n>'
    let g:UltiSnipsJumpBackwardTrigger='<c-p>'
    let g:UltiSnipsSnippetsDir='~/.config/nvim/plugged/vim-snippets/UltiSnips'

    set relativenumber
    Plug 'junegunn/vim-easy-align'

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

    Plug 'yuttie/comfortable-motion.vim'
    let g:comfortable_motion_scroll_down_key = "j"
    let g:comfortable_motion_scroll_up_key = "k"
    nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
    nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
    nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

  " CODE STYLE "
    Plug 'chiel92/vim-autoformat'
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
        Plug 'hynek/vim-python-pep8-indent', {'for': ['python', 'python3']}
        let python_highlight_all=1


    Plug 'JamshedVesuna/vim-markdown-preview'
    let vim_markdown_preview_github=1
    let vim_markdown_preview_toggle=2

  " THEME "
    Plug 'dracula/vim'
    syntax on
    set t_Co=256
    colorscheme dracula
    let g:airline_theme='dracula'

  " TOOLS "
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'xolox/vim-misc'
    let g:notes_directories=['~/Dropbox/notes']
    let g:notes_suffix='.notes'

    Plug 'vimwiki/vimwiki'
    let g:vimwiki_list = [{
      \ 'path': '$HOME/notes/',
      \ 'template_path': '$HOME/notes/templates',
      \ 'template_default': 'default',
      \ 'template_ext': '.html'}]

    set nocompatible

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
    Plug '/usr/local/opt/fzf'
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

    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    Plug 'Xuyuanp/nerdtree-git-plugin'
    let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

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

" SYSTEM
  let g:python3_host_prog = '/Users/oguzserbetci/.pyenv/versions/neovim3/bin/python'
  let g:python_host_prog = '/Users/oguzserbetci/.pyenv/versions/neovim2/bin/python'

" INTERFACE
  set cursorline

  " Italics
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    let g:dracula_italic = 1

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

" SHORTCUTS "
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
  set wildignore+=*.aux,*.fls,*.out,*.bbl,*.bcf,*.blg,*.latexmain,*.upa,*.upb,*.dvi,*.fdb_latexmk

" PERFORMANCE "
  set lazyredraw
