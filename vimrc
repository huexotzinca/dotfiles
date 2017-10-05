" Enable Alt key for mapping. Fix: the terminator <alt> no support
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

""""""""""""""""""""""""""""""""
" Enable Pluging Manager
" First you need install [PLUG](https://github.com/junegunn/vim-plug)
" Then you can open Vim and run :PlugInstall or :PlugUpdate if you're adding or modifying the plugins
call plug#begin('~/.vim/plugged')
  "Plug 'https://github.com/powerline/powerline'
  " Powerline faster version, but with more additions and themes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  Plug 'https://github.com/tpope/vim-surround'

  Plug 'https://github.com/tpope/vim-eunuch'

  Plug 'https://github.com/jiangmiao/auto-pairs'

  Plug 'https://github.com/tomtom/tcomment_vim'

  Plug 'https://github.com/mattn/emmet-vim'

  Plug 'https://github.com/tpope/vim-fugitive'

  Plug 'https://github.com/kien/ctrlp.vim'
  Plug 'https://github.com/tacahiroy/ctrlp-funky'
  Plug 'https://github.com/sgur/ctrlp-extensions.vim'

  " syntax and language plugins
  Plug 'https://github.com/veloce/vim-behat'
  Plug 'https://github.com/stanangeloff/php.vim'
  Plug 'https://github.com/pangloss/vim-javascript'
  Plug 'https://github.com/tpope/vim-rails'
  Plug 'https://github.com/tomtom/checksyntax_vim/'
  Plug 'https://github.com/mustache/vim-mustache-handlebars'
  "Plug 'git@bitbucket.org:huexotzinca/vim-laravel.git'

  " Theme plugins
  Plug 'https://github.com/altercation/vim-colors-solarized'
  Plug 'https://github.com/antlypls/vim-colors-codeschool'
  Plug 'https://github.com/crusoexia/vim-monokai'
  Plug 'https://github.com/encody/nvim'
  Plug 'https://github.com/carlobaldassi/mustang-vim'
  Plug 'https://github.com/endel/vim-github-colorscheme'
  Plug 'https://github.com/vim-scripts/xoria256.vim'
  Plug 'https://github.com/goatslacker/mango.vim'
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Configuration  """"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set shellcmdflag=-ic            " Vim acces to .bashrc
set nocompatible                " Must come first because it changes other options. For no VI
set hidden                      " Handle multiple buffers better.
set history=10000               " remember more commands and search history

set expandtab                   " Use spaces instead of tabs
set tabstop=2                   " Global tab width.
set shiftwidth=2                " And again, related.
set softtabstop=2               " Global tab back or remove width.
set smarttab
set autoindent
set laststatus=2                " Show the status line all the time
set showmatch

set incsearch                   " Highlight matches as you type.
set hlsearch                    " Highlight matches.

set ignorecase                  " Case-insensitive searching.
set smartcase                   " But case-sensitive if expression contains a capital letter.

set cursorline                  " Highlight current line
set number                      " Show line numbers.
set ruler                       " Show cursor position.
set linespace=14
set winaltkeys=no
set autowrite
set autoread                    " If a file is changed outside of vim, 
                                " automatically reload it without asking

set foldmethod=manual           " Turn folding off for real, hopefully
set nofoldenable

set termencoding=utf-8          " set UTF-8 Encode for Terminal and Files
set encoding=utf-8

" Always show tab bar at the top
set showtabline=2
set winwidth=79

set complete-=t
set showcmd                     " Display incomplete commands.
set cmdheight=1
set switchbuf=useopen
set showmode                    " Display the mode you're in.
set shell=bash                  " This let work rvm and node in vim
set nojoinspaces                " Insert only one space when joining lines
                                " that contain sentence-terminating punctuation like
" Fix slow O inserts
set timeout timeoutlen=500 ttimeoutlen=0
set title                       " Set the terminal's title
set visualbell                  " No beeping.
set noerrorbells

set wildmenu                    " Enhanced command line completion.
set wildmode=list:longest       " Complete files like a shell.

set splitbelow                  " 

set wrap                        " Turn on line wrapping.
set scrolloff=3                 " keep more context when scrolling off the end of a buffer

set backspace=indent,eol,start  " Intuitive backspacing.
if exists('+breakindent')
  set breakindent showbreak=\ +
endif

" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable

set tags=tags

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬     " this is used by -list- for show hidden symbols

" Don't make backups at all
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim-tmp,~/.vim-tmp
set directory=~/.vim-tmp,~/.vim-tmp

" MAPPING LEADER
let mapleader=","
let g:mapleader=","
"///////////////////////////// Extra and Language Functions """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration By File Type """""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " On save new files create parent directory if doesn't exist.
  function s:MkNonExDir(file, buf)
      if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
          let dir=fnamemodify(a:file, ':h')
          if !isdirectory(dir)
              call mkdir(dir, 'p')
          endif
      endif
  endfunction
  augroup BWCCreateDir
      autocmd!
      autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END

  " JAVASCRIPT
  autocmd FileType javascript set completefunc=backbone#compl

  """"""""""""""""""""""""""""""""
  "  IDENTATION and FILETYPE

  " Bash
  autocmd FileType sh setlocal sw=4 ts=4
  " CSS, SASS and LESS
  autocmd FileType css,less,sass,scss setlocal sw=4 ts=4
  " JavaScript
  autocmd FileType js,javascript setlocal sw=2 ts=2 tw=80 wm=80
  " PHP
  autocmd FileType blade,php setlocal sw=4 ts=4 tw=120 wm=120
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
  au BufRead,BufNewFile *.handlebars,*.hbs setlocal filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

  " Laravel
  au BufRead,BufNewFile *.blade.php setlocal tw=0 wm=0 wrap syntax=blade filetype=blade

  " Jade Lang
  au BufRead,BufNewFile *.jade setlocal filetype=jade syntax=jade

augroup END
"/////////////////////////////////////// Main Configuration """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping """"""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save time
nnoremap <space> :

