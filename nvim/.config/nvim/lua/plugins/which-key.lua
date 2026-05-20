return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 500,
    icons = { mappings = true },
    spec = {
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunks' },
      { '<leader>f', group = 'folds/find' },
      { '<leader>c', group = 'copilot/code' },
      { '<leader>d', group = 'diff' },
      { '<leader>b', group = 'buffer' },
      { '<leader>t', group = 'tabs' },
      { '<leader>y', group = 'yank' },
      { '<leader>l', group = 'lsp' },
      { '<leader>k', group = 'kubectl' },
      { '<leader>e', group = 'explore' },
      { '<leader>p', group = 'pick/color' },
      { '<leader>s', group = 'swap/search' },
      { '<leader>6', group = 'base64' },
    },
  },
}
