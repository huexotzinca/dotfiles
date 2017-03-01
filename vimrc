" Copy or symlink to ~/.vimrc or ~/_vimrc.

autocmd!
call pathogen#incubate()

" Enable Alt key for mapping. Fix: the terminator <alt> no support
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Vim Configuration  ======================================
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
set nocompatible                  " Must come first because it changes other options. For no VI
set hidden                        " Handle multiple buffers better.
" remember more commands and search history
set history=10000

set expandtab                    " Use spaces instead of tabs
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set softtabstop=2                " Global tab back or remove width.
set smarttab
set autoindent
set laststatus=2                  " Show the status line all the time
set showmatch

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set cursorline                    " Highlight current line
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set autoread
set autowrite
set winaltkeys=no
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 15
set linespace=14

set foldmethod=manual             " Turn folding off for real, hopefully
set nofoldenable

" set UTF-8 Encode for Terminal and Files
set termencoding=utf-8
set encoding=utf-8

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.
set showcmd                       " Display incomplete commands.
set cmdheight=2
set showmode                      " Display the mode you're in.
set shell=bash                    " This let work rvm and node in vim
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
set title                         " Set the terminal's title
set visualbell                    " No beeping.
set noerrorbells

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set splitbelow                    " 

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " keep more context when scrolling off the end of a buffer

set backspace=indent,eol,start    " Intuitive backspacing.
if exists('+breakindent')
  set breakindent showbreak=\ +
endif

set tags=tags

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬ " this is used by -list- for show hidden symbols

" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp
set directory=~/.vim-tmp,~/.tmp

" Create dictionary for custom expansions
set dictionary+=~/.vim/dict/global.dict

" For dictionary, now you only need <CTRL-N><CTRL-N> intead of <CTRL-X><CTRL-L><CTRL-N>
set complete-=k complete+=k

" MAPPING LEADER
let mapleader=","
let g:mapleader=","

augroup vimrcEx
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Configuration By File Type ===================================
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " JAVASCRIPT
  autocmd FileType javascript set completefunc=backbone#compl

  """"""""""""""""""""""""""""""""
  "  IDENTATION and FILETYPE

  " Bash
  autocmd FileType sh setlocal sw=4 ts=4
  " CSS, SASS and LESS
  autocmd FileType css,less,sass,scss setlocal sw=4 ts=4
  " JavaScript
  autocmd FileType javascript setlocal sw=2 ts=2 tw=80 wm=80
  " PHP
  autocmd FileType php setlocal sw=4 ts=4 tw=120 wm=120
  " HTML
  autocmd FileType html setlocal sw=4 ts=4 tw=0 wm=0 wrap
  " Ruby and their things
  autocmd FileType ruby,haml,eruby,yaml,sass,cucumber setlocal et sw=2 ts=2 sts=2
  " Python
  autocmd FileType python set sw=4 sts=4 et
  " Slim
  autocmd! FileType *.slim set sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd FileType php let b:surround_45 = "<?php \r ?>" " Shortcut yss-
  autocmd BufRead *.html.js,*.hbs,*.handlebars let b:surround_45 = "{{ \r }}" " Shortcut yss=
  autocmd BufRead *.blade.php,*.blade let b:surround_45 = "{{ \r }}" " Shortcut yss=

  """"""""""""""""""""""""""""""""
  "  SYNTAX

  " Behat
  au BufRead,BufNewFile *.feature setlocal filetype=behat
  " SASS-SCSS
  au BufRead,BufNewFile *.scss setlocal filetype=scss
  " Handlebars
  au BufRead,BufNewFile *.handlebars,*.hbs setlocal ft=html syntax=handlebars tw=0 wm=0 wrap

  " Laravel
  au BufRead,BufNewFile *.blade.php setlocal tw=0 wm=0 wrap syntax=blade filetype=blade

  " Jade Lang
  au BufRead,BufNewFile *.jade setlocal filetype=jade syntax=jade

  """"""""""""""""""""""""""""""""
  "  DICTIONARY
  " javascript
  au FileType javascript setlocal dictionary+=~/.vim/dict/node.dict
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping ======================================================
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Stop F1 
nnoremap <F1>  <NOP>
inoremap <F1>  <NOP>
vnoremap <F1>  <NOP>

" Improve my skills with hjkl
noremap <left> <NOP>
noremap <down> <NOP>
noremap <up> <NOP>
noremap <right> <NOP>

