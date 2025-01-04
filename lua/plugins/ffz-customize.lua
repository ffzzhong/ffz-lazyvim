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
    dependencies = {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      event = "VeryLazy",
      version = "2.*",
      opts = {
        hint = "floating-big-letter",
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            -- filetype = { "neo-tree", "neo-tree-popup", "notify", "snacks_notif" },
            filetype = {
              "Trouble",
              "alpha",
              "dashboard",
              "help",
              "lazy",
              "mason",
              "neo-tree",
              "notify",
              "snacks_dashboard",
              "snacks_notif",
              "snacks_terminal",
              "snacks_win",
              "toggleterm",
              "trouble",
              "lspconfig",
              "lsp_definitions",
            },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
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
          ["o"] = "open_with_window_picker",
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
      keys[#keys + 1] = { "<leader>cC", mode = { "n" }, false }
      keys[#keys + 1] = { "gy", false }
      keys[#keys + 1] = {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
        end,
        desc = "Goto Definition",
        has = "definition",
      }
      keys[#keys + 1] = {
        "gt",
        function()
          require("telescope.builtin").lsp_type_definitions({ jump_type = "vsplit" })
        end,
        desc = "Goto Type Definition",
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                ["http://json.schemastore.org/composer"] = "/values.yaml",
                ["kubernetes"] = "*.yaml",
              },
            },
          },
        },
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {
        --   settings = {
        --     pyright = {
        --       disableLanguageServices = false,
        --       disableOrganizeImports = true,
        --     },
        --     python = {
        --       analysis = {
        --         autoImportCompletions = true,
        --         diagnosticSeverityOverrides = {
        --           reportArgumentType = "warning",
        --           reportAssignmentType = "warning",
        --         },
        --       },
        --     },
        --   },
        -- },
      },
    },
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
