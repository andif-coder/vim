" grep in vim
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr><c-l><cr>
" nnoremap <leader>G :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr><c-l><cr>
nnoremap <leader>g :set operatorfunc=GrepOpsVis<cr>g@
vnoremap <leader>g :<c-u>call GrepOpsVis(visualmode())<cr>

function! GrepOpsVis(type)
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
    silent execute "grep! -R " . shellescape(expand(shellescape(@@))) . " ."
    copen
    redraw!
endfunction
