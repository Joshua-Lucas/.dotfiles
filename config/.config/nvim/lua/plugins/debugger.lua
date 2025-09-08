return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		-- Install the vscode-js-debug adapter
		{
			"microsoft/vscode-js-debug",
			-- After install, build it and rename the dist directory to out
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

					-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
					-- debugger_cmd = { "js-debug-adapter" },

					-- Which adapters to register in nvim-dap
					adapters = {
						"chrome",
						"pwa-node",
						"pwa-chrome",
						"pwa-msedge",
						"pwa-extensionHost",
						"node-terminal",
					},

					-- Custom adapter for "pwa-node"
					-- Use your configuration for the "pwa-node" adapter
					adapters_config = {
						["pwa-node"] = {
							type = "server",
							host = "localhost",
							port = "${port}",
							executable = {
								command = "node",
								-- 💀 Ensure this path is correct for your setup (modify if needed)
								args = {
									vim.fn.resolve(
										vim.fn.stdpath("data")
											.. "/lazy/js-debug-adapter/js-debug/src/dapDebugServer.js"
									),
									"${port}",
								},
							},
						},
					},

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

					-- Logging level for output to file. Set to false to disable logging.
					-- log_file_level = false,

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR,
				})
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapText = require("nvim-dap-virtual-text")
		local dapgo = require("dap-go")

		local js_based_langs = {
			"typescript",
			"javascript",
		}

		dapui.setup()
		dapgo.setup()

		dapText.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		for _, language in ipairs(js_based_langs) do
			dap.configurations[language] = {
				-- Debug single nodejs files
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug web applications (client side)
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				-- Divider for the launch.json derived configs
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
			}
		end

		-- Eval var under cursor
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.repl.open, { desc = "Start DAP REPL" })
		vim.keymap.set("n", "<F8>", dap.continue, {})
		vim.keymap.set("n", "<F10>", dap.step_over, {})
		vim.keymap.set("n", "<F11>", dap.step_into, {})
		vim.keymap.set("n", "<S-F11>", dap.step_out, {})
		vim.keymap.set("n", "<F9>", dap.step_back, {})
		vim.keymap.set("n", "<F13>", dap.restart, {})
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "adds breakpoint for debugger" })

		vim.keymap.set("n", "<leader>da", function()
			if vim.fn.filereadable(".vscode/launch.json") then
				local dap_vscode = require("dap.ext.vscode")
				-- Assuming js_based_languages is defined somewhere or replace it with the appropriate value.
				local js_based_languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
				dap_vscode.load_launchjs(nil, {
					["pwa-node"] = js_based_languages,
					["chrome"] = js_based_languages,
					["pwa-chrome"] = js_based_languages,
				})
			end
			dap.continue() -- Use locally required dap
		end, { desc = "Run with Args" })
	end,
}
