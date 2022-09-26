local fn = vim.fn

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end
packer.init {
  max_jobs = 10,
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}
return packer.startup(function(use)
  -- Infrastructure
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Project Drawer
  -- use { 'preservim/nerdtree', cmd = { 'NERDTreeToggle' } }
  -- use { 'Xuyuanp/nerdtree-git-plugin', cmd = { 'NERDTreeToggle' } }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    command = 'NvimTreeToggle',
  }

  -- Git Related
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use { 'mosheavni/vim-to-github', cmd = { 'ToGithub' } }
  use 'akinsho/git-conflict.nvim'

  -- Documents
  use { 'nanotee/luv-vimdocs', cmd = { 'Telescope', 'help' } }
  use { 'milisims/nvim-luaref', cmd = { 'Telescope', 'help' } }

  -- Fuzzy Search - Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-project.nvim' },
    },
  }

  -- LSP, Completion and Language
  -- Tree Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'p00f/nvim-ts-rainbow'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  }
  use {
    'cuducos/yaml.nvim',
    ft = { 'yaml' }, -- optional
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }
  use 'someone-stole-my-name/yaml-companion.nvim'
  use 'lewis6991/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use { 'sam4llis/nvim-lua-gf', ft = { 'lua' } }
  use 'Afourcat/treesitter-terraform-doc.nvim'
  use 'David-Kunz/markid'

  -- LSP
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }
  use {
    'ray-x/lsp_signature.nvim', -- Show function signature when you type
    'lukas-reineke/lsp-format.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'b0o/SchemaStore.nvim',
    'folke/lsp-colors.nvim',
    'nanotee/nvim-lsp-basics',
    'j-hui/fidget.nvim',
  }
  use {
    'jayp0521/mason-null-ls.nvim',
    after = {
      'null-ls.nvim',
      'mason.nvim',
    },
  }
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'hrsh7th/nvim-cmp', -- auto completion
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      { 'hrsh7th/cmp-nvim-lua', ft = { 'lua' } },
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind-nvim', -- show pictograms in the auto complete popup
      { 'tzachar/cmp-tabnine', run = './install.sh' },
      'windwp/nvim-autopairs',
    },
  }
  -- Github's suggeetsions engine
  use 'github/copilot.vim'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    cmd = 'MarkdownPreview',
    ft = { 'markdown' },
  }
  use 'jose-elias-alvarez/typescript.nvim'
  use { 'vim-scripts/groovyindent-unix', ft = { 'groovy', 'Jenkinsfile' } }
  use { 'martinda/Jenkinsfile-vim-syntax', ft = { 'groovy', 'Jenkinsfile' } }
  use { 'chr4/nginx.vim', ft = { 'nginx' } }
  use { 'mosheavni/vim-kubernetes', ft = { 'yaml' } }
  use { 'towolf/vim-helm', ft = { 'yaml', 'yaml.gotexttmpl' } }
  use { 'mogelbrod/vim-jsonpath', ft = { 'json' } }
  use { 'chrisbra/vim-sh-indent', ft = { 'sh', 'bash', 'zsh' } }
  use { 'phenomenes/ansible-snippets', ft = { 'yaml' } }
  use 'rafamadriz/friendly-snippets' -- snippets for many languages
  use 'folke/lua-dev.nvim'

  -- Debug Adapter Protocol (DAP)
  use {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'mfussenegger/nvim-dap-python',
    'nvim-telescope/telescope-dap.nvim',
    -- 'mxsdev/nvim-dap-vscode-js',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/cmp-dap',
    'Pocco81/dap-buddy.nvim',
  }
  use 'andrewferrier/debugprint.nvim'

  -- Functionality Tools
  use 'kevinhwang91/nvim-hlslens'
  use 'vim-scripts/ReplaceWithRegister'
  use 'voldikss/vim-floaterm'
  use { 'mosheavni/vim-dirdiff', cmd = { 'DirDiff' } }
  use 'simeji/winresizer'
  use 'tiagovla/scope.nvim'
  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  }
  use { 'pechorin/any-jump.vim', cmd = { 'AnyJump', 'AnyJumpVisual' } }
  use {
    'anuvyklack/fold-preview.nvim',
    requires = 'anuvyklack/keymap-amend.nvim',
  }
  use 'kazhala/close-buffers.nvim'

  use 'folke/which-key.nvim'
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Quickfix
  use 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use { 'tommcdo/vim-lister', ft = 'qf', cmd = { 'Qfilter', 'Qgrep' } } -- Qfilter and Qgrep on Quickfix

  -- Look & Feel
  use 'stevearc/dressing.nvim' -- overrides the default vim input to provide better visuals
  use 'rcarriga/nvim-notify'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use 'RRethy/vim-illuminate'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
  }
  use 'kyazdani42/nvim-web-devicons'
  -- use 'karb94/neoscroll.nvim'
  use 'mhinz/vim-startify'
  use 'vim-scripts/CursorLineCurrentWindow'
  use 'norcalli/nvim-colorizer.lua'

  -- Themes
  -- use 'drewtempelmeyer/palenight.vim'
  -- use 'joshdick/onedark.vim'
  -- use 'ghifarit53/tokyonight-vim'
  -- use { 'dracula/vim', as = 'dracula' }
  -- use 'jacoborus/tender.vim'
  -- use 'ellisonleao/gruvbox.nvim'
  -- use 'ellisonleao/gruvbox.nvim'
  -- use 'rafamadriz/neon'
  -- use 'marko-cerovac/material.nvim'
  -- use 'folke/tokyonight.nvim'
  -- use 'cpea2506/one_monokai.nvim'
  use 'Mofiqul/vscode.nvim'
  -- use { 'luisiacc/gruvbox-baby', branch = 'main' }

  -- Text Manipulation
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'numToStr/Comment.nvim'
  use 'junegunn/vim-easy-align'
  use 'AndrewRadev/switch.vim'
  use 'justinmk/vim-sneak'
  use { 'alvan/vim-closetag', ft = { 'html', 'javascript' } }
  use 'editorconfig/editorconfig-vim'

  -- Devicons is last so it can support all of the other plugins
  use 'ryanoasis/vim-devicons'

  local custom_settings_ok, custom_settings = pcall(require, 'user.custom-settings')
  if custom_settings_ok then
    custom_settings.plugins(use)
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
