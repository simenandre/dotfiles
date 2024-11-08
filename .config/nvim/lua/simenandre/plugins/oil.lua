return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    })

    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set(
      "n",
      "<leader>dd",
      "<CMD>Oil /Users/cobraz/ghq/github.com/simenandre/notes/<CR>",
      { desc = "Open parent directory" }
    )
  end,
}
