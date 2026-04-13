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

" use rg for grepping its a lot faster
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"add command to remove quickfix entries
command! -nargs=? Cdel call setqflist(filter(getqflist(), {i,_ -> i != (empty(<q-args>) ? line('.')-1 : <args>-1)}))

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

" Open fzf in terminal, capture selection, save to default register
command! Fzf call FzfToRegister()

function! FzfToRegister()
  let tmpfile = tempname()
  call system('fzf > ' . tmpfile . ' < /dev/tty')
  redraw!
  let @" = trim(readfile(tmpfile)[0])
  call delete(tmpfile)
  echom 'Saved: ' . @"
endfunction

" Open fzf in terminal, capture selection, open file in current buffer
command! Fzfo call FzfOpenFile()
function! FzfOpenFile()
  let tmpfile = tempname()
  call system('fzf > ' . tmpfile . ' < /dev/tty')
  redraw!
  let selected = trim(readfile(tmpfile)[0])
  call delete(tmpfile)
  if !empty(selected)
    execute 'edit ' . fnameescape(selected)
  endif
endfunction
