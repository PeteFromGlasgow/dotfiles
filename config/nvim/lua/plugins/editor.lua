return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
      }
      vim.cmd('colorscheme catppuccin')
      end
  },
  {
    "sbdchd/neoformat",
    -- No specific config needed here unless you want to customize it.
    -- Neoformat usually works out of the box if formatters are installed.
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Or build = false if you manage TS updates manually
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true,
        },
        -- Add other treesitter modules if needed, e.g., indent, incremental_selection
      }
    end,
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }, -- Should already be installed via telescope
      { 'nvim-treesitter/nvim-treesitter', lazy = true }, -- lazy = true as it's already managed
    },
    event = 'VeryLazy', -- Or 'FileType org'
    config = function()
      require('orgmode').setup({
        -- Your orgmode configurations will go here
        -- For example:
        org_agenda_files = {'~/orgfiles/**/*'},
        org_default_notes_file = '~/orgfiles/notes.org',
      })
    end,
  },
}
