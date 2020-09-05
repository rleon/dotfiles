" Force to work with python3
let g:pymode_python = 'python3'
execute pathogen#infect()

filetype plugin indent on    " required
" Set indentation settings for python scripts
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set number
set hlsearch
syntax on

set t_Co=256
colorscheme molokai
let g:rehash256 = 1

" Enable word spellchecking
" set spell spelllang=en_us
set spelllang=en_us
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType mail setlocal spell

" Always show at least 3 lines below the cusrsor
set scrolloff=3

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

" Remove trailing white spaces
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e

augroup filetypedetect
	 " Mail
	autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" Set mutt specific configurations
" Add Reviewed-by tag and delete rest of the email
function! RBtag()
	r~/.vim/mutt/rb-tag.txt
endfunction
function! ABtag()
	r~/.vim/mutt/ab-tag.txt
endfunction
autocmd FileType mail nmap <F2> :call RBtag()<CR>2j<CR>dG<CR>
autocmd FileType mail nmap <F3> :call ABtag()<CR>2j<CR>dG<CR>
" To limit the width of text to 72 character for mutt
autocmd FileType mail setlocal tw=72

" Autoread works in gVIM only, but little help is needed for VIM.
" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" Enable vim-easygit
let g:easygit_enable_command = 1
let g:wordy#ring = [
\  ['weasel'], ['passive-voice'], ['being', 'problematic'], ['redundant', 'weak'],
\  ]

" put all splits below, mainly for terminal
set splitbelow

" Exit/return to/from shell
noremap <C-d> :sh<cr>

" Format line in INSERT mode or buffer in VISUAL mode to clang format
map <C-F> :py3f ~/.vim/clang-format.py<cr>
imap <C-F> <c-o>:py3f ~/.vim/clang-format.py<cr>

" bind F1 to grep word under cursor
map <silent> <F1> :Gblame<CR>
"FZF over files
nnoremap <silent> <F2> :Files<CR>

map <F3> :GrepperGit<space>
map <silent> <F4> :GrepperGit <cword><CR>
" open buffer list
" map <silent> <F4> :ls<cr>:b<space>
autocmd FileType gitcommit nmap <F5> :w! /tmp/grammarly.txt <bar> :silent exec "!~/.vim/grammarly commit &" <bar> :redraw!<CR>
autocmd FileType gitsendemail nmap <F5> :w! /tmp/grammarly.txt <bar> :silent exec "!~/.vim/grammarly patch &" <bar> :redraw!<CR>

map <silent> <F9> :ccl<CR>
map <silent> <F12> :NextWordy<CR>

" \gf will add Fixes line according to linux kernel coding standard
nnoremap <leader>gf :read !git fixes<space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :GdiffThis HEAD<CR>

" COC configurations
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Remap :W to be :w and :Q to be :q
" https://stackoverflow.com/a/3879737
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
