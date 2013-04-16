"----------------------------------------
" Basic Settings
"----------------------------------------
" Change ESC to C-j
imap <C-j> <ESC>
nmap <C-j> <ESC>

" Color
colorscheme desert
set background=dark

" Cursor
hi CursorLine cterm=none ctermbg=darkblue gui=none guibg=darkblue

" Window size
set lines=80 columns=100

" Font
set guifont=Monaco:h10

" Disable Menubar
set guioptions-=T

" Always Shows Tab
set showtabline=2

" Backslash
inoremap <D-\> \
