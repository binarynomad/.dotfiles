" ----------------------------------------
" VIMRC SYSTEM SETTINGS
" Version: 2021-07-28
" ----------------------------------------
" vim --clean (to run default vim)

" ---- CONFIGS: VIM Environment ---- {{{1

" ---System Keyboard Mappings--- {{{2

" Map additional <ESC> keys
inoremap jk <ESC>
inoremap kj <ESC>

" Map <space> as the <leader> key
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" Map <leader>-; as alternative for : to make it easier
nnoremap <Leader>; :

" Move macro recording to Q instead of q
nnoremap Q q
nnoremap q <Nop>

" Map to make it easier to force quit after notification
cnoremap qq q!
nnoremap <Leader>vq :quit<CR>

" Map <leader>-w to act like ctrl-w for windows
nnoremap <Leader>w <C-w>

" Map Edit & Reload .vimrc configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Map navigation inside long lines (instead of jumping)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <Up> gk
nnoremap <Down> gj

" Map navigation across Vim Windows CTRL-[h,j,k,l]
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Mac cursor keys to resize split windows
nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

" Map shift chars so you only need to type once to shift
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" Make Y consistent with C & D; yank to EOL
nnoremap Y y$

" Jump to and select the last inserted text
nnoremap gV `[v`]

" Map for quick paragraph reflowing
vmap <Leader>rf gq
nmap <Leader>rf gqap

" Clear search term highlighitng
noremap <silent> ? :nohlsearch<CR>

" Map buffer commands/keys
nnoremap <Leader>b :bNext<CR>
nnoremap <Leader>dd :bdelete<CR>
nnoremap <Leader>nn :enew<CR>

" Map shortcut for quick folding/unfolding
nnoremap <Leader><space> za

" Map F2 to all visable line numbers and special chars (for copy)
nmap <F2> :set norelativenumber!<bar>set nonumber!<bar>set nolist!<CR>

" Save a file as root (L-W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Allow searching of a visual selection (//)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" vim-powered terminal in split window
map <Leader>t :term ++close<cr>
tmap <Leader>t <c-w>:term ++close<cr>
" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>
tmap <Leader>T <c-w>:tab term ++close<cr>

" ---File Directory Setup--- {{{2

" Identify where the configs & plugins will go
if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

"  Create directories if they don't exist
let dir_list = ['after', 'backups', 'colors', 'plugin', 'swaps', 'undo']
for dir in dir_list
  if !isdirectory($VIMHOME."/".dir)
    call mkdir($VIMHOME."/".dir, "p", 0700)
  endif
endfor

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
if exists("&undodir")
    set undodir=~/.vim/undo//
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*


" ---- CONFIGS: Application Specific ---- {{{1

" ARGWRAP : Reformats Python lists between one to multiline (L-1)
nnoremap <silent> <leader>1 :ArgWrap<CR>

" WHICHKEY : Activate to see what is mapped to Leader (L)
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" FZF FINDER : Fuzzy searching of files, buffers, history, etc. (L-f?)
nmap <Leader>fH :Helptags<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fc :Commands<CR>
nmap <Leader>fe :Files<CR>
nmap <Leader>fg :GFiles<CR>
nmap <Leader>fh :History<CR>
nmap <Leader>fm :Maps<CR>
nmap <Leader>fr :Rg<Space>
nmap <Leader>fs :Snippets<CR>

" NERDTREE : Directory tree and explorer (L-ft)
" TODO: Possibly remove in favor of Netrw (https://shapeshed.com/vim-netrw/)
nmap <Leader>ft :NERDTree<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" EASYMOTION : Quick search/jump to text (s)
let g:EasyMotion_do_mapping = 0  " disable extra mappings
let g:EasyMotion_smartcase = 1  " smartcase searching
nmap s <Plug>(easymotion-s)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" EASYALIGN : Align text based on characters visual (vipga) motion/text (gaip)
" note: Align comments and ":  vipga-<space>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" VIM MARKED : Activate MacOS Marked2 with (L-md)
nnoremap <Leader>md :MarkedOpen!<CR>

" GOYO / LIMELIGHT : Distraction free and focused writing (L-gy)
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <Leader>gy :Goyo<CR>

