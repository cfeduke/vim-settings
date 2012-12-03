" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                  " Must come first because it changes other options.
filetype off

let g:pathogen_disabled = []
if !has('gui_running')
  call add(g:pathogen_disabled, 'command-t')
endif

let g:NumberToggleTrigger="<leader>ln"
call pathogen#infect()
silent! Helptags
syntax on

filetype plugin indent on

set modelines=0

"syntax enable                     " Turn on syntax highlighting.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set softtabstop=2
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
set autoindent
" let the numbertoggle plugin handle this
"set relativenumber                " show line numbers relative to the current line
" Useful status information at bottom of screen
 set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l/%L,%c-%v\ %)%P

" Or use vividchalk
let g:solarized_termcolors=256
let g:solarized_termtrans=1
"let g:solarized_degrade=1

colorscheme solarized

if has('gui_running')
	set background=light
	set guioptions=egmrt
else
	set background=dark
endif

"map leader to comma
let mapleader = ","

" Tab mappings.
"map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove
"imap <Tab> <C-N>
"imap <S-Tab> <C-P>
"vmap <Tab> >gv
"vmap <S-Tab> <gv
"nmap <S-Tab> <C-W><C-W>
" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec


"NERDTree settings
let g:NERDTreeWinPos = "left"
map <leader>nf :NERDTreeFind<cr>
map <F2> :NERDTreeToggle<CR>
"map <Leader>n :NERDTreeToggle<CR>
" don't open nerdtree on directory opens
let NERDTreeHijackNetrw=1 

nmap <silent> <leader>n :silent :nohlsearch<CR>

" dbext settings
let g:dbext_default_type   = 'MYSQL'

"let g:dbext_default_use_sep_result_buffer = 1

let g:sql_type_default = 'mysql'


" highlight tabs and trailing spaces
set listchars=tab:>-,trail:-
" set list

au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/bundle/thrift/syntax/thrift.vim

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" fuzzy finder
nmap <leader>f :FufFile<CR>  
nmap <leader>o :FufCoverageFile<CR>
nmap <leader>d :FufFileWithCurrentBufferDir<CR>
nmap <leader>b :FufBuffer<CR>
"nmap <leader>t :FufTaggedFile<CR>
noremap <leader>j :FufLine<CR>

hi CursorLine   cterm=NONE ctermbg=black guibg=#e4e4e4
hi CursorColumn cterm=NONE ctermbg=black guibg=#e4e4e4
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>

" from http://zwiener.org/vimautocomplete.html
" complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" limit popup menu height
set pumheight=15
" supertab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"
" disable autopopup, use <Tab> to autocomplete
let g:clang_complete_auto = 0
" show clang errors in the quickfix window
let g:clang_complete_copen = 1

" VimClojure
au Bufenter,Bufnewfile *.clj setl complete+=k~/.clj_completions


" omnicompletion
set ofu=syntaxcomplete#Complete

" by default enable the cursor crosshairs
set cursorline! cursorcolumn!

" searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" gutter column
set colorcolumn=120

" remove arrow keys crutch
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" disable the help key, can just use :help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" allow ; to work just like : (no shift)
nnoremap ; :

" lose focus and sove
"au FocusLost * :wa

" strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" ack
nnoremap <leader>a :Ack

" select lines of text just pasted
nnoremap <leader>v V`]

" since no words contain "jj" have "jj" act as ESC
inoremap jj <ESC>

" open a new vertical split and change focus to it
nnoremap <leader>w <C-w>v<C-w>l
" navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" yankring shortcuts
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" editing files in the current file's directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" map </ to automatically close tags
:iabbrev </ </<C-X><C-O>

" I like numbers when I enter a file in command mode
set number
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","
nmap <leader>vrc :tabedit $MYVIMRC<CR>
" undo trees
nnoremap <F4> :GundoToggle<CR>
