---@diagnostic disable: missing-fields
return {
  {
    'saghen/blink.cmp',
    enabled = true,
    version = 'v1.*',
    build = 'cargo build --release',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    event = 'InsertEnter',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal',
      },

      completion = {

        accept = { auto_brackets = { enabled = true } },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = 'rounded' },
        },

        ghost_text = { enabled = false },

        list = {
          selection = {
            preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
            auto_insert = function(ctx) return ctx.mode == 'cmdline' end,
          },
        },

        menu = {
          border = 'rounded',

          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,

          draw = {
            columns = {
              { 'kind_icon', 'label', gap = 1 },
              { 'label_description', gap = 1 },
              { 'source_name' },
            },
          },
        },
      },

      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'show', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'show', 'select_prev', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-/>'] = { 'hide', 'fallback' },
      },

      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },

      sources = {
        default = { 'lsp', 'snippets', 'path', 'buffer', 'lazydev' },
        providers = {
          lsp = { fallbacks = { 'lazydev' } },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
        },
      },
    },
  },
}
