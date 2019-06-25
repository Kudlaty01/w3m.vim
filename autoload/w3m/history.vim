" File: autoload/w3m/history.vim
" OriginalAuthor: yuratomo (twitter @yusetomo)
" Author: matsuhav

let s:w3m_history_load = 0

function! w3m#history#Add(title, params)
        let idx = 0
        for hist in g:w3m_options['historylist']
                if string(hist.params) == string(a:params)
                        call remove(g:w3m_options['historylist'], idx)
                        break
                endif
                let idx += 1
        endfor
        call add(g:w3m_options['historylist'], {'title' : a:title, 'params' : a:params} )
        if len(g:w3m_options['historylist']) > g:w3m_options['max_history_num']
                call remove(g:w3m_options['historylist'], 0)
        endif
endfunction

function! w3m#history#Load()
  if s:w3m_history_load == 1
    return
  endif
  let s:w3m_history_load = 1

  if filereadable(g:w3m_options['historyfile'])
    let title = ''
    let params = []
    let idx = 0
    for line in readfile(g:w3m_options['historyfile'])
      if idx % 2 == 0
        let title = line
      else
        let params = split(line, ' ')
        call add(g:w3m_options['historylist'], {'title': title, 'params': params} )
      endif
      let idx += 1
    endfor
  endif
  augroup w3m
    autocmd BufUnload * call w3m#history#Save()
  augroup END
endfunction

function! w3m#history#Save()
  let lines = []
  for hist in g:w3m_options['historylist']
    call add(lines, hist.title)
    call add(lines, join(hist.params, ' '))
  endfor
  call writefile(lines, g:w3m_options['historyfile'])
endfunction

function! w3m#history#Show()
  call w3m#history#Load()

  let idx = 0
  for hist in g:w3m_options['historylist']
    exe 'echohl Number | echon "' . printf('%3d',idx) . ': " | echohl Comment | echon "' . hist.title . ' " | echohl None | echon " ... :W3m ' . join(hist.params, ' ') . '" | echo ""'
    let idx += 1
  endfor
  if idx > 0
    let num = input('Please input history number:', '')
    let item = g:w3m_options['historylist'][num]
    if num != '' && num >= 0 && num < len(g:w3m_options['historylist'])
            if len(a:item.params) > 1
                    call w3m#Open(a:item.params[0], join(a:item.params[1:], ' '))
            else
                    call w3m#Open(a:item.params[0])
            endif
        endif
    endif
  endif
endfunction

function! w3m#history#Clear()
  if s:w3m_history_load == 0
    return
  endif

  let ans = input('Clear w3m history?[y/n]:')
  if ans ==? "y"
    let g:w3m_options['historylist'] = []
    redraw
    echo 'w3m: clear ok.'
  endif
endfunction

