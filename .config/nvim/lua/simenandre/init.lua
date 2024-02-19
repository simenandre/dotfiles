require("simenandre.lazy")
require("simenandre.set")
require("simenandre.remap")

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("plugins")

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
