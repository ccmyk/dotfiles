
" Set to show line numbers
" set number
  
" Enable syntax highlighting
syntax on

" Escape on kj keybinding
:imap kj <Esc>

" Set how many lines of history VIM should remember
set history=500

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Enable wildmeny for command line completions
" Hit <Tab> after : and see what will happen
set wildmenu

" Always show current position
set ruler
" Heigh of command bar
set cmdheight=2

"A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
" If a pattern contains an uppercase letter, it is case sensitive.
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" Highlight possible results when typing
set incsearch

" Show matching brackets when text indicator is over them
set showmatch 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

call plug#begin()

Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'tmux-plugins/vim-tmux'
Plug 'mortonfox/nerdtree-ag'
Plug 'ryanoasis/vim-devicons'
Plug 'mbbill/undotree'
Plug 'sjl/gundo.vim'
Plug 'christoomey/vim-tmux-navigator'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

colorscheme phoenix
let g:airline_theme='zenburn'

" Always show the status line
set laststatus=2

 
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction
