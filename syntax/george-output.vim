" Vim syntax file
" Language: George Output
" Maintainer: Jack Zhou (hkmix)
" Latest Revision: 2015-09-24

if exists("b:current_syntax")
    finish
endif

" Syntax Highlighting
let b:current_syntax = "george-output"

syn match question '^#.*$'
syn match pass '^+ .*'
syn match passComment '^++ .*'
syn match fail '^- .*'
syn match failComment '^-- ' nextgroup=failError

syn match failError contained '.\{-\}:'

hi def link question PreProc
hi pass cterm=bold ctermfg=green
hi def link passComment Comment
hi fail cterm=bold ctermfg=red
hi def link failComment Comment
hi failError cterm=bold
