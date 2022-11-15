" set smartindent             " use smart indent if there is no indent file
" set signcolumn=number       " always show signcolumns
"
set shortmess+=A

" let mapleader = " "
" nnoremap ; :

"https://vimways.org/2018/the-power-of-diff/
" set diffopt+=algorithm:patience
" set diffopt+=indent-heuristic


" set ignorecase              " Default to using case insensitive searches,
" set hlsearch
" set smarttab                " Handle tabs more intelligently
" set smartcase

" set colorcolumn=81 " one column after limit
" set scrolloff=8
" set textwidth=80
" set inccommand=split
"set virtualedit=all
" set mouse=a

" set foldmethod=indent
" set foldlevelstart=999

" set formatoptions-=t  " disable wrap

" set cpoptions+=I " When moving the cursor up or down just after inserting indent for 'autoindent', do not delete the indent.

" set breakindentopt=shift:4,sbr
" set breakindent

" nnoremap Q <nop>

" set noautowrite             " Never write a file unless I request it.
" set noautowriteall          " NEVER.
" set autoread                " automatically re-read changed files.
" set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
" set noro                    " Disable read only

" set confirm                 " Y-N-C prompt if closing with unsaved changes.
" set laststatus=2            " Always show statusline, even if only 1 window.
"
" au FileType html set tabstop=2               " <tab> inserts 2 spaces
" au FileType html set shiftwidth=2            " but an indent level is 2 spaces wide.
" au FileType html set softtabstop=2           " <BS> over an autoindent deletes both spaces.
"
" au FileType pug set tabstop=2               " <tab> inserts 2 spaces
" au FileType pug set shiftwidth=2            " but an indent level is 2 spaces wide.
" au FileType pug set softtabstop=2           " <BS> over an autoindent deletes both spaces.
"
" au FileType go se noexpandtab
"
" au BufNewFile,BufRead *.classpath set filetype=eclipse_classpath
" au BufNewFile,BufRead *.jinja set filetype=jinja.jinja2.html


function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

function! s:ebin()
    split | resize 20 | term
endfunction
com! DiffSaved call s:DiffWithSaved()
autocmd User GnvimScroll :
cnoremap w!!  w suda://%
com! Vterm split | resize 20 | term
syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo


" give group
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
