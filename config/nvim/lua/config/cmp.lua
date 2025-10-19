  local luasnip = require('luasnip')
  require("luasnip.loaders.from_vscode").load()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    })
  })

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

      -- Global diagnostic configuration
  vim.diagnostic.config({
        virtual_text = true, -- Show diagnostics as virtual text (inline)
        signs = true, -- Show signs in the gutter
        underline = true, -- Underline diagnostics
        update_in_insert = false, -- Don't update diagnostics in insert mode
        severity_sort = true, -- Sort diagnostics by severity
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always", -- Or "if_many"
          header = "",
          prefix = "",
        },
  })
  
  vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true})
  vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, {silent = true})
  vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})
  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --  mapping = cmp.mapping.preset.cmdline(),
  --  sources = cmp.config.sources({
  --    { name = 'path' }
  --  }, {
  --    { name = 'cmdline' }
  -- }),
  --  matching = { disallow_symbol_nonprefix_matching = false }
  -- })

  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --  capabilities = capabilities
  -- }
