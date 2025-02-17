" ----------------------------------------
" VIMRC SYSTEM SETTINGS
" ----------------------------------------
" vim --clean (to run default vim)

" ---- CONFIGS: VIM Keymaps & Folders ---- {{{1

" ---System Keyboard Mappings--- {{{2

" Map additional <ESC> keys
inoremap jk <ESC>
inoremap kj <ESC>

" Map ZZ to quit without saving
:nnoremap ZZ :q!<CR>

" Map <space> as the <leader> key
nnoremap <Space> <Nop>
let mapleader=" "
"let maplocalleader=","

" Map <leader>-; as alternative for : to make it easier
nnoremap <Leader>; :

" Map <leader>-<TAB> to allow tabbing between buffers
nnoremap <Leader><TAB> :bnext<CR>
nnoremap <Leader><S-TAB> :bprev<CR>

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
nnoremap <Leader>bb :bnext<CR>
nnoremap <Leader>bC :%bd<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bn :enew<CR>
nnoremap <Leader>dd :bdelete<CR>
nnoremap <Leader>xx :q!<CR>

" Map shortcut for quick folding/unfolding
nnoremap <Leader><space> zA

" Map shortcut for spell checking (use s[, z=, zg)
nnoremap <Leader>sc :set spell spelllang=en_us<CR>
nnoremap <Leader>sp :normal! mz[s1z=`z<CR>

" Map F2 to all visable line numbers and special chars (for copy)
nmap <F2> :set norelativenumber!<bar>set nonumber!<bar>set nolist!<CR>

" Map Leader-F2 to switch between relative and sequential line numbers
nmap <leader><F2> :set relativenumber!<CR>

" Save a file as root (L-W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Allow searching of a visual selection (//)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" vim-powered terminal in split window
map <Leader>tt :term ++close<cr>
tmap <Leader>tt <c-w>:term ++close<cr>
" vim-powered terminal in new tab
map <Leader>TT :tab term ++close<cr>
tmap <Leader>TT <c-w>:tab term ++close<cr>

" VimGrep Customization
let &grepprg="grep -HRIn $* ."
nnoremap <leader>gr :copen \| :silent :grep
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" Map to paste a blank line below
nnoremap <Leader>o :put_<CR>

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


" ---- CONFIGS: Plugin Keymaps & Settings ---- {{{1

" AI : OpenAI / ChatGPT keybindings
" make sure your env has export OPENAI_API_KEY="<YOUR KEY>"
" complete text on the current line or in visual selection
nnoremap <leader>ai :AI
xnoremap <leader>ai :AI
xnoremap <leader>aI :AI<CR>
nnoremap <leader>aI :AI<CR>
" edit text with a custom prompt
xnoremap <leader>ae :AIEdit
nnoremap <leader>ae :AIEdit
" edit text with a custom prompt
xnoremap <leader>as :AIEdit fix grammar and spelling<CR>
nnoremap <leader>as :AIEdit fix grammar and spelling<CR>
" trigger chat
xnoremap <leader>ac :AIChat /right<CR>
" nnoremap <leader>ac :AIChat<CR>"
nnoremap <leader>ac :AIChat /right<CR>

" AIRLINE : Advanced status bar on the bottom
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if has('macunix')  " use powerline fonts if launched from iTerm
  let g:airline_powerline_fonts = 1
endif

" ALE : Code linter and fixer system
" for LSP servers look here https://langserver.org/
let b:ale_linters = {
      \  'python': ['ruff'],
\}
let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'json': ['prettier'],
      \  'markdown': ['prettier'],
      \  'python': ['ruff_format', 'isort'],
      \  'sql': ['sqlfluff'],
      \  'yaml': ['prettier'],
\}
nnoremap <leader>cf :ALEFix<CR>



" ARGWRAP : Reformats Python lists between one to multiline (L-1)
nnoremap <silent> <leader>1 :ArgWrap<CR>

" EASYALIGN : Align text based on characters visual (vipga) motion/text (gaip)
" note: Align comments and ":  vipga-<space>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" EASYMOTION : Quick search/jump to text (s)
let g:EasyMotion_do_mapping = 0  " disable extra mappings
let g:EasyMotion_smartcase = 1  " smartcase searching
nmap s <Plug>(easymotion-s)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" FUGITIVE : Git commands built into VIM
nnoremap <Leader>gg :G<CR>

" FZF FINDER : Fuzzy searching of files, buffers, history, etc. (L-f?)
" (recommended installs: Rg, bat)
" Initialize configuration dictionary
" let g:fzf_vim = {}
" let g:fzf_vim.preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']
" let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
set rtp+=/opt/homebrew/opt/fzf
nmap <Leader>fH :Helptags<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fc :Commands<CR>
nmap <Leader>fC :Colors<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fg :GFiles?<CR>
nmap <Leader>fh :History<CR>
nmap <Leader>fl :Lines<CR>
nmap <Leader>fL :BLines<CR>
nmap <Leader>fm :Marks<CR>
nmap <Leader>fM :Maps<CR>
nmap <Leader>fr :Rg<Space>
nmap <Leader>fs :Snippets<CR>
nmap <Leader>fT :Filetypes<CR>

" GITGUTTER : Navigation & Shows changes in git managed files (]c,]h)
nnoremap <Leader>gd :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gD :GitGutterDiffOrig<CR>

" GOYO / LIMELIGHT : Distraction free and focused writing (L-gy)
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <Leader>gy :Goyo<CR>

" INDENT GUIDES : Bars showing indent levels (L-ig)
" hi IndentGuidesOdd  ctermbg=darkgrey
" hi IndentGuidesEven ctermbg=black
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 0
let g:indent_guides_start_level = 1

" MARKDOWN : Markdown Syntax, automation
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" MARKDOWN FOLDING : Markdown folding styles
let g:vim_markdown_folding_style_pythonic = 1

" MARKED : Activate MacOS Marked2 with (L-md)
nnoremap <Leader>md :MarkedOpen!<CR>
let g:marked_auto_quit = 1

" NERDTREE : Directory tree and explorer (L-ft)
" Custom open command that will toggle, and open at file in buffer
nnoremap <silent> <expr> <Leader>ft g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" OLLAMA : Plugin settings and keybindings
" autocmd VimEnter * Ollama disable
" nmap <Leader>ao :Ollama toggle<CR>
" let g:ollama_debug = 0
" let g:ollama_model = 'mistral-nemo'
" let g:ollama_chat_model = 'llama3.2'
" mistral-nemo:latest        7.1 gb
" mistral:latest             4.1 gb
" llama3.2:latest            2.0 gb
" deepseek-coder-v2:16b      8.9 GB

" SEARCHTASKS : Search files for tags like TODO (L-st)
" note: use the function ClearQuickfillList (L-cc) to free up
let g:searchtasks_list=["TODO", "FIXME"]
nnoremap <Leader>st :SearchTasks %<CR>

" SNIPMATE : Plugin that allows for smart/responsive text snippets
let g:snipMate = { 'snippet_version' : 1 }

" UNDOTREE : program to visualize/switch unto changes (L-uu)
nnoremap <Leader>uu :UndotreeToggle<CR>

" WHICHKEY : Activate to see what is mapped to Leader (L)
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>


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
set guifont=Hack\ Nerd\ Font:h13  " Default font used by gvim or macvim

"---Folding Settings---
set nofoldenable  " disable folding by default on file open
set foldlevel=0  " fold everything except the top level
set foldlevelstart=0  " fold everything except the top level
set foldmethod=marker  " [manual, marker, indent, syntax]
set foldnestmax=10  " 10 nexted folds maximum

"---Search Settings---
set gdefault  " Add the g flag to search/replace by default
set hlsearch  " Highlight searches
set ignorecase  " Ignore case of searches
set incsearch  " Highlight dynamically as pattern is typed
set lazyredraw  " Don't redraw during macros for better response (N)
set path+=**   " Fuzzy search into folders, tab-completion (without plugin)
set showcmd  " Show the (partial) command as it’s being typed
set showmode  " Show the current mode
set smartcase  " Make search case sensitive if there is uppercase char

"---Misc Settings---
set backspace=indent,eol,start  " Allow backspace in insert mode
set clipboard^=unnamed,unnamedplus  " Use the OS clipboard (vim compiled w/ `+clipboard`)
set encoding=utf-8 nobomb  " Use UTF-8 without BOM
set esckeys  " Allow cursor keys in insert mode
set exrc  " Enable per-directory .vimrc files
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
set ssop-=folds " do not store folds in a session
set ssop-=options " do not store global and local values in a session
set ttyfast  " Optimize for fast terminal connections
set undolevels=100  " Increase scope of undo
set wildmenu " Display all matches when we tab compliete, (:find)



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
" Plug 'sheerun/vim-polyglot'             " great syntax package (?needed)
" Plug 'gergap/vim-ollama'                " plugin to utilize a local ollama install for AI work

"---General Env Plugins---
Plug 'djoshea/vim-autoread'             " reload_file: keeps file updated
Plug 'dkarter/bullets.vim'              " autoincement bullet lists (gN)
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
Plug 'TaDaa/vimade'                     " window focus fading / highlighting

"---TextObj Plugins---
Plug 'glts/vim-textobj-comment'         " vic: select all in commented block
Plug 'kana/vim-textobj-line'            " vil: select all in line
Plug 'kana/vim-textobj-user'            " used by the other object plugins
Plug 'michaeljsmith/vim-indent-object'  " text object, based on indentation levels ai,ii,aI,iI
Plug 'wellle/targets.vim'               " smart selection between ([{<\"''\"}])

"---Markdown Plugins---
Plug 'itspriddle/vim-marked'            " launch MacOS Marked2.app
Plug 'masukomi/vim-markdown-folding'    " markdown_header_folding

"---AI Plugins---
if has('python3')
  Plug 'madox2/vim-ai'                    " OpenAI / ChatGPT integration (needs curl and OPENAI_API_KEY)
  if !exists("OPENAI_API_KEY") | let g:vim_ai_token_file_path = "~/.openai.token" | endif
endif

"---Coding Plugins---
Plug 'FooSoft/vim-argwrap'              " spread_condense_arrays (L-1)
Plug 'airblade/vim-gitgutter'           " git: shows git diff in the gutter
Plug 'dense-analysis/ale'               " language syntax checker, depends on engines (ruff, )
Plug 'honza/vim-snippets'               " contains snippets in snippets/UltiSnips format for various languages
Plug 'nathanaelkane/vim-indent-guides'  " indentation levels shown with columns
Plug 'tpope/vim-commentary'             " comment out using vim motions/objects
Plug 'tpope/vim-fugitive'               " git_cmds: run with :Git $cmd
Plug 'tpope/vim-repeat'                 " global_repeat_actions
Plug 'tpope/vim-surround'               " enclose_txt: S',cs,ds,ys,yss,VS
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
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'dracula/vim', { 'as': 'dracula' } " color_scheme
Plug 'ghifarit53/tokyonight-vim', { 'as': 'tokyonight' } " color_scheme
Plug 'nanotech/jellybeans.vim'          " color_scheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}   " color_scheme
Plug 'tomasr/molokai'                   " color_scheme

"---MUST BE LOADED LAST---
Plug 'ryanoasis/vim-devicons'           " custom icons for files & folders

call plug#end()


" ---- COLORSCHEMES: Settings ---- {{{1
" IMPORTANT: this has to come AFTER the plugins

"---Shared Settings---

set background=dark

" Set Truecolors if the terminal is iTerm
if &term =~ '256color' && exists("$ITERM_PROFILE")
	if has('termguicolors')
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		set termguicolors
	endif
endif

" Setup italic text so it doesn't have a colored background
set t_ZH="\e[[3m"
set t_ZR="\e[[23m"

"---Dracula---
"colorscheme dracula

"---Tokyonight---
colorscheme tokyonight
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:airline_theme = "tokyonight"

"---Molokai---
"colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1  " bring the 256 color version as close as possible

"---OneHalfDark---
"colorscheme onehalfdark
"let g:airline_theme='onehalfdark'


" ---- ABBREVIATIONS: Mini-Snippets ---- {{{1

iab abpy #!/usr/bin/env python3
iab abbash #!/usr/bin/env bash
iab abline # -------------------------------------
" TODO: iab abdt <ESC>:r!date
iab ablongline # ----------------------------------------------------------------------------

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
" Add Markdown code-block current visual group (m_ <--UNDERSCORE)
function! s:MarkCodeBlock() abort
    call append(line("'<")-1, '```')
    call append(line("'>"), '```')
endfunction
xnoremap <Leader>mc :<c-u>call <sid>MarkCodeBlock()<CR>

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
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    autocmd BufNewFile,BufRead *.txt setlocal filetype=markdown
    autocmd FileType gitcommit setlocal textwidth=80
endif

" ---- SETTINGS: FileType Customization ---- {{{1
"
filetype plugin indent on  " Make sure we are loading user overwrites
syntax on  " Enable syntax highlighting (after filetype on)

" Create user overwrite directory for filetype
" note: user file Locations  $HOME/.vim/after/ftplugin/<filetype>.vim
if !isdirectory($VIMHOME."/after/ftplugin")
    call mkdir($VIMHOME."/after/ftplugin", "p", 0700)
  endif

"---Vim Settings--- {{{2
let vim_settings=[
\ 'set colorcolumn=80          " show line length marker',
\ 'set foldmethod=marker       " set for editing the .vimrc file'
\]"
if !filereadable($VIMHOME."/after/ftplugin/vim.vim")
    call writefile(vim_settings, $VIMHOME."/after/ftplugin/vim.vim")
endif

"---Python Settings--- {{{2
let python_settings=[
\ 'autocmd BufWritePre *.py :%s/\s\+$//e   " strip whitespace on save',
\ 'let g:ale_fix_on_save = 1   " allow ALE to autofix file on save',
\ 'let python_highlight_all=1  " enable all syntax highlighting features',
\ 'set colorcolumn=80          " show line length marker',
\ 'set fileformat=unix         " avoid conversion issues with github',
\ 'set formatoptions=tcqroj    " text wrapping / comment rules',
\ 'set foldlevel=1             " set default folding level at 1',
\ 'set foldmethod=indent       " set all python files for indent folding',
\ 'set shiftwidth=4            " spaces for shifting',
\ 'set softtabstop=4           " jump to multiples of tabs',
\ 'set tabstop=8               " standard spaceing for starting tab (PEP8)',
\ 'set textwidth=79            " wrap text at 79 for PEP8',
\]"
if !filereadable($VIMHOME."/after/ftplugin/python.vim")
  call writefile(python_settings, $VIMHOME."/after/ftplugin/python.vim")
endif

"---Markdown Settings--- {{{2
let markdown_settings=[
\ 'set colorcolumn=80          " show line length marker',
\ 'set conceallevel=1          " Show the formatting chars',
\ 'set foldmethod=expr         " set all markdown files for expression folding',
\ 'set formatoptions=tcqnlj    " text wrapping / comment rules',
\ 'set shiftwidth=4            " spaces for shifting',
\ 'set softtabstop=4           " jump to multiples of tabs',
\ 'set tabstop=8               " standard spaceing for starting tab (PEP8)',
\ 'set textwidth=79            " wrap text at 79 for PEP8',
\]"
if !filereadable($VIMHOME."/after/ftplugin/markdown.vim")
  call writefile(markdown_settings, $VIMHOME."/after/ftplugin/markdown.vim")
endif

"---- CHEAT SHEET WINDOW: function and data for all my Vim commands ---- {{{1

function! ShowCheatSheet(varname)
    " Open a new window
    vnew
    " Set the buffer as a scratch buffer
    setlocal buftype=nofile
    " Disable swap file
    setlocal noswapfile
    " Put the variable's contents into the buffer
    "exe "put =" . a:varname
    for item in a:varname
        call append('$', item)
    endfor
    " Prevent modification by accident
    setlocal nomodifiable
    " Automatically delete the buffer when closing the window
    autocmd BufLeave <buffer> bwipeout
endfunction
noremap <leader>hh :call ShowCheatSheet(my_vim_cheatsheet)<CR>

let my_vim_cheatsheet=[
      \"---- CHEATSHEET BASICS ----",
      \"",
      \"'a..z   - N: jump to mark in buffer",
      \"50%     - N: jump to % of file",
      \"<C>]    - N: jump to tag source",
      \"<C>a    - N: increment number at cursor",
      \"<C>d    - C: show all options for command",
      \"<C>f    - C: edit command mode line",
      \"<C>n    - I: completion window",
      \"<C>r    - N: redo",
      \"<C>r a  - I: paste register a",
      \"<C>t    - N: jump back to tag",
      \"<C>v    - N: visual block mode",
      \"<C>x    - N: decrement number at cursor",
      \"=z      - N: suggest spelling",
      \"@a..z   - N: play a macro from register",
      \"B       - N: move to beginning of word (skip special)",
      \"E       - N: move to end of word (skip special)",
      \"H       - N: jump to HIGH/top of screen",
      \"L       - N: jump to LOW/bottom of screen",
      \"M       - N: jump to MEDIUM/middle of screen",
      \"S[({']  - V: surround selection",
      \"U       - N: undo all edits in line",
      \"V       - N: visual line mode",
      \"ZQ      - N: quit without saving",
      \"ZZ      - N: quit with saving",
      \"[#*]    - N: make the word under cursor the search object",
      \"\"=     - N: register for math calculation",
      \"\"a..z  - N: reference a register a..zA..Z0..9",
      \"`.      - N: jump to last change in buffer",
      \"b       - N: move to beginning of word",
      \"cs'(    - N: change surrounding item/brackets/tags",
      \"ds(     - N: delete surrounding item/brackets",
      \"e       - N: move to end of word",
      \"g&      - N: run last search & replace on entire buffer",
      \"gN      - N: renumber lists for selected text",
      \"gU      - V: change to upper case",
      \"gUU     - N: change line to upper case",
      \"ga      - V: EasyAlign",
      \"gc      - V: comment out selection",
      \"gcc     - I: comment out line",
      \"gd      - N: goto definition/function named under cursor",
      \"gf      - N: open FILE in path",
      \"ggg?G   - N: ROT13 entire file",
      \"gu      - V: change to lower case",
      \"guu     - N: change line to lower case",
      \"gv      - N: re-select last selection",
      \"gx      - N: open URL in browser",
      \"m[A..Z] - N: mark point in buffers across files",
      \"m[a..z] - N: mark point in buffer",
      \"o       - V: switch between selection beginning & end",
      \"s       - N: easymotion jump to char on screen",
      \"u       - N: undo last edit",
      \"v       - N: visual mode",
      \"viwp    - V: paste over word (replace)",
      \"xp      - N: swap characters",
      \"ys[]B   - I: quick surround with curly brackets {}",
      \"ys[]b   - I: quick surround with brackets ()",
      \"zM      - N: fold all",
      \"zR      - N: unfold all",
      \"zg      - N: add word to spelling dictionary",
      \"~       - V: invert case",
      \"",
      \"---- ACTIONS ----",
      \"",
      \"c       - change",
      \"d       - delete",
      \"y       - yank (copy)",
      \"ys      - surround",
      \"",
      \"---- ACTION RANGE ----",
      \"",
      \"[]a[]       - AROUND",
      \"[]i[]       - IN",
      \"[]t[char]   - TILL Char",
      \"",
      \"---- ACTION TARGETS ----",
      \"",
      \"[]p     - paragraph",
      \"[]s     - sentence",
      \"[]t     - tags",
      \"[]w     - word",
      \"[]{     - brackets",
      \"",
      \"",
      \"---- GIT / FUGITIVE COMMANDS ----",
      \"",
      \"-       - GIT TOGGLE stage file",
      \"=       - GIT diff file",
      \"cc      - GIT commit file",
      \"dv      - GIT diff vsplit file",
      \"s       - GIT stage file",
      \"u       - GIT unstage file",
      \"",
      \"",
      \"---- LEADER KEYS (L-) ----",
      \"",
      \"F2      - toggle relative line numbers",
      \"ai      - AI command",
      \"ac      - AI chat",
      \"ae      - AI edit",
      \"bC      - buffer close all",
      \"bb      - buffer next",
      \"bd      - buffer delete",
      \"bn      - buffer new",
      \"fb      - Fzf find buffers",
      \"fc      - Fzf find commands",
      \"ff      - FzF find file",
      \"fg      - Fzf find Git files",
      \"fr      - Rg search all files for target",
      \"fs      - Fzf find snippets",
      \"ft      - file tree (NERDTree)",
      \"gD      - Git diff",
      \"gd      - Git gutter toggle",
      \"gg      - Git status/commit",
      \"gr      - vimgrep with quicklist",
      \"gy      - focused mode",
      \"hh      - open help (cheatsheet)",
      \"ig      - indent guide toggle",
      \"mc      - enclose in markdown code block",
      \"md      - open file in Marked2 (markdown)",
      \"rf      - reflow paragraph",
      \"ss      - strip trailing whitespace",
      \"st      - search for all TODO/FIXME",
      \"uu      - undo tree window",
      \"ve      - .VIMRC edit",
      \"vr      - .VIMRC reload",
      \"wc      - window close",
      \"wn      - window new horizontal",
      \"wv      - window new vertical",
      \"ww      - cycle through windows",
      \"x       - mark checbox",
      \"xx      - quit nosave",
      \"",
      \"---- SYSTEM COMMANDS ----",
      \"",
      \":%s/old/new/g              - search and replace (global)",
      \":s/old/new/c               - search and replace (confirm)",
      \":s/old/new/g               - search and replace (selection)",
      \":set ff=dos                - set filetype to DOS",
      \":set ff=unix               - set filetype to UNIX",
      \":set list                  - show hidden characters",
      \":set spell spelllang=en_us - enable spellcheck",
      \"",
      \"---- SPECIAL COMMANDS ----",
      \"",
      \":!cmd                       - pipe through command (. % V)",
      \":.!sh                       - run the current line in the shell",
      \":DiffSaved                  - vertical diff between buffer and file",
      \":EasyAlign 2 /-/            - align on 2nd custom delimiter",
      \":Gvdiffsplit HEAD~1         - git diff recent commit with previous",
      \":let @a='C-r C-r a          - edit and replace macro",
      \":RenumberSelection          - renumber lists for selected text",
      \":mks filename               - make session wiht filename (load with source",
      \":reg                        - list contents of registers",
      \"<C>[hjkl]                   - window direction navigation",
      \"F12                         - toggle code paste mode",
      \"F2                          - toggle line numbers & special chars",
      \"[VB]A<ESC>                  - multiline insert at end of line (APPEND)",
      \"[VB]I<ESC>                  - multiline insert at cursor",
      \"[search]cgn[new].           - selective replace search term with new item",
      \"vim scp://name@host/path    - edit remote file(s)",
      \"",
      \"---- SPECIAL SEARCHES ----",
      \"",
      \":%s#<[^>]\+>##g             - strip all HTML tags",
      \":%s/ITEM//gc                - search and replace, asking for each",
      \":%s/ITEM//gn                - search and count instances of ITEM",
      \":%s/e\([0-9]\)/e_\1/g       - search and keep matches in replacement",
      \":g!/ITEM/d                  - filter out lines without item",
      \":g/ITEM/d                   - filter out lines with item",
      \":g/pattern/y B              - find pattern and put into B register",
      \":lvmgrep ITEM % | lopen     - open local location with pattern",
      \":vimgrep ITEM % | copen     - open quickfix with pattern",
      \"",
      \"---- USEFUL URLS ----",
      \"",
      \"https://learnvim.irian.to/                                          - Learn vim",
      \"https://www.youtube.com/watch?v=wlR5gYd6um0                         - Mastering The Vim Language",
      \"https://www.youtube.com/watch?v=aHm36-na4-4                         - More Instantly Better Vim",
      \"https://realpython.com/vim-and-python-a-match-made-in-heaven/       - RealPython: Vim and Python",
      \"https://devhints.io/vim-easyalign                                   - EasyAlign examples",
\]"

"---- TESTING AREA: Trying out new options/functions ---- {{{1

" TODO: this is not working
let @b=@*  " Backup system clipboard to b register incase user yank/del before paste

" TESTING - OPENAI Variable detection
if !exists("OPENAI_API_KEY") | let g:vim_ai_token_file_path = "~/.openai.token" | endif
