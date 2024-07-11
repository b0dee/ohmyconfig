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

let g:bujo_path = '~/repos/bujo/'
let g:bujo_journal_default_name = "default"
let g:bujo_index_winsize = 30
let g:bujo_daily_log_winsize = 50
" The below - in theory - should allow for auto rotation of files per month/week/day 
" as function will just replace and open file based on what set here
" so %Y-%m-%d (aka. 2024-07-10) or %Y-%m (aka. 2024-07) etc.
let g:bujo_daily_log_filename = "daily_%Y-%m.md"
let g:bujo_journal_index_header = "# {journal} Index"
let g:bujo_daily_log_header =  "# %A %B %d" 
let g:bujo_daily_log_task_header =  "**Tasks:**"
let g:bujo_daily_log_event_header =  "**Events:**" 
let g:bujo_daily_log_note_header =  "**Notes:**"
" Options: month_long, month_short
let g:bujo_future_log_header =  "# {month-long}" 
" 0 = Don't include header
" 1 = Include header
" TODO - 2 = Smart inclusion only if events scheduled for this day
let g:bujo_include_event_header = 0
let s:BUJO_NOTE = "note"
let s:BUJO_TASK = "task"
let s:BUJO_EVENT = "event"
let g:bujo_default_list_char = "*"
let g:bujo_entries_order = [
\ s:BUJO_EVENT,
\ s:BUJO_TASK,
\ s:BUJO_NOTE,
\]

let g:bujo_entries = {
\ s:BUJO_EVENT: {
\   "name": s:BUJO_EVENT,
\   "header": g:bujo_daily_log_event_header,
\   "list_char": "*",
\   "daily_log_enabled": v:true,
\   "future_log_enabled": v:true,
\   "backlog_enabled": v:true
\ },
\ s:BUJO_TASK : {
\   "name": s:BUJO_TASK,
\   "header": g:bujo_daily_log_task_header,
\   "list_char": "*",
\   "daily_log_enabled": v:true,
\   "future_log_enabled": v:true,
\   "backlog_enabled": v:true
\ },
\ s:BUJO_NOTE: {
\   "name": s:BUJO_NOTE,
\   "header": g:bujo_daily_log_note_header,
\   "list_char": "",
\   "daily_log_enabled": v:true,
\   "future_log_enabled": v:true,
\   "backlog_enabled": v:true
\ }
\}
let g:bujo_journal_init_include_future = v:true
let g:bujo_journal_init_include_monthly = v:true
let g:bujo_journal_init_include_daily  = v:true
let g:bujo_journal_init_include_backlog  = v:true
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
" TODO - Add customisable list elements
" i.e. let g:bujo_migrated_to_future = '<' -- Migrated to future log
"      > = Migrated to next week look
" etc

" ------------------------------ 
"  autoload
" ------------------------------ 

function! s:mkdir_if_needed(journal = v:null)
  let l:journal_dir = expand(g:bujo_path . a:journal)
  if isdirectory(l:journal_dir)
    return
	endif

  let l:journal_print_name = substitute(a:journal, "\\<\\([a-z]\\)", "\\U\\1", "g")
  let l:choice = confirm("Creating new journal `" . l:journal_print_name . "`. Continue Y/n (default: yes)?",
                        \ "&Yes\n&No")
  if choice != 1 
    echo "Aborting journal creation"
    return
  endif

  call mkdir(l:journal_dir, "p", "0o775")
endfunction

