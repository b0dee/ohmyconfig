" ################################
" #                              #
" #      GENERAL SETTINGS        #
" #                              #
" ################################
syntax on                                              " Enable syntax highlighting
set updatetime=100
set conceallevel=2
filetype indent on                                     " Indent based on file type
" Set leader to space
let mapleader=" "
set confirm
set nostartofline
set noendofline
set pumheight=5                                        " Limit CoC to 5 sugestions
set signcolumn=yes                                     " Always show sign column
set tabstop=2 shiftwidth=2 softtabstop=2               " Indentation levels
set expandtab smarttab autoindent                      " Tab settings
set nobackup nowritebackup noundofile noswapfile       " Disable backups/swap files. We save often; VCS should be used for accidental edits/removals
set ignorecase smartcase incsearch hlsearch            " Text searching
set number relativenumber                              " Line Numbering
set wrap linebreak breakindent                         " Line wrapping - purely UI (not saved to file)
set showbreak=+++\                                     " When text is wrapped, prefix with '+++ ' to signify wrapping
set wildmode=list:full,full                        " Only affects command mode completion as CoC handles all other completions. Makes command mode completion work how we've configured CoC (tab auto select first option and fill)
set noruler
set completeopt=menuone,popup,noselect,noinsert " Auto-complete menu display settings
set complete-=i                                        " Stop Vim looking through header files for c lookups
set wildignore+=*.docx,*.jpg,*.png,*.gif,*.pdf         " Add to ignore list when searching for files/ content within files
set wildignore+=*.pyc,*.exe,*.flv,*.img,*.xlsx         " Above continued
set encoding=utf-8                                     " Document encoding
set path+=.,,**;                                       " Set path to be current dir, dir of current file and search them recursively
set laststatus=2                                       " Show status line at all times (regardless of # files open)
set colorcolumn=                                       " Set Colour Column line
set nospell                                            " Disable spell checking, we enable it ad-hoc when needed
set mouse=a                                            " Enable mouse support
set matchpairs+=<:>                                    " Enable matching for tags
set showmatch                                          " Show matching pairs of [],() and {} (and <> from above line)
set scroll=0                                           " Moves by 1/2 # of lines in window when using CTRL+D and CTRL+U
set ttyfast                                            " Enable fast scrolling
set background=dark
set viminfo='100,<9999,s100                            " Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set noshowmode                                         " No need to notify mode changes, we have them visible perma
set termguicolors                                      " Enable use of all colours
set textwidth=0
autocmd FileType markdown,txt set textwidth=80
set guicursor=n-v-c:block-Cursor,r-cr:hor30
set nocompatible
highlight SpellBad cterm=bold ctermbg=darkred          " Spelling error highlighting
let &t_SI = "\e[5 q"                                   " Blinking line in insert
let g:LargeFile=100                                    " Activate when file is > 100mb
set shiftround
autocmd GUIEnter * set vb t_vb= " Disable error bells and visual flash for GUI
autocmd VimEnter * set vb t_vb= " Same as above but terminal
let g:polyglot_disabled = ['markdown']

" ################################
" #                              #
" #           PLUGINS            #
" #                              #
" ################################
" Self install vim-plug if misssing
let data_dir = has('win32') ? $HOME.'/vimfiles/' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'idanarye/vim-merginal'

" Text Objects and Motions
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-jdaddy'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'

" Configuration Presets
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/LargeFile'

" Tools and Utilities
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-obsession'
Plug 'gcmt/taboo.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-vinegar'
Plug 'godlygeek/tabular' | Plug 'b0dee/vi-mark'
Plug 'LunarWatcher/auto-pairs'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-endwise'
Plug 'romainl/vim-qf'
Plug 'bfrg/vim-qf-preview'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'}
Plug 'mattn/calendar-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dhruvasagar/vim-zoom'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'b0dee/vim-bujo'
Plug 'airblade/vim-matchquote'
Plug 'machakann/vim-swap'
Plug 'matze/vim-move'
Plug 'puremourning/vimspector'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'
Plug 'bullets-vim/bullets.vim'
Plug 'kana/vim-textobj-line'

" UI
Plug 'markonm/traces.vim'
Plug 'itchyny/vim-cursorword'
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'
Plug 'b0dee/elevator.vim'
Plug 'sainnhe/sonokai'
Plug 'prisma/vim-prisma'

" Linux only 
if !has('win32')
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'
"Windows Only
else
  Plug 'vim-scripts/Windows-PowerShell-indent-enhanced' " Fixing problems
endif

call plug#end()

" Auto Update Plugins Monthly
function! OnVimEnter() abort
  if exists('g:plug_home')
    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
    if !filereadable(l:filename)
      call writefile([], l:filename)
    endif
    let l:this_month = strftime('%Y_%m')
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_month) < 0
      call execute('PlugUpdate')
      call writefile([l:this_month], l:filename, 'a')
    endif
  endif
endfunction

autocmd VimEnter * call OnVimEnter()


