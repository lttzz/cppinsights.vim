""
" @section Introduction, intro
" @library
" <doc/@plugin(name).txt> is generated by <https://github.com/google/vimdoc>.
" See <README.md> for more information about installation and screenshots.

""
" Main function for |:Insights|.
function! cppinsights#main(bang) abort
  if has('win32')
    let l:null = 'null'
  else
    let l:null = '/dev/null'
  endif
  let l:cmd = g:cppinsights_cmd . ' ' . expand('%') . ' 2>' . l:null
  try
    let l:text = trim(system(l:cmd))
  catch /^Vim\%((\a\+)\)\=:E677:/
    echohl WarningMsg
    echomsg l:cmd 'cannot be executed!'
    echohl None
    return
  endtry
  if a:bang == '!'
    let l:diff = 'diff'
  else
    let l:diff = ''
  endif
  if g:cppinsights_vertical == 1
    let l:vertical = 'vertical '
  else
    let l:vertical = ''
  endif
  let l:cmd = l:vertical . l:diff . 'split ' . g:cppinsights_window_name
  execute l:cmd
  %delete
  1put=l:text
  1delete
  setlocal buftype=nofile
endfunction