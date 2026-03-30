return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"stevanmilic/neotest-scala",
	},
	config = function ()
		require('neotest').setup {
			adapters = {
				-- require('rustaceanvim.neotest'),
				require('neotest-scala')({
					runner = "sbt",
				})
			},
		}
	end
}
