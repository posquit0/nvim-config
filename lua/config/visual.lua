-- Enable if the terminal support true colors
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

local options = {
  opt = {
    number = true, -- Line numbers on
    relativenumber = true, -- Enable relative number for line (Constantly computing the relative nubmers is expensive)
    signcolumn = "yes", -- Always show signcolumns

    breakindent = false, -- Every wrapped line will continue visually indented, thus preserving horizontal blocks of text.
    linebreak = true, -- Vim will wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen.
    showbreak = "» ", -- String to put at the start of lines that have been wrapped.
    wrap = true, -- Change how text is displayed. When on, lines longer than the width of the window will wrap and displaying continues on the next line.

    showtabline = 2, -- Only if there are at least two tab pages

    ruler = true, -- Show ruler
    showcmd = true, -- Show the command typing
    showmode = false, -- Hide the current mode

    cursorline = true, -- Highlight current line
    showmatch = true, -- Show matching brackets
    matchtime = 5, -- Bracket blinking
  },
  g = {},
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

-- vim.opt.breakindent = true
-- vim.opt.cmdheight = 0
-- vim.opt.completeopt = "menuone,noselect"
-- vim.opt.conceallevel = 3
-- vim.opt.confirm = true
-- vim.opt.hidden = true
-- vim.opt.ignorecase = true
-- vim.opt.inccommand = "nosplit"
-- vim.opt.joinspaces = false
-- vim.opt.laststatus = 0
-- vim.opt.list = true
-- vim.opt.mouse = "a"
-- vim.opt.pumblend = 10
-- vim.opt.pumheight = 10
-- vim.opt.scrolloff = 8
-- vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- vim.opt.shiftround = true
-- vim.opt.shiftwidth = indent
-- vim.opt.sidescrolloff = 8
-- vim.opt.splitbelow = true
-- vim.opt.splitkeep = "screen"
-- vim.opt.splitright = true
-- vim.opt.timeoutlen = 300
-- vim.opt.undofile = true
-- vim.opt.updatetime = 200
-- vim.opt.wildmode = "longest:full,full"
--
-- -- Enable syntax highlighting
-- syntax on
--
-- -- Mark 80th column with a highlight color
-- if exists('+colorcolumn')
--   set colorcolumn=80
--   highlight ColorColumn ctermbg=gray
-- endif
-- -- No blinking
-- set novisualbell
-- -- No noise
-- set noerrorbells
-- -- Minimal number of screen lines to keep above and below the cursor
-- set scrolloff=3
-- -- Native customized statusline, if airline is not available
-- set statusline=%1*%{winnr()}\ %*%<\ %f\ %h%m%r%=%l,%c%V\ (%P)
-- -- Always show status line.
-- set laststatus=2
-- -- No conceal
-- set conceallevel=0
-- -- Use a block cursor in normal mode, i-beam cursor in insertmode
-- if empty($TMUX)
--   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
--   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
-- else
--   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
--   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
-- endif
-- if has('nvim')
--   set inccommand=split
-- endif
--
