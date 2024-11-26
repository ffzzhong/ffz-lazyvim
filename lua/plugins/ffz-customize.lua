return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
      { "<leader>E", false },
      {
        "<leader>n",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>a",
        function()
          require("neo-tree.command").execute({ reveal = true })
        end,
        desc = "Reveal file in NeoTree",
      },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        window = {
          mappings = {
            ["."] = "toggle_hidden",
          },
        },
      },
      window = {
        mappings = {
          ["oc"] = false,
          ["od"] = false,
          ["og"] = false,
          ["om"] = false,
          ["on"] = false,
          ["os"] = false,
          ["ot"] = false,
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["l"] = false,
          ["L"] = false,
          ["h"] = false,
          ["H"] = false,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
        file_ignore_patterns = {
          "node_modules",
        },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        -- live grep show hidden files
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
    },
    keys = {
      { "<leader>sa", false },
      -- switch original fr and fR
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent (all)" },
      -- {
      --   "<leader>sg",
      --   "<cmd>lua require('telescope.builtin').live_grep({additional_args = {'--hidden'}})<cr>",
      --   desc = "Live Grep (with hidden)",
      -- },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cc", mode = { "n", "v" }, false }
      keys[#keys + 1] = { "<leader>cC", mode = { "n", "v" }, false }
      keys[#keys + 1] = {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
        end,
        desc = "Goto Definition",
        has = "definition",
      }
    end,
    -- opts = function(_, opts)
    --   opts.servers = {
    --     -- pyright will be automatically installed with mason and loaded with lspconfig
    --     pyright = {
    --       settings = {
    --         pyright = {
    --           disableLanguageServices = false,
    --           disableOrganizeImports = true,
    --         },
    --         python = {
    --           analysis = {
    --             autoImportCompletions = true,
    --             diagnosticSeverityOverrides = {
    --               reportArgumentType = "warning",
    --               reportAssignmentType = "warning",
    --             },
    --           },
    --         },
    --       },
    --     },
    --   }
    --   -- lsp keymap is different from other plugins, check https://www.lazyvim.org/plugins/lsp
    --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = { "<leader>cc", false }
    --   keys[#keys + 1] = { "<leader>cC", false }
    --   keys[#keys + 1] = {
    --     "gd",
    --     function()
    --       require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
    --     end,
    --     desc = "Goto Definition",
    --     has = "definition",
    --   }
    -- end,
  },
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.add(opts.spec)
      end
    end,
    opts = function(_, opts)
      -- opts.spec = nil

      opts.spec = {
        mode = { "n", "v" },
        { "<leader>a", hidden = true },
        { "<leader>q", hidden = true },
        { "<leader>w", hidden = true },
        { "<leader>n", hidden = true },
        { "<leader><tab>", group = "tabs", hidden = true },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
      }
    end,
  },
}
