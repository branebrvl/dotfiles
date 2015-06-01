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

" On by default, turn it off for html
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
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Use jshint (uses ~/.jshintrc if there is no local file)
let g:syntastic_javascript_checkers = ['jshint']

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
:command NT  NERDTree
