" To use vimrc:
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin(stdpath('data') . '/plugged')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind' ]}
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

set list
set listchars=trail:.

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
colorscheme onedark
let g:onedark_terminal_italics=1


" ----------------------------------------------------------------------------
"  spellcheck 
" ----------------------------------------------------------------------------
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell


" ----------------------------------------------------------------------------
"  vim-wiki 
" ----------------------------------------------------------------------------
function MakeAWiki(path, name, frequency)
  let wiki = {}
  let wiki.path = a:path 
  let wiki.name = a:name
  let wiki.syntax = 'markdown'
  let wiki.ext = 'md'
  let wiki.diary_index = 'notes'
  let wiki.diary_header = 'Notes'
  let wiki.diary_frequency = a:frequency
  return wiki
endfunction

autocmd BufNewFile,BufRead *.wiki set filetype=markdown
let wiki_1 = MakeAWiki('~/notes/personal', 'Grabbag', 'weekly')
let wiki_2 = MakeAWiki('~/notes/work/', 'Work', 'weekly')

let g:vimwiki_list = [wiki_1, wiki_2]


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


"———————————————————
" CoC — copied from https://github.com/neoclide/coc.nvim
"—————————————————————
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
