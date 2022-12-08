local utils = require 'user.utils'
local opts = utils.map_opts
local keymap = utils.keymap
local tnoremap = utils.tnoremap
local vnoremap = utils.vnoremap
vim.opt.compatible = false

-- disable legacy vim filetype detection in favor of new lua based from neovim
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

vim.opt.cursorcolumn = true
vim.opt.cursorline = true -- Add highlight behind current line
vim.opt.shortmess:append { c = true, l = false, q = false, S = false }
vim.opt.list = true
vim.opt.listchars = { tab = '┆·', trail = '·', precedes = '', extends = '', eol = '↲' }
-- set lcscope=tab:┆·,trail:·,precedes:,extends:
vim.opt.fillchars = { vert = '|', fold = '·' }
vim.opt.emoji = false
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append '<>[]hl'
vim.opt.diffopt:append { linematch = 50 }
vim.opt.diffopt:append 'vertical'

vim.opt.number = true -- Show current line number
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.linebreak = true -- Avoid wrapping a line in the middle of a word.
vim.opt.wrap = true -- Wrap long lines
vim.opt.hlsearch = true -- highlight reg. ex. in @/ register
vim.opt.incsearch = true -- Search as characters are typed
vim.opt.inccommand = 'split' -- Incremental search and replace with small split window
vim.opt.ignorecase = true -- Search case insensitive...
vim.opt.smartcase = true -- ignore case if search pattern is all lowercase, case-sensitive otherwise
vim.opt.autoread = true -- Re-read file if it was changed from the outside
vim.opt.scrolloff = 8 -- When about to scroll page, see 7 lines below cursor
vim.opt.cmdheight = 1 -- Height of the command bar
vim.opt.hidden = true -- Hide buffer if abandoned
vim.opt.showmatch = true -- When closing a bracket (like {}), show the enclosing
vim.opt.splitbelow = true -- Horizontaly plitted windows open below
vim.opt.splitright = true -- Vertically plitted windows open below bracket for a brief second
vim.opt.startofline = false -- Stop certain movements from always going to the first character of a line.
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.confirm = true -- Prompt confirmation if exiting unsaved file
vim.opt.lazyredraw = false -- redraw only when we need to.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.wildmenu = true -- Displays a menu on autocomplete
vim.opt.wildmode = { 'longest:full', 'full' } -- Command-line completion mode
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.previewheight = 15
vim.opt.title = true -- Changes the iterm title
vim.opt.laststatus = 3 -- Global statusline, only one for all buffers
vim.opt.titlestring = "nvim: %{substitute(getcwd(), $HOME, '~', '')}"
vim.opt.showcmd = true
vim.opt.guifont = 'Fira Code,Hack Nerd Font'
vim.opt.mouse = 'a'
vim.opt.undofile = true -- Enables saving undo history to a file
-- opt.colorcolumn = '80' -- Mark where are 80 characters to start breaking line
vim.opt.textwidth = 80
vim.opt.fileencodings = { 'utf-8', 'cp1251' }
vim.opt.encoding = 'utf-8'
vim.opt.visualbell = true -- Use visual bell instead of beeping
vim.opt.conceallevel = 0
vim.opt.showmode = false -- Redundant as lighline takes care of that
vim.opt.history = 1000
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
-- require 'user.winbar'
-- opt.winbar = "%{%v:lua.require'user.winbar'.eval()%}"

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
vim.opt.updatetime = 300

-- Ignore node_modules and other dirs
vim.opt.wildignore:append { '**/node_modules/**', '.hg', '.git', '.svn', '*.DS_Store', '*.pyc' }
vim.opt.path:append { '**' }

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevel = 999
vim.opt.foldlevelstart = 10

-- j = Delete comment character when joining commented lines.
-- t = auto break long lines
-- r = auto insert comment leader after <Enter> (insert mode)
-- o = auto insert comment leader after o (normal mode)
-- l = don't break long lines
vim.opt.formatoptions:append { j = true, t = true, r = true, o = true, l = true }

-- Indenting
vim.opt.breakindent = true -- Maintain indent on wrapping lines
vim.opt.autoindent = true -- always set autoindenting on
vim.opt.copyindent = true -- copy the previous indentation on autoindenting
vim.opt.smartindent = true -- Number of spaces to use for each step of (auto)indent.
vim.opt.shiftwidth = 4 -- Number of spaces for each indent
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true -- insert tabs on the start of a line according to shiftwidth, not tabstop
vim.opt.expandtab = true -- Tab changes to spaces. Format with :retab
vim.opt.indentkeys:remove '0#'
vim.opt.indentkeys:remove '<:>'

-- Allow clipboard copy paste in neovim
keymap('', '<D-v>', '+p<CR>', opts.no_remap_silent)
keymap('!', '<D-v>', '<C-R>+', opts.no_remap_silent)
tnoremap('<D-v>', '<C-R>+', true)
vnoremap('<D-v>', '<C-R>+', true)

