" Enable number prints
set number
" Short description of keys definitions (Command mode only):

" F2			- Toggle file browsing (NERDtree)
" TAB			- indent current block of code
" SPACE			- fold / unfold current func
" Control + r		- unfold all folds
" Control + z 		- fold all folds
" Control + DOWN	- jump to next function (below)
" Control + UP		- jump to prev function (above)
" Control + RIGHT	- jump to the end of line
" Control + LEFT	- jump to the beginning of line
" ALT + RIGHT		- jump to a keyword definition
" ALT + LEFT		- jump back from a keyword definition
" Control + f		- delete all in buffer 'a' and copy current line to there
" Control + y		- add current line to buffer 'a'
" Alt + Control + PageDown 	- switch to next tab
" Alt + Contorl + PageUp	- switch to previous tab

nnoremap <F2> :NERDTreeToggle<CR>

" TAB - indent current block of code / function
nnoremap <TAB> =i}

" Sometimes I need copy multiple lines from diff. places of code.
" The most typical is to change return statuses in diffirent spots
" to defines, and afterwards declare these defines in the beginning of the file.
" So it is pretty simple with the next mappings:

" Control + f -- copy a first item to buffer 'a'
nnoremap <C-f> "ayy
" Control + y -- copy a next item to buffer 'a'
nnoremap <C-y> "Ayy
" And later you just past it where you need it as regulat by 'p', or -
" Control + p -- paste from buffer 'a'
nnoremap <C-p> "ap


" Control + DOWN key - jump to the next function
map <C-down> ]]
" Control + UP key - jump to the prev function
map <C-up> [[
" Jump to the end of line
map <C-right> $
" Jump to the end of line
map <C-left> ^

" Control + RIGHT key - jump to keyword definition (tag)
nnoremap <A-right> <C-]>
" Control + LEFT key - jump back from the keyword (tag)
nnoremap <A-left> <C-t>

" SPACE in command - fold / unfold current function
set foldmethod=syntax
set foldlevel=0
autocmd BufWinEnter * silent! :%foldopen!

nnoremap <space> zA
nnoremap <C-z> zM
nnoremap <C-o> za
nnoremap <C-r> zR
set hlsearch
nnoremap <F3> :set hlsearch!<CR>

" Save and restore the state of the window
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Always show at least 3 lines below the cusrsor
:set scrolloff=3

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" Set indentation settings for python scripts
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" Look for the ctags anywhere in the source code
set tags=./tags;/

" Ctrl+\ Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Alt+] Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Enable word spellchecking
set spell spelllang=en_us
" Set colorscheme
set t_Co=256
colors zenburn
