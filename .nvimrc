syntax on
syntax enable

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("~/.vim/vundle")
Plugin 'python-rope/ropevim'
Plugin 'gmarik/Vundle.vim'
Plugin 'janko-m/vim-test'
Plugin 'tell-k/vim-autopep8'
Plugin 'fsharp/vim-fsharp'
Plugin 'fntlnz/atags.vim'
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'klen/python-mode'
Bundle 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'kassio/neoterm'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'tpope/vim-vividchalk'
Plugin 'morhetz/gruvbox'
Plugin 'lzh9102/vim-distinguished'
Plugin 'majutsushi/tagbar'
Plugin 'w0rp/ale'
call vundle#end()
"neovim settings
set clipboard+=unnamedplus
set termguicolors
call jobstart('ctags -R .')

"Yapf settings
"
filetype plugin indent on
set backup
set backupdir=~/.backups
set foldlevelstart=20

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italicize_strings = 1

set laststatus=2
set showmode
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
tnoremap <A-p> <C-\><C-n><C-p>


nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
map <F2> :NERDTreeFind<CR>
nmap <F3> :TagbarToggle<CR>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
"vim-test settings
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>f :Ag<CR>
nmap <silent> zz :q<CR>
nmap <silent> <leader>d :YcmCompleter GoTo<CR>
nmap <silent> <leader>D :YcmCompleter GoToReferences<CR>

nnoremap [q :cn<CR>
nnoremap ]q :cp<CR>

nmap <silent> <leader>t :call KillTestAndRunAnew()<CR>
function! KillTestAndRunAnew()
    :T exec('try: quit()\nexcept: quit()')
    TestNearest
endfunc


"git settings

nmap <silent> <leader>gc :Gcommit %<CR>
nmap <silent> <leader>ga :!git add %<CR>
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gb :Gbrowse<CR>


let g:ale_linters = {'python': ['isort', 'flake8',]}
let g:ale_python_flake8_executable = $VIRTUAL_ENV . '/bin/flake8'
let g:ale_python_isort_executable = $VIRTUAL_ENV . '/bin/isort'
let g:ale_python_yapf_executable = $VIRTUAL_ENV . '/bin/yapf'
let g:ale_python_flake8_args = '--ignore=E731,E501,E126'
let g:ale_fixers = {'python': ['yapf']}
let g:ale_sign_column_always = 1


map <silent> <leader>gp :Gpush<CR>

function! CleanDBTransform(cmd) abort
  return 'CLEAN_OSIRIUM_DATABASE=TRUE OSIRIUM_DATABASE_URI=postgresql://:5432/osirium '.a:cmd
endfunction

let g:test#custom_transformations = {'clean_db': function('CleanDBTransform')}
let g:test#transformation = 'clean_db'

let test#python#runner = 'pytest'
let test#python#pytest#options = '--pdb -s -x'
let test#filename_modifier = ':~'
let test#strategy = "neoterm"
let g:neoterm_size = 20

nnoremap <silent> ,th :call neoterm#close()<CR>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<CR>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<CR>
nnoremap <silent> H :T <C-R>"<CR>

nnoremap <silent> qq :call CloseWindowsToCode()<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-a> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-t> :Tags<CR>
nnoremap <silent> <C-g> :Commits<CR>
nnoremap <silent> <C-l> :BCommits<CR>
let g:fzf_buffers_jump = 1
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

autocmd BufWritePost * call atags#generate()

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

let g:pymode_breakpoint_cmd = 'import pytest; pytest.set_trace()'
"Linting:

"let g:neomake_python_enabled_makers = ['flake8']
"let g:neomake_python_flake8_maker = {
"    \'args': [],
"    \}
" autocmd! BufWritePost * Neomake
autocmd! InsertLeave,TextChanged * :call LeaveInsertSaveAndCheck()
function! LeaveInsertSaveAndCheck()
    update
    " Neomake
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
nnoremap <silent> <leader>c :g/XXX BREAKPOINT/d<CR>

nnoremap <C-S-e> :T rtd %<CR>


let g:pymode_rope_extract_method_bind = '<leader>e'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
let g:pymode_folding = 1
let g:ycm_python_binary_path = 'python'

"rope rename
let g:pymode_rope_rename_bind = '<leader>m'

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

nnoremap Q <nop>
set showbreak=...
set formatoptions=1
set linebreak
set wrap

autocmd BufNewFile,BufRead *tac set syntax=python

let NERDTreeIgnore = ['\.pyc$']

set showtabline =0

nnoremap <leader>y :ALEFix<cr>
vmap Y :'<'>YAPF<cr>

function! yapf#YAPF() range
  " Determine range to format.
  let l:line_ranges = a:firstline . '-' . a:lastline
  let l:cmd = 'yapf --lines=' . l:line_ranges

  " Call YAPF with the current buffer
  if exists('*systemlist')
    let l:formatted_text = systemlist(l:cmd, join(getline(1, '$'), "\n") . "\n")
  else
    let l:formatted_text =
        \ split(system(l:cmd, join(getline(1, '$'), "\n") . "\n"), "\n")
  endif

  if v:shell_error
    echohl ErrorMsg
    echomsg printf('"%s" returned error: %s', l:cmd, l:formatted_text[-1])
    echohl None
    return
  endif

  " Update the buffer.
  execute '1,' . string(line('$')) . 'delete'
  call setline(1, l:formatted_text)

  " Reset cursor to first line of the formatted range.
  call cursor(a:firstline, 1)
endfunction

command! -range=% YAPF <line1>,<line2>call yapf#YAPF()

highlight ALEErrorSign guifg=#fb4934 guibg=#B22222 gui=bold
highlight ALEWarningSign guifg=#fb4934 guibg=#EEE8AA gui=bold
