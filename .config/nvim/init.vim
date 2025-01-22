set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'yassinebridi/vim-purpura'
Plug 'ggandor/leap.nvim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'qpkorr/vim-bufkill'



call plug#end()

lua require('plugins.lualine')
lua require('plugins.telescope')
lua require('plugins.treesitter')
lua require('leap').create_default_mappings()

colorscheme retrobox
hi Normal ctermbg=none guibg=none
hi LineNr ctermbg=none guibg=none
hi SignColumn ctermbg=none guibg=none
hi EndOfBuffer ctermbg=none guibg=none

cabbrev bc bd

set clipboard=unnamedplus

nnoremap <leader>ff <cmd>Telescope find_files follow=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Set the first file to be writable
let g:first_file_opened = 0

" Save the last cursor position and restore it when reopening a file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

" thanks, ChatGPT
" '25: Remember marks for the last 25 files.
" <5000: Remember up to 5000 KiB of command-line history.
" s10: Store search history for the last 10 items.
" h: Save global variables.

set shada='25,<5000,s10,h

" Ensure the first file is writable, others are readonly
autocmd BufReadPost * if g:first_file_opened == 0 | let g:first_file_opened = 1 | else | setlocal readonly | endif

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
autocmd FileType nerdtree cnoreabbrev <buffer> bd :echo "No you don't"<cr>
autocmd FileType nerdtree cnoreabbrev <buffer> bc :echo "No you don't"<cr>
let g:NERDTreeWinPos = "right"
cabbrev bd BD
cabbrev bc BD
cabbrev bw BW
cabbrev bun BUN



set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

set updatetime=300
