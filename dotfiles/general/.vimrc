" vim files
set viminfo=
set noswapfile
set nobackup
set undodir=$HOME/.vim/
" Editor settings
syntax on
set incsearch
set invnumber
set relativenumber
set smartindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set cursorline
color iceberg
" Enable mouse in all modes if possible
if has('mouse')
	set mouse=a
endif
" Fixes backspace not working
set backspace=indent,eol,start
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
