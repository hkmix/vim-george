setlocal indentexpr=GeorgeIndent() 

function! GeorgeIndent()
  let line = getline(v:lnum)
  let previousNum = prevnonblank(v:lnum - 1)
  let previous = getline(previousNum)

  " simple indentation using only brackets
  " assumes we don't have nested brackets on the same line
  " also assumes } will be on it's own line
  if previous =~ '{' && !(previous =~ '}')
    if line =~ "}" && !(line =~ '{')
      return indent(previousNum)
    endif 
    return indent(previousNum) + &tabstop
  endif
  if line =~ "}" && !(line =~ '{')
    return indent(previousNum) - &tabstop
  endif
  return indent(previousNum) 

endfunction

