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
let data_dir = has('win32') || has('win64')  ? $HOME.'/vimfiles/' : '~/.vim'
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
Plug 'b0dee/Auto-Pairs'
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
  \   'right': [ [ 'filetype', 'fileencoding', 'fileformat'  ],  [ 'lineinfo', 'percent' ]],
  \ },
  \ 'inactive': {
  \   'left': [ [ 'readonly', 'pwd', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo', 'percent' ], []],
  \ },
  \ 'component_function': {
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
\ ]

" Markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_strikethrough = 1

" Netrw
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
let g:netrw_browse_split = 4

" Calendar
let g:calendar_monday = 1
let g:calendar_diary= $HOME . '/repos/diary'

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
  let cwd = getcwd()
  if has('win32')
    let l:home = substitute($HOME, '\\', '\\\\', 'g')
    let cwd = substitute(cwd, l:home, '~', "")
  endif
  return cwd
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
cnoreabbrev ShowChanges GitGutterLineHighlightsEnable
cnoreabbrev HideChanges GitGutterLineHighlightsDisable
cnoreabbrev ToggleChanges GitGutterLineHighlightsToggle
cnoreabbrev Stage GitGutterPreviewHunk


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

" ------------------------------ 
" Bullet Journal WIP

" Constants/ Enums
let s:BUJO_NOTE = "note"
let s:BUJO_TASK = "task"
let s:BUJO_EVENT = "event"
let s:BUJO_DAILY = "daily"
let s:BUJO_BACKLOG = "backlog"
let s:BUJO_MONTHLY = "monthly"
let s:BUJO_FUTURE = "future"

let g:bujo_path = '~/repos/bujo/'
let g:bujo_index_winsize = 30

" Default settings
let g:bujo_journal_default_name = "primary"
let g:bujo_default_list_char = "*"
let g:bujo_split_right = &splitright

" Daily Log vars
" The below allows for auto rotation of files per month/week/day 
" as function will just replace and open file based on what set here
" so %Y-%m-%d (aka. 2024-07-10) or %Y-%m (aka. 2024-07) etc.
let g:bujo_daily_filename = "daily_%Y-%m.md"
let g:bujo_daily_winsize = 50
let g:bujo_daily_header =  "# %A %B %d" 
let g:bujo_daily_task_header =  "**Tasks:**"
let g:bujo_daily_event_header =  "**Events:**" 
let g:bujo_daily_note_header =  "**Notes:**"

" TODO - Move the core entries into a private list
"        They are required for core functionality, not sure what 
"        will break if they are removed, don't want to fix whatever it does though
let g:bujo_header_entries_ordered = [
\ s:BUJO_EVENT,
\ s:BUJO_TASK,
\ s:BUJO_NOTE,
\]

" TODO - Move the core entries into a private dictionary
"        They are required for core functionality, not sure what 
"        will break if they are removed, don't want to fix whatever it does though
let g:bujo_header_entries = {
\ s:BUJO_EVENT: {
\   "name": s:BUJO_EVENT,
\   "header": g:bujo_daily_event_header,
\   "list_char": "*",
\   "daily_enabled": v:true,
\   "future_enabled": v:true,
\   "monthly_enabled": v:true,
\   "backlog_enabled": v:false
\ },
\ s:BUJO_TASK : {
\   "name": s:BUJO_TASK,
\   "header": g:bujo_daily_task_header,
\   "list_char": "- [ ]",
\   "daily_enabled": v:true,
\   "future_enabled": v:true,
\   "monthly_enabled": v:true,
\   "backlog_enabled": v:true
\ },
\ s:BUJO_NOTE: {
\   "name": s:BUJO_NOTE,
\   "header": g:bujo_daily_note_header,
\   "list_char": "",
\   "daily_enabled": v:true,
\   "future_enabled": v:true,
\   "monthly_enabled": v:true,
\   "backlog_enabled": v:false
\ }
\}

" Options: month_long, month_short
" 0 = Don't include header
" 1 = Include header
" 2 = Smart inclusion only if events scheduled for this day
let g:bujo_daily_include_event_header = 0

" Future Log vars
let g:bujo_future_filename = "future_%Y.md"
let g:bujo_future_header =  "# {journal} Future Log - %Y" 
" Available replacements: 
" - Long month name: %B
" - Short month name: %b
let g:bujo_future_month_header =  "# %B" 

" Monthly Log vars
let g:bujo_monthly_filename = "monthly_%Y_%m.md"
let g:bujo_monthly_header = "# %B %Y"
let g:bujo_monthly_table_enabled = v:true
let g:bujo_monthly_table_align = v:true
let g:bujo_monthly_table_headers_ordered = [
\ "gratitude",
\ "meditation",
\ "reading"
\ ]
let g:bujo_monthly_table_headers = { 
\ "gratitude": {
\		"display":"Gratitude",
\		"cron":""
\ },
\ "meditation": {
\		"display":"Meditation",
\		"cron":""
\ },
\ "reading": {
\		"display":"Reading",
\		"cron":""
\ }
\ }

" Backlog vars
let g:bujo_backlog_filename = "backlog.md"
let g:bujo_backlog_header =  "# {journal} Backlog" 


" Index vars
let g:bujo_index_header = "# {journal} Index"
let g:bujo_index_list_char = "{#}"
let g:bujo_index_enable_future = v:true
let g:bujo_index_enable_monthly = v:true
let g:bujo_index_enable_daily  = v:true
let g:bujo_index_enable_backlog  = v:true
let s:bujo_index_entries = [
\ { 
\  "name": "Future Log",
\  "file": g:bujo_future_filename,
\ },
\ { 
\   "name": "Monthly Log",
\   "file": g:bujo_monthly_filename,
\ },
\ { 
\   "name": "Daily Log",
\   "file": g:bujo_daily_filename,
\ },
\ { 
\   "name": "Backlog",
\   "file": g:bujo_backlog_filename,
\ }
\]

" Add in custom index entries from global list
if exists("g:bujo_index_entries") 
  call extend(s:bujo_index_entries, g:bujo_index_entries)
endif

let g:bujo_months = [
  \ { "short": "Jan", "long": "January", "days": 31 },
  \ { "short": "Feb", "long": "February", "days": 28 },
  \ { "short": "Mar", "long": "March", "days": 31 },
  \ { "short": "Apr", "long": "April", "days": 30 },
  \ { "short": "May", "long": "May", "days": 31 },
  \ { "short": "Jun", "long": "June", "days": 30 },
  \ { "short": "Jul", "long": "July", "days": 31 },
  \ { "short": "Aug", "long": "August", "days": 31 },
  \ { "short": "Sep", "long": "September", "days": 30 },
  \ { "short": "Oct", "long": "October", "days": 31 },
  \ { "short": "Nov", "long": "November", "days": 30 },
  \ { "short": "Dec", "long": "December", "days": 31 },
\ ]
" i.e. let g:bujo_migrated_to_future = '<' -- Migrated to future log
"      > = Migrated to next week look
" etc

" ------------------------------ 
"  autoload
" ------------------------------ 

function! s:format_filename(filename) 
  return tolower(substitute(strftime(a:filename), " ", "_", "g"))
endfunction

function! s:format_header(header, journal = g:bujo_journal_default_name) 
  return strftime(substitute(a:header, "{journal}", substitute(a:journal, "\\<\\([a-z]\\)", "\\U\\1", "g"), "g"))
endfunction

" mkdir_if_needed
" Returns true if user cancelled, false if already exists/created directory
function! s:mkdir_if_needed(journal = v:null)
  let l:journal_dir = tolower(expand(g:bujo_path). a:journal)
  if isdirectory(l:journal_dir)
    return v:false
	endif

  let l:journal_print_name = substitute(a:journal, "\\<\\([a-z]\\)", "\\U\\1", "g")
  let l:choice = confirm("Creating new journal `" . l:journal_print_name . "`. Continue Y/n (default: yes)?",
                        \ "&Yes\n&No")
  if choice != 1 
    echo "Aborting journal creation"
    return v:true
  endif

  call mkdir(l:journal_dir, "p", "0o775")
  return v:false
endfunction

function! s:init_journal_index(journal)
  let l:journal_dir = expand(g:bujo_path . a:journal)
  let l:journal_index = l:journal_dir . "/index.md"
  " We have already initialised index 
  if filereadable(l:journal_index) | return | endif

  let l:content = [s:format_header(g:bujo_index_header, a:journal), ""]
  let l:counter = 0
  for key in s:bujo_index_entries
    let l:counter += 1
    call add(l:content, substitute(g:bujo_index_list_char, "{#}", l:counter . ".", "g") . " [" . key["name"] . "](" . key["file"] . ")")
  endfor
  call writefile(l:content, l:journal_index)
endfunction

" Paramaters: openJournal: bool, vaargs - each argument is joined in a string
" to create the journal name
" Description: Open the index file for a journal or index file of journals
" Notes: Additional arguments are appended to the 'journal' argument with
" spaces between
function! OpenIndex(open_journal, ...)
  let l:journal = a:0 == 0 ? g:bujo_journal_default_name : join(a:000, " ")
  let l:journal_dir = expand(g:bujo_path . l:journal)
  let l:journal_index = expand(l:journal_dir . "/index.md")
  
  " Check to see if the journal exists
  if !a:open_journal
    if s:mkdir_if_needed(l:journal) | return | endif
  endif

  let l:cmd = (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_index_winsize > 0)? (g:bujo_index_winsize*winwidth(0))/100 : -g:bujo_index_winsize) . "new" 
  if a:open_journal
    execute l:cmd 
    setlocal filetype=markdown buftype=nofile noswapfile bufhidden=wipe
    let l:content = ["# Journal Index", ""]
    for entry in readdir(expand(g:bujo_path), {f -> isdirectory(expand(g:bujo_path . f)) && f !~ "^[.]"})
      call add(l:content, "- [" . substitute(entry, "\\<\\([a-z]\\)", "\\U\\1", "g") . "]( " . entry . "/index.md" . " )")
    endfor
    call append(0, l:content)
    setlocal readonly nomodifiable
  else
    let l:journal_index = expand(g:bujo_path . l:journal . "/index.md")  
    call s:init_journal_index(l:journal)
    execute l:cmd 
    execute "edit " . fnameescape(l:journal_index)
  endif
endfunction

function! s:init_daily(journal)
  " Check if we've already initialised today's log
  let l:formatted_daily_header = s:format_header(g:bujo_daily_header, a:journal) 
  let l:journal_dir = expand(g:bujo_path . a:journal) 
  let l:daily_log = l:journal_dir . "/". s:format_filename(g:bujo_daily_filename)
  if filereadable(l:daily_log) && readfile(l:daily_log, "", 1)[0] ==# l:formatted_daily_header
    return
  endif

  let l:content = [l:formatted_daily_header, ""]

  if s:mkdir_if_needed(a:journal) | return | endif

  for key in g:bujo_header_entries_ordered
    if g:bujo_header_entries[key]["daily_enabled"]
      call add(l:content, g:bujo_header_entries[key]["header"])
      if g:bujo_daily_include_event_header == 2
      " TODO - implement smart event inclusion in daily log
      " Will likely come after calendar integration, need a way of finding all live events
        echoerr "Smart event creation Not implemented!"
        return
      endif
      call add(l:content, g:bujo_header_entries[key]["list_char"] . " ")
      call add(l:content, "")
    endif
  endfor

  " Does the containing file have other daily log entries?
  if filereadable(l:daily_log) && readfile(l:daily_log, "", 1)[0] !=# l:formatted_daily_header
    " Add any pre-existing content to the file
    call extend(l:content, readfile(l:daily_log))
  endif

  " Write output to file
  call writefile(l:content, l:daily_log)
endfunction

function! OpenDaily(...)
  let l:journal = a:0 == 0 ? g:bujo_journal_default_name : join(a:000, " ")
  let l:daily_log = expand(g:bujo_path . l:journal . "/". s:format_filename(g:bujo_daily_filename))
  call s:init_daily(l:journal)
  execute (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_winsize > 0)? (g:bujo_daily_winsize*winwidth(0))/100 : -g:bujo_daily_winsize) "new" 
  execute  "edit " . fnameescape(l:daily_log)
  
