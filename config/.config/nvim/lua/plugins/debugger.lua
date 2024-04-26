return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
    local dapgo = require("dap-go")

		dapgo.setup()
		dapui.setup()

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

		vim.keymap.set("n", "<F1>", dap.repl.open, { desc = "Start DAP REPL" })
		vim.keymap.set("n", "<F11>", dap.continue, {})
		vim.keymap.set("n", "<F12>", dap.terminate, {})
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "adds breakpoint for debugger" })
	end,
}