nmap <M-S> :%s/\<<C-R><C-W>\>//g<left><left>

" Save time
nnoremap <space> :

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Switch between the last two files
nmap <leader><leader> <C-^><CR>

" TagBar
nmap <F8> :TagbarToggle<CR>

" Go To Definitions and Ctags
nmap <leader>gg :exec("tag ".expand("<cword>"))<CR>
nmap <leader>gv :vsp<CR>:exec("tag ".expand("<cword>"))<CR>

" Copy Filename, Path of file to clipboard
nmap <Leader>cpwd :! pwd \| tr -d "\n\r" \| clipit<CR><CR>

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Switch between splits hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

"Resize vsplit
nmap <leader>wv :vertical resize +20
nmap <leader>ww :resize +20
nmap <leader>we <c-w>=

" Quickly go forward or backward to buffer
nmap <M-PageUp> :bprevious<cr>
nmap <M-PageDown> :bnext<cr>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

"Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Idention Map
nmap -{ <<
nmap -} >>
imap -{<TAB> <ESC><<i
imap -}<TAB> <ESC>>>i
vmap -{ <gv
vmap -} >gv

" Toggle show hidden 
nmap <leader>ll :set list!<CR>
 
"Delete all buffers (via Derek Wyatt)
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

" Move current Line with Alt+j or Alt+k
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>


