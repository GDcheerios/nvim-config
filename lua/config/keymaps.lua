local builtin = require('telescope.builtin')

-- basic keymaps
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- telescope
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep,  { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers,    { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags,  { desc = '[S]earch [H]elp' })

-- line comment toggle
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts)
vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)
