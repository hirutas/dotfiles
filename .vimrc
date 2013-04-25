"----------------------------------------
" NeoBundle Settings
"----------------------------------------
" How to use
" :NeoBundleInstall  => Install
" :NeoBundleInstall! => Update

set nocompatible            " be iMproved
filetype off                " required!
filetype plugin indent off  " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" let NeoBundle manage NeoBundle
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
" after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile

" github repos
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
NeoBundle 'mattn/zencoding-vim'

" vim-scripts repos
" http://vim-scripts.org/
NeoBundle 'AutoClose'
NeoBundle 'PDV--phpDocumentor-for-Vim'

" NeoBundle Settings End
filetype plugin indent on   " required!

"----------------------------------------
" Basic Settings
"----------------------------------------
" To modify cursol key bug
if !has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=200
endif

" Color scheme
set t_Co=256
colorscheme desert

" Caracter set
"set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,euc-jp-ms,cp932
"set encoding=utf-8

" Encoding auto detection
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" Return code auto detection
set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

" Backup
set nobackup

" Swap file
set swapfile
set directory=/tmp

" Display
set number
set ruler
set laststatus=2
syntax on
set list

" Highlight invisible characters
set listchars=tab:»\ ,trail:-,nbsp:%

" Search
set incsearch
set ignorecase
set hlsearch
set nowrapscan
set whichwrap=b,s,h,l,<,>,[,]
hi Search ctermbg=darkred guibg=darkred
hi IncSearch ctermbg=red guibg=red
" Clear search highlight by ESC ESC ESC
nmap <ESC><ESC><ESC> :nohlsearch<CR><ESC>

" Input
set autoindent
set smartindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=2
set scrolljump=5
set hidden

" CursorLine
set cursorline
" CursorLine current window only
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi CursorLine cterm=none ctermbg=darkblue gui=none guibg=darkblue

" Clipboard
set clipboard+=autoselect
set clipboard+=unnamed

" Keymap
" Change ESC to C-j
imap <NL> <ESC>
nmap <NL> <ESC>

" Don't move back to first position when yaning on visual mode
vnoremap y y`>

"----------------------------------------
" FileType
"----------------------------------------
" Perl
autocmd BufNewFile,BufRead *.pl setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.pm setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.cgi setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.fcgi setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4


"----------------------------------------
" Unite
"----------------------------------------
" Start on insert mode
let g:unite_enable_start_insert=1
" Keymap
nnoremap [unite] <Nop>
nmap <Space> [unite]
" List File
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
" List Buffer
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" List Register
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" Most Recently Used
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" Bookmarks
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" Add to Bookmark
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" Exit by ESC ESC
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
autocmd FileType unite nnoremap <silent> <buffer> <C-j><C-j> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <C-j><C-j> <ESC>:q<CR>

" Map <tab> function
autocmd FileType unite inoremap <silent> <buffer><expr> <Tab> unite#do_action('narrow')

" Delete backward path
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction

" File window cursor line
let g:unite_cursor_line_highlight = 'CursorLine'

"----------------------------------------
" Vim-LaTeX
"----------------------------------------
" Configuration from TeXWiki (MacTeX & TeXLive)
" http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Vim-LaTeX#aecb2dfb
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'

let g:Tex_CompileRule_dvi = '/usr/texbin/platex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_pdf = '/usr/texbin/dvipdfmx $*.dvi'

let g:Tex_BibtexFlavor = '/usr/texbin/pbibtex'
let g:Tex_MakeIndexFlavor = '/usr/texbin/mendex $*.idx'

" Disable foldings
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

" Disable Vim-Latex keybind
imap <C-f> <Plug>IMAP_JumpForward
nmap <C-f> <Plug>IMAP_JumpForward

"----------------------------------------
" Zencoding
"----------------------------------------
" Swap C-y and C-e
imap <C-e> <C-y>
vmap <C-e> <C-y>
nmap <C-e> <C-y>

"----------------------------------------
" php-doc
"----------------------------------------
inoremap <C-0> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-0> :call PhpDocSingle()<CR>
vnoremap <C-0> :call PhpDocRange()<CR>
