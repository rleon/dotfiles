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
Plugin 'vim-scripts/cscope_macros.vim'

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
" let g:gitsessions_use_cache=1

" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

" Vim quickfix list launch files in new tab
set switchbuf+=usetab,newtab