vim.cmd [[
" hi ColorColumn ctermbg=238 guibg=lightgrey
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
set guicursor+=i:blinkon1
]]
--
-- Abbreviations
vim.cmd [[
inoreabbrev teh the
inoreabbrev seperate separate
inoreabbrev dont don't
inoreabbrev rbm # TODO: remove before merging
inoreabbrev cbm # TODO: change before merging
inoreabbrev ubm # TODO: uncomment before merging
inoreabbrev funciton function
inoreabbrev functiton function
inoreabbrev fucntion function
inoreabbrev funtion function
inoreabbrev erturn return
inoreabbrev retunr return
inoreabbrev reutrn return
inoreabbrev reutn return
inoreabbrev queyr query
inoreabbrev htis this
inoreabbrev foreahc foreach
inoreabbrev forech foreach
]]

-- Run current buffer
vim.cmd [[
" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! ExecuteFile()
  let l:filetype_to_command = {
        \   'javascript': 'node',
        \   'python': 'python3',
        \   'html': 'open',
        \   'sh': 'bash'
        \ }
  call inputsave()
  let sure = input('Are you sure you want to run the current file? (y/n): ')
  call inputrestore()
  if sure !=# 'y'
    return ''
  endif
  echo ''
  let l:cmd = get(l:filetype_to_command, &filetype, 'bash')
  :%y
  new | 0put
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  exe '%!'.l:cmd
  normal! ggO
  call setline(1, 'Output of ' . l:cmd . ' command:')
  normal! yypVr=o
endfunction

nnoremap <silent> <F3> :call ExecuteFile()<CR>
]]

-- Grep
vim.cmd [[
" Set grepprg as RipGrep or ag (the_silver_searcher), fallback to grep
if executable('rg')
  let &grepprg="rg --vimgrep --no-heading --smart-case --hidden --follow -g '!{" . &wildignore . "}' -uu $*"
  let g:grep_literal_flag="-F"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  let &grepprg='ag --vimgrep --smart-case --hidden --follow --ignore "!{' . &wildignore . '}" $*'
  let g:grep_literal_flag="-Q"
  set grepformat=%f:%l:%c:%m
else
  let &grepprg='grep -n -r --exclude=' . shellescape(&wildignore) . ' . $*'
  let g:grep_literal_flag="-F"
endif

function! RipGrepCWORD(bang, visualmode, ...) abort
  let search_word = a:1

  if a:visualmode
    " Get the line and column of the visual selection marks
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]

    " Get all the lines represented by this range
    let lines = getline(lnum1, lnum2)

    " The last line might need to be cut if the visual selection didn't end on the last column
    let lines[-1] = lines[-1][: col2 - (&selection ==? 'inclusive' ? 1 : 2)]
    " The first line might need to be trimmed if the visual selection didn't start on the first column
    let lines[0] = lines[0][col1 - 1:]

    " Get the desired text
    let search_word = join(lines, "\n")
  endif
  if search_word ==? ''
    let search_word = expand('<cword>')
  endif

  " Set bang command for literal search (no regexp expansion)
  let search_message_literally = "for " . search_word
  if a:bang == "!"
    let search_message_literally = "literally for " . search_word
    let search_word = get(g:, 'grep_literal_flag', "") . ' ' . shellescape(search_word)
  endif

  echom 'Searching ' . search_message_literally

  " Silent removes the "press enter to continue" prompt
  " Bang (!) is for literal search (no regexp expansion)
  let grepcmd = 'silent grep! ' . search_word
  execute grepcmd
endfunction
command! -bang -range -nargs=? RipGrepCWORD call RipGrepCWORD("<bang>", v:false, <q-args>)
command! -bang -range -nargs=? RipGrepCWORDVisual call RipGrepCWORD("<bang>", v:true, <q-args>)
nmap <c-f> :RipGrepCWORD!<Space>
vmap <c-f> :RipGrepCWORDVisual!<cr>
]]

-- Visual Calculator
vim.cmd [[
function s:VisualCalculator() abort
  let save_pos = getpos('.')
  " Get visual selection
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection ==? 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let first_expr = join(lines, "\n")

  " Get arithmetic operation from user input
  call inputsave()
  let operation = input('Enter operation: ')
  call inputrestore()

  " Calculate final result
  let fin_result = eval(str2nr(first_expr) . operation)

  " Replace
  exe 's/\%V' . first_expr . '/' . fin_result . '/'

  call setpos('.', save_pos)
endfunction
command! -range VisualCalculator call <SID>VisualCalculator()
vmap <c-r> :VisualCalculator<cr>
]]

-- SynStack - see highlight under cursor
vim.cmd [[
function! s:SynStack()
  if !exists("*synstack")
    return
  endif
  return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command! SynStack echo <SID>SynStack()
]]

-- disable some builtin vim plugins
local default_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  -- 'netrw',
  -- 'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}
for _, plugin in pairs(default_plugins) do
  vim.g['loaded_' .. plugin] = 1
end
