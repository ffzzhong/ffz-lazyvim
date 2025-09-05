return {
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  {
    "rainbowhxch/accelerated-jk.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.8,
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" },
    },
  },
}
