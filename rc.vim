" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

:runtime! ftplugin/man.vim " Красивый вывод мануала. Должно быть в самом начале

" Setup {{{
" ======


    if !exists('s:loaded_my_vimrc')                " don't reset twice on reloading

        set nocompatible                           " enable vim features

        set backupdir=~/.vim/.cache/backup         " where to put backup file
        set backup                                 " make backup file and leave it around
        set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp

        set directory=~/.vim/.cache/tmp                         " where to put swap file
        let g:SESSION_DIR   = '~/.vim/.cache/sessions'

        " Create system vim dirs
        if finddir(&backupdir) == ''
            silent call mkdir(&backupdir, "p")
        endif

        if finddir(g:SESSION_DIR) == ''
            silent call mkdir(g:SESSION_DIR, "p")
        endif

        " Pathogen load
        filetype off
        call pathogen#infect()
        call pathogen#helptags()
        filetype plugin indent on
        syntax on

    endif

" }}}


" Options {{{
" =======

    " Buffer options
    set hidden                  " hide buffers when they are abandoned
    set autoread                " auto reload changed files
    set autowrite               " automatically save before commands like :next and :make

    " Display options
    set title                   " show file name in window title
    set visualbell t_vb=        " mute error bell
    set linespace=1             " add some line space for easy reading
    set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
    set linebreak               " break lines by words
    set winminheight=0          " minimal window height
    set winminwidth=0           " minimal window width

    "vertical/horizontal scroll off settings
    set scrolloff=3
    set sidescrolloff=7
    set sidescroll=1

    set showcmd                 " show incomplete cmds down the bottom
    set showmode                " show current mode down the bottom"
    set whichwrap=b,s,<,>,[,],l,h
    set completeopt=menu,preview
    set infercase
    set cmdheight=1             " высота строки команд
    set number                  " нумерация строк
    set showbreak=→
    set wrap linebreak nolist
    set ruler                   " показывать положение курсора всё время

    " indent settings
    set cindent
    set smartindent             " enable nice indent
    set smarttab                " indent using shiftwidth"
    set tabstop=4
    set expandtab               " tab with spaces
    set autoindent              " copy indent from previous line
    set shiftwidth=4            " number of spaces to use for each step of indent
    set softtabstop=4           " tab like 4 spaces
    set shiftround              " drop unused spaces

    " Backup and swap files
    set history=40000             " history length
    set viminfo+=h              " save history
    set ssop-=blank             " dont save blank vindow
    "set ssop-=options           " dont save options

    " Search options
    set hlsearch                " Highlight search results
    set ignorecase              " Ignore case in search patterns
    set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
    set incsearch               " While typing a search command, show where the pattern

    " Matching characters
    set showmatch               " Show matching brackets
    set matchpairs+=<:>         " Make < and > match as well

    " Localization
    set langmenu=none            " Always use english menu
    set keymap=russian-jcukenwin " Alternative keymap
    set iminsert=0               " English by default
    set imsearch=-1              " Search keymap from insert mode
    set spelllang=en,ru          " Languages
    set encoding=utf-8           " Default encoding
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    " Wildmenu
    set wildmode=list:longest,full           "make cmdline tab completion similar to bash
    set wildmenu                " use wildmenu ...
    set wildcharm=<TAB>
    set wildignore=*.obj,.git,.svn,*.pyc,*.pyo,*.o,*.DS_Store,*~    " ignore file pattern

    " ==>StatusLine
    "statusline setup
    set statusline=%f           "tail of the filename

    "Git
    set statusline+=%{fugitive#statusline()}

    "RVM
    set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

    set statusline+=%=          "left/right separator
    set statusline+=%c,         "cursor column
    set statusline+=%l/%L       "cursor line/total lines
    set statusline+=\ %P        "percent through file
    set laststatus=2

    "recalculate the trailing whitespace warning when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    "recalculate the tab warning flag when idle and after writing
    autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
    "recalculate the long line warning when idle and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

    " ===>end statusline

    "some stuff to get the mouse going in term
    set mouse=a
    set ttymouse=xterm2
    set ttyfast                         "коннект с терминалом быстрый

    "turn on syntax highlighting
    syntax on

    " Undo
    set undofile            " enable persistent undo
    " added test line
    if has('persistent_undo')
        set undodir=~/.vim/.cache/tmp/       " store undofiles in a tmp dir
    endif

    " Copy-Paste
    vmap <D-c> "+y
    map <D-v> "+gP

    " Folding
    if has('folding')
        set foldmethod=indent   " Fold on marker
        set foldlevel=999       " High default so folds are shown to start
        set foldcolumn=0        " Колоночка, чтобы показывать плюсики для скрытия блоков кода
    endif

    " Выводим красиво оформленную man-страницу прямо в Vim
    " в отдельном окне (см. начало этого файла)
    nmap <C-c>m :exe ":Man " expand("<cword>")<CR>

    " X-clipboard support
    if has('unnamedplus')
        set clipboard+=unnamed     " enable x-clipboard
    endif

    " Term
    if &term =~ "xterm"
        set t_Co=256            " set 256 colors
    endif

    " Color theme
    "let g:solarized_termcolors=256
    "let g:solarized_contrast = "high"
    "let g:solarized_termtrans = 1
    "color solarized

    colorscheme railscasts2

    " Edit
    set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
    set virtualedit=all         " on virtualedit for all mode

    set confirm
    set numberwidth=1              " Keep line numbers small if it's shown
    set autochdir

    " Open help in a vsplit rather than a split
    command! -nargs=? -complete=help Help :vertical help <args>
    cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

    " NASM settings
    au BufRead,BufNewFile *.asm	 set filetype=nasm

" }}}

" Functions {{{
" ==========

    " Key bind helper
    fun! rc#Map_ex_cmd(key, cmd) "{{{
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfun "}}}

    " Option switcher helper
    fun! rc#Toggle_option(key, opt) "{{{
      call rc#Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfun "}}}

    " Sessions
    fun! rc#SessionRead(name) "{{{
        let s:name = g:SESSION_DIR.'/'.a:name.'.session'
        if getfsize(s:name) >= 0
            echo "Reading " s:name
            exe 'source '.s:name
            exe 'silent! source '.getcwd().'/.vim/.vimrc'
        else
            echo 'Not find session: '.a:name
        endif
    endfun "}}}

    fun! rc#SessionInput(type) "{{{
        let s:name = input(a:type.' session name? ')
        if a:type == 'Save'
            call rc#SessionSave(s:name)
        else
            call rc#SessionRead(s:name)
        endif
    endfun "}}}

    fun! rc#SessionSave(name) "{{{
        exe "mks! " g:SESSION_DIR.'/'.a:name.'.session'
        echo "Session" a:name "saved"
    endfun "}}}

    " Omni and dict completition
    fun! rc#AddWrapper() "{{{
        if exists('&omnifunc') && &omnifunc != ''
            return "\<C-X>\<C-o>\<C-p>"
        else
            return "\<C-N>"
        endif
    endfun "}}}

    " Recursive vimgrep
    fun! rc#RGrep() "{{{
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif

        let cwd = getcwd()
        let startdir = input("Start searching from directory: ", cwd, "dir")
        if startdir == ""
            return
        endif

        let filepattern = input("Search in files matching pattern: ", "*.*")
        if filepattern == ""
            return
        endif

        execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern | botright copen
    endfun "}}}

    " Restore cursor position
    fun! rc#restore_cursor() "{{{
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction "}}}

    " Templates
    fun! rc#load_template() "{{{
        let dir_tpl = $HOME . "/.vim/templates/"

        if exists("g:tpl_prefix")
            let dir_tpl = l:dir_tpl . g:tpl_prefix . "/"
        endif

        let template = ''

        let path = expand('%:p:~:gs?\\?/?')
        let path = strpart(l:path, len(fnamemodify(l:path, ':h:h:h')), len(l:path))
        let parts = split(l:path, '/')

        while len(l:parts) && !filereadable(l:template)
            let template = l:dir_tpl . join(l:parts, '/')
            let l:parts = l:parts[1:]
        endwhile

        if !filereadable(l:template)
            let l:template = l:dir_tpl . &ft
        endif

        if filereadable(l:template)
            exe "0r " . l:template
        endif
    endfunction "}}}

    fun! rc#NTToggle() "{{{
        if !exists('g:NTToggle') || !g:NTToggle
            let g:NTToggle = 1 | NERDTree | TagbarOpen
            cwindow
            wincmd l
        else
            let g:NTToggle = 0 | NERDTreeClose | TagbarClose
            cclose
        endif
    endfunction "}}}

    "return '[\s]' if trailing white space is detected
    "return '' otherwise
    function! StatuslineTrailingSpaceWarning() "{{{
        if !exists("b:statusline_trailing_space_warning")
            if search('\s\+$', 'nw') != 0
                let b:statusline_trailing_space_warning = '[\s]'
            else
                let b:statusline_trailing_space_warning = ''
            endif
        endif
        return b:statusline_trailing_space_warning
    endfunction "}}}

    "return the syntax highlight group under the cursor ''
    function! StatuslineCurrentHighlight() "{{{
        let name = synIDattr(synID(line('.'),col('.'),1),'name')
        if name == ''
            return ''
        else
            return '[' . name . ']'
        endif
    endfunction "}}}

    "return '[&et]' if &et is set wrong
    "return '[mixed-indenting]' if spaces and tabs are used to indent
    "return an empty string if everything is fine
    function! StatuslineTabWarning() "{{{
        if !exists("b:statusline_tab_warning")
            let tabs = search('^\t', 'nw') != 0
            let spaces = search('^ ', 'nw') != 0

            if tabs && spaces
                let b:statusline_tab_warning =  '[mixed-indenting]'
            elseif (spaces && !&et) || (tabs && &et)
                let b:statusline_tab_warning = '[&et]'
            else
                let b:statusline_tab_warning = ''
            endif
        endif
        return b:statusline_tab_warning
    endfunction "}}}

    "return a warning for "long lines" where "long" is either &textwidth or 80 (if
    "no &textwidth is set)
    "
    "return '' if no long lines
    "return '[#x,my,$z] if long lines are found, were x is the number of long
    "lines, y is the median length of the long lines and z is the length of the
    "longest line
    function! StatuslineLongLineWarning() "{{{
        if !exists("b:statusline_long_line_warning")
            let long_line_lens = s:LongLines()

            if len(long_line_lens) > 0
                let b:statusline_long_line_warning = "[" .
                            \ '#' . len(long_line_lens) . "," .
                            \ 'm' . s:Median(long_line_lens) . "," .
                            \ '$' . max(long_line_lens) . "]"
            else
                let b:statusline_long_line_warning = ""
            endif
        endif
        return b:statusline_long_line_warning
    endfunction "}}}

    "return a list containing the lengths of the long lines in this buffer
    function! s:LongLines() "{{{
        let threshold = (&tw ? &tw : 80)
        let spaces = repeat(" ", &ts)

        let long_line_lens = []

        let i = 1
        while i <= line("$")
            let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
            if len > threshold
                call add(long_line_lens, len)
            endif
            let i += 1
        endwhile

        return long_line_lens
    endfunction "}}}

    "find the median of the given array of numbers
    function! s:Median(nums) "{{{
        let nums = sort(a:nums)
        let l = len(nums)

        if l % 2 == 1
            let i = (l-1) / 2
            return nums[i]
        else
            return (nums[l/2] + nums[(l/2)-1]) / 2
        endif
    endfunction "}}}

    "if we're in a rails env then read in the rails snippets
    function! s:SetupSnippets() "{{{
        if filereadable("./config/environment.rb")
        try
            call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
            call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
        catch
            call ExtractSnips("~/vimfiles/snippets/ruby-rails", "ruby")
            call ExtractSnips("~/vimfiles/snippets/eruby-rails", "eruby")
        endtry
        endif

        try
        call ExtractSnips("~/.vim/snippets/html", "eruby")
        call ExtractSnips("~/.vim/snippets/html", "xhtml")
        call ExtractSnips("~/.vim/snippets/html", "php")
        catch
        call ExtractSnips("~/vimfiles/snippets/html", "eruby")
        call ExtractSnips("~/vimfiles/snippets/html", "xhtml")
        call ExtractSnips("~/vimfiles/snippets/html", "php")
        endtry
    endfunction "}}}

    "visual search mappings
    function! s:VSetSearch() "{{{
        let temp = @@
        norm! gvy
        let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
        let @@ = temp
    endfunction "}}}

    function! SetCursorPosition() "{{{
        if &filetype !~ 'commit\c'
            if line("'\"") > 0 && line("'\"") <= line("$")
                exe "normal! g`\""
                normal! zz
            endif
        end
    endfunction "}}}

    function! s:HighlightLongLines(width) "{{{
        let targetWidth = a:width != '' ? a:width : 79
        if targetWidth > 0
            exec 'match Todo /\%>' . (targetWidth) . 'v/'
        else
            echomsg "Usage: HighlightLongLines [natural number]"
        endif
    endfunction "}}}

    " Strip trailing whitespace
    function! <SID>StripTrailingWhitespaces() "{{{
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction "}}}

" }}}


" Autocommands {{{
" =============

    if has("autocmd")

        augroup vimrc
        au!

            " Auto reload vim settins
            au! BufWritePost *.vim source ~/.vimrc

            " Highlight insert mode
            au InsertEnter * set cursorline
            au InsertLeave * set nocursorline

            " New file templates
            au BufNewFile * silent! call rc#load_template()

            " Restore cursor position
            au BufWinEnter * call rc#restore_cursor()

            " Autosave last session
            if has('mksession')
                au VimLeavePre * :call rc#SessionSave('last')
            endif

            " Save current open file when window focus is lost
            au FocusLost * if &modifiable && &modified | write | endif

            " Filetypes {{{
            " ---------
                au BufNewFile,BufRead *.json setf javascript
            " }}}

        augroup END

    endif

" }}}


" Plugins setup {{{
" ==============

    let mapleader = ","         " set custom map leader to ','

    map <C-g> g<C-g>            " Так получим более полную информацию, чем просто <C-g>

    "Command-T configuration
    let g:CommandTMaxHeight=10
    let g:CommandTMatchWindowAtTop=0
    nnoremap <silent> <Leader>t :CommandT<CR>
    nnoremap <silent> <Leader>b :CommandTBuffer<CR>

    "bindings for ragtag
    inoremap <M-o>       <Esc>o
    inoremap <C-j>       <Down>
    let g:ragtag_global_maps = 1

    "mark syntax errors with :signs
    let g:syntastic_enable_signs=1

    "key mapping for vimgrep result navigation
    map <A-o> :copen<CR>
    map <A-q> :cclose<CR>
    map <A-j> :cnext<CR>
    map <A-k> :cprevious<CR>


    "snipmate setup
    try
        source ~/.vim/bundle/snipmate-snippets/support_functions.vim
    catch
        source ~/vimfiles/snippets/support_functions.vim
    endtry
    autocmd vimenter * call s:SetupSnippets()

    "visual search mappings
    vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
    vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

    "define :HighlightLongLines command to highlight the offending parts of
    "lines that are longer than the specified length (defaulting to 80)
    command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')

    " Strip trailing whitespace
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

    "jump to last cursor position when opening a file
    "dont do it when writing a commit log entry
    autocmd BufReadPost * call SetCursorPosition()

    "key mapping for window navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    "Key mapping for textmate-like indentation
    nmap <D-[> <<
    nmap <D-]> >>
    vmap <D-[> <gv
    vmap <D-]> >gv

    let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'}

    "Enabling Zencoding
    let g:user_zen_settings = {
    \  'php' : {
    \    'extends' : 'html',
    \    'filters' : 'c',
    \  },
    \  'xml' : {
    \    'extends' : 'html',
    \  },
    \  'haml' : {
    \    'extends' : 'html',
    \  },
    \  'erb' : {
    \    'extends' : 'html',
    \  },
    \}

    " Tagbar
    let g:tagbar_width = 30
    let g:tagbar_foldlevel = 1
    " autocmd VimEnter * nested TagbarOpen " open at start

    " XPTemplates
    let g:xptemplate_key = '<Tab>'
    let g:xptemplate_key_pum_only = '<S-Tab>'
    let g:xptemplate_highlight = 'following'
    let g:xptemplate_vars = 'author=Kirill Klenov&email=horneds@gmail.com&SPfun=&SParg='
    let g:xptemplate_brace_complete = 1

    " NERDCommenter
    let NERDSpaceDelims = 1

    " NERDTree
    let NERDTreeWinSize = 30
    " files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
    let NERDTreeIgnore=[
        \'\~$',
        \'\.pt.cache$',
        \'\.Python$',
        \'\.svn$',
        \'\.beam$',
        \'\.pyc$',
        \'\.pyo$',
        \'\.mo$',
        \'\.o$',
        \'\.lo$',
        \'\.la$',
        \'\..*.rej$',
        \'\.rej$',
        \'\.\~lock.*#$',
        \'\.AppleDouble$',
        \'\.DS_Store$']

    " Enable extended matchit
    runtime macros/matchit.vim

    " Vimerl
    let g:erlangCompleteFile  = $HOME."/.vim/bundle/vimerl.git/autoload/erlang_complete.erl"
    let g:erlangCheckFile     = $HOME."/.vim/bundle/vimerl.git/compiler/erlang_check.erl"
    let g:erlangHighlightBIFs = 1
    let g:erlangCompletionGrep="zgrep"
    let g:erlangManSuffix="erl\.gz"

    " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>ga :Gwrite<CR>
    nnoremap <leader>gc :Gcommit %<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gl :Glog<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gr :Gremove<CR>
    nnoremap <leader>gpl :Git pull origin master<CR>

    noremap <F9> :emenu G.<TAB>
    menu G.Status :Gstatus<CR>
    menu G.Diff :Gdiff<CR>
    menu G.Commit :Gcommit %<CR>
    menu G.Checkout :Gread<CR>
    menu G.Remove :Gremove<CR>
    menu G.Move :Gmove<CR>
    menu G.Log :Glog<CR>
    menu G.Blame :Gblame<CR>

" }}}


" Hot keys {{{
" ==========

    " Insert mode {{{
    " ------------

        " Omni and dict completition on space
        inoremap <Nul> <C-R>=rc#AddWrapper()<CR>
        inoremap <C-Space> <C-R>=rc#AddWrapper()<CR>

        " emacs style jump to end of line
        inoremap <C-E> <C-o>A
        inoremap <C-A> <C-o>I


    " }}}

    " Normal mode {{{
    " ------------

        " Nice scrolling if line wrap
        noremap j gj
        noremap k gk

        " Toggle paste mode
        set paste
        noremap <silent> ,p :set invpaste<CR>:set paste?<CR>

        " Not jump on star, only highlight
        nnoremap * *N

        " Split line in current cursor position
        noremap <S-O>       i<CR><ESC>

        " Drop hightlight search result
        noremap <leader><space> :nohls<CR>

        " Unfold
        noremap <space> za

        " Fast scrool
        nnoremap <S-J> 5j
        nnoremap <S-K> 5k

        " Select all
        map vA ggVG
        map <D-a> ggVG

        " Если забыл перед открытием sudo
        cmap w!! %!sudo tee > /dev/null %

        " Close cwindow
        nnoremap <silent> ,ll :ccl<CR>

        " Quickfix fast navigation
        nnoremap <silent> ,nn :cwindow<CR>:cn<CR>
        nnoremap <silent> ,pp :cwindow<CR>:cp<CR>

        " Window commands
        nnoremap <silent> ,h :wincmd h<CR>
        nnoremap <silent> ,j :wincmd j<CR>
        nnoremap <silent> ,k :wincmd k<CR>
        nnoremap <silent> ,l :wincmd l<CR>
        nnoremap <silent> ,+ :wincmd +<CR>
        nnoremap <silent> ,- :wincmd -<CR>
        nnoremap <silent> ,cj :wincmd j<CR>:close<CR>
        nnoremap <silent> ,ck :wincmd k<CR>:close<CR>
        nnoremap <silent> ,ch :wincmd h<CR>:close<CR>
        nnoremap <silent> ,cl :wincmd l<CR>:close<CR>
        nnoremap <silent> ,cw :close<CR>

        " Buffer commands
        noremap <silent> ,bp :bp<CR>
        noremap <silent> ,bn :bn<CR>
        noremap <silent> ,ww :w<CR>
        noremap <silent> ,bd :bd<CR>
        noremap <silent> ,ls :ls<CR>

        " Delete all buffers
        nnoremap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

        " Search the current file for the word under the cursor and display matches
        nnoremap <silent> ,gw :call rc#RGrep()<CR>

        " Open new tab
        "call rc#Map_ex_cmd("<C-W>t", ":tabnew")

        " Tab navigation
        nmap <D-1> 1gt
        nmap <D-2> 2gt
        nmap <D-3> 3gt
        nmap <D-4> 4gt
        nmap <D-5> 5gt
        nmap <D-6> 6gt
        nmap <D-7> 7gt
        nmap <D-8> 8gt
        nmap <D-9> 9gt
        nmap <D-t> <ESC>:tabnew<CR>
        nmap <D-Right> <ESC>:tabnext<CR>
        nmap <D-Left> <ESC>:tabprev<CR>
        nmap <D-UP> <ESC>:tabfirst<CR>
        nmap <D-DOWN> <ESC>:tablast<CR>

        " первая вкладка
        "call rc#Map_ex_cmd("<A-UP>", ":tabfirst")
        " последняя вкладка
        "call rc#Map_ex_cmd("<A-DOWN>", ":tablast")
        " переместить вкладку в начало
        "nmap Q :tabmove 0<cr>
        " переместить вкладку в конец
        "call rc#Map_ex_cmd("<C-DOWN>", ":tabmove")

        " Keymap switch <C-F>
        cnoremap <silent> <C-F> <C-^>
        inoremap <silent> <C-F> <C-^>
        nnoremap <silent> <C-F> a<C-^><Esc>
        vnoremap <silent> <C-F> <Esc>a<C-^><Esc>gv

        " NERDTree keys
        call rc#Map_ex_cmd("<F1>", "NERDTreeToggle")
        nnoremap <silent> <leader>f :NERDTreeFind<CR>

        " Toggle NERDTRee and Tagbar
        nnoremap <F2> :call rc#NTToggle()<CR>

        " Toggle tagbar
        call rc#Map_ex_cmd("<F3>", "TagbarToggle")

        call rc#Toggle_option("<F6>", "list")      " Переключение подсветки невидимых символов
        call rc#Toggle_option("<F7>", "wrap")      " Переключение переноса слов

        " Session UI
        nnoremap <Leader>ss :call rc#SessionInput('Save')<CR>
        nnoremap <Leader>sr :call rc#SessionInput('Read')<CR>
        nnoremap <Leader>sl :call rc#SessionRead('last')<CR>

        " по звездочке не прыгать на следующее найденное, а просто подсветить
        nnoremap * *N
        " в визуальном режиме по команде * подсвечивать выделение
        vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>
        " Поиск и замена слова под курсором
        nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

        " < & > - делаем отступы для блоков
        vmap < <gv
        vmap > >gv

        "try to make possible to navigate within lines of wrapped lines
        nmap <Down> gj
        nmap <Up> gk
        set fo=l

    " }}}

    " Command mode {{{
    " ------------

        " Allow command line editing like emacs
        cnoremap <C-A>      <Home>
        cnoremap <C-B>      <Left>
        cnoremap <C-E>      <End>
        cnoremap <C-F>      <Right>
        cnoremap <C-N>      <Down>
        cnoremap <C-P>      <Up>

    " }}}

    " Visual mode {{{
    " ------------

    " }}}

" }}}


" GUI settings {{{
" ============

    " Some gui settings
    if has("gui_running")

        set guitablabel=%M%t
        "set lines=40
        "set columns=115

        set guioptions+=a
        set guioptions+=g   " grey menu items
        set guioptions+=i   " use vim icon
        set guioptions+=e   " use graphic tabs
        set guioptions-=T   " remove toolbar
        set guioptions-=m   " remove menu bar
        set guioptions+=c   " отключить графические диалоги
        set guioptions+=p   " use pointer callbacks
        set guioptions-=r   " remove right-hand scroll bar
        set guioptions-=l   " remove left-hand scroll bar

        set guifont=droid_sans_mono_slashed:h11
        set antialias       " включить антиаласинг шрифтов
        set noguipty        " Так не выводятся ненужные escape последовательности в :shell
        set cursorline      " подсвечивать текущую строку

        "let macvim_hig_shift_movement = 1 " выделение текста с помощью shift и стрелок
    endif

" }}}


" Local settings
" ================
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif

" C sittings
" ================
    "autocmd FileType text setlocal textwidth=80 "устанавливаем ширину в 80 знаков для текстовых файлов
    "au FileType c,cc,h,sh au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1) "Подсвечиваем 81 символ и т.д.

    "При редактировании файла всегда переходить на последнюю известную
    "позицию курсора. Если позиция ошибочная - не переходим.
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

    " Если есть makefile - собираем makeом.
    " Иначе используем gcc для текущего файла.
    if filereadable("Makefile")
        set makeprg=make
    else
        set makeprg=gcc\ -Wall\ -o\ %<\ %
    endif

    " формат строки с ошибкой для gcc и sdcc, это нужно для errormarker
    let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

    " Несколько удобных биндингов для С
    au FileType c,cc,h inoremap {<CR> {<CR>}<Esc>O
    au FileType c,cc,h inoremap #m int main(void)<CR>{<CR>return 0;<CR>}<CR><Esc>2kO
    au FileType c,cc,h inoremap #d #define
    au FileType c,cc,h inoremap #e #endif /*  */<Esc>hhi
    au FileType c,cc,h inoremap #" #include ""<Esc>i
    au FileType c,cc,h inoremap #< #include <><Esc>i
    au FileType c,cc,h inoremap #f /* FIXME:  */<Esc>hhi
    au FileType c,cc,h inoremap #t /*TODO:  */<Esc>hhi
    au FileType c,cc,h inoremap ;; <END>;<CR>
    au FileType c,cc,h inoremap " ""<Left>
    au FileType c,cc,h inoremap ' ''<Left>
    au FileType c,cc,h inoremap ( ()<Left>
    au FileType c,cc,h inoremap [ []<Left>
    au FileType c,cc,h inoremap (; ();<CR>
    au FileType c,cc,h inoremap ({ () {<CR>}<Esc>O
    au FileType c,cc,h inoremap /*<Space> /*  */<Esc>3ha

    " Compile programs using Makefile (and do not jump to first error)
    au FileType c,cc,h,s imap <C-c>m <Esc>:make!<CR>a
    au FileType c,cc,h,s nmap <C-c>m :make!<CR>

    " List of errors
    au FileType c,cc,h imap <C-c>l <Esc>:copen<CR>
    au FileType c,cc,h nmap <C-c>l :copen<CR>

    " Необходимо установить для того, чтобы *.h файлам
    " присваивался тип c, а не cpp.
    let c_syntax_for_h=""


" TagList sittings
" ================
    let g:Tlist_Show_One_File=1                         " показывать информацию только по одному файлу
    let g:Tlist_GainFocus_On_ToggleOpen=1               " получать фокус при открытии
    let g:Tlist_Compact_Format=1
    let g:Tlist_Close_On_Select=0                       " не закрывать окно после выбора тега
    let g:Tlist_Auto_Highlight_Tag=1                    " подсвечивать тег, на котором сейчас находимся

    imap <C-c>t <Esc>:TlistToggle<CR>:TlistUpdate<CR>
    nmap <C-c>t :TlistToggle<CR>:TlistUpdate<CR>

" ToggleProject sittings
" ================
    nmap <silent> <C-c>p <Plug>ToggleProject

" Gundo sittings
" ================
    nnoremap <C-c>u :GundoToggle<CR>
    let g:gundo_preview_bottom=1 " распологать часть снизу
    let g:gundo_width = 30
    let g:gundo_preview_height=15

" Python syntax
let python_highlight_all=1
setlocal keywordprg=pydoc
autocmd FileType python let g:pydiction_location ='~/.vim/bundle/pydiction/ftplugin/pydiction/complete-dict'

" Django templates
au! BufNewFile,BufRead *.html set filetype=htmldjango

" Omnicomplit
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'asux/snipmate-snippets'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-surround'
Bundle 'pangloss/vim-javascript'
Bundle 'klen/jslint.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-endwise'
Bundle 'akitaonrails/snipmate.vim'
Bundle 'scrooloose/syntastic'
Bundle 'wincent/Command-T'
Bundle 'timcharper/textile.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-unimpaired'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ervandew/supertab'
Bundle 'hallison/vim-ruby-sinatra'
Bundle 'ciaranm/securemodelines'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'greyblake/vim-preview'
Bundle 'tpope/vim-abolish'
Bundle 'Shadowfiend/liftweb-vim'
Bundle 'akhil/scala-vim-bundle'
Bundle 'felipero/grails-vim'
Bundle 'vim-scripts/VimClojure'
Bundle 'mattn/zencoding-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'digitaltoad/vim-jade'
Bundle 'itspriddle/vim-jquery'
Bundle 'othree/html5.vim'
Bundle 'sjl/gundo.vim'
Bundle 'chrismetcalf/vim-yankring'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rvm'
Bundle 'endel/actionscript.vim'
Bundle 'asux/vim-capybara'
Bundle 'jimenezrick/vimerl'
Bundle 'kana/vim-fakeclip'
Bundle 'klen/python-mode'
Bundle 'lambdalisue/vim-django-support'
Bundle 'drmingdrmer/xptemplate'
Bundle 'jceb/vim-orgmode'
Bundle 'majutsushi/tagbar'
Bundle 'Townk/vim-autoclose'
Bundle 'mattn/gist-vim'
Bundle 'henrik/vim-indexed-search'
Bundle 'tpope/vim-repeat'


" Project settings
" ================

    " enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
    set exrc

    " must be written at the last.  see :help 'secure'.
    set secure