" SEARCHTASKS : Search files for tags like TODO (L-st)
" note: use the function ClearQuickfillList (L-cc) to free up
let g:searchtasks_list=["TODO", "FIXME"]
nnoremap <Leader>st :SearchTasks %<CR>

" AIRLINE : Advanced status bar on the bottom
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if has('macunix')  " use powerline fonts if launched from iTerm
  let g:airline_powerline_fonts = 1
endif

" INDENT GUIDES : Bars showing indent levels
" hi IndentGuidesOdd  ctermbg=darkgrey
" hi IndentGuidesEven ctermbg=black
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1

" VIM MARKDOWN FOLDING : Markdown folding styles
let g:vim_markdown_folding_style_pythonic = 1

" VIM MARKDOWN : Markdown Syntax, automation
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" UNDOTREE : program to visualize/switch unto changes (F5)
" nnoremap <F5> :UndotreeToggle<cr>
nnoremap <Leader>uu :UndotreeToggle<cr>

" SNIPMATE : Plugin that allows for smart/responsive text snippets
let g:snipMate = { 'snippet_version' : 1 }

" ---- SETTINGS: General Editor ---- {{{1

"---Editor Spacing/Tab Standards---
filetype indent on  " Set specific filetype indents on TAB
set autoindent  " Setup autoindent
set copyindent  " Setup copyindent to use same style as previous indent
set expandtab  " On pressing tab, insert spaces
set shiftround  " Make indents a multiple of shiftwidth
set shiftwidth=2  " when indenting with '>', use 4 spaces width
set tabstop=2  " Make tabs as wide as two spaces

"---Line Wrapping---
set linebreak " Break lines at words, not characters
set showbreak=+++  " Show indent on long wrapped lines
set wrap  " Setup line wrapping

"---Visual Settings---
set cursorline  " Highlight current line
set laststatus=2  " Always show status line
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_  " Set identifiers for “invisible” characters
set list  " Show “invisible” characters
set number  " Enable line numbers
set relativenumber  " Use relative numbers around absolute in guter
set ruler  " Show the cursor position
set scrolloff=3  " Start scrolling three lines before the horizontal window border
set showtabline=2  " Show the TABLINE
set splitbelow  " Default vertical splits to below
set splitright  " Default horizontal splits to the right
set title  " Show the filename in the window titlebar

"---Folding Settings---
set nofoldenable  " disable folding by default on file open
set foldlevel=0  " fold everything except the top level
set foldlevelstart=0  " fold everything except the top level
set foldmethod=marker  " [manual, marker, indent, syntax]
set foldnestmax=10  " 10 nexted folds maximum

"---Search Settings---
set hlsearch  " Highlight searches
set ignorecase  " Ignore case of searches
set incsearch  " Highlight dynamically as pattern is typed
set lazyredraw  " Don't redraw during macros for better response (N)
set showcmd  " Show the (partial) command as it’s being typed
set showmode  " Show the current mode
set smartcase  " Make search case sensitive if there is uppercase char

"---Misc Settings---
set backspace=indent,eol,start  " Allow backspace in insert mode
set clipboard^=unnamed,unnamedplus  " Use the OS clipboard (vim compiled w/ `+clipboard`)
set encoding=utf-8 nobomb  " Use UTF-8 without BOM
set esckeys  " Allow cursor keys in insert mode
set exrc  " Enable per-directory .vimrc files
set gdefault  " Add the g flag to search/replace by default
set hidden  " Set HIDDEN so you can jump between buffers
set history=100  " Increase scope of history
set mouse=a  " Enable mouse in all modes
set nocompatible  " Make Vim more useful
set noeol  " Don’t add empty newlines at the end of files
set noerrorbells  " Disable error bells
set nomodeline  " Disable modeline for security
set nostartofline  " Don’t reset cursor to start of line when moving around.
set pastetoggle=<F12>  " Setup Paste Toggle to have clean pasted code
set secure  " Disable unsafe commands in per-directory .vimrc files
set shortmess=atI  " Don’t show the intro message when starting Vim
set ttyfast  " Optimize for fast terminal connections
set undolevels=100  " Increase scope of undo
set wildmenu  " Enhance command-line completion


" ---- SETTINGS: FileType Editor ---- {{{1
"
filetype plugin indent on  " Make sure we are loading user overwrites
syntax on  " Enable syntax highlighting (after filetype on)

