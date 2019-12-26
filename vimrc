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
setlocal spell spelllang=en_us

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

" To limit the width of text to 72 character for mutt
" au BufRead /tmp/mutt-* set tw=72

augroup filetypedetect
	 " Mail
	autocmd BufRead,BufNewFile *mutt-* setfiletype mail
	 " Add Reviewed-by tag and delete rest of the email
	function! RBtag()
		r~/.vim/mutt/rb-tag.txt
	endfunction
	nmap rt :call RBtag()<CR>2j<CR>dG<CR>
augroup END

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

" Exit/return to/from shell
noremap <C-d> :sh<cr>

" Format line in INSERT mode or buffer in VISUAL mode to clang format
map <C-F> :py3f ~/.vim/clang-format.py<cr>
imap <C-F> <c-o>:py3f ~/.vim/clang-format.py<cr>

" bind F4 to grep word under cursor
map <F4> :GrepperGit <cword><CR>

" \b will open buffer list
nnoremap <leader>b :ls<cr>:b<space>

" \gf will add Fixes line according to linux kernel coding standard
nnoremap <leader>gf :read !git fixes<space>
" Enable vim-easygit
let g:easygit_enable_command = 1
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nmap <leader>gt <Plug>(git-time-lapse)
nnoremap <leader>gd :GdiffThis HEAD<CR>

" vim-dispatch
map <silent> <f9> :Dispatch mkt build<CR>
map <silent> <f10> :Dispatch mkt ci<CR>

" Configure netrw to behave like NERDtree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Toggle Vexplore with F2
let g:NetrwIsOpen=0
function! ToggleNetrw()
        if g:NetrwIsOpen
                let i = bufnr("$")
                while (i >= 1)
                        if (getbufvar(i, "&filetype") == "netrw")
                                silent exe "bwipeout " . i
                        endif
                        let i-=1
                endwhile
                let g:NetrwIsOpen=0
        else
                let g:NetrwIsOpen=1
                silent Lexplore
        endif
endfunction

map <silent> <f2> :call ToggleNetrw()<CR>

let g:wordy#ring = [
\  ['weasel'], ['passive-voice'], ['being', 'problematic'], ['redundant', 'weak'],
\  ]

map <silent> <f5> :NextWordy<CR>
