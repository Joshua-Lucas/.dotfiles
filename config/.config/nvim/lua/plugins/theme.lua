return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					alpha = true,
					harpoon = true,
					mason = true,
					neotree = true,
					lsp_trouble = true,
				},
				color_overides = {
					mocha = {
						base = "#1e1e2e",
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
--[[return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    vim.cmd("colorscheme rose-pine-moon")
  end
}--]]
