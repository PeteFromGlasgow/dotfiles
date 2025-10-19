return {
  -- Mason and LSP Setup
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Ensure cmp_nvim_lsp is loaded for capabilities
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- List of servers to ensure are installed by mason-lspconfig
      -- Add any other servers you use here, e.g. "pylsp", "tsserver", "gopls"
      local servers = {
        "lua_ls",
        "yamlls",
	"terraform",
	"terraformls"
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
	automatic_enable = true
      })

      vim.lsp.enable('terraformls')


      vim.lsp.config('terraformls', {
	capabilities = capabilities,
	settings = {}
      })

      vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {"*.tf", "*.tfvars"},
        callback = function()
          vim.lsp.buf.format()
        end,
      })

      -- Configure lua_ls
      vim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      
      -- Configure yamlls
      vim.lsp.enable('yamlls')
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              kubernetes = "*.{yaml,yml}",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".git{hub,lab}/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
            },
          },
        },
      })

    end,
  },
  -- Completion Engine: nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets', -- Added as a direct dependency for clarity
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        })
      })


      -- Luasnip keymaps
      vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true, desc = "Luasnip expand"})
      vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump(1) end, {silent = true, desc = "Luasnip jump forward"})
      vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true, desc = "Luasnip jump backward"})

      -- Setup cmdline completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    -- No specific config here as it's configured via nvim-cmp and its own loaders.
    -- Ensure friendly-snippets is loaded if it's a dependency for LuaSnip's snippets.
    -- Often, just having friendly-snippets as a plugin is enough for luasnip to find its snippets.
  },
  {
    'rafamadriz/friendly-snippets',
    -- This plugin provides the snippets. No specific config usually needed here.
  },
}
