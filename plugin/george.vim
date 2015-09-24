if !(has("python"))
    finish
endif

let s:script = fnamemodify(resolve(expand("<sfile>:p")), ":h:h") . "/george.py"

function! GeorgeCheck()
    let s:filename = expand("%:p")
    new | execute "read! python " . fnameescape(s:script) . " " . fnameescape(s:filename)
    silent! g/^+-+-.*$/de
    silent! g/^\s*$/de
    silent! 2,s/^#.*/\r&/g
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal filetype=george-output
endfunction

command! GeorgeCheck call GeorgeCheck()