" Create user overwrite directory for filetype
" note: user file Locations  ~/.vim/after/ftplugin/<filetype>.vim
if !isdirectory($VIMHOME."/after/ftplugin")
    call mkdir($VIMHOME."/after/ftplugin", "p", 0700)
  endif

"---Vim Settings--- {{{2
let vim_settings=[
\ 'set foldmethod=marker       " set for editing the .vimrc file'
\]"
call writefile(vim_settings, $VIMHOME."/after/ftplugin/vim.vim")

"---Python Settings--- {{{2
let python_settings=[
\ 'autocmd BufWritePre *.py :%s/\s\+$//e',
\ 'let python_highlight_all=1  " enable all syntax highlighting features',
\ 'set autoindent              " keep indentation going',
\ 'set colorcolumn=80          " show line length marker',
\ 'set encoding=utf-8          " best for use with python3',
\ 'set expandtab               " convert <tab> to <space>',
\ 'set fileformat=unix         " avoid conversion issues with github',
\ 'set formatoptions=tcqroj    " text wrapping / comment rules',
\ 'set foldlevel=1             " set default folding level at 1',
\ 'set foldmethod=indent       " set all python files for indent folding',
\ 'set shiftround              " use multiple of shiftwidth when indenting',
\ 'set shiftwidth=4            " spaces for shifting',
\ 'set softtabstop=4           " jump to multiples of tabs',
\ 'set tabstop=8               " standard spaceing for starting tab (PEP8)',
\ 'set textwidth=79            " wrap text at 79 for PEP8',
\ 'syntax on                   " make sure highlighting is on',
\]"
call writefile(python_settings, $VIMHOME."/after/ftplugin/python.vim")

"---Markdown Settings--- {{{2
let markdown_settings=[
\ 'set colorcolumn=80          " show line length marker',
\ 'set conceallevel=1          " Show the formatting chars',
\ 'set encoding=utf-8          " best for use with python3',
\ 'set expandtab               " convert <tab> to <space>',
\ 'set foldlevel=0             " set default folding level at 1',
\ 'set foldmethod=expr         " set all markdown files for expression folding',
\ 'set formatoptions=tcqnlj    " text wrapping / comment rules',
\ 'set shiftround              " use multiple of shiftwidth when indenting',
\ 'set shiftwidth=4            " spaces for shifting',
\ 'set softtabstop=4           " jump to multiples of tabs',
\ 'set tabstop=8               " standard spaceing for starting tab (PEP8)',
\ 'syntax on                   " make sure highlighting is on',
\]"
call writefile(markdown_settings, $VIMHOME."/after/ftplugin/markdown.vim")

" ---- PLUGINS: Plugin Install List ---- {{{1

"---Install Vim-Plug---
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"---Plug In List BEGIN---
call plug#begin('~/.vim/plugged')

"---TESTING Plugins---

Plug 'chrisbra/csv.vim'                 " plugin to edit CSV files (2021-07-29)

"---General Env Plugins---
Plug 'cohama/lexima.vim'                " add closing pairs to (,{.[.<,\"
Plug 'djoshea/vim-autoread'             " reload_file: keeps file updated
Plug 'dkarter/bullets.vim'              " autoincement bullet lists
Plug 'easymotion/vim-easymotion'        " jump_to_spot`: s, /
Plug 'ervandew/supertab'                " tab_autocomplete
Plug 'gilsondev/searchtasks.vim'        " tasklist_summary; SearchTasks
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  "fuzzy file searching
Plug 'junegunn/fzf.vim'                 " fuzzy searching of vim (commands, bufferec, history, etc)
Plug 'junegunn/goyo.vim'                " distraction_free
Plug 'junegunn/limelight.vim'           " dulls colors of paragraphs surrounding foused text
Plug 'junegunn/vim-easy-align'          " align text in columns on markers
Plug 'lingceng/z.vim'                   " dir_jump: uses Z for your most used dirs (:Z dir)
Plug 'liuchengxu/vim-which-key'         " show some of your mappings live
Plug 'mbbill/undotree'                  " full undo tracking and diffs
Plug 'mhinz/vim-startify'               " vim startup splashscreen
Plug 'scrooloose/nerdtree'              " file_tree: remap <Leader>f<CR>

