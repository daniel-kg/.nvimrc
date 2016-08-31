syntax on
syntax enable
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("~/.vim/vundle")
Plugin 'python-rope/ropevim'
Plugin 'mhinz/vim-startify'
Plugin 'gmarik/Vundle.vim'
Plugin 'janko-m/vim-test'
Plugin 'tell-k/vim-autopep8'
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'frankier/neovim-colors-solarized-truecolor-only'
Bundle 'Valloric/YouCompleteMe'
Bundle 'klen/python-mode'
Bundle 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'kassio/neoterm'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rking/ag.vim'
Plugin 'benekastah/neomake'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'tpope/vim-vividchalk'
Plugin 'morhetz/gruvbox'
Plugin 'lzh9102/vim-distinguished'
Plugin 'majutsushi/tagbar'
call vundle#end()
"neovim settings
set clipboard+=unnamedplus
set termguicolors


filetype plugin indent on
set backup
set backupdir=~/.backups
set foldlevelstart=20

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italicize_strings = 1

set laststatus=2
set noshowmode
" Neovim-qt Guifont command, to change the font
"#######Highlight excess line length
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END
"window mappings

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
map <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
"ctrlp matching

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

let g:ctrlp_clear_cache_on_exit = 1
"vim-test settings
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <leader>f :Ag<CR>
nmap <silent> zz :Bclose<CR>
nmap <silent> <leader>d :YcmCompleter GoTo<CR>

nmap <silent> <leader>t :call KillTestAndRunAnew()<CR>
function! KillTestAndRunAnew()
    :T exec('try: quit()\nexcept: quit()')
    TestNearest
endfunc

function! CleanDBTransform(cmd) abort
  return 'CLEAN_OSIRIUM_DATABASE=TRUE '.a:cmd
endfunction

let g:test#custom_transformations = {'clean_db': function('CleanDBTransform')}
let g:test#transformation = 'clean_db'

let test#python#runner = 'nose'
let test#python#nose#options = '--ipdb --ipdb-failures -s --nologcapture'
let test#filename_modifier = ':~'
let test#strategy = "neoterm"

nnoremap <silent> ,th :call neoterm#close()<CR>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<CR>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<CR>
nnoremap <silent> H :T <C-R>"<CR>

nnoremap <silent> qq :call CloseWindowsToCode()<CR>
nnoremap <silent> <C-B> :CtrlPBuffer<CR>
nnoremap <silent> 't :call GoToNeoTerm()<CR>
tnoremap <silent> 't <C-\><C-n> :call GoToNeoTerm()<CR>
function! CloseWindowsToCode()
    Tclose
    NERDTreeClose
    TagbarClose
    cclose
    lclose
    helpclose
endfunc

let g:not_in_neoterm = 1
function! GoToNeoTerm()
  echo g:not_in_neoterm
  if(g:not_in_neoterm == 1)
    :100 wincmd j
    :startinsert
    let g:not_in_neoterm = 0
  else
    :wincmd p
    let g:not_in_neoterm = 1
  endif
endfunc

"#############line numbering##############

function! NumberToggle()
  if(&relativenumber == &number)
    set norelativenumber
  elseif(&number == 1)
    set nonumber
    set relativenumber
  else
    set number
  endif
endfunc

set relativenumber
set number
nnoremap <C-n> :call NumberToggle()<cr>

"########## AESTHETICS #################

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme gruvbox
set guifont=Ubuntu\ Mono\ for\ Powerline\ 12
"############# WHITESPACE ###########
set expandtab tabstop=4 shiftwidth=4
nmap <F8> o<Esc>k
nmap <F9> O<Esc>j
"################ Python-mode ###################
"

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation <Ctrl-c>f     Rope find occurrences <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled) [[            Jump on previous class or function (normal, visual, operator modes) ]]            Jump on next class or function (normal, visual, operator modes) [M            Jump on previous class or method (normal, visual, operator modes) ]M            Jump on next class or method (normal, visual, operator modes) let g:pymode_rope = 1 " Documentation let g:pymode_doc = 1 let g:pymode_doc_key = 'K' "Linting let g:pymode_lint = 1 let g:pymode_lint_checker = "pyflakes,pep8"


set mouse=a
autocmd BufWritePre * :%s/\s\+$//e

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_regenerate_on_write = 0

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()'
"Linting:

let g:autopep8_ignore="E501,E121,E711,E712,E123,E126,E226,E24,E704"
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
    \'args': ['--ignore=E501,E121,E711,E712,E123,E126,E226,E24,E704'],
    \}
autocmd! BufWritePost * Neomake
autocmd! InsertLeave,TextChanged * :call LeaveInsertSaveAndCheck()
function! LeaveInsertSaveAndCheck()
    update
    Neomake
    GitGutter
endfunction

let g:pymode_lint = 0
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

let g:pymode_lint_cwindow = 0
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_breakpoint_bind = '<leader>b'
nnoremap <silent> <leader>c :g/XXX BREAKPOINT/d<CR>
let g:pymode_rope_extract_method_bind = '<leader>e'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

"rope rename
let g:pymode_rope_rename_bind = '<leader>m'

nnoremap Q <nop>
set showbreak=...
set formatoptions=1
set linebreak
set wrap

autocmd BufNewFile,BufRead *tac set syntax=python
"Auto reload vimrc
augroup reload_vimrc " {
        autocmd!
            autocmd BufWritePost $MYVIMRC source $MYVIMRC
        augroup END " }

        " clock for airline

function! AirlineInit()
  let g:airline_section_y = airline#section#create(['ffenc', '-[%{strftime("%H:%M")}]'])
endfunction
autocmd VimEnter * call AirlineInit()

let NERDTreeIgnore = ['\.pyc$']

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 0
let g:airline_section_y = ''
set showtabline =0
