local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- custom plugins
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
 },
 {
    "simrat39/rust-tools.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
      require("rust-tools").setup()
    end,
    event = {"CmdlineEnter"}
 },
 {
    "rust-lang/rust.vim"
 },
 {
   "elixir-tools/elixir-tools.nvim",
   version = "*",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
     local elixir = require("elixir")
     local elixirls = require("elixir.elixirls")

     elixir.setup {
       credo = {},
       elixirls = {
         enable = true,
         cmd = "/Users/bruce/Documents/github_code/elixir-ls/release/language_server.sh",
         settings = elixirls.settings {
           dialyzerEnabled = true,
           fetchDeps = false, 
           enableTestLenses = false,
           suggestSpecs = false,
        },
         on_attach = function(client, bufnr)
           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
           vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
         end,
       }
     }
   end,
   dependencies = {
     "nvim-lua/plenary.nvim",
   },
 }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
