return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 500,
    triggers = {
      { '<leader>', mode = { 'n', 'v' } },
      { '<C-w>', mode = { 'n' } },
    },
    icons = { mappings = true },
    spec = {
      -- leader groups
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
      -- ctrl groups
      { '<C-w>', group = 'windows' },
      { '<C-x>', group = 'completion/decrement' },
      -- ctrl descriptions
      { '<C-h>', desc = 'window left',           mode = 'n' },
      { '<C-j>', desc = 'window down',           mode = 'n' },
      { '<C-k>', desc = 'window up',             mode = 'n' },
      { '<C-l>', desc = 'window right',          mode = 'n' },
      { '<C-p>', desc = 'find files (fzf)',       mode = 'n' },
      { '<C-b>', desc = 'find buffers (fzf)',     mode = 'n' },
      { '<C-/>', desc = 'toggle terminal',        mode = 'n' },
      { '<C-u>', desc = 'scroll up + center',     mode = 'n' },
      { '<C-d>', desc = 'scroll down + center',   mode = 'n' },
      { '<C-n>', desc = 'yank cycle forward',     mode = 'n' },
      { '<C-r>', desc = 'visual calculator',      mode = 'v' },
    },
  },
  keys = {
    { '<leader>.', '<cmd>WhichKey <C-<cr>', desc = 'Show all Ctrl keymaps' },
  },
}
