local M = {
	"folke/tokyonight.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	init = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("tokyonight-night")

		-- remove bg color
		function ColorMyPencils(color)
			color = color or "tokyonight-night"
			vim.cmd.colorscheme(color)

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
		end

		ColorMyPencils()

		-- You can configure highlights by doing something like
		vim.cmd.hi("Comment gui=none")
	end,
}

local C = {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-macchiato"
    end
  }
}

local N = {
	-- Highlight todo, notes, etc in comments
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}

return { C, N }