endfunction

function! s:list_insert_entry(list, type_header, type_list_char, entry, stop_pattern = v:null)
  let l:index = 0
  let l:list_char = a:type_list_char . (a:type_list_char == "" ? "" : " " )
  for line in a:list
    let l:index += 1
    if line ==# a:stop_pattern | break | endif
    if line ==# a:type_header
      call insert(a:list, l:list_char . a:entry, l:index)
      return a:list
    endif
  endfor

  " If we reach here, we've failed to locate the header
  " The only 'safe' way I can conceive to add this in is 
  " to locate todays header and insert it 2 lines below 
  " (leaving blank line below header)
  call insert(a:list, a:type_header, 2)
  call insert(a:list, l:list_char . a:entry, 3)
  call insert(a:list, "", 4)
  return a:list
endfunction

function! s:list_append_entry(list, type_header, type_list_char, entry) 
  let l:index = 0
  let l:list_char = a:type_list_char . (a:type_list_char == "" ? "" : " " )
  for line in a:list
    if line ==# a:type_header
      for item in a:list[l:index:-1]
        if item ==# l:list_char
          call insert(a:list, l:list_char . a:entry, l:index)
          return a:list
        endif
        let l:index += 1
      endfor
      break
    endif
    let l:index += 1
  endfor

  " If we reach here, we've failed to locate the header
  " The only 'safe' way I can conceive to add this in is 
  " to locate todays header and insert it 2 lines below 
  " (leaving blank line below header)
  " TODO - This doesn't actually 'find todays header' it just inserts it a the top of the file
  " but when support for future daily log entries is added this may not be the case
  call insert(a:list, a:type_header, 2)
  call insert(a:list, l:list_char . a:entry, 3)
  call insert(a:list, "", 4)
  return a:list
