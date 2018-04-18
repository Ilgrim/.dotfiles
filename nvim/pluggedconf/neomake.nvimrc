" Neomake signs in the gutter
let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
    \   'text': '',
    \   'texthl': 'NeomakeWarningSign',
    \ }
let g:neomake_message_sign = {
    \   'text': '➤',
    \   'texthl': 'NeomakeMessageSign',
    \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" update neomake when save file
if isdirectory($HOME . "/nvim/plugged/neomake")
    call neomake#configure#automake('w')
endif

"----------------
" PHP
"-----------------

" standard phpcs config
let g:neomake_php_phpcs_args_standard = 'PSR2'

" display warning for phpcs error
function! SetWarningType(entry)
  let a:entry.type = 'W'
endfunction

function! SetErrorType(entry)
  let a:entry.type = 'E'
endfunction

function! SetMessageType(entry)
  let a:entry.type = 'M'
endfunction

let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs', 'phpstan']

let g:neomake_php_php_maker = {
        \ 'args': ['-l', '-d', 'display_errors=1', '-d', 'log_errors=0',
            \      '-d', 'xdebug.cli_color=0'],
        \ 'errorformat':
            \ '%-GNo syntax errors detected in%.%#,'.
            \ '%EParse error: %#syntax error\, %m in %f on line %l,'.
            \ '%EParse error: %m in %f on line %l,'.
            \ '%EFatal error: %m in %f on line %l,'.
            \ '%-G\s%#,'.
            \ '%-GErrors parsing %.%#',
       \ 'postprocess': function('SetErrorType'),
\ }

let g:neomake_php_phpcs_maker = {
        \ 'args': ['--report=csv', '--standard=PSR2'],
        \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpstan_maker = {
        \ 'args': ['analyse', '--errorFormat', 'raw', '--no-progress', '--level', '7'],
        \ 'errorformat': '%E%f:%l:%m',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpmd_maker = {
        \ 'args': ['%:p', 'text', 'cleancode,codesize,design,unusedcode,naming'],
        \ 'errorformat': '%W%f:%l%\s%\s%#%m',
        \ 'postprocess': function('SetMessageType'),
 \ }


"-----------------
" Golang
"-----------------
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
" let g:neomake_go_gometalinter_maker = {
"  \ 'args': [
"  \   '--enable-all',
"  \   '--disable=lll',
"  \   '--concurrency=8',
"  \   '--tests',
"  \   '--fast',
"  \   '%:p:h',
"  \ ],
"  \ 'cwd': '%:h',
"  \ 'append_file': 0,
"  \ 'errorformat':
"  \   '%E%f:%l:%c:%trror: %m,' .
"  \   '%W%f:%l:%c:%tarning: %m,' .
"  \   '%E%f:%l::%trror: %m,' .
"  \   '%W%f:%l::%tarning: %m'
" \ }

let g:neomake_go_gometalinter_maker = {
  \ 'exe': 'zb',
  \ 'args': [
  \   'lint',
  \   '--exclude=unexported',
  \   '--fast',
  \ ],
  \ 'cwd': '%:h',
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
\ }

  let g:go_fmt_options = {
    \ 'gofmt': '-s',
\ }
"-----------------
" Yaml
"-----------------

let g:neomake_yaml_enabled_makers = [ 'yamllint' ]