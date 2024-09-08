vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require('config.lazy')
require('config.cmp')
require('mason').setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end
    }

require'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true,
  }
}


vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>ts", ":Telescope treesitter path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>t", ":terminal <CR>i")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]],{noremap=true})

vim.wo.relativenumber = true
