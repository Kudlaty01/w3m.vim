" File: plugin/w3m.vim
" OriginalAuthor: yuratomo (twitter @yusetomo)
" Author: matsuhav

if exists('g:loaded_w3m')
        finish
endif
let g:loaded_w3m = 1
let s:save_cpo = &cpo
set cpo&vim

" User can use g:w3m_config to override options
let g:w3m_options = {
                \ 'home': 'https://raw.githubusercontent.com/matsuhav/w3m.vim/master/README.md',
                \ 'default_searchengine': 'bing',
                \ 'debug': 0,
                \ 'command': 'w3m',
                \ 'option': '-o display_charset=' . &encoding . ' -halfdump -o frame=true -o ext_halfdump=1 -o strict_iso2022=0 -o ucs_conv=1',
                \ 'wget_command': 'wget',
                \ 'download_ext': ['zip', 'lzh', 'cab', 'tar', 'gz', 'z', 'exe'],
                "\ not used. For search engines?
                \ 'lang': v:lang,
                \ 'max_history_num': 30,
                \ 'max_cache_page_num': 10,
                \ 'external_browser': '',
                \ 'hit_a_hint_key': 'f',
                "\ -1 uses default
                \ 'use_cookie': -1,
                \ 'accept_cookie': -1,
                \ 'accept_bad_cookie': -1,
                \ 'user_agent': '',
                \ 'set_hover_on': 1,
                \ 'hover_delay_time': 100,
                \ 'disable_default_keymap': 0,
                \ 'disable_default_highlight': 0,
                \ }
if exists('g:w3m_config')
        call extend(g:w3m_options, g:w3m_config)
endif
" Make sure w3m is executable
if !executable(g:w3m_options['command'])
        let &cpo = s:save_cpo
        unlet s:save_cpo
        finish
endif
" User can use g:w3m_custom_searchengines to add/override searchengines
let g:w3m_searchengines = {
                \ 'bing' : 'https://www.bing.com/search?q=%s&setmkt=en-us&setlang=en-us',
                \ 'bing-local': 'https://www.bing.com/search?q=%s',
                \ 'google': 'https://www.google.com/search?&q=%s',
                \ }
if exists('g:w3m_custom_searchengines')
        call extend(g:w3m_searchengines, g:w3m_custom_searchengines)
endif
" Make sure default one is valid
if !has_key(g:w3m_searchengines, g:w3m_options['default_searchengine'])
        let g:w3m_options['default_searchengine'] = 'bing'
endif
" User can use g:w3m_custom_useragents to add/override searchengines
let g:w3m_useragents = {
                \ 'w3m': '',
                \ 'Firefox': 'Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1',
                \ }
if exists('g:w3m_custom_useragents')
        call extend(g:w3m_useragents, g:w3m_custom_useragents)
endif

command! -nargs=* -complete=customlist,w3m#searchengine_completion W3m :call w3m#Open(<f-args>)
command! -nargs=0 W3mHistory :call w3m#history#Show()
command! -nargs=0 W3mHistoryClear :call w3m#history#Clear()

let &cpo = s:save_cpo
unlet s:save_cpo