" Paramaters: openJournal: bool, vaargs - each argument is joined in a string
" to create the journal name
" Description: Open the index file for a journal or index file of journals
" Notes: Additional arguments are appended to the 'journal' argument with
" spaces between
function! s:open_index(open_journal, ...)
  let l:journal = a:0 == 0 ? g:bujo_journal_default_name : join(a:000, " ")
  let l:journal_print_name = substitute(l:journal, "\\<\\([a-z]\\)", "\\U\\1", "g")
  let l:journal_dir = expand(g:bujo_path . l:journal)
  let l:journal_index = expand(l:journal_dir . "/index.md")
  
  " Check to see if the journal exists
  if !a:open_journal
    call s:mkdir_if_needed(l:journal)
  endif

  let l:cmd = (&splitright ? "botright" : "topleft") . " vertical " . ((g:bujo_index_winsize > 0)? (g:bujo_index_winsize*winwidth(0))/100 : -g:bujo_index_winsize) . "new" 
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
    let l:index_path = expand(g:bujo_path . l:journal . "/index.md")  
    if !filereadable(l:index_path)
      let l:content = [substitute(g:bujo_journal_index_header, "{journal}", l:journal_print_name, "g"), ""]
      let l:counter = 1
      if g:bujo_journal_init_include_future
				call add(l:content, strftime("[" . l:counter . ". Future Log](future_%Y)"))      
        let l:counter += 1
      endif
      if g:bujo_journal_init_include_monthly
				call add(l:content, strftime("[" . l:counter . ". Monthly Log](monthly_%Y-%M)")) 
        let l:counter += 1
      endif
      if g:bujo_journal_init_include_daily
				call add(l:content, strftime("[" . l:counter . ". Daily Log](daily_%Y-%M)"))     
        let l:counter += 1
      endif
      if g:bujo_journal_init_include_backlog
				call add(l:content, strftime("[" . l:counter . ". Backlog](backlog)"))           
        let l:counter += 1
      endif
      call writefile(l:content, l:index_path)
    endif
    execute l:cmd 
    execute "edit " . l:index_path
  endif
endfunction

function! s:init_daily_log(journal, type = v:null, ...)
  if a:type != v:null && a:0 == 0 
    echoerr "Provided type (" . a:type . ") but did not provide any data to enter"
    return
  endif
  let l:entry = substitute(join(a:000, " "), "\\(^[a-z]\\)", "\\U\\1", "g")
  let l:journal_dir = expand(g:bujo_path . a:journal) 
  let l:daily_log = expand(l:journal_dir . "/". strftime(g:bujo_daily_log_filename))
  let l:content = [strftime(g:bujo_daily_log_header), ""]

  " Check to see if the journal exists
  call s:mkdir_if_needed(l:journal)

  for key in g:bujo_entries_order
    if g:bujo_entries[key]["daily_log_enabled"]
      call add(l:content, g:bujo_entries[key]["header"])
      if a:type == key
        echom l:entry
        call add(l:content, g:bujo_entries[key]["list_char"] . " " . l:entry)
      endif
      if g:bujo_include_event_header == 2
      " TODO - implement smart event inclusion in daily log
      " Will likely come after calendar integration, need a way of finding all live events
        echoerr "Not implemented!"
        return
      endif
      call add(l:content, g:bujo_entries[key]["list_char"] . " ")
      call add(l:content, "")
    endif
  endfor

  " Are we initialising for today?
  if filereadable(l:daily_log) && (readfile(l:daily_log, "", 1)[0] !=# strftime(g:bujo_daily_log_header))
    " Add any pre-existing content to the file
    call extend(l:content, readfile(l:daily_log))
  endif

  " Write output to file
  call writefile(l:content, l:daily_log)
endfunction

function! s:open_daily_log(...)
  let l:journal = a:0 == 0 ? g:bujo_journal_default_name : join(a:000, " ")
  let l:daily_log = expand(g:bujo_path . l:journal . "/". strftime(g:bujo_daily_log_filename))
  if !filereadable(l:daily_log) || readfile(l:daily_log, "", 1)[0] !=# strftime(g:bujo_daily_log_header) 
    call s:init_daily_log(l:journal)
  endif
  execute (&splitright ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_log_winsize > 0)? (g:bujo_daily_log_winsize*winwidth(0))/100 : -g:bujo_daily_log_winsize) "new" 
  execute  "edit " . g:bujo_path . l:journal . "/" . strftime(g:bujo_daily_log_filename)
  
endfunction

