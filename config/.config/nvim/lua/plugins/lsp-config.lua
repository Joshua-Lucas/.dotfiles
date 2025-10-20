return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				ts_ls = { filetypes = { "javascript", "typescript", "ejs" } },
				html = { filetypes = { "html", "ejs" } },
				htmx = { filetypes = { "html" } },
				eslint = { filetypes = { "javascript", "typescript" } },
				cssls = {},
				gopls = {},
				lua_ls = {},
				rust_analyzer = {},
			}

			for name, opts in pairs(servers) do
				opts.capabilities = capabilities
				vim.lsp.config(name, opts)
				vim.lsp.enable(name)
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf }
					-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				end,
			})
		end,
	},
}
