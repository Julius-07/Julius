"================= Base setting ==================================================================="
set nobackup
set noundofile
set nu
syntax on
filetype on
filetype plugin on
filetype indent on
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noswapfile
set ruler
set hlsearch
set ignorecase
set number
set ignorecase smartcase
colorscheme evening

set cursorline
set cursorcolumn
set lines =42 columns =172
set autoindent
set smartindent
"set guifont=Courier\ 10\ pitch\ 20
set guifont=Consolas:h14:cANSI:qDRAFT
set nocompatible
"set bckspace=indent,eol,start
set laststatus=2
"set incsearch
set nowrapscan
set ruler
set foldmethod=marker
"set enc=utf-8

"================= Shortcut setting ==============================================================="
map <C-g> :NERDTreeToggle<CR>
map <A-a> oalways @(posedge clk or negedge rst_n) begin<ESC>oif(!rst_n) begin<ESC>oend<ESC>oelse if() begin<ESC>oend<ESC>oend<ESC><CR>
map <A-1> <ESC>:call AutoInst1()<ESC>
map <A-2> <ESC>:call AutoInst2()<ESC>
map <C-h> <ESC>:call SetTitle() <ESC>
"=================================================================================================="



"================= vim plug-in setting ============================================================"
" SuperTab setting
source C:\Users\朱锦涛\OneDrive\Documents\Personal\Julius\template\gvim\SuperTab.vim
let g:SuperTabMappingFroward="<tap>"
let g:SuperTabMappingBackward="<s-tap>"

" Minbuf setting
source C:\Users\朱锦涛\OneDrive\Documents\Personal\Julius\template\gvim\minibufexpl.vim

" Nerd tree setting
source C:\Users\朱锦涛\OneDrive\Documents\Personal\Julius\template\gvim\NERD_tree.vim
"=================================================================================================="



"================= Match setting =================================================================="
"let b:match_word = '\<\>:\<\>'
let b:match_word = '\<module\>:\<endmodule\>'
let b:match_word = '\<begin\>:\<end\>'
let b:match_word = '\<ifdef\>:\<endif\>'
let b:match_word = '\<ifndef\>:\<endif\>'
"=================================================================================================="



"================= AutoInst1/AutoInst2 function define ============================================"
function AutoInst1()
    :'<,'>s/\( *\)\(\w*\)\( *\)(\(.*\))\(.*\)/    \2\3                                         (\4                                                        )\5/g
    :'<,'>s/\(.\{30\}\) *(\(.\{20\}\) *)/\1(\2)/g
    :'<,'>s/^ *\(\/\/.*\)/    \1/g
endfunction

function AutoInst2()
    :'<,'>s/\( *\)\(\w*\)\( *\)(\(.*\))\(.*\)/    \2\3                                                               (\4                                                                        )\5/g
    :'<,'>s/\(.\{50\}\) *(\(.\{30\}\) *)/\1(\2)/g
    :'<,'>s/^ *\(\/\/.*\)/    \1/g
endfunction
"=================================================================================================="



"================= Auto insert file header ========================================================"
autocmd BufNewFile *.v,*.sv,*.tcl,*.py ":call SetTitle()"

"""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为Verilog文件 
    if &filetype == 'verilog'
        call setline(1 , "//---------------------------------------------------------------------------------") 
        call setline(2 , "// Copyright (c) by personal. All reghts reserved.")
        call setline(3 , "// ")
        call setline(4 , "// This model is confidential and proprietary property of personal.")
        call setline(5 , "// And the possession of use of this file requires a written lincese from: personal")
        call setline(6 , "//---------------------------------------------------------------------------------") 
        call setline(7 , "// Filename     : ".expand("%"))
        call setline(8 , "// Project      : ")
        call setline(9 , "// Description  : ")
        call setline(10, "//---------------------------------------------------------------------------------") 
        call setline(11, "") 
        call setline(12, "//---------------------------------------------------------------------------------") 
        call setline(13, "// Frunction    : ") 
        call setline(14, "//---------------------------------------------------------------------------------") 
        call setline(15, "// Author       : zhujintao")
        call setline(16, "// Created On   : ".strftime("%c"))
        call setline(17, "// Last Modified: ".strftime("%c"))
        call setline(18, "//---------------------------------------------------------------------------------") 
        call setline(19, "// Version      : ")
        call setline(20, "//   V1.0       : ")
        call setline(21, "//     Note     : First version")
        call setline(22, "//---------------------------------------------------------------------------------") 
        call setline(23, "") 
        call setline(24, "") 
    "endif
    else
        call setline(1 , "##---------------------------------------------------------------------------------") 
        call setline(2 , "## Filename     : ".expand("%"))
        call setline(3 , "## Project      : ")
        call setline(4 , "## Description  : ")
        call setline(5 , "##---------------------------------------------------------------------------------") 
        call setline(6 , "## Author       : zhujintao")
        call setline(7 , "## Created On   : ".strftime("%c"))
        call setline(8 , "## Last Modified: ".strftime("%c"))
        call setline(9 , "##---------------------------------------------------------------------------------") 
        call setline(10, "## Version      : ")
        call setline(11, "##   V1.0       : ")
        call setline(12, "##     Note     : First version")
        call setline(13, "##---------------------------------------------------------------------------------") 
        call setline(14, "") 
        call setline(15, "") 
    endif
endfunc
"=================================================================================================="



"================= Auto update lasy modified time ================================================="
function SetLastModifiedTime(lineno)
    let modif_time = strftime("%c")
    let line = getline(a:lineno)

    if line =~ 'Last Modified'
        let line = substitute(line, ':.*', ': '.modif_time, "")
    else
        let line = line
    endif

    call setline(a:lineno, line)
endfunction

au BufWrite *.v,*.sv   call SetLastModifiedTime(17)
au BufWrite *.tcl,*.py call SetLastModifiedTime(8)
"=================================================================================================="


