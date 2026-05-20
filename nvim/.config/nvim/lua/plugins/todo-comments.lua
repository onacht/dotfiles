return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'BufReadPost',
  opts = {},
  keys = {
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Next TODO' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Prev TODO' },
    { '<leader>ft', '<cmd>TodoFzfLua<cr>', desc = 'Find TODOs' },
  },
}
