return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
      require("fzf-lua").setup({
        "telescope",
        winopts = function(opts)
          opts = opts or {}
          return {
            backdrop = 100,
            border = "single",
            width = math.floor(math.min(vim.o.columns - 4, (opts.previewer and 0.8 or 0.6) * vim.o.columns)),
          }
        end,
        fzf_opts = {
          ["--layout"] = "reverse-list",
          ["--info"] = "inline-right",
          ["--no-separator"] = "",
        },
        file_icon_padding = " ",
        prompt = " ",
        previewer = "builtin",
        files = {
          cwd_prompt = false,
          previewer = false,
          git_icons = false,
        },
        grep_curbuf = {
          winopts = {
            treesitter = true,
          },
        },
        keymaps = { previewer = false, },
        file_ignore_patterns = {
          "%.age",
          "%.cache",
          "%.class",
          "%.dart_tool/",
          "%.dll",
          "%.docx",
          "%.dylib",
          "%.exe",
          "%.git/",
          "%.gradle/",
          "%.ico",
          "%.idea/",
          "%.ipynb",
          "%.jar",
          "%.jpeg",
          "%.jpg",
          "%.lock",
          "%.luac",
          "%.met",
          "%.min.js",
          "%.npz",
          "%.otf",
          "%.pdb",
          "%.pdf",
          "%.png",
          "%.pyc",
          "%.settings/",
          "%.so",
          "%.sqlite3",
          "%.ttf",
          "%.vale/",
          "%.vscode/",
          "%.webp",
          ".direnv/",
          ".direnv/*",
          "__pycache__/",
          "__pycache__/*",
          "_sources/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "node_modules/*",
          "smalljre_*/*",
          "target/",
          "tmp/",
          "vendor/*",
        },
      })

      require("fzf-lua").register_ui_select()

      local map = function(mode, shortcut, command, opt)
        opt = opt or { noremap = true, silent = true }
        vim.keymap.set(mode, shortcut, command, opt)
      end

      map("n", "<leader><leader>", require("fzf-lua").files)
      map("n", "<leader>fw", require("fzf-lua").live_grep)
      map("n", "<leader>fh", require("fzf-lua").help_tags)
      map("n", "<leader>fc", require("fzf-lua").git_commits)
      map("n", "<leader>fd", require("fzf-lua").diagnostics_document)
      map("n", "<leader>f/", require("fzf-lua").grep_curbuf)
    end,
  },
}
