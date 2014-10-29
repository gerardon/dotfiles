".vimrc
set nocompatible
filetype off

"vundle configs
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"vundle itself
Plugin 'gmarik/Vundle.vim'

"autocomplete
Plugin 'Valloric/YouCompleteMe'

"syntax checking
Plugin 'scrooloose/syntastic'

"json
Plugin 'elzr/vim-json'

"git wrapper
Plugin 'tpope/vim-fugitive'

"file handling plugins
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

"motion plugins
Plugin 'edsono/vim-matchit'
Plugin 'vim-scripts/python_match.vim'
Plugin 'Lokaltog/vim-easymotion'

"surround plugin
Plugin 'tpope/vim-surround'

"enhanced .
Plugin 'tpope/vim-repeat'

"automatic tab expand
Plugin 'tpope/vim-sleuth'

"automatic tag closing
Plugin 'vim-scripts/closetag.vim'

"enhanced python syntax highlighting
Plugin 'hdima/python-syntax'

"statusline plus a mais
Plugin 'bling/vim-airline'

"with sufficient thrust, pigs fly just fine
Plugin 'jnurmine/Zenburn'

call vundle#end()
filetype plugin indent on

"Easymotion settings
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

"YouCompleteMe settings
let g:ycm_key_list_select_completion = ['<TAB>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<A-TAB>', '<C-p>']
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"NERDTree settings
"map <C-T> :NERDTreeToggle<return>
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', 'bin$', 'lib$', 'local$', 'share$', 'include$', 'build$', 'public$']
let NERDChristmasTree = 1

"closetag settings
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1

"Zenburn settings
syntax on
let g:zenburn_high_Contrast = 1
colorscheme zenburn

"wtf settings
set autoread            "altera o arquivo no vim caso seja alterado por uma fonte externa
set autoindent          "identação automática
set softtabstop=4       "makes backspacing over spaced out tabs work real nice
set expandtab           "expand tabs to spaces
set shiftwidth=4
set tabstop=4
set termencoding=utf-8
set nobackup
set fileencodings=ucs-bom,utf-8,default,latin1
set smartindent
set showmatch
set showcmd
set showmode
set number
set hlsearch
set paste
set cursorline
set virtualedit=all
set noswapfile
set laststatus=2

"gvim settings
if has("gui_running")
   set guioptions-=T " disable toolbar
   set guioptions-=m " disable menu
   set guioptions-=M " disable system menu
   set guioptions-=r " disable scrollbar (right)
   set guioptions-=R " disable scrollbar if there's split (right)
   set guioptions-=l " disable scrollbar (left)
   set guioptions-=L " disable scrollbar if there's split (left)
   set guioptions-=b " disable scrollbar (bottom)
   set guioptions-=h " disable scrollbar (top)
   set guioptions+=c " enable console choices
endif

"show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:»\ ,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:»\ ,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>\ ,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>\ ,trail:.,extends:>
    endif
endif

"remove ^M characters from windows files
map <C-M> mvggVG:s/<C-V><CR>//g<CR>`v

"automatically remove all trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

"Mapping para code fold
vmap <space> zf
nmap <space> :call ToggleFold()<CR>

function ToggleFold()
   if foldlevel('.') == 0
      " No fold exists at the current line,
      " so create a fold based on indentation

      let l_min = line('.')   " the current line number
      let l_max = line('$')   " the last line number
      let i_min = indent('.') " the indentation of the current line
      let l = l_min + 1

      " Search downward for the last line whose indentation > i_min
      while l <= l_max
         " if this line is not blank ...
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            if indent(l) <= i_min

               " we've gone too far
               let l = l - 1    " backtrack one line
               break
            endif
         endif
         let l = l + 1
      endwhile

      " Clamp l to the last line
      if l > l_max
         let l = l_max
      endif

      " Backtrack to the last non-blank line
      while l > l_min
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            break
         endif
         let l = l - 1
      endwhile

      "execute "normal i" . l_min . "," . l . " fold"   " print debug info

      if l > l_min
         " Create the fold from l_min to l
         execute l_min . "," . l . " fold"
      endif
   else
      " Delete the fold on the current line
      normal zd
   endif
endfunction

map <S-Insert> <MiddleMouse>
