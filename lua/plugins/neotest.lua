return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {
      require('dapui').setup(),
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'fredrikaverpil/neotest-golang', version = '*' }, -- Installation
      { 'nvim-neotest/neotest-plenary' },
    },
    config = function()
      local neotest_golang_opts = {} -- Specify custom configuration
      require('neotest').setup {
        adapters = {
          require 'neotest-plenary',
          require 'neotest-golang'(neotest_golang_opts), -- Registration
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
  -- stylua: ignore
  keys = {
      { "<leader>dt", function() require("neotest").run.run() end, desc = "Debug Nearest" },
      {"<leader>da",  function() require("dapui").toggle() end, desc="Toggle DAP UI"},
      {"<leader>ds",  function() require("neotest").summary.toggle() end, desc="Toggle Neotest Summary"}
  },
  },
}
