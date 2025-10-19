-- General keybindings

-- Telescope
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope File Browser" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files path=%:p:h select_buffer=true<CR>", { desc = "Telescope Find Files" })
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep path=%:p:h select_buffer=true<CR>", { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>ts", ":Telescope treesitter path=%:p:h select_buffer=true<CR>", { desc = "Telescope Treesitter" })
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { desc = "Telescope Buffers" })

-- Terminal
vim.keymap.set("n", "<leader>t", ":terminal <CR>i", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Add other general, non-plugin-specific keymaps here