" ################################
" #                              #
" #    Plugin Customisation      #
" #                              #
" ################################

" Merginal
let g:merginal_resizeWindowToBranchLen = 1
let g:merginal_showCommands = 0

" Elevator
let g:elevator#timeout_msec = 0
let g:elevator#show_on_enter = v:true
let g:elevator#highlight = 'PmenuThumb'

" Fix comments in json files
autocmd FileType json syntax match Comment +\/\/.\+$+

" Colorscheme
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai

" Bookmarks
let g:bookmark_sign = '♥'

" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \	'operators': '_,_',
  \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \	'separately': {
  \		'*': {},
  \		'markdown': {
  \			'parentheses_options': 'containedin=markdownCode contained',
  \		},
  \		'lisp': {
  \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
  \		},
  \		'haskell': {
  \			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
  \		},
  \		'vim': {
  \			'parentheses_options': 'containedin=vimFuncBody',
  \		},
  \		'perl': {
  \			'syn_name_prefix': 'perlBlockFoldRainbow',
  \		},
  \		'stylus': {
  \			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
  \		},
  \		'css': 0,
  \	},
\ }

" Status Line
let g:lightline = {
  \ 'colorscheme': 'sonokai',
  \ 'active': {
  \   'left': [ [ 'mode', 'zoomed', 'paste' ], [ 'gitbranch' ], [ 'readonly', 'pwd', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'filetype', 'fileencoding', 'fileformat', 'journal'],  [ 'lineinfo', 'percent' ]],
  \ },
  \ 'inactive': {
  \   'left': [ [ 'readonly', 'pwd', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo', 'percent' ], []],
  \ },
  \ 'component_function': {
  \   'journal': 'BujoHead',
  \   'gitbranch':'FugitiveHead',
  \   'pwd': 'RelativeOrAbsolutePath',
  \   'zoomed': "zoom#statusline"
  \ },
  \ 'component': {
  \   'lineinfo': '%3l:%-2v%<',
  \ },
  \ 'tabline': {
  \   'left': [ [ 'tabs' ] ],
  \   'right': [ [ ] ],
  \ }
\ }


" QF Preview
let g:qfpreview = {
  \ 'close':"\<Esc>",
  \ 'next':'j',
  \ 'previous':'k'
\}

augroup qfpreview
  autocmd!
  " Preview quickfix under cursor
  autocmd FileType qf nmap <silent><buffer> p <plug>(qf-preview-open)
  autocmd FileType qf nmap <silent><buffer> <Esc> :cclose<CR>
  autocmd FileType qf nmap <silent><buffer> q :cclose<CR>

  " Auto open quickfix window in c/lwindow mode (auto closes when no more errors
  " in list)
  " The default autocmd (... nested cwindow) does not auto select quickfix window
  " unlike the actual :cwindow command
  " We can emulate this with the <C-w>b command - can't find any docs on this but
  " it seems to auto switch to quickfix window.
  " Follow up with 'p' which previews the quickfix location
  autocmd QuickFixCmdPost [^l]* cwindow
    \ | call feedkeys("\<C-w>b", 'in')
    \ | let b:gitgutter_was_enabled = gitgutter#utility#getbufvar(expand('<abuf>'), 'enabled')
    \ | call feedkeys("p")
  autocmd QuickFixCmdPost    l* lwindow
    \ | call feedkeys("\<C-w>b", 'in')
    \ | let b:gitgutter_was_enabled = gitgutter#utility#getbufvar(expand('<abuf>'), 'enabled')
    \ | call feedkeys("p")
augroup END
" ALE
let g:ale_disable_lsp = 1 "  Let CoC do it's job
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:ale_cursor_detail = 1
let g:ale_floating_preview = 1

" OmniSharp
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_highlighting = 0
let g:OmniSharp_coc_snippet = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [0],
\ 'border': [1],
\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\ 'borderhighlight': ['ModeMsg']
\}
" \ 'close': '<Esc>',
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>'],
\ 'lineDown': '<C-j>',
\ 'lineUp': '<C-k>',
\ 'sigParamNext': '<C-l>',
\ 'sigParamPrev': '<C-h>'
\}
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}

" CoC
let g:coc_user_config = {
  \ 'floatFactory.floatConfig': {
  \   'border': v:true
  \ },
  \ 'suggest.floatConfig': {
  \   'border': v:true
  \ },
  \ 'suggest.enablePreselect': v:false,
  \ 'suggest.noselect': v:true,
  \ 'suggest.virtualText': v:true,
  \ 'suggest.acceptSuggestionOnCommitCharacter': v:true,
  \ 'diagnostic.displayByAle': v:true,
  \ 'javascript.suggest.autoImports': v:true,
  \ 'typescript.suggest.autoImports': v:true,
  \ 'colors.enable': v:true,
  \ 'markdownlint.config': { 
  \   'MD004': v:false,
  \   'MD012': v:false,
  \   'MD013': v:false,
  \   'MD025': v:false,
  \   'MD032': v:false,
  \ }
\ }

