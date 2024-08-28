return {
  'Ramilito/kubectl.nvim',
  opts = {
    diff = { bin = 'kdiff' },
    notifications = {
      enabled = false,
      verbose = false,
      blend = 0,
    },
  },
  cmd = { 'Kubectl', 'Kubectx', 'Kubens' },
  keys = {
    { '<leader>k', '<cmd>lua require("kubectl").toggle()<cr>' },
  },
}
