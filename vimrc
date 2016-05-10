" show Line Numbers
" set number
" tab Indents
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" set auto-indenting on for programming
set ai

" turn off compatibility with the old vi
set nocompatible

" turn on the visual bell - which is much quieter than the audio blink
set vb

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" make that backspace key work the way it should
set backspace=indent,eol,start

" conveniently turn 'paste' on and off with one keypress
set pastetoggle=<C-p>

" disable backups and swap files
set nobackup
set noswapfile

" configure status line
" Always display the statusline in all windows
set laststatus=2 
" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode 
" load powerline
" set statusline=%f\ %y%m%{fugitive#statusline()}%=%l,%c%V
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim 
let g:Powerline_symbols = 'fancy'

execute pathogen#infect()

filetype plugin indent on

let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable
set background=dark
colorscheme solarized
" colorscheme xoria256

let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" vim-css-color plugin
" used when updatetime value set by plugin (100ms) is interfering with your configuration.
let g:cssColorVimDoNotMessMyUpdatetime = 1

" vim-laravel-4-snippet
" autocmd FileType php set ft=php.laravel

" vim-jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>

" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>

" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" On by default, turn it off for html and go
" let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_go_checkers = ['govet']
let g:syntastic_mode_map = { 'mode': 'active',
	 	\ 'active_filetypes': [],
 		\ 'passive_filetypes': ['html'] }

" html indentation provided by Andy Wokula
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" Same with the colon and semicolon; colon is used very often
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" easy escaping to normal mode
imap jj <esc>

" gcc comment
map <leader>c <c-_><c-_>

" vim-php-namespace
" Automatically adds the corresponding use statement for the class under 
" the cursor.
noremap <Leader>u :call PhpInsertUse()<CR>
" Expands the class name under the cursor to its fully qualified name.
noremap <Leader>e :call PhpExpandClass()<CR>

" nerdtree
" map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" vim-textmanip
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
 
vmap <C-c> <Plug>(textmanip-duplicate-down)
nmap <C-c> <Plug>(textmanip-duplicate-down)

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" tagbar Vim plugin that displays tags in a window, ordered by class
nnoremap <silent> ,b :TagbarToggle<CR>

" PDV (phpDocumentor for Vim) 
nnoremap <silent> ,p :call PhpDocSingle()<CR>
nnoremap <silent> ,P :call PhpDocRange()<CR>
let g:pdv_cfg_Author = "Branislav Vladisavljev"

highlight Search cterm=underline

" highlights the background in a subtle red for text that goes over the 80 column limit
highlight OverLength ctermbg=gray ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Use jshint (uses ~/.jshintrc if there is no local file)
let g:syntastic_javascript_checkers = ['jshint']

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
:command NT  NERDTree


" go-vim
" Another issue with vim-go and syntastic is that the location list window that
" contains the output of commands such as :GoBuild and :GoTest might not appear.
" To resolve this:
let g:go_list_type = "quickfix"
" go test
" au FileType go nmap <leader>t <Plug>(go-testj
au FileType go noremap <Leader>t :w<cr>:!clear && go test<cr>
" Or open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
" Show a list of interfaces which is implemented by the type under your cursor with <leader>s
au FileType go nmap <Leader>s <Plug>(go-implements)
" Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>i <Plug>(go-info)

" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"
" By default syntax-highlighting for Functions, Methods and Structs is disabled. To change it:
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" https://github.com/Shougo/neocomplete.vim
let g:neocomplete#enable_at_startup = 1
" https://github.com/Shougo/neosnippet.vim
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
