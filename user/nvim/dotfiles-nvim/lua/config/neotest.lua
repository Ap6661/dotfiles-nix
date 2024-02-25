return {
  "nvim-neotest/neotest",
  opts = {
    adapaters =
    {
      "neotest-java"
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "andy-bell101/neotest-java",
  },
  config = function ()
    require("neotest-java")
  end,
}
