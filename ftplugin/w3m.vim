if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

command! -buffer -nargs=0 W3mCopyUrl call w3m#CopyUrl('*')
command! -buffer -nargs=0 W3mReload call w3m#Reload()
command! -buffer -nargs=0 W3mAddressBar call w3m#EditAddress()
command! -buffer -nargs=0 W3mShowTitle call w3m#ShowTitle()
command! -buffer -nargs=0 W3mShowExtenalBrowser call w3m#ShowExternalBrowser()
command! -buffer -nargs=0 W3mShowSource call w3m#ShowSourceAndHeader()
command! -buffer -nargs=0 W3mShowDump call w3m#ShowDump()
command! -buffer -nargs=0 W3mClose bd
command! -buffer -nargs=0 W3mSyntaxOff call w3m#ToggleSyntax(0)
command! -buffer -nargs=0 W3mSyntaxOn call w3m#ToggleSyntax(1)
command! -buffer -nargs=1 -complete=customlist,w3m#useragent_completion W3mSetUserAgent call w3m#SetUserAgent('<args>')

if g:w3m_options['disable_default_highlight'] == 0
        highlight w3mBold gui=bold
        highlight w3mUnderline gui=underline
        highlight! link w3mInput String
        highlight! link w3mSubmit Special
        highlight! link w3mLink Function
        highlight! link w3mAnchor Label
        highlight! link w3mLinkHover SpecialKey
        highlight! link w3mHitAHint Question
endif

if g:w3m_options['disable_default_keymap'] == 0
        nmap <buffer> <LeftMouse> <LeftMouse><Plug>(w3m-click)
        nmap <buffer> <CR>        <Plug>(w3m-click)
        nmap <buffer> <S-CR>      <Plug>(w3m-shift-click)
        nmap <buffer> <C-S-CR>    <Plug>(w3m-shift-ctrl-click)
        nmap <buffer> <TAB>       <Plug>(w3m-next-link)
        nmap <buffer> <S-TAB>     <Plug>(w3m-prev-link)
        nmap <buffer> <BS>        <Plug>(w3m-back)
        nmap <buffer> <A-LEFT>    <Plug>(w3m-back)
        nmap <buffer> <A-RIGHT>   <Plug>(w3m-forward)
        nmap <buffer> s           <Plug>(w3m-toggle-syntax)
        nmap <buffer> c           <Plug>(w3m-toggle-use-cookie)
        nmap <buffer> =           <Plug>(w3m-show-link)
        nmap <buffer> o           <Plug>(w3m-address-bar)
        execute 'nmap <buffer> ' . g:w3m_options['hit_a_hint_key'] . ' <Plug>(w3m-hit-a-hint)'
endif
