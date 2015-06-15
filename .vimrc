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
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \   'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
  \   'cygwin' : 'make -f make_cygwin.mak',
  \   'mac' : 'make -f make_mac.mak',
  \   'unix' : 'make -f make_unix.mak',
  \  },
  \ }

" github repos
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'kannokanno/previm'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'editorconfig/editorconfig-vim'

" vim-scripts repos
" http://vim-scripts.org/
NeoBundle 'AutoClose'
NeoBundle 'PDV--phpDocumentor-for-Vim'

call neobundle#end()

" NeoBundle Settings End
filetype plugin indent on   " required!

"----------------------------------------
" Basic Settings
" :h index.txt => default keybind
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

" Modeline
set modeline
set modelines=3

" Highlight invisible characters
set listchars=tab:»\ ,trail:-,nbsp:%

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
set nowrapscan
set whichwrap=b,s,h,l,<,>,[,]
hi Search ctermbg=darkred guibg=darkred
hi IncSearch ctermbg=red guibg=red
" Clear search highlight by ESC ESC
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <NL><NL> :nohlsearch<CR><ESC>

" Input
set autoindent
set smartindent
" set noexpandtab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
map <NL> <ESC>
imap <NL> <ESC>
" TODO: enable at command mode
" nmap <NL> <ESC>

" Map $,@
inoremap <C-d> $
inoremap <C-a> @

" Don't move back to first position when yaning on visual mode
vnoremap y y`>

"----------------------------------------
" filetype
"----------------------------------------
" Xslate
autocmd BufNewFile,BufRead *.tt,*.tx set filetype=html
" Perl
autocmd BufNewFile,BufRead *.t,*.psgi set filetype=perl

"----------------------------------------
" neocomplcache
"----------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>""

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default'    : '',
    \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"

"----------------------------------------
" neosnippet
"----------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_start_unite_snippet_target)
let g:neosnippet#snippets_directory='~/.vim/snippets'

"----------------------------------------
" ref
"----------------------------------------
" Search builtin function
nmap <C-k> :call ref#open("perldoc", '-f ' . expand('<cword>'))<CR>

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
" List Recursive File
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=file_rec file_rec<CR>
" Most Recently Used
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" Bookmarks
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
" Add to Bookmark
nnoremap <silent> [unite]d :<C-u>UniteBookmarkAdd<CR>
" Search perldoc
nnoremap <silent> [unite]k :<C-u>Unite ref/perldoc<CR>

" Sorter
call unite#filters#sorter_default#use("sorter_rank")

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
" ag
"----------------------------------------
nmap <Space>a :let a=expand("<cword>")<CR>:Ag <C-R>=expand(a)<CR>
nmap <Space>A :Ag
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200


"----------------------------------------
" php-doc
"----------------------------------------
" inoremap <C-0> <ESC>:call PhpDocSingle()<CR>i
" nnoremap <C-0> :call PhpDocSingle()<CR>


"----------------------------------------
" watchdogs
"----------------------------------------
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_CursorHold_enable = 1
nnoremap <Space>s :WatchdogsRun<CR>
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>


"----------------------------------------
" previm
"----------------------------------------
let g:previm_open_cmd = 'open -a "Google Chrome"'
let g:previm_enable_realtime = 1
augroup PrevimSettings
	autocmd!
	autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END


"----------------------------------------
" coffeescript
"----------------------------------------
autocmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et


"----------------------------------------
" emmet
"----------------------------------------
" let g:user_emmet_leader_key = '<c-e>'
autocmd FileType css,scss,html,coffee imap <c-e> <plug>(emmet-expand-abbr)
let g:user_emmet_settings = {
\    'indentation' : '  '
\}

"----------------------------------------
" matchit
"----------------------------------------
source $VIMRUNTIME/macros/matchit.vim
