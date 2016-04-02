set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
let g:vundle_default_git_proto = 'git'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rleon/Zenburn'
Plugin 'tpope/vim-fugitive'
Plugin 'freitass/todo.txt-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wting/gitsessions.vim'
Plugin 'vim-scripts/linuxsty.vim'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Set indentation settings for python scripts
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" Put your non-Plugin stuff after this line
" Set colorscheme
set t_Co=256
colors zenburn

set number
set hlsearch
" F2			- Toggle file browsing (NERDtree)
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <leader>gss :GitSessionSave<cr>
nnoremap <leader>gsl :GitSessionLoad<cr>
nnoremap <leader>gsd :GitSessionDelete<cr>

" Enable word spellchecking
set spell spelllang=en_us
" Always show at least 3 lines below the cusrsor
set scrolloff=3

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Cache session file for gitsessions.vim
let g:gitsessions_use_cache=1

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_text_checkers = ['proselint']
