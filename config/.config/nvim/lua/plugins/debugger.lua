return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapText = require("nvim-dap-virtual-text")
		local dapgo = require("dap-go")

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
	end,
}
