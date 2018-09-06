syntax on
syntax enable

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ludovicchabant/vim-gutentags'
Plug 'python-rope/ropevim'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'ncm2/ncm2'
Plug 'w0rp/ale'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-snipmate'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-racer'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'roxma/nvim-yarp'
Plug 'fatih/vim-go'
Plug 'Kuniwak/vint'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'rbgrouleff/bclose.vim'
Plug 'morhetz/gruvbox'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-rhubarb'
Plug 'vim-scripts/groovy.vim'
call plug#end()
"neovim settings
set clipboard+=unnamedplus
set termguicolors
"call jobstart('ctags -R .')
"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ }
let g:ncm2#matcher = 'abbrfuzzy'
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_snipmate#expand_or("\<CR>", 'n')

" wrap <Plug>snipMateTrigger so that it works for both completin and normal
" snippet
" inoremap <expr> <c-u> ncm2_snipmate#expand_or("\<Plug>snipMateTrigger", "m")

" c-j c-k for moving in snippet
let g:snips_no_mappings = 1
vmap <c-j> <Plug>snipMateNextOrTrigger
vmap <c-k> <Plug>snipMateBack
imap <expr> <c-k> pumvisible() ? "\<c-y>\<Plug>snipMateBack" : "\<Plug>snipMateBack"
imap <expr> <c-j> pumvisible() ? "\<c-y>\<Plug>snipMateNextOrTrigger" : "\<Plug>snipMateNextOrTrigger"
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap  <space> <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
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
nnoremap <F4> :T cargo test<CR>
nnoremap <F5> :T cargo run<CR>
nnoremap <F6> :T cargo build<CR>
nmap <F3> :TagbarToggle<CR>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
"vim-test settings
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>f :Ag<CR>
nmap <silent> zz :q<CR>

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


let g:ale_linters = {'python': ['isort', 'flake8',], 'go' : ['gofmt', 'gometalinter'], 'rust': ['rls']}
let g:ale_go_gometalinter_options = '--fast'
let g:ale_python_flake8_executable = $VIRTUAL_ENV . '/bin/flake8'
let g:ale_python_isort_executable = $VIRTUAL_ENV . '/bin/isort'
let g:ale_python_yapf_executable = $VIRTUAL_ENV . '/bin/yapf'
let g:ale_python_flake8_args = '--ignore=E731,E501,E126'
let g:ale_fixers = {'python': ['black'], 'go': ['gofmt']}
let g:ale_sign_column_always = 1


map <silent> <leader>gp :Gpush<CR>

function! CleanDBTransform(cmd) abort
  return 'CLEAN_OSIRIUM_DATABASE=TRUE OSIRIUM_DATABASE_URI=postgresql://:5432/osirium '.a:cmd
endfunction

let g:test#custom_transformations = {'clean_db': function('CleanDBTransform')}
let g:test#transformation = 'clean_db'

let g:test#python#runner = 'pytest'
let g:test#python#pytest#options = '--pdb -s -x'
let g:test#filename_modifier = ':~'
let g:test#strategy = 'neoterm'
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

set mouse=a
autocmd BufWritePre * :%s/\s\+$//e

autocmd! InsertLeave,TextChanged * :call LeaveInsertSaveAndCheck()

function! LeaveInsertSaveAndCheck()
    write
    GitGutter
endfunction

nnoremap <silent> <leader>c :g/XXX BREAKPOINT/d<CR>

nnoremap <C-S-e> :T rtd %<CR>


set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

nnoremap Q <nop>
set showbreak=...
set formatoptions=1
set linebreak
set wrap

autocmd BufNewFile,BufRead *tac set syntax=python

let g:NERDTreeIgnore = ['\.pyc$']

set showtabline =0

let g:rustfmt_autosave = 1

nnoremap <F9> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
vnoremap <silent> F :call LanguageClient_textDocument_rangeFormatting()<CR>
nnoremap <silent> F V :call LanguageClient_textDocument_rangeFormatting()<CR>
