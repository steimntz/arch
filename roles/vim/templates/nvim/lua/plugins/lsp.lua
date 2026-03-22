return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Angular
      vim.lsp.config("angularls", {
        root_dir = vim.fs.root(0, { "angular.json" }),
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      })

      -- TypeScript
      vim.lsp.config("tsserver", {
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      })

      -- HTML
      vim.lsp.config("html", {
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      })

      vim.lsp.enable({
        "angularls",
        "tsserver",
        "html",
      })

      -- Kotlin
      vim.lsp.config("kotlin_language_server", {
        root_dir = vim.fs.root(0, {
          "settings.gradle",
          "settings.gradle.kts",
          "build.gradle",
          "build.gradle.kts",
          ".git",
        }),
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "kotlin",
        callback = function()
          vim.lsp.enable("kotlin_language_server")
        end,
      })
    end,
  },
}
