return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")
			local fmt = require("luasnip.extras.fmt").fmt
			local s = ls.snippet
			local i = ls.insert_node
			local f = ls.function_node

			-- Load from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Define the custom snippet
			ls.add_snippets("javascript", {
				s(
					"plc",
					fmt(
						[[
import {{ html, render }} from '../utils/html';

class {}Component extends HTMLElement {{
  constructor() {{
    super();
    this.attachShadow({{ mode: 'open' }});
  }}

  connectedCallback() {{
    render(this.template(), this.shadowRoot);
  }}

  template() {{
    return html``
  }}
}}

export default {}Component;
			]],
						{
							i(1, "FileName"),
							f(function(_, parent)
								return parent.snippet.env.TM_FILENAME_BASE
							end, {}),
						}
					)
				),
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-x"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				}),
			})

			-- Setup up vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
