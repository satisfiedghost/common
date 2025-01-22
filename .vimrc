set number
set autoindent expandtab tabstop=2 shiftwidth=2
set laststatus=2
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set wildmenu
set backspace=indent,eol,start
"set foldmethod=syntax
set foldlevelstart=99

autocmd FileType python setlocal foldmethod=indent

highlight Search ctermfg=red ctermbg=cyan guifg=white guibg=#6A07F7

command! -nargs=1 Toggle execute 'set ' . <q-args> . '!'

" Cursor Colors
if &term =~ 'xterm'
    let &t_ti.="\e]12;#270A9C\x7"
    let &t_te.="\e]12;white\x7"
endif

nnoremap <leader><space> :nohlsearch<CR>

" Makes window navigation the same as tmux
nnoremap <C-b> <C-w>