endfunction

" TODO: Handle displaying urgent tasks
function! CreateEntry(type, is_urgent, ...)
  let l:entry = substitute(join(a:000, " "), "\\(^[a-z]\\)", "\\U\\1", "g") . (a:type ==# s:BUJO_NOTE ? "\r\n": "")
  let l:daily_log = expand(g:bujo_path . g:bujo_journal_default_name . "/". s:format_filename(g:bujo_daily_filename))
  call s:init_daily(g:bujo_journal_default_name)
  let l:content = readfile(l:daily_log)
  call writefile(s:list_append_entry(l:content, g:bujo_header_entries[a:type]["header"], g:bujo_header_entries[a:type]["list_char"], l:entry), l:daily_log)
endfunction

" This needs to handle for month selected (required)
function! OpenFuture(...)
  let l:journal_dir = expand(g:bujo_path . g:bujo_journal_default_name)
  let l:future_log = l:journal_dir . "/" . s:format_filename(g:bujo_future_filename) 
  if s:mkdir_if_needed(g:bujo_journal_default_name) | return | endif

  if !filereadable(l:future_log)
    let l:content = []
    call add(l:content, s:format_header(g:bujo_future_header))
    call add(l:content, "")
    for month in g:bujo_months
      " TODO - This **will** break between systems. Will need to add a conditional to decide what to go with when we encounter it
      call add(l:content, substitute(substitute(g:bujo_future_month_header, "%B", month["long"], "g"), "%b", month["short"], "g"))
      call add(l:content, "")
      for key in g:bujo_header_entries_ordered
        if g:bujo_header_entries[key]["future_enabled"]
          call add(l:content, g:bujo_header_entries[key]["header"])
          call add(l:content, g:bujo_header_entries[key]["list_char"] . " ")
          call add(l:content, "")
        endif
      endfor
      call add(l:content, "")
      call writefile(l:content, l:future_log)
    endfor
  endif

  if a:0 == 0
    execute (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_winsize > 0)? (g:bujo_daily_winsize*winwidth(0))/100 : -g:bujo_daily_winsize) "new" 
    execute  "edit " . fnameescape(l:future_log)
  else 
    echoerr "Future entry rappid logging not implemented."
    return
    let l:type = tolower(a:1)
    let l:entry = substitute(join(a:000[1:-1], " "), "\\(^[a-z]\\)", "\\U\\1", "g")
    let l:content = readfile(l:future_log)
    call writefile(s:list_append_entry(l:content, g:bujo_header_entries[l:type]["header"], g:bujo_header_entries[l:type]["list_char"], l:entry), l:future_log)
  endif
