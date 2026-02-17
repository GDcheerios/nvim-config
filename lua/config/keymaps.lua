local builtin = require('telescope.builtin')

-- keymap syntax
-- (mode, lhs (keys), rhs (action), opts)

-- basic keymaps
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = '[L]azy Plugin Manager' })

-- mason
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = '[M]ason Manager' })

-- lsp keybinds
local function safe_on_attach(client, bufnr)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local bufopts = { buffer = bufnr, silent = true }

  -- Find
  vim.keymap.set('n', '<leader>fd', function() vim.lsp.buf.definition() end, vim.tbl_extend('force', bufopts, { desc = "[F]ind [D]efinition" }))
  vim.keymap.set('n', '<leader>fq', function() vim.lsp.buf.hover() end, vim.tbl_extend('force', bufopts, { desc = "[F]ind [Q]uote" }))
  vim.keymap.set('n', '<leader>fs', function() vim.lsp.buf.signature_help() end, vim.tbl_extend('force', bufopts, { desc = "[F]ind [S]ignature" }))

  if client.server_capabilities.declarationProvider then
    vim.keymap.set('n', '<leader>fi', function() vim.lsp.buf.declaration() end, vim.tbl_extend('force', bufopts, { desc = "[F]ind [I]nit" }))
  end

  -- Refactor
  vim.keymap.set('n', '<leader>rr', function() vim.lsp.buf.rename() end, vim.tbl_extend('force', bufopts, { desc = "[R]efactor [R]ename", noremap = true }))
  vim.keymap.set('n', '<leader>rf', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', bufopts, { desc = "[R]efactor [F]ormat" }))

  -- Code action (guard if needed)
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader><space>', function() vim.lsp.buf.code_action() end, vim.tbl_extend('force', bufopts, { desc = "Code Action" }))
  end

  -- Diagnostics
  vim.keymap.set('n', '<leader>d[', function() vim.diagnostic.goto_prev() end, vim.tbl_extend('force', bufopts, { desc = "Go to previous diagnostic" }))
  vim.keymap.set('n', '<leader>d]', function() vim.diagnostic.goto_next() end, vim.tbl_extend('force', bufopts, { desc = "Go to next diagnostic" }))
  vim.keymap.set('n', '<leader>d<space>', function() vim.diagnostic.setloclist() end, vim.tbl_extend('force', bufopts, { desc = "Open location list with diagnostics" }))
end

-- telescope
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep,  { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers,    { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags,  { desc = '[S]earch [H]elp' })

-- line comment toggle
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { silent = true })
vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.attach', { clear = true }),
  callback = function(args)
    local bufnr = args.buf or vim.api.nvim_get_current_buf()
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and bufnr then
      safe_on_attach(client, bufnr)
    end
  end,
})

