return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        "graphql-language-service-cli",
        "intelephense",
        "blade",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "graphql",
        "javascript",
        "typescript",
        "tsx",
        "php",
        "blade",
      },
    },
  },
  {
    -- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "php_only",
      })
    end,
    config = function(_, opts)
      vim.filetype.add {
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      }

      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    -- cmd = {
    --     "TmuxNavigateLeft",
    --     "TmuxNavigateDown",
    --     "TmuxNavigateUp",
    --     "TmuxNavigateRight",
    --     "TmuxNavigatePrevious",
    -- },
    -- keys = {
    --     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    --     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    --     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    --     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- },
  },
}
