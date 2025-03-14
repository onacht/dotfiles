local user_maps = require 'user.lsp.keymaps'
local utils = require 'user.utils'
local autocmd = vim.api.nvim_create_autocmd
local augroup = utils.augroup

local on_attach_aug = augroup 'OnAttachAu'
local default_on_attach = function(client, bufnr)
  ------------------
  -- Add mappings --
  ------------------
  user_maps(bufnr)

  -----------------------
  -- Plugins on-attach --
  -----------------------
  -- require('user.lsp.formatting').setup(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  ------------------
  -- AutoCommands --
  ------------------
  if client.server_capabilities.code_lens then
    autocmd({ 'BufEnter', 'InsertLeave', 'InsertEnter' }, {
      desc = 'Auto show code lenses',
      group = on_attach_aug,
      buffer = bufnr,
      command = 'silent! lua vim.lsp.codelens.refresh({bufnr=' .. bufnr .. '})',
    })
  end
  if client.server_capabilities.document_highlight then
    -- Highlight text at cursor position
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      desc = 'Highlight references to current symbol under cursor',
      group = on_attach_aug,
      buffer = bufnr,
      command = 'silent! lua vim.lsp.buf.document_highlight()',
    })
    autocmd({ 'CursorMoved' }, {
      desc = 'Clear highlights when cursor is moved',
      group = on_attach_aug,
      buffer = bufnr,
      command = 'silent! lua vim.lsp.buf.clear_references()',
    })
  end

  ----------------------------------
  -- Enable tag jump based on LSP --
  ----------------------------------
  if client.server_capabilities.goto_definition then
    vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', { buf = bufnr })
  end

  -----------------
  -- Inlay Hints --
  -----------------
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
end

local minimal_on_attach = function(_, bufnr)
  -- Add mappings
  user_maps(bufnr)
end

return {
  default = default_on_attach,
  minimal = minimal_on_attach,
}