let g:coc_global_extensions= [ 
  \ 'coc-clangd',
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-jedi',
  \ 'coc-sh',
  \ 'coc-sql',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-marketplace'
\ ]

" Markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_conceal_code_blocks = 0
"let g:vim_markdown_auto_insert_bullets = 1
"let g:vim_markdown_strikethrough = 1
"set formatoptions+=n

" Netrw
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
let g:netrw_browse_split = 4

" Calendar
let g:calendar_monday = 1
let g:calendar_diary= $HOME . '/repos/diary'

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets=[ '--all', 'netcoredbg', 'vscode-js-debug' ]
set noequalalways
let g:vimspector_base_dir = g:plug_home . '/vimspector'
if has('win32')
    let g:vimspector_base_dir = substitute(g:vimspector_base_dir, '/', '\', 'g')
endif
let &runtimepath = &runtimepath . ',' . g:vimspector_base_dir


" ################################
" #                              #
" #      CUSTOM FUNCTIONS        #
" #                              #
" ################################

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if coc#rpc#ready() && CocAction('hasProvider', 'hover') && !coc#float#has_float()
    silent call CocActionAsync('doHover')
  else
    silent call feedkeys('K', 'in')
  endif
endfunction

function! RelativeOrAbsolutePath() abort
  return substitute(getcwd(), $HOME, "~", "")
endfunction

" ################################
" #                              #
" #           MAPPINGS           #
" #                              #
" ################################

" Use <ctrl> + 't' to create a new buffer tab
noremap <silent><C-T> :tabedit<CR>
noremap! <silent><C-T> <Esc>:tabedit<CR>
tnoremap <silent><C-T> <C-W>:tabedit<CR>

" Navigate buffer tabs with ctrl+w + h/l
noremap <silent><C-W>h :tabprevious<CR>
noremap! <silent><C-W>h <Esc>:tabprevious<CR>
tnoremap <silent><C-W>h <C-W>:tabprevious<CR>
noremap <silent><C-W>l :tabnext<CR>
noremap! <silent><C-W>l <Esc>:tabnext<CR>
tnoremap <silent><C-W>l <C-W>:tabnext<CR>

" Move tabs left and right
noremap <silent><C-,> :tabmove-<CR>
noremap! <silent><C-,> <Esc>:tabmove-<CR>
tnoremap <silent><C-,> :tabmove-<CR>
noremap <silent><C-.> :tabmove+<CR>
noremap! <silent><C-.> <Esc>:tabmove+<CR>
tnoremap <silent><C-.> :tabmove+<CR>

" Make ctrl + backspace work like normal in insert and command mode
noremap! <C-BS> <C-W>

nmap <C-w>z <Plug>(zoom-toggle)
nmap <silent>gG :G<CR>
nmap <silent><leader>g :G<CR>

" short hands for Git Gutter magic
cnoreabbrev Changes GitGutterLineHighlightsToggle


" GoTo code navivgation
autocmd FileType * nmap <silent> gd <Plug>(coc-definition)
autocmd FileType * nmap <silent> gi <Plug>(coc-implementation)

nnoremap <silent>K :call ShowDocumentation()<CR>

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
abbreviate Cal CalendarT

" Overwrite FZF Rg/RG commands to include dot files, excluding node_modules
" and git folders
command! -bang -nargs=? -complete=dir Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}' -- ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir RG call fzf#vim#grep2("rg --column --line-number --no-heading --color=always --smart-case --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}' -- ", <q-args>, fzf#vim#with_preview(), <bang>0)

augroup netrw_mapping
  autocmd!
  autocmd FileType netrw nmap <buffer> h -^
  autocmd FileType netrw nmap <buffer> l <CR>
augroup END

noremap  <silent><C-n> :Lexplore<CR>
noremap! <silent><C-n> <Esc>:Lexplore<CR>
tnoremap <silent><C-n> :Lexplore<CR>
let g:move_key_modifier_visualmode = 'C'



"" ~~~~~~~~~~~~~~
"" Notes
"" ~~~~~~~~~~~~~~

"" TODO - General
"" TODO - AutoPairs - Fix inserting closing paren when we there already exists one
"" TODO - Add syntax highlight like TODO has for ISSUE and BUG etc.
"" TODO - Go through plugins and see what you're not fully utilising
"" TODO - Try remove some plugins i.e. bookmarks? quickfix related ones?"

"" vim-bujo Ideas: 
""  `:Backlog An Example Header With Spaces: Task To Be added with spaces`
""   would create a task in backlog under heading 'An Example Header With Spaces' with task `Task To Be added with spaces`
"" - Having a shortcut to allow for quick migration to next week/ back to future log (>> and <<)
"" - Since we want to have ability to migrate by week for example, would need to introduce way to have future days in 
""   daily log while still putting entries into correct day, so would need to iterate through lines until we found todays
""   entry, then foud the appropriate type to enter it under
"" - Switch to have entries append to list rather than insert at the top. This work will be needed for collections anyhow
""   (as they are being put into index rather than a log). 
