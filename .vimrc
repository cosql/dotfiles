" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

set nocompatible
"set cinoptions=:0,t0,+4,(4
set tabstop=8
set shiftwidth=8
set softtabstop=4
" set number

filetype on

set history=1000

set background=dark

syntax on

set autoindent
set smartindent

"set tabstop=4
"set shiftwidth=4
set noexpandtab

set showmatch

set guioptions-=T

set vb t_vb=

set ruler

set incsearch

set hlsearch

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
	if line("'\"") <= line("$")
	normal! g`"
	return 1
	endif
	endfunction

	augroup resCur
	autocmd!
autocmd BufWinEnter * call ResCur()
augroup END
fun! IgnoreParenIndent()
let indent = cindent(v:lnum)

        if indent > 4000
if cindent(v:lnum - 1) > 4000
return indent(v:lnum - 1)
        else
        return indent(v:lnum - 1) + 4
        endif
else
return (indent)
        endif
        endfun

" Conform to style(9).
fun! FreeBSD_Style()
        setlocal cindent
        setlocal formatoptions=clnoqrt
        setlocal textwidth=80

setlocal indentexpr=IgnoreParenIndent()
        setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e

        setlocal cinoptions=(4200,u4200,+0.5s,*500,t0,U4200
            setlocal shiftwidth=8
            setlocal tabstop=8
            setlocal noexpandtab
            endfun
