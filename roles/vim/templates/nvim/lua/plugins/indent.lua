return {
  {
    "Darazaki/indent-o-matic",
    config = function()
      require("indent-o-matic").setup({})
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
}
