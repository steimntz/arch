return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',  -- Required for compatibility [page:0]
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')  -- Local var prevents unload issues [web:5][web:6]
    configs.setup {
      ensure_installed = { "lua", "javascript", "python", "bash", "java", "c", "markdown", "elixir", "kotlin" },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end
}

