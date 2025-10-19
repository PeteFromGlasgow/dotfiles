return {
  "folke/lazydev.nvim",
  ft = "lua", -- Only load on lua files
  opts = {
    library = {
      -- See https://github.com/folke/lazydev.nvim/tree/main/types
      -- Load luv types
      "luv",
      -- Load vim runtime types
      "vim.lsp",
      "vim.treesitter",
    },
  },
}
