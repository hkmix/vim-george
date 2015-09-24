function! GeorgeCheck()
    cexpr system("../george.py " . expand("%"))
endfunction
