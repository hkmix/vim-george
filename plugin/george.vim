if !(has('python'))
    finish
endif

function! GeorgeCheck()
    pyfile ../george.py
endfunction
