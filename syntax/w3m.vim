" File: syntax/w3m.vim
" OriginalAuthor: yuratomo (twitter @yusetomo)
" Author: matsuhav

if exists("b:current_syntax")
        finish
endif

syntax match    w3mMark /[\*\+\-\#="]/
syntax match    w3mNumber /^ *[0-9]\+\./
syntax keyword w3mCopyright Copyright
syntax match w3mUrl contained "\vhttps?://[[:alnum:]][-[:alnum:]]*[[:alnum:]]?(\.[[:alnum:]][-[:alnum:]]*[[:alnum:]]?)*\.[[:alpha:]][-[:alnum:]]*[[:alpha:]]?(:\d+)?(/[^[:space:]]*)?$"
syntax match w3mUrl "https\?://\S*"

highlight default link w3mMark Function
highlight default link w3mNumber Number
highlight default link w3mCopyright Keyword
highlight default link w3mUrl Comment

let b:current_syntax = 'w3m'
