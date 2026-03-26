set number
set clipboard=unnamedplus
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on
colorscheme industry
set hlsearch 
set incsearch 
let g:netrw_liststyle = 3 "use tree view
let g:netrw_browse_split = 3 "open in new tab

" use rg for grepping its a lot faster
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"add command to remove quickfix entries
command! -nargs=? Cdel call setqflist(filter(getqflist(), {i,_ -> i != (empty(<q-args>) ? line('.')-1 : <args>-1)}))
