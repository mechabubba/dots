unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" indentation is four spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" allow wrapping between lines with left and right
" https://vim.fandom.com/wiki/Automatically_wrap_left_and_right
set whichwrap+=<,>,h,l,[,]

" ctrl left/right/up/down word skipping
" https://vi.stackexchange.com/a/11669
execute "set <xUp>=\e[1;*A" 
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"