"---TextObj Plugins---
Plug 'kana/vim-textobj-user'            " used by the other object plugins
Plug 'glts/vim-textobj-comment'         " vic: select all in commented block
Plug 'kana/vim-textobj-line'            " vil: select all in line
Plug 'michaeljsmith/vim-indent-object'  " text object, based on indentation levels ai,ii,aI,iI
Plug 'wellle/targets.vim'               " smart selection between ([{<\"''\"}])

"---Markdown Plugins---
Plug 'tpope/vim-markdown'               " markdown syntax and list management
Plug 'masukomi/vim-markdown-folding'    " markdown_header_folding
Plug 'itspriddle/vim-marked'            " launch MacOS Marked2.app

"---Coding Plugins---
Plug 'FooSoft/vim-argwrap'              " spread_condense_arrays <L>1
Plug 'airblade/vim-gitgutter'           " git: shows git diff in the gutter
Plug 'honza/vim-snippets'               " snippet_groups
Plug 'nathanaelkane/vim-indent-guides'  " indentation levels shown with columns
Plug 'tpope/vim-commentary'             " comment out using vim motions/objects
Plug 'tpope/vim-fugitive'               " git_cmds: run with :Git $cmd
Plug 'tpope/vim-repeat'                 " global_repeat_actions
Plug 'tpope/vim-surround'               " enclose_txt: cs,ds,ys,S, yss, VS
Plug 'vim-syntastic/syntastic'          " syntax checker using exteral prog (flake8, pylint, pyflakes)
Plug 'vim-airline/vim-airline'          " status_line
Plug 'vim-airline/vim-airline-themes'   " status_line_themes

"---Python Plugins---
Plug 'bitc/vim-bad-whitespace'          " highlight_spaces
Plug 'nvie/vim-flake8'                  " python_pep8: F7; Needs brew install flake8
Plug 'vim-python/python-syntax'         " python_syntax 
Plug 'vim-scripts/indentpython.vim'     " indentation: using PEP8

"---Snippit Engine Plugins---
if (has('python') || has('python3'))
    Plug 'SirVer/ultisnips'             " code templates (uses python)
else
    Plug 'garbas/vim-snipmate'          " code template (uses vimscript)
    Plug 'MarcWeber/vim-addon-mw-utils' "required for snipmate
    Plug 'tomtom/tlib_vim'              "required for snipmate
endif

"---ColorSchemes---
Plug 'altercation/vim-colors-solarized' " color_scheme
Plug 'ayu-theme/ayu-vim'                " color_scheme
Plug 'dracula/vim', { 'as': 'dracula' } " color_scheme
Plug 'jnurmine/Zenburn'                 " color_scheme
Plug 'rakr/vim-one'                     " color_scheme: based off Atom
Plug 'sonph/onehalf', {'rtp': 'vim/'}   " color_scheme
Plug 'tomasr/molokai'                   " color_scheme

call plug#end()


" ---- COLORSCHEMES: Settings ---- {{{1
" IMPORTANT: this has to come AFTER the plugins

"---Shared Settings---

" Setup TRUECOLORS for full color range
" warning: this can cause visual issues in terms not supporting true-colors
if (has("termguicolors"))
  if (exists("$COLORTERM"))
    set termguicolors
  endif
endif

" Setup italic text so it doesn't have a colored background
set t_ZH="\e[[3m"
set t_ZR="\e[[23m"

"---Dracula---
colorscheme dracula

"---ONE---
"colorscheme one
"set background=dark  "called after colorscheme
"let g:airline_theme='one'

"---Molokai---
"colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1  " bring the 256 color version as close as possible

"---Ayu---
"colorscheme ayu
"let ayucolor='mirage'  " for mirage version of them

"---OneHalfDark---
"colorscheme onehalfdark
"let g:airline_theme='onehalfdark'


" ---- ABBREVIATIONS: Mini-Snippets ---- {{{1

iab absetuppy #!/usr/bin/env python3
iab absetupbash #!/usr/bin/env bash
iab ablline # ----------------------------------------------------------------------------
iab abline # -------------------------------------

" ---- FUNCTIONS: User Functions ---- {{{1

