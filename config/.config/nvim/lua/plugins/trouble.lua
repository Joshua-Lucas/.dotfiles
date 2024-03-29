return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local trouble = require("trouble")

        vim.keymap.set("n", "<leader>tt", function()
            trouble.toggle()
        end)
        vim.keymap.set("n", "<leader>tw", function()
            trouble.toggle("workspace_diagnostics")
        end)
        vim.keymap.set("n", "<leader>td", function()
            trouble.toggle("document_diagnostics")
        end)
        vim.keymap.set("n", "<leader>tq", function()
            trouble.toggle("quickfix")
        end)
        vim.keymap.set("n", "<leader>tx", function()
            trouble.close()
        end)
        vim.keymap.set("n", "<leader>tj", function()
            trouble.next({ skip_groups = true, jump = true })
        end)
        vim.keymap.set("n", "<leader>tk", function()
            trouble.previous({ skip_groups = true, jump = true })
        end)
    end,
}
