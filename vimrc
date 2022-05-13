

set number

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set mouse=a

" Get rid of annoying errors
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Wqa wqa

" Open terminal in current windoe
cnoreabbrev term terminal ++curwin
