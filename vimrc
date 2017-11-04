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
" Then you can open Vim and run :PlugInstall or :PlugUpdate if you're
" adding or modifying the plugins
call plug#begin('~/.vim/plugged')
  " Lightweight Powerline alternative and with more additions and themes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'

  Plug 'jiangmiao/auto-pairs'

  Plug 'tomtom/tcomment_vim'

  Plug 'mattn/emmet-vim'

  Plug 'godlygeek/tabular'

  Plug 'mileszs/ack.vim'

  Plug 'vim-syntastic/syntastic'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
  Plug 'junegunn/fzf.vim'

  " syntax and language plugins
  Plug 'tpope/vim-rails'
  Plug 'veloce/vim-behat'
  Plug 'stanangeloff/php.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'tomtom/checksyntax_vim/'
  Plug 'mustache/vim-mustache-handlebars'

  " Theme plugins
  Plug 'altercation/vim-colors-solarized'
  Plug 'antlypls/vim-colors-codeschool'
  Plug 'crusoexia/vim-monokai'
  Plug 'encody/nvim'
  Plug 'carlobaldassi/mustang-vim'
  Plug 'endel/vim-github-colorscheme'
  Plug 'vim-scripts/xoria256.vim'
  Plug 'goatslacker/mango.vim'
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Configuration  """"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set shellcmdflag=-ic       " Vim acces to .bashrc
set nocompatible           " Must come first because it changes other options.
set hidden                 " Handle multiple buffers better.
set history=10000          " remember more commands and search history

set expandtab              " Use spaces instead of tabs
set tabstop=2              " Global tab width.
set shiftwidth=2           " And again, related.
set softtabstop=2          " Global tab back or remove width.
set smarttab
set autoindent
set laststatus=2           " Show the status line all the time
set showmatch

set incsearch              " Highlight matches as you type.
set hlsearch               " Highlight matches.

set ignorecase             " Case-insensitive searching.
set smartcase              " But case-sensitive if expression contains a capital letter.

set cursorline             " Highlight current line
set number                 " Show line numbers.
set relativenumber         " Show line numbres relatives to current line
set ruler                  " Show cursor position.
set linespace=14
set winaltkeys=no
set autowrite
set autoread               " If a file is changed outside of vim,
                           " automatically reload it without asking

set foldmethod=manual      " Turn folding off for real, hopefully
set nofoldenable

set termencoding=utf-8     " set UTF-8 Encode for Terminal and Files
set encoding=utf-8

" Always show tab bar at the top
set showtabline=0
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

set splitbelow
set splitright

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

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END

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

  " Ruby
  au BufRead,BufNewFile Gemfile,Guardfile setlocal filetype=ruby

augroup END
"/////////////////////////////////////// Main Configuration """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping """"""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save time
nnoremap <space> :
noremap <leader>y "*y

" Switch between the last two files
nnoremap <leader>- <C-^><CR>

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Stop F1
nnoremap <F1>  <NOP>
inoremap <F1>  <NOP>
vnoremap <F1>  <NOP>

" Improve my skills with hjkl
noremap <left> <NOP>
noremap <down> <NOP>
noremap <up> <NOP>
noremap <right> <NOP>

" Replace all words under cursor in current buffer.
nnoremap <M-r> :%s/\<<C-R><C-W>\>//g<left><left>

" Insert a hash rocket with <C-l>
inoremap <C-l> <space>=><space>

" Switch between splits hjkl
noremap <C-h> <C-w>h:vertical resize 80<CR>
noremap <C-j> <C-w>j:vertical resize 80<CR>
noremap <C-k> <C-w>k:vertical resize 80<CR>
noremap <C-l> <C-w>l:vertical resize 80<CR>

" Quickly go forward or backward to buffer
nnoremap <M-PageUp> :bprevious<CR>
nnoremap <M-PageDown> :bnext<CR>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>e :edit %%
map <leader>v :view %%

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Idention Map
nnoremap -{ <<
nnoremap -} >>
inoremap -{<TAB> <ESC><<i
inoremap -}<TAB> <ESC>>>i
vnoremap -{ <gv
vnoremap -} >gv

" Toggle show hidden
nnoremap <leader>ll :set list!<CR>

"Delete all buffers (via Derek Wyatt)
nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<CR>

" Move current Line with Alt+j or Alt+k
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

inoremap <s-tab> <C-n>

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
nnoremap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vnoremap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
"////////////////////////////////////////////////// Mapping """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration By Pluggin """""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                   " Turn on syntax highlighting.
filetype plugin indent on       " Turn on file type detection.

""""""""""""""""""""""""""""""""
" Airline
" https://github.com/vim-airline/vim-airline
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

""""""""""""""""""""""""""""""""
" Emmet
let g:user_emmet_leader_key='<C-Y>'
inoremap <C-E> <C-Y>,
nnoremap <C-E> <C-Y>,
vnoremap <C-E> <C-Y>,

""""""""""""""""""""""""""""""""
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" """"""""""""""""""""""""""""""""
" " Ctrl-P
" set runtimepath^=~/.vim/bundle/ctrlp.vim
" set wildignore+=*/node_modules/*
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](\.(git|hg|svn|tmp|sass-cache)|tmp|node_modules|bower_components|prod|dist|vendor)$',
"   \ 'file': '\v\.(exe|so|dll|git|jpge|jpg|png|ico|pdf|tar|(swp|un)\~)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }
" nnoremap <leader><C-P> :CtrlPBuffer<CR>
" nnoremap <leader><C-T> :CtrlPBufTag<CR>
" nnoremap <leader><leader><C-T> :CtrlPTag<CR>
" " Ctrl-PFunky
" nnoremap <leader><leader>f :CtrlPFunky<CR>
" " ctrlp-extensions
" nnoremap <leader><C-V> :CtrlPYankring<CR>
"
""""""""""""""""""""""""""""""""
" fzf.vim

function! s:update_fzf_colors()
  let g:fzf_action = 
  \ { 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

nnoremap <C-P> :Files<CR>
nnoremap <leader><C-P> :Buffers<CR>

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
" Surround Eg. ysiw surround a word, yss surround line
vnoremap s S
nnoremap <F5> ysiw
nnoremap <M-F5> ySiw
nnoremap <F6> yss
nnoremap <M-F6> ySS

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
" Extra and Language Functions  """"""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
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
"///////////////////////////// Extra and Language Functions """"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal & Theme Configuration  """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 15

" NOTE: Delete try/catch statement, is only for autobuild virtualization
try
  "set background=dark " This is for solarized theme
  color monokai
catch
endtry

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<CR>

" Highlights underline
highlight Search guibg=black guifg=yellow gui=bold

"////////////////////////// Personal & Theme Configuration  """"