" TODO: Handle displaying urgent tasks
function! s:create_entry(type, is_urgent, ...)
  let l:entry = substitute(join(a:000, " "), "\\(^[a-z]\\)", "\\U\\1", "g")
  let l:daily_log = expand(g:bujo_path . g:bujo_journal_default_name . "/". strftime(g:bujo_daily_log_filename))
  if !filereadable(l:daily_log) || readfile(l:daily_log, "", 1)[0] !=# strftime(g:bujo_daily_log_header) 
    " We're creating a new file/ initialising today
    call s:init_daily_log(g:bujo_journal_default_name, a:type, l:entry)
  else
    let l:index = 0
    let l:content = readfile(l:daily_log)
    for line in l:content
      let l:index = l:index+1
      if line ==# g:bujo_entries[a:type]["header"] && g:bujo_entries[a:type]["daily_log_enabled"]
        call insert(l:content, g:bujo_entries[a:type]["list_char"] . " " . l:entry, l:index)
        call writefile(l:content, l:daily_log)
        return
      endif
    endfor

    " If we reach here, we've failed to locate the header
    " The only 'safe' way I can conceive to add this in is 
    " to locate todays header and insert it 2 lines below 
    " (leaving blank line below header)
    call insert(l:content, g:bujo_entries[type]["header"], 2)
    call insert(l:content, g:bujo_default_list_char . " " . l:entry, 3)
    call insert(l:content, "", 4)
    call writefile(l:content, l:daily_log)
  endif
endfunction

function! s:open_future_log(new_entry, ...)
  if !a:new_entry
    let l:journal_dir = expand(g:bujo_path . g:bujo_journal_default_name)
    let l:future_log = l:journal_dir . "/future_log.md" 
    call s:mkdir_if_needed(g:bujo_journal_default_name)
    if !filereadable(l:future_log)
      let l:content = []
      for month in g:bujo_months
        call add(l:content, substitute(substitute(g:bujo_future_log_header, "{month-long}", month["long"], "g"), "{month-short}", month["short"], "g"))
        call add(l:content, "")
        for key in g:bujo_entries_order
          if g:bujo_entries[key]["future_log_enabled"]
            call add(l:content, g:bujo_entries[key]["header"])
            call add(l:content, g:bujo_entries[key]["list_char"] . " ")
            call add(l:content, "")
          endif
        endfor
        call add(l:content, "")
        call writefile(l:content, l:future_log)
      endfor
    endif
    execute (&splitright ? "botright" : "topleft") . " vertical " . ((g:bujo_daily_log_winsize > 0)? (g:bujo_daily_log_winsize*winwidth(0))/100 : -g:bujo_daily_log_winsize) "new" 
    execute  "edit " . l:future_log
  endif
endfunction

" ------------------------------ 
"  interface [plugin]
" ------------------------------ 
command! -nargs=* -bang Index call s:open_index(<bang>0, <f-args>)
command! -nargs=* -bang Today call s:open_daily_log(<f-args>)
command! -nargs=+ -bang Task call s:create_entry(s:BUJO_TASK, <bang>0, <f-args>)
command! -nargs=+ -bang Event call s:create_entry(s:BUJO_EVENT, <bang>0, <f-args>)
command! -nargs=+ -bang Note call s:create_entry(s:BUJO_NOTE, <bang>0, <f-args>)
command! -nargs=* -bang Future call s:open_future_log(<bang>0, <f-args>) 
" Creating command names to guage what is wanted/needed 
" Creating the 'black box' based on that
" APIs here are just template
" command! -nargs=* -bang Future call s:open_future_log(<bang>0, <f-args>) -- bang is to create a new entry, vaargs indicate month and entry
" command! -nargs=* -bang Backlog call s:open_backlog(<bang>0, <f-args>) -- bang is to create a new entry, vaargs indicate entry
" command! -nargs=* -bang Monthly call s:open_monthly_log(<bang>0, <f-args>)
" command! -nargs=* -bang Container call s:create_container(<bang>0, <f-args>)
" command! -nargs=* -bang TaskList call s:list_tasks(<bang>0, <f-args>)
" command! -nargs=* -bang EventList call s:list_events(<bang>0, <f-args>)
" command! -nargs=* -bang  call s:open_monthly_log(<bang>0, <f-args>)






















