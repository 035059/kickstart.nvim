local wk = require('which-key')

-- [[ Which-key Configurations ]]
-- document existing key chains
wk.register {
  ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = 'Toggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
wk.register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git Hunk' },
}, { mode = 'v' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Oil keybinds
vim.keymap.set('n', '-', "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Harpoon keybinds
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set("n", "<A-h>", mark.add_file)
vim.keymap.set("n", "<A-u>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-j>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<A-k>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<A-l>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<A-;>", function() ui.nav_file(4) end)

-- Git keybinds
local function git_commit()
  vim.cmd(string.format('Git commit -m "%s"', vim.fn.input('Commit message: ')))
end
wk.register({
  g = {
    name = "Git",
    a = { "<CMD>Git add .<CR>", "Add file to git tracking" },
    A = { "<CMD>Git add *<CR>", "Add all files to git" },
    c = { function() git_commit() end, "Create commit" },
    h = { name = 'Git Hunk', _ = 'which_key_ignore' },
    p = { "<CMD>Git push<CR>", "Push to remote" },
    P = { "<CMD>Git pull<CR>", "Pull from remote" },
    s = { "<CMD>Git status<CR>", "Get git status" },
  }
}, { prefix = "<leader>" })

-- Debugging keymaps
local dap = require('dap')
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

-- Telescope keymaps
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = 'Search in Open Files' })
vim.keymap.set('n', '<leader>ss', tb.builtin, { desc = 'Search Select Telescope' })
vim.keymap.set('n', '<leader>gf', tb.git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>sf', tb.find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', tb.grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sg', tb.live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = 'Search by Grep on Git Root' })
vim.keymap.set('n', '<leader>sd', tb.diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', tb.resume, { desc = 'Search Resume' })
