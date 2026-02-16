local builtin = require('telescope.builtin')

-- basic keymaps
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = '[L]azy Plugin Manager' })

-- mason
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = '[M]ason Manager' })

-- lsp keybinds
local on_attach = function(client, bufnr)

  -- Buffer-local keymaps (only active when an LSP is attached to the buffer)
  -- Find
  vim.keymap.set('n', '<leader>fd', vim.lsp.buf.definition, { buffer = bufnr, desc = "[F]ind [D]efinition" })
  vim.keymap.set('n', '<leader>fq', vim.lsp.buf.hover, { buffer = bufnr, desc = "[F]ind [Q]uote" })
  vim.keymap.set('n', '<leader>fs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "[F]ind [S]ignature" })
  vim.keymap.set('n', '<leader>fi', vim.lsp.buf.declaration, { buffer = bufnr, desc = "[F]ind [I]nit" })

  -- Refactor
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]efactor [R]ename" })
  vim.keymap.set('n', '<leader>rf', function() vim.lsp.buf.format { async = true } end, { buffer = bufnr, desc = "[R]efactor [F]ormat" })

  -- Code Action
  vim.keymap.set('n', '<leader><space>', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

  -- Diagnostics
  vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })
  vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
  vim.keymap.set('n', '<leader>d<space>', vim.diagnostic.set_loclist, { buffer = bufnr, desc = "Open location list with diagnostics" })
end

-- telescope
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep,  { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers,    { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags,  { desc = '[S]earch [H]elp' })

-- line comment toggle
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts)
vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp.attach', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            on_attach(client, args.buf)
        end
    end
})