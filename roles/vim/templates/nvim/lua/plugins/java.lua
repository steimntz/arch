return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = "java",
    config = function()
      require("java").setup()
    end,
  },
}