" ---DiffWithSaved--- {{{2
" function: to see unsaved changes side by side (:DiffWithSaved)
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" ---StripWhitespace--- {{{2
" function: sript out trailing whitespace (L-ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" ---ClearQuickfixList--- {{{2
" function: Prevent cmds from stacking the Quicklist (L-cc)
function! ClearQuickfixList()
  call setqflist([])
endfunction
command! ClearQuickfixList call ClearQuickfixList()
nnoremap <leader>cc :call ClearQuickfixList()<CR>

" ---JsonFormatter--- {{{2
" function: Pipe buffer through python JSON formatting (:JSONFormatter)
function! JSONFormatter()
  exe '%!python3 -m json.tool'
endfunction
com! JSONFormatter call JSONFormatter()

" ---MarkCodeBlock--- {{{2
" Add Markdown code-block current visual group (m_)
function! s:MarkCodeBlock() abort
    call append(line("'<")-1, '```')
    call append(line("'>"), '```')
endfunction
xnoremap m_ :<c-u>call <sid>MarkCodeBlock()<CR>

" ---- USER COMMANDS: Custom commands filtered through cli ---- {{{1
"
" GetEmails: filter all emails from a selection or whole file, sorted unique
command -range=% -bar GetEmails :<line1>,<line2>!grep -aEio '([a-zA-Z0-9_\.\-]+)@([a-zA-Z0-9_\.\-]+)\.([a-zA-Z]{2,5})' | sort -u

" GetDomains: filter all domains from a selection or whole file, sorted unique
command -range=% -bar GetDomains :<line1>,<line2>!grep -iIohE '(([[:alpha:]](-?[[:alnum:]])*)\.)+[[:alpha:]]{2,}$' | sort -u

" GetIPs: filter IP addresses from a selection or whole file, sorted
command -range=% -bar GetIPs :<line1>,<line2>!grep -aEio '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' | sort -n

" GetURLs: filter URL addresses from a selection or whole file, sorted unique
command -range=% -bar GetURLs :<line1>,<line2>!grep -iIohE 'https?://[^[:space:]"]+' | sort -u

" GetMAC: filter MAC addresses from a selection or whole file, sorted unique
command -range=% -bar GetMAC :<line1>,<line2>!grep -aEio '(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})' | sort -n

" Convert Filenames: Convert text to lowercase, replace spaces with dash
command -range=% -bar Filename :<line1>,<line2>!tr 'A-Z' 'a-z' | tr '_,;: ' '-' | sed -E 's/-+/-/g'

" URL Encode: Convert string to URL safe chars
command -range=% -bar URLEncode :<line1>,<line2>!python3 -c 'import sys; from urllib import parse; print(parse.quote(sys.stdin.read().strip()))'
"
" URL Decode: Convert URL to string
command -range=% -bar URLDecode :<line1>,<line2>!python3 -c 'import sys; from urllib import parse; print(parse.unquote(sys.stdin.read().strip()))'
"
" ---- AUTOCMD: Final Commands ---- {{{1
" note: these could move up to the Settings: FileType Editor area

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    autocmd BufRead,BufNewFile *.txt setlocal textwidth=80
    autocmd BufNewFile,BufRead *.txt setlocal filetype=markdown
    autocmd FileType gitcommit setlocal textwidth=80
endif

"---- TESTING AREA: Trying out new options/functions ---- {{{1

" "NETRW : Test out the built-in file explorer in stead of NERDTree
" "https://blog.stevenocchipinti.com/2016/12/28/using-netrw-instead-of-nerdtree-for-vim/
" " Disable banner
" let g:netrw_banner = 0
" " Set list style to tree view
" let g:netrw_liststyle = 3
" " Open files in previous window
" let g:netrw_browse_split = 4
" " Open splits to the right
" let g:netrw_altv = 1
" " Set window size
" let g:netrw_winsize = 25
" " Auto open netrw on VimEnter
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Lex
" augroup END
" " Map <Leader>nt to open netrw and resize the window
" inoremap <Leader>nt <ESC>:Lex<CR>:vertical resize 30<CR>
" nnoremap <Leader>nt :Lex<CR>:vertical resize 30<CR>

"---- TESTING FZF: normally I use via plugin, but this was in the brew update
set rtp+=/opt/homebrew/opt/fzf
