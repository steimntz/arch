return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "angularls",
          "tsserver",
          "html",
          "ts_ls",
          "kotlin_language_server",
        },
      })
    end,
  },
}
