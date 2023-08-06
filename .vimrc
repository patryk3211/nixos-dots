let s:tab_sizes = { 'nix': 2, 'yuck': 2, 'scss': 4 }
let s:default_tab_size = 4

function s:set_shift_width(filetype)
    let l:size = get(s:tab_sizes, a:filetype, s:default_tab_size)
    exec 'set shiftwidth='.l:size
    exec 'set tabstop='.l:size
    exec 'set softtabstop='.l:size
endfunction

autocmd FileType * call s:set_shift_width(expand('<amatch>'))

