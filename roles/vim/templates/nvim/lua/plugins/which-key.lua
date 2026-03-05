return {
  "folke/which-key.nvim",
  dependencies = { "nvim-mini/mini.icons", "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    local builtin = require("telescope.builtin")

    wk.register({
      f = {
        name = "Find",
        f = { builtin.find_files, "Find files" },
        g = { builtin.git_files, "Find git files" },
        l = { builtin.live_grep, "Live grep" },
      },
    }, { prefix = "<leader>" })
  end,
}
