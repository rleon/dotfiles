" Force to work with python3
let g:pymode_python = 'python3'
execute pathogen#infect()

filetype plugin indent on    " required
filetype plugin on

" Enable vim-easygit
let g:easygit_enable_command = 1

let g:copilot_filetypes = {
	\ 'gitcommit': v:true,
	\ }
