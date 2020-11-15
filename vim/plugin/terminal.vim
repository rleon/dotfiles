function! PutTermPanel(buf) abort
  " new term if no buffer
  if a:buf == 0
    term
  else
    execute "sp" bufname(a:buf)
  endif
  execute "wincmd" "J"
  execute 'resize ' . string(&lines * 0.25)
endfunction

function! s:ToggleTerminal() abort
  let tpbl=[]
  let closed = 0
  let tpbl = tabpagebuflist()
  " hide visible terminals
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  if closed > 0
    return
  endif
  " open first hidden terminal
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call PutTermPanel(buf)
      return
    endif
  endfor
  " open new terminal
  call PutTermPanel(0)
endfunction


" gnome-terminal doesn't send ALT kyes, need to teach VIM
execute "set <M-=>=\e="
nnoremap <silent> <M-=> :call <SID>ToggleTerminal()<CR>
tnoremap <silent> <M-=> <C-w>:call <SID>ToggleTerminal()<CR>
