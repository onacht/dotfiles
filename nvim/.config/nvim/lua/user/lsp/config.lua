local M = {
  diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = '✘',
    [vim.diagnostic.severity.WARN] = '',
    [vim.diagnostic.severity.HINT] = ' ',
    [vim.diagnostic.severity.INFO] = ' ',
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
}

M.init = function()
  _G.start_ls = function(with_file)
    local file_name = nil
    if with_file == true then
      local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      file_name = _G.tmp_write { should_delete = false, new = false, ft = ft }
    end
    -- load lsp
    require 'lspconfig'
    return file_name
  end
  vim.keymap.set('n', '<leader>ls', function()
    _G.start_ls(false)
  end)
  vim.keymap.set('n', '<leader>lS', function()
    _G.start_ls(true)
  end)
  require('user.menu').add_actions('LSP', {
    ['Start LSP (<leader>ls)'] = function()
      _G.start_ls()
    end,
  })
end

M.setup = function()
  require('user.lsp.actions').setup()
  require('vim.lsp.log').set_format_func(vim.inspect)
  M.capabilities =
    vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities(), M.capabilities or {}, {})

  -- Diagnostics
  vim.diagnostic.config {
    jump = { on_jump = function() vim.diagnostic.open_float() end },
    signs = { text = M.diagnostic_signs },
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_lines = { current_line = true },
    float = { border = 'rounded', source = 'if_many' },
  }

  ---@diagnostic disable-next-line: missing-fields
  require('user.lsp.servers').setup()

  -- on attach
  local on_attach_aug = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', {
    group = on_attach_aug,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local bufnr = ev.buf
      require 'user.lsp.keymaps'(bufnr)
      if client and client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end

      -- 🔧 Patch: disable semantic tokens only for broken servers
      local broken_servers = {
        tsserver = true,
        eslint = true,
        vuels = true,
        vtsls = true,
        jsonls = true,
      }

      if client and broken_servers[client.name] then
        client.server_capabilities.semanticTokensProvider = nil
        vim.notify(
          string.format("Disabled semantic tokens for %s (missing legend)", client.name),
          vim.log.levels.WARN
        )
      elseif client and client.server_capabilities.semanticTokensProvider
        and not client.server_capabilities.semanticTokensProvider.legend then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end,
  })
end

return M
