" show Line Numbers
" set number
" tab Indents
set smartindent
set tabstop=4
set shiftwidth=4
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

execute pathogen#infect()

filetype plugin indent on
syntax enable

let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

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

" Faster commenting for T-Comment plugin
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" gcc comment
map <leader>c <c-_><c-_>

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" fuzzyfinder
map ,f :FufFile<CR>
map ,b :FufBuffer<CR>

" vim-textmanip
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
 
vmap <C-c> <Plug>(textmanip-duplicate-down)
nmap <C-c> <Plug>(textmanip-duplicate-down)

" Use jshint (uses ~/.jshintrc)
let g:syntastic_javascript_checkers = ['jshint']

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
:command NT  NERDTree