endfunction

function! CreateCollection(...)
  if a:0 == 0 
    echoerr "create_collection() requires at least 1 argment. Aborting."
    return
  endif

  let l:collection = join(a:000, " ")
  let l:collection_print_name = substitute(l:collection, "\\<\\([a-z]\\)", "\\U\\1", "g")

  if s:mkdir_if_needed(g:bujo_journal_default_name) | return | endif

  let l:journal_dir = expand(g:bujo_path . g:bujo_journal_default_name)
  let l:journal_index = expand(l:journal_dir) . "/index.md"
  let l:collection_index_link = s:format_filename(l:collection) . ".md"
  let l:collection_path = expand(l:journal_dir) . "/" . s:format_filename(l:collection) . ".md"

  call s:init_journal_index(g:bujo_journal_default_name)

  " Add the entry to index
  let l:content = readfile(l:journal_index)
  " Skip the first 2 lines, these will always be the index header and a new line
  let l:counter = 0
  for line in l:content[2:-1]
    let l:counter += 1
    " Account for the case where we are at EOF and no empty newline
    if line !~# substitute(g:bujo_index_list_char, "{#}", l:counter . ". ", "g") 
      call insert(l:content, substitute(g:bujo_index_list_char, "{#}", l:counter, "g") . ". [" . l:collection_print_name . "](" . l:collection_path . ")", l:counter + 1)
      break
    elseif line ==# l:content[-1] && len(l:content) == l:counter + 2
      call add(l:content, substitute(g:bujo_index_list_char, "{#}", l:counter + 1, "g") . ". [" . l:collection_print_name . "](" . l:collection_path . ")")
    endif
  endfor
  call writefile(l:content, l:journal_index)

  let l:content = [ "# " . l:collection_print_name, "", "" ]
  call writefile(l:content, l:collection_path)

  execute (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_winsize > 0)? (g:bujo_daily_winsize*winwidth(0))/100 : -g:bujo_daily_winsize) "new" 
  execute  "edit " . fnameescape(l:collection_path)

