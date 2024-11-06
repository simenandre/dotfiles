require("simenandre.set")
require("simenandre.remap")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

function open_daily_note()
  -- Get today's date in YYYY-mm-dd format
  local date = os.date("%Y-%m-%d")

  -- Construct the file path
  local file_path = "/Users/cobraz/ghq/github.com/simenandre/notes/" .. date .. ".md"

  -- Open the file (it will be created if it doesn't exist)
  vim.cmd("edit " .. file_path)
end

-- Map the function to <leader>dn (for "daily note")
vim.keymap.set("n", "<leader>da", open_daily_note, { noremap = true, silent = true, desc = "Open daily note" })
