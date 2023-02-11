" grep in vim
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr><c-l><cr>
" nnoremap <leader>G :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr><c-l><cr>
nnoremap <leader>g :set operatorfunc=<SID>GrepOpsVis<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOpsVis(visualmode())<cr>

function! s:GrepOpsVis(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v' " viw<leader>g
        " echom "normal v"
        execute "normal! `<v`>y"
    elseif a:type ==# 'V' " Vjj<leader>g
        echom "line v"
        return 
    elseif a:type ==# 'char' " <leader>giw
        " echom "giw"
        execute "normal! `[v`]y"
    elseif a:type ==# 'line' " <leader>gG
        echom "gG"
        return
    endif
    " echom @@
    echom shellescape(@@)
    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
    redraw!
    let @@ = saved_unnamed_register
endfunction