endfunction

function! OpenBacklog(...)
  let l:journal_dir = expand(g:bujo_path . g:bujo_journal_default_name)
  let l:backlog = l:journal_dir . "/" . s:format_filename(g:bujo_backlog_filename)
  if s:mkdir_if_needed(g:bujo_journal_default_name) | return | endif
  if !filereadable(l:backlog)
    let l:content = []
    call add(l:content, s:format_header(g:bujo_backlog_header, g:bujo_journal_default_name))
    call add(l:content, "")
    for key in g:bujo_header_entries_ordered
      if g:bujo_header_entries[key]["backlog_enabled"]
        call add(l:content, g:bujo_header_entries[key]["header"])
        call add(l:content, g:bujo_header_entries[key]["list_char"] . " ")
        call add(l:content, "")
      endif
    endfor
    call add(l:content, "")
    call writefile(l:content, l:backlog)
  endif
  " Check if we need to create an entry
  " We do this before opening the split as we may want to do both
  if a:0 == 0
    execute (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_winsize > 0)? (g:bujo_daily_winsize*winwidth(0))/100 : -g:bujo_daily_winsize) "new" 
    execute  "edit " . fnameescape(l:backlog)
  else
    let l:entry = substitute(join(a:000, " "), "\\(^[a-z]\\)", "\\U\\1", "g")
    let l:content = readfile(l:backlog)
    call writefile(s:list_append_entry(l:content, g:bujo_header_entries[s:BUJO_TASK]["header"], g:bujo_header_entries[s:BUJO_TASK]["list_char"],  l:entry), l:backlog)
  endif
endfunction