map <leader>y "*y

" Switch between the last two files
nmap <leader><leader> <C-^><CR>

" Stop F1 
nnoremap <F1>  <NOP>
inoremap <F1>  <NOP>
vnoremap <F1>  <NOP>

" Improve my skills with hjkl
noremap <left> <NOP>
noremap <down> <NOP>
noremap <up> <NOP>
noremap <right> <NOP>

" Find in file all words under the cursor.
nmap <leader>s :%s/\<<C-R><C-W>\>/
" And replace with
nmap <leader><leader>s :%s/\<<C-R><C-W>\>//g<left><left>

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Switch between splits hjkl
map <C-h> <C-w>h:vertical resize 80<CR>
map <C-j> <C-w>j:vertical resize 80<CR>
map <C-k> <C-w>k:vertical resize 80<CR>
map <C-l> <C-w>l:vertical resize 80<CR>

" Quickly go forward or backward to buffer
nmap <M-PageUp> :bprevious<CR>
nmap <M-PageDown> :bnext<CR>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>e :edit %%
map <leader>v :view %%

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<CR>

" Move current Line with Alt+j or Alt+k
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
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

" From  http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
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
"////////////////////////////////////////////////// Mapping """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration By Pluggin """""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                   " Turn on syntax highlighting.
filetype plugin indent on       " Turn on file type detection.

""""""""""""""""""""""""""""""""
" Powerline
" https://github.com/Lokaltog/powerline/tree/develop/powerline
"set rtp+=~/src/powerline/powerline/bindings/vim
"let g:Powerline_symbols = 'fancy'
"set laststatus=2   " Always show the statusline
"set encoding=utf-8 " Necessary to show Unicode glyphs
"set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

""""""""""""""""""""""""""""""""
" Airline
" https://github.com/vim-airline/vim-airline
let g:airline_theme='simple'
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

""""""""""""""""""""""""""""""""
" Emmet
let g:user_emmet_leader_key='<C-Y>'
imap <C-E> <C-Y>,
nmap <C-E> <C-Y>,
vmap <C-E> <C-Y>,

""""""""""""""""""""""""""""""""
" Ctrl-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/node_modules/*
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|tmp|sass-cache)|tmp|node_modules|bower_components|prod|dist|vendor)$',
  \ 'file': '\v\.(exe|so|dll|git|jpge|jpg|png|ico|pdf|tar|(swp|un)\~)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
nnoremap <leader><C-P> :CtrlPBuffer<CR>
nnoremap <leader><leader><C-P> :CtrlPMRUFiles<CR>
nnoremap <C-F8> :CtrlPBufTag<CR>
nnoremap <leader><C-F8> :CtrlPTag<CR>
" Ctrl-PFunky
nnoremap <C-F12> :CtrlPFunky<CR>
" ctrlp-extensions
nnoremap <M-v> :CtrlPYankring<CR>

""""""""""""""""""""""""""""""""
" Vim-eunuch
nnoremap <F2> :Rename <C-R>=expand('%:t')<CR>
inoremap <F2> <ESC>:Rename <C-R>=expand('%:t')<CR>
nnoremap <leader><F2> :Move <C-R>=expand('%:p')<CR>

""""""""""""""""""""""""""""""""
" tComment
nnoremap <M-c> :TComment<CR>
vnoremap <M-c> :TComment<CR>
nnoremap <leader><M-c> :TCommentBlock<CR>
vnoremap <leader><M-c> :TCommentBlock<CR>

""""""""""""""""""""""""""""""""
"Surround
vmap s S
nmap <F5> ysiw
nmap <M-F5> ySiw
nmap <F6> yss
nmap <M-F6> ySS

""""""""""""""""""""""""""""""""
" vim-behat
let g:feature_filetype='behat'

""""""""""""""""""""""""""""""""
" vim-javascript
let g:javascript_plugin_jsdoc = 1

""""""""""""""""""""""""""""""""
" vim-javascript
let g:mustache_abbreviations = 1
"///////////////////////////////// Configuration By Pluggin """"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal & Theme Configuration  """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 15

" NOTE: Delete try/catch statement, is only for autobuild virtualization
try
  color monokai
catch
endtry

" Highlights underline
highlight Search guibg=black guifg=yellow gui=bold

""""""""""""""""""""""""""""""""
" Abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris faucibus, quam at viverra vestibulum, odio magna scelerisque augue, non placerat enim ante nec mi.
iab llorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris faucibus, quam at viverra vestibulum, odio magna scelerisque augue, non placerat enim ante nec mi. Pellentesque magna ante, molestie quis mattis posuere, facilisis vulputate dolor. Vivamus et orci vitae eros ultrices commodo et sed arcu. Fusce tempor volutpat aliquam. In laoreet varius lacus, vitae auctor nisl ultrices lobortis. Vestibulum pretium adipiscing tempor. Proin cursus interdum leo, at scelerisque dui. In et augue placerat lorem pretium commodo. Phasellus neque lectus, mollis quis elit in, semper vestibulum est. Mauris quam tellus, posuere id dictum ac, adipiscing sed tortor. Nunc ipsum mauris, viverra interdum consectetur eu, ornare quis nisl. Sed gravida sollicitudin risus quis sagittis.

"////////////////////////// Personal & Theme Configuration  """"