" From
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration By Pluggin =====================================
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""""
" Powerline
" https://github.com/Lokaltog/powerline/tree/develop/powerline
set rtp+=~/src/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

""""""""""""""""""""""""""""""""
" Emmet
let g:user_emmet_leader_key='<C-Y>'
imap <C-E> <C-Y>,
nmap <C-E> <C-Y>,
vmap <C-E> <C-Y>,

""""""""""""""""""""""""""""""""
" Ctrl-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/node_modules/*
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|tmp|sass-cache)|tmp|node_modules|prod|dist|vendor)$',
  \ 'file': '\v\.(exe|so|dll|git|jpge|jpg|png|ico|pdf|tar|(swp|un)\~)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
nnoremap <leader><C-P> :CtrlPBuffer<cr>
nnoremap <leader><leader><C-P> :CtrlPMRUFiles<cr>
nnoremap <C-F8> :CtrlPBufTag<cr>
nnoremap <leader><C-F8> :CtrlPTag<cr>
" Ctrl-PFunky
nnoremap <C-F12> :CtrlPFunky<cr>
" ctrlp-extensions
nnoremap <M-v> :CtrlPYankring<cr>

""""""""""""""""""""""""""""""""
" Vim-eunuch
nnoremap <F2> :Rename <C-R>=expand('%:t')<cr>
inoremap <F2> <ESC>:Rename <C-R>=expand('%:t')<cr>
nnoremap <leader><F2> :Move <C-R>=expand('%:p')<cr>

""""""""""""""""""""""""""""""""
" TComment
nmap <M-c> <c-_><c-_>
nmap <leader>cb :TCommentBlock<cr>
nmap <leader>cp <c-_>p
nmap <leader>cr :TCommentRight<cr>
vmap <M-c> <c-_><c-_>gv=gv
vmap <leader>cb :TCommentBlock<cr>gv=gv
vmap <leader>cp <c-_>pgv=gv
vmap <leader>cr :TCommentRight<cr>gv=gv
imap <M-c> <ESC><c-_><c-_>==gi

""""""""""""""""""""""""""""""""
"Sorround
vmap s S
nmap <F5> ysiw
nmap <M-F5> ySiw
nmap <F6> yss
nmap <M-F6> ySS

""""""""""""""""""""""""""""""""
" vim-behat
let g:feature_filetype='behat'

" PHP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>co :e composer.json<cr>

" Laravel
cnoreabbrev gm !php artisan generate:model
cnoreabbrev gc !php artisan generate:controller
cnoreabbrev gmig !php artisan generate:migration
cnoreabbrev mm !php artisan make:model
cnoreabbrev mc !php artisan make:controller
cnoreabbrev mmig !php artisan make:migration
cnoreabbrev mr !php artisan make:request

" Laravel framework commons
function! LaravelSetVersion()
  let g:LaravelVersion = substitute(system("php artisan --version | grep -oh '[0-9]\\{1,2\\}\\.[0-9]\\{1,2\\}\\.[0-9]\\{2\\}'"), "\\n", "", "g")
  let g:LaravelVersionShort = substitute(system("php artisan --version | grep -oh '[0-9]\\{1,2\\}\\.[0-9]\\{1,2\\}\\.[0-9]\\{2\\}' | grep -oh '^[0-9]\\{1,2\\}'"), "\\n", "", "g")

  if g:LaravelVersionShort != '4' && g:LaravelVersionShort != '5'
    unlet g:LaravelVersion
    unlet g:LaravelVersionShort
  endif
endfunction

function! LaravelGetRoutes()
  call InitLaravel()
  if exists("g:LaravelVersion")
    if g:LaravelVersionShort == '4'
      !php artisan routes
    elseif g:LaravelVersionShort == '5'
      !php artisan route:list
    endif
  endif
endfunction

function! LaravelSelectAController()
  call InitLaravel()
  if exists("g:LaravelVersion")
    if g:LaravelVersionShort == '4'
      call SelectaFile("app/controllers")
    elseif g:LaravelVersionShort == '5'
      call SelectaFile("app/Http/Controllers")
    endif
  endif
endfunction

function! LaravelSlectAModel()
  call InitLaravel()
  if exists("g:LaravelVersion")
    if g:LaravelVersionShort == '4'
      call SelectaFile("app/models")
    elseif g:LaravelVersionShort == '5'
      call SelectaFile("app/Models")
    endif
  endif
endfunction

function! LaravelSelectAView()
  call InitLaravel()
  if exists("g:LaravelVersion")
    if g:LaravelVersionShort == '4'
      call SelectaFile("app/views")
    elseif g:LaravelVersionShort == '5'
      call SelectaFile("resources/views")
    endif
  endif
endfunction

function! InitLaravel()
  if !exists("g:LaravelVersion")
    call LaravelSetVersion()
  endif
endfunction

nmap <leader>lR :call LaravelGetRoutes()<cr>
nmap <leader>lr :call TryOpenFile('app/Http/routes.php', 'app/routes.php')<cr>
nmap <leader>la :call TryOpenFile('config/app.php', 'app/config/app.php')<cr>
nmap <leader>ld :call TryOpenFile('config/database.php', 'app/config/database.php')<cr>

nmap <leader>lC :call LaravelSelectAController()<cr>
nmap <leader>lM :call LaravelSelectAModel()<cr>
nmap <leader>lV :call LaravelSelectAView()<cr>
nmap <leader>lI :call SelectaFile("vendor/laravel/framework/src/Illuminate")<cr>

function! TryOpenFile(...)
  let l:fileOpened = 0
  if a:0 <= 0
    return
  endif
  for file in a:000
    if l:fileOpened == 0
      if filereadable(file)
        exec "silent :e ".file
        echo ""
        let l:fileOpened = 1
      endif
    endif
  endfor
  if l:fileOpened == 0
    echom "Sorry this or these file(s) doesn't exist."
    echo a:000
  endif
endfunction

function! SelectaFile(path)
  if isdirectory(a:path)
    exec "CtrlP ".a:path
  else
    echo "Sorry but the ".a:path." directory doesn't exist."
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveFancyCharacters()
  let typo = {}
  let typo["“"] = '"'
  let typo["”"] = '"'
  let typo["‘"] = "'"
  let typo["’"] = "'"
  let typo["–"] = '--'
  let typo["—"] = '---'
  let typo["…"] = '...'
  :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal Settings ============================================
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

" Colors
"set t_Co=256
"set background=dark
"color solarized mustang
color delek

" Highlights underline
highlight Search guibg=black guifg=yellow gui=bold

""""""""""""""""""""""""""""""""
" Abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris faucibus, quam at viverra vestibulum, odio magna scelerisque augue, non placerat enim ante nec mi.
iab llorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris faucibus, quam at viverra vestibulum, odio magna scelerisque augue, non placerat enim ante nec mi. Pellentesque magna ante, molestie quis mattis posuere, facilisis vulputate dolor. Vivamus et orci vitae eros ultrices commodo et sed arcu. Fusce tempor volutpat aliquam. In laoreet varius lacus, vitae auctor nisl ultrices lobortis. Vestibulum pretium adipiscing tempor. Proin cursus interdum leo, at scelerisque dui. In et augue placerat lorem pretium commodo. Phasellus neque lectus, mollis quis elit in, semper vestibulum est. Mauris quam tellus, posuere id dictum ac, adipiscing sed tortor. Nunc ipsum mauris, viverra interdum consectetur eu, ornare quis nisl. Sed gravida sollicitudin risus quis sagittis.