function! OpenMonthly(...)
  if a:0 > 0 && a:0 < 2
    echoerr "Monthly command requires at least 2 arguments if providing any."
    return
  elseif a:0 > 0
    let l:type = tolower(a:1) 
    let l:entry = substitute(join(a:000[1:-1], " "), "\\(^[a-z]\\)", "\\U\\1", "g")
  endif

  let l:journal_dir = expand(g:bujo_path . g:bujo_journal_default_name)
  let l:monthly_log = l:journal_dir . "/" . s:format_filename(g:bujo_monthly_filename)

  if s:mkdir_if_needed(g:bujo_journal_default_name) | return | endif
  if !filereadable(l:monthly_log)
    let l:content = [ s:format_header(g:bujo_monthly_header), "" ]
    for header in g:bujo_header_entries_ordered
      if g:bujo_header_entries[header]["monthly_enabled"]
        call add(l:content, s:format_header(g:bujo_header_entries[header]["header"]))
        call add(l:content, g:bujo_header_entries[header]["list_char"] . " ")
        call add(l:content, "")
      endif
    endfor
    if g:bujo_monthly_table_enabled 
      let l:day_header = "Day"
      let l:empty_checkbox = "[ ]"
      let l:table_horizontal_border = "|" . repeat("-",len(l:day_header) + 1)
      let l:row = "| " . l:day_header
      for header in g:bujo_monthly_table_headers_ordered
        let l:table_horizontal_border .= "-+" . repeat("-", len(s:format_header(g:bujo_monthly_table_headers[header]["display"])) + 1)
        let l:row .= " | " . s:format_header(g:bujo_monthly_table_headers[header]["display"])
      endfor
      let l:table_horizontal_border .= "-|"
      let l:row .= " |"
      call add(l:content, l:table_horizontal_border)
      call add(l:content, l:row)
      if g:bujo_monthly_table_align
        let l:row = "| :" . repeat("-", len(l:day_header) - 1) . " |"
        for header in g:bujo_monthly_table_headers_ordered
          let l:row .= " :" . repeat("-", len(g:bujo_monthly_table_headers[header]["display"]) - 2) . ": |"
        endfor
        call add(l:content, l:row)
      endif
      for day in range(1, g:bujo_months[strftime("%m") - 1]["days"])
        let l:row = "| " . day . "." . repeat(" ", len(l:day_header) - (day / 10 < 1 ? 2: 3)) . " |"
        for header in g:bujo_monthly_table_headers_ordered
          let l:padding = ((len(g:bujo_monthly_table_headers[header]["display"]) + 2) / 2) - (len(l:empty_checkbox) / 2)
          let l:rounding_padding = (len(g:bujo_monthly_table_headers[header]["display"]) + 2) - ((l:padding * 2) + len(l:empty_checkbox))
          let l:row .= repeat(" ", l:padding) . l:empty_checkbox . repeat(" ", l:padding + l:rounding_padding) . "|"
        endfor
        call add(l:content, l:row)
      endfor
      call add(l:content, l:table_horizontal_border)
      call add(l:content, "")
    endif
    call writefile(l:content, l:monthly_log)
  endif

  if a:0 == 0 
    execute (g:bujo_split_right ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_winsize > 0)? (g:bujo_daily_winsize*winwidth(0))/100 : -g:bujo_daily_winsize) "new" 
    execute  "edit " . fnameescape(l:monthly_log)
  else
    " TODO - MAYBE change open_monthly to open a specific month rather than rappid log
    " TODO - Or figure out a nice implementation for doing rappid logging + specifying month
    let l:type = tolower(a:1)
    let l:entry = substitute(join(a:000[1:-1], " "), "\\(^[a-z]\\)", "\\U\\1", "g")
    let l:content = readfile(l:monthly_log)
    call writefile(s:list_append_entry(l:content, g:bujo_header_entries[l:type]["header"], g:bujo_header_entries[l:type]["list_char"], l:entry), l:monthly_log)
  endif

endfunction

