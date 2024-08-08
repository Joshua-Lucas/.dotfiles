return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.ejs = {
				install_info = {
					url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
				},
				filetype = "ejs", -- if filetype does not match the parser name
			}

			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"c",
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
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
			vim.cmd("set foldmethod=expr")
			vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
			vim.cmd("set nofoldenable")
		end,
	},
}
