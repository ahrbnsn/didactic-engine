" To use vimrc:
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin(stdpath('data') . '/plugged')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind' ]}
" Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
" Plug 'prettier/vim-prettier'
" Plug 'scrooloose/nerdcommenter'
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
" Plug 'sjl/gundo.vim'


" 
" Colors
"
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim' 


"
" Searching
"
Plug 'mileszs/ack.vim'
Plug 'epmatsw/ag.vim'
Plug 'tpope/vim-abolish'
Plug 'henrik/vim-qargs'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"
"
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'direnv/direnv.vim'

" Markdown
"
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'

"
" javascript
"
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.js,*.jsx,*.ts,*.tsx'
  
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-eslint']
"
"
" Tmux friendlyifier
"
Plug 'pivotal/tmux-config'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
"
let mapleader = ","
let maplocalleader = ";"

set clipboard=unnamed
set expandtab
set tabstop=2
set autoindent
set smarttab
set shiftwidth=2
set number
set nowrap
set backspace=indent,eol,start
set hidden " keep undo history when switching buffers

" set list
" set listchars=trail:.

set showmatch       " show matching brackets 
set splitright
set scrolloff=3
set incsearch

set noswapfile
set hls             " search with highlights


set ignorecase smartcase " case insensitive unless search has a capital

" Write all writeable buffers when changing buffers or losing focus.
set autowriteall                " Save when doing various buffer-switching things.
autocmd BufLeave * silent! wall  " Save anytime we leave a buffer
autocmd FocusLost * silent! wall  " Save anytime we leave a buffer

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('nvim')
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0 = '#4e4e4e'
  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'

  set fillchars=vert:\|,fold:-
  autocmd BufReadPost *
    \ if line("'\"")>= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else
  let g:terminal_ansi_colors = [
    \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
    \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
    \ '#626262', '#d75f87', '#87af87', '#ffd787',
    \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4']
endif 


" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

" Open new line below and above current line
nnoremap <leader>o o<esc>

" Make Y behave like other capitals
nnoremap Y y$

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/

" Split screen
map <leader>v   :vsp<CR>

" Move between screens
map <leader>w   ^Ww

" Auto-indent whole file
nmap <leader>=  gg=G``

" Fast scrollin
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" File tree browser
map \           :NERDTreeToggle<CR>

" File tree browser showing current file - pipe (shift-backslash)
map \|          :NERDTreeFind<CR>

" Open and close the quickfix window
map <leader>qo  :copen<CR>
map <leader>qc  :cclose<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv


" Git blame
map <leader>g   :Git blame<CR>

" Comment/uncomment lines
vmap <leader>/  gc
nmap <leader>/  gcc 

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" Copy current file path to system pasteboard
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>

map <leader>a :AV<CR>

" ctrlp
" <leader>f is the default trigger (set in init/ctrlp.vim)
nnoremap <silent> <leader>F :CtrlPClearAllCaches<CR>:CtrlPCurWD<CR>

" Additional mapping for buffer search
nnoremap <silent> <leader>bb :CtrlPBuffer<cr>
map <D-e> :CtrlPBuffer<CR>

" Map most recently used
nnoremap <silent> <C-p> :CtrlPMRU<cr>

" Cmd-Shift-P to clear the cache
nnoremap <silent> <D-P> :ClearCtrlPCache<cr>

" Press Space to turn off highlighting and clear any message already
" displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""


" I keep hitting _ when i am trying to hit w and save
cnoreabbrev <expr> _ ((getcmdtype() is# ':' && getcmdline() is# '_')?('w'):('W'))


" Open the url under the cursor w/ a browser
" https://stackoverflow.com/a/63352904
nmap <silent>gx :sil :!open <c-r><c-a>g


" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()
nnoremap <leader>O O<esc>


" ----------------------------------------------------------------------------
"  color scheme
" ----------------------------------------------------------------------------
set background=dark
syntax on
"silent! colorscheme Tomorrow-Night
"
" colorscheme onedark
" let g:onedark_terminal_italics=1
colorscheme tokyonight



" ----------------------------------------------------------------------------
"  spellcheck 
" ----------------------------------------------------------------------------
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell


" ----------------------------------------------------------------------------
"  vim-wiki 
" ----------------------------------------------------------------------------
" function MakeAWiki(path, name, frequency)
"   let wiki = {}
"   let wiki.path = a:path 
"   let wiki.name = a:name
"   let wiki.syntax = 'markdown'
"   let wiki.ext = 'md'
"   let wiki.diary_index = 'notes'
"   let wiki.diary_header = 'Notes'
"   let wiki.diary_frequency = a:frequency
"   return wiki
" endfunction

" autocmd BufNewFile,BufRead *.wiki set filetype=markdown
" let wiki_1 = MakeAWiki('~/notes/personal', 'Grabbag', 'weekly')
" let wiki_2 = MakeAWiki('~/notes/work/', 'Work', 'weekly')

" let g:vimwiki_list = [wiki_1, wiki_2]


" ----------------------------------------------------------------------------
"  vim-prettier 
" ----------------------------------------------------------------------------
" let g:prettier#autoformat = 0
" " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml Prettier

" au FileType *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html let b:prettier_exec_cmd = /"prettier-eslint"


" ----------------------------------------------------------------------------
"  whitespace stripping
" ----------------------------------------------------------------------------
function! StripTrailingWhitespace()
  let _save_cursor = getpos(".")
  silent! %s/\s\+$//
  call setpos('.', _save_cursor)
endfunction

autocmd BufWritePre *.{rb,yml,js,jsx,.ts,.tsx,css,scss,html} call StripTrailingWhitespace()


" ----------------------------------------------------------------------------
"  insert mode shifts stripping
" ----------------------------------------------------------------------------
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul

"
" ----------------------------------------------------------------------------
"  markdown settings
" ----------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.mdx set filetype=markdown
autocmd BufNewFile,BufRead *.wiki set filetype=markdown

" Open all folds in Markdown.
autocmd FileType markdown normal zR

" Soft wrap markdown
let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
augroup END


" ----------------------------------------------------------------------------
" ctrp settings
" ----------------------------------------------------------------------------
let g:ctrlp_map = '<leader>f'

" https://github.com/kien/ctrlp.vim/issues/174
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_mruf_relative = 1
let g:ctrlp_switch_buffer = 0

" ----------------------------------------------------------------------------
" mouse
" ----------------------------------------------------------------------------

set mouse=a

" ----------------------------------------------------------------------------
" GF mappings
" ----------------------------------------------------------------------------
function! SetUpEnvironment()
  let l:path = expand('%:p')
  if l:path =~ 'poodle'
    set wildignore+=**/node_modules/**
    setlocal includeexpr=substitute(v:fname,'\honeycombio\','packages','g') suffixesadd+=.ts,.tsx,.js,.jsx
    " setlocal includeexpr=substitute(v:fname,'honeycombio','packages','g') suffixesadd+=.ts,.tsx
  endif
endfunction

augroup js
  autocmd!
  autocmd FileType typescript call SetUpEnvironment() 
  autocmd FileType typescriptreact call SetUpEnvironment() 
  autocmd FileType javascript call SetUpEnvironment() 
augroup END

" ----------------------------------------------------------------------------
" Go stuff
" ----------------------------------------------------------------------------
" open extra info in popover window instead of seperate pane
let g:go_doc_popup_window = 1
let g:go_def_mode='godef'
let g:go_gocode_autobuild = 0


" ----------------------------------------------------------------------------
" Notes! 
" ----------------------------------------------------------------------------
"
lua require("notes")