" ------------------------------ 
"  interface [plugin]
" ------------------------------ 
command! -nargs=* -bang Index call OpenIndex(<bang>0, <f-args>)
command! -nargs=* -bang Today call OpenDaily(<f-args>)
command! -nargs=+ -bang Task  call CreateEntry(s:BUJO_TASK,    <bang>0,   <f-args>)
command! -nargs=+ -bang Event call CreateEntry(s:BUJO_EVENT,   <bang>0,   <f-args>)
command! -nargs=+ -bang Note  call CreateEntry(s:BUJO_NOTE,    <bang>0,   <f-args>)
command! -nargs=+ Collection  call CreateCollection(<f-args>)
command! -nargs=* Backlog call OpenBacklog(<f-args>)
command! -nargs=* Future call OpenFuture(<f-args>) 
command! -nargs=* Monthly call OpenMonthly(<f-args>)
" Creating command names to guage what is wanted/needed 
" Creating the 'black box' based on that
" APIs here are just template
" command! -nargs=* -bang TaskList call s:list_tasks(<bang>0, <f-args>)
" command! -nargs=* -bang EventList call s:list_events(<bang>0, <f-args>)

" ~~~~~~~~~~~~~~
" Notes
" ~~~~~~~~~~~~~~
" TODO - vim-bujo 
" TODO - Make Vader test suite
" TODO - Control insert/append based on entry type?
" TODO - Replace existing window if already open, don't spam create them
" TODO - Future log: to only include months from init forward (i.e. initialised in july has jul - dec)
" TODO - Future log: auto scroll to put this month header at top line
" TODO - Future log: open a different year
" TODO - Future log: rappid log
" TODO - Sort out issue with recording a weekly rolling daily log
" TODO - Migration functionality
" TODO - Motions to navigate/ prepopulate command
" TODO - Set filetype, link syntax with markdown, and introduce motions within files
"        i.e. '<leader><<' in daily log can prompt
"        user to specify month and will migrate entry to future log etc., >> will move to next monthly log
" TODO: Implement Weekly Command
" - Launches to a week in review session
" TODO: Implement RenameJournal Command
" - bang: false
" TODO: Implement RenameCollection Command
" - bang: false
" TODO: Implement FutureEvent Command
" - bang: true
" - bang means first arg is month/date string
" TODO: Implement FutureTask Command
" - bang: true
" - bang means first arg is month/date string
" TODO: Implement FutureNote Command
" - bang: true
" - bang means first arg is month/date string
" TODO: Implement ListTasks Command
" - bang: true
" - bang means list tasks in ALL journals, arguments provided are used as journal or default is used 
" TODO: Implement ListEvents Command
" - bang: true
" - bang means list events in ALL journals, arguments provided are used as journal or default is used 
" TODO: Implement Reflect Command
" - ability to have this be done automatically/ prompt (perhaps controllable so can be silenced) when
"   launching any bujo command
" - bang: false
" - Arguments provided are used as journal or default is used 
" - Initialises next weeks daily log showing the past week in horizontal split and monthly log in 
"   vert split to move tasks in where needed 
" TODO - Automatic git pull, commit and push 
" TODO - Cron scheduling of monthly headers (to auto populate table)
" TODO - Markdown
" - fix markdown opening local file links
" TODO - vim-zoom
" - Fork and add in a scratch buffer, created/destroyed on toggle to prevent quit during zoom 
"   (perhaps autocmd restore state if go into this window)
" TODO - monthly update table setting the row for today to have a link to daily log
" TODO - General
" TODO - AutoPairs - Fix inserting closing paren when we there already exists one
" TODO - Add syntax highlight like TODO has for ISSUE and BUG etc.
" TODO - Go through Vim help manuals as missed loads
" TODO - Go through plugins and see what you're not fully utilising
" vim-bujo Ideas: 
" - Having commands be smart enough to put things under appropriate header when in format of 
"  `:Backlog An Example Header With Spaces: Task To Be added with spaces`
"   would create a task in backlog under heading 'An Example Header With Spaces' with task `Task To Be added with spaces`
" - Having a shortcut to allow for quick migration to next week/ back to future log (>> and <<)
" - Since we want to have ability to migrate by week for example, would need to introduce way to have future days in 
"   daily log while still putting entries into correct day, so would need to iterate through lines until we found todays
"   entry, then foud the appropriate type to enter it under
" - Switch to have entries append to list rather than insert at the top. This work will be needed for collections anyhow
"   (as they are being put into index rather than a log). 
