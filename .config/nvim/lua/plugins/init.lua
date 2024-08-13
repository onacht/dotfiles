local utils = require 'user.utils'
local nmap = utils.nmap

local M = {
  ------------------------------------
  -- Language Server Protocol (LSP) --
  ------------------------------------
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'TroubleToggle',
  },
  {
    'sam4llis/nvim-lua-gf',
    ft = 'lua',
  },
  {
    'asdf.nvim',
    enabled = false,
    dir = '~/Repos/asdf.nvim',
    opts = {},
  },
  {
    'NStefan002/2048.nvim',
    cmd = 'Play2048',
    config = true,
  },
  {
    'milisims/nvim-luaref',
    ft = 'lua',
  },
  {
    'chr4/nginx.vim',
    ft = 'nginx',
  },
  {
    'ton/vim-bufsurf',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { ']b', '<Plug>(buf-surf-forward)' },
      { '[b', '<Plug>(buf-surf-back)' },
    },
  },
  {
    'mosheavni/vim-kubernetes',
    ft = 'yaml',
    config = function()
      require('user.menu').add_actions('Kubernetes', {
        ['Apply (:KubeApply)'] = function()
          vim.cmd [[KubeApply]]
        end,
        ['Apply Directory (:KubeApplyDir)'] = function()
          vim.cmd [[KubeApplyDir]]
        end,
        ['Create (:KubeCreate)'] = function()
          vim.cmd [[KubeCreate]]
        end,
        ['Decode Secret (:KubeDecodeSecret)'] = function()
          vim.cmd [[KubeDecodeSecret]]
        end,
        ['Delete (:KubeDelete)'] = function()
          vim.cmd [[KubeDelete]]
        end,
        ['Delete Dir (:KubeDeleteDir)'] = function()
          vim.cmd [[KubeDeleteDir]]
        end,
        ['Encode Secret (:KubeEncodeSecret)'] = function()
          vim.cmd [[KubeEncodeSecret]]
        end,
        ['Recreate (:KubeRecreate)'] = function()
          vim.cmd [[KubeRecreate]]
        end,
      })
    end,
  },
  {
    'chrisbra/vim-sh-indent',
    ft = { 'sh', 'bash', 'zsh' },
  },

  --------------
  -- Quickfix --
  --------------
  {
    'yorickpeterse/nvim-pqf',
    opts = {},
    event = 'QuickFixCmdPre',
    -- ft = 'qf',
  },
  {
    'tommcdo/vim-lister',
    ft = 'qf',
    cmd = { 'Qfilter', 'Qgrep' },
  }, -- Qfilter and Qgrep on Quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },

  -----------------------
  -- Text Manipulation --
  -----------------------
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    keys = { 'ds', 'cs', 'ys', { 'S', nil, mode = 'v' } },
    opts = {},
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {},
    event = 'BufReadPre',
  },
  {
    'junegunn/vim-easy-align',
    keys = { { 'ga', '<Plug>(EasyAlign)', mode = { 'v', 'n' } } },
  },
  {
    'AndrewRadev/switch.vim',
    keys = {
      { 'gs', nil, { 'n', 'v' } },
    },
    config = function()
      local fk = [=[\<\(\l\)\(\l\+\(\u\l\+\)\+\)\>]=]
      local sk = [=[\<\(\u\l\+\)\(\u\l\+\)\+\>]=]
      local tk = [=[\<\(\l\+\)\(_\l\+\)\+\>]=]
      local fok = [=[\<\(\u\+\)\(_\u\+\)\+\>]=]
      local folk = [=[\<\(\l\+\)\(\-\l\+\)\+\>]=]
      local fik = [=[\<\(\l\+\)\(\.\l\+\)\+\>]=]
      vim.g['switch_custom_definitions'] = {
        vim.fn['switch#NormalizedCaseWords'] { 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday' },
        vim.fn['switch#NormalizedCase'] { 'yes', 'no' },
        vim.fn['switch#NormalizedCase'] { 'on', 'off' },
        vim.fn['switch#NormalizedCase'] { 'left', 'right' },
        vim.fn['switch#NormalizedCase'] { 'up', 'down' },
        vim.fn['switch#NormalizedCase'] { 'enable', 'disable' },
        vim.fn['switch#NormalizedCase'] { 'Always', 'Never' },
        { '==', '!=' },
        {
          [fk] = [=[\=toupper(submatch(1)) . submatch(2)]=],
          [sk] = [=[\=tolower(substitute(submatch(0), '\(\l\)\(\u\)', '\1_\2', 'g'))]=],
          [tk] = [=[\U\0]=],
          [fok] = [=[\=tolower(substitute(submatch(0), '_', '-', 'g'))]=],
          [folk] = [=[\=substitute(submatch(0), '-', '.', 'g')]=],
          [fik] = [=[\=substitute(submatch(0), '\.\(\l\)', '\u\1', 'g')]=],
        },
      }
    end,
    init = function()
      local custom_switches = require('user.utils').augroup 'CustomSwitches'
      vim.api.nvim_create_autocmd('FileType', {
        group = custom_switches,
        pattern = { 'gitrebase' },
        callback = function()
          vim.b['switch_custom_definitions'] = {
            { 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec', 'drop' },
          }
        end,
      })
      -- (un)check markdown buxes
      vim.api.nvim_create_autocmd('FileType', {
        group = custom_switches,
        pattern = { 'markdown' },
        callback = function()
          local fk = [=[\v^(\s*[*+-] )?\[ \]]=]
          local sk = [=[\v^(\s*[*+-] )?\[x\]]=]
          local tk = [=[\v^(\s*[*+-] )?\[-\]]=]
          local fok = [=[\v^(\s*\d+\. )?\[ \]]=]
          local fik = [=[\v^(\s*\d+\. )?\[x\]]=]
          local sik = [=[\v^(\s*\d+\. )?\[-\]]=]
          vim.b['switch_custom_definitions'] = {
            {
              [fk] = [=[\1[x]]=],
              [sk] = [=[\1[-]]=],
              [tk] = [=[\1[ ]]=],
            },
            {
              [fok] = [=[\1[x]]=],
              [fik] = [=[\1[-]]=],
              [sik] = [=[\1[ ]]=],
            },
          }
        end,
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', '<Plug>(leap-forward-to)' },
      { 'S', '<Plug>(leap-backward-to)' },
    },
  },
  {
    'atusy/treemonkey.nvim',
    keys = {
      {
        'm',
        function()
          require 'nvim-treesitter.configs'
          ---@diagnostic disable-next-line: missing-fields
          require('treemonkey').select {
            ignore_injections = false,
            action = require('treemonkey.actions').unite_selection,
          }
        end,
        mode = { 'x', 'o' },
      },
    },
  },
  {
    'axelvc/template-string.nvim',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' },
    event = 'InsertEnter',
    config = true,
  },
  {
    'mizlan/iswap.nvim',
    cmd = { 'ISwap', 'ISwapWith' },
    keys = {
      { '<leader>sw', '<cmd>ISwap<CR>' },
    },
    opts = {},
  },
  {
    'vim-scripts/ReplaceWithRegister',
    keys = {
      { '<leader>p', '<Plug>ReplaceWithRegisterOperator' },
      { '<leader>P', '<Plug>ReplaceWithRegisterLine' },
      { '<leader>p', '<Plug>ReplaceWithRegisterVisual', mode = { 'x' } },
    },
  },
  {
    'vidocqh/auto-indent.nvim',
    event = 'InsertEnter',
    opts = {},
  },

  -- DONE ✅
}

nmap('<leader>z', '<cmd>Lazy<CR>', true)

return M
