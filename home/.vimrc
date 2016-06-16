" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

" Change <Leader>
let mapleader = ","

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

colorscheme sourcerer
set background=light

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set wrapscan      " Searches wrap around end of the file.
set ignorecase
set smartcase
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline    " highlight the current line the cursor is on
set diffopt+=vertical

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

"sm:    flashes matching brackets or parentheses
set showmatch

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

"sta:   helps with backspacing because of expandtab
set smarttab

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" Enable tab complete for commands.
" first tab shows all matches. next tab starts cycling through the matches
set wildmenu
set spelllang=en_gb


" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  "command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" configure syntastic syntax checking to check on open as well as save
"let g:syntastic_check_on_open=1
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }


let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1
nnoremap <leader>w :SyntasticCheck<CR>:w<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Open the Rails ApiDock page for the word under cursor, using the 'open'
" command
let g:browser = 'open '

function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  exec '!'.g:browser.' '.url
endfunction

" Open the Ruby ApiDock page for the word under cursor, using the 'open'
" command
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  exec '!'.g:browser.' '.url
endfunction

" NERDTree
let NERDTreeQuitOnOpen=1
" colored NERD Tree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']

"" Shortcuts!!

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -r .<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Tab navigation
nmap <space> gt

" Remap F1 from Help to ESC.  No more accidents.
nmap <F1> <Esc>
map! <F1> <Esc>

" <leader>F to begin searching with ag
map <leader>F :Ag<space>

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap * *Nzz
nmap # #nzz

" Capital Y yanks to clipboard
noremap Y "+y

" Easily lookup documentation on apidock
noremap <leader>rb :call OpenRubyDoc(expand('<cword>'))<CR>
noremap <leader>rr :call OpenRailsDoc(expand('<cword>'))<CR>

" Easily spell check
" http://vimcasts.org/episodes/spell-checking/
nmap <silent> <leader>s :set spell!<CR>

" Added by Leo

" Switch into background mode
nnoremap <leader>. <C-z>

" Git shortcut
map <leader>g :Git<space>

" Move between splits
nnoremap <S-Tab> <C-W>W
nnoremap <Tab> <C-W><C-W>

" Paste mode in and out
nnoremap <leader>p :set paste<CR>
nnoremap <leader>np :set nopaste<CR>

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" JJ escape
inoremap jj <ESC>

:au FocusLost * :wa

"save and run last command
nnoremap <CR> :wa<CR>:!!<CR>

"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"make ctrl-c work with vim on a mac
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

autocmd FileType javascript inoremap (; ();<Esc>hi
set autowrite

set shell=$SHELL

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" such very magic
":nnoremap / /\v
:cnoremap %s/ %s/\v

" Indentation
nnoremap == gg=G``
nnoremap <Leader>i gg=G``

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
inoremap <Left> Use h
inoremap <Right> Use l
inoremap <Up> Use k
inoremap <Down> Use j


" Convert to ruby 1.9 hash
nnoremap <Leader>H :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

nnoremap <leader>q <C-w>q
nnoremap <leader>w :StripWhitespace<CR>
map zx :wqa<CR>

" Toggle paste mode
nnoremap <leader>p :set invpaste paste?<CR>
imap <leader>p <C-O>:set invpaste paste?<CR>
set pastetoggle=<leader>p

" Move up and down by visual line
nnoremap j gj
nnoremap k gk

" Relative line number toggle
let g:NumberToggleTrigger="<leader>r"

" Pomodoro
nmap <leader>T :!thyme -d<CR><CR>

nnoremap <C-o> o<Esc>
nnoremap <C-O> O<Esc>

" Hard times
let g:hardtime_default_on = 0
nnoremap <leader>h :HardTimeToggle<CR>
let g:hardtime_timeout = 900
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 2

" Run feature tests
nnoremap <leader>f :!clear && echo "Running all feature tests" && rspec features<CR>

nnoremap <leader>vs :so $MYVIMRC <CR>:VundleInstall <CR>:q <CR> :echo "Vimrc has been reloaded"<CR>
nnoremap <leader>S :so $MYVIMRC<CR> :echo "Vimrc has been reloaded"<CR>

" Convert html to haml
nmap <leader><leader>h :%!html2haml --erb 2> /dev/null<CR>:set ft=haml<CR>
vmap <leader><leader>h :!html2haml --erb 2> /dev/null<CR>

" Automatically run a file
function! RunWith (command)
  execute "w"
  execute "!clear; " . a:command . " " . expand("%")
endfunction

autocmd FileType ruby nnoremap <leader>q :call RunWith("ruby")<CR>
autocmd FileType javascript nnoremap <leader>q :call RunWith("node")<CR>
autocmd FileType python nnoremap <leader>q :call RunWith("python")<CR>

" Put a single line cursor in insert mode
" https://gist.github.com/andyfowler/1195581
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
