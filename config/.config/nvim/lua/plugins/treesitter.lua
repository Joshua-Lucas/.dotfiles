return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.ejs = {
        install_info = {
          url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
          files = { "src/parser.c" },
        },
        filetype = "ejs",
      }

      vim.filetype.add({ extension = { ejs = "ejs" } })

      -- Map EJS filetype to HTML + JS
      vim.treesitter.language.register("html", "ejs")
      vim.treesitter.language.register("javascript", "ejs")

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "bash",
          "javascript",
          "json",
          "typescript",
          "tsx",
          "css",
          "rust",
          "yaml",
          "html",
          "embedded_template",
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })

      vim.cmd("set foldmethod=expr")
      vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
      vim.cmd("set nofoldenable")
    end,
  },
}
