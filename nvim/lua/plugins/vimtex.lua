local M = {
	"lervag/vimtex",
}

function M.config()
	vim.g["vimtex_view_method"] = "general"
	vim.g["tex_flavor"] = "latex" -- how to read tex files
	vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
	vim.g["tex_indent_brace"] = 0 -- turn off brace indent
	vim.g["vimtex_syntax_enabled"] = 1 -- Syntax highlighting
	vim.g["vimtex_log_ignore"] = {
		"Underfull",
		"Overfull",
		"specifier changed to",
		"Token not allowed in a PDF string",
	}

	vim.api.nvim_set_keymap("n", "<leader>r", ":VimtexCompile<CR>", { noremap = true, silent = true })

	-- Custom viewer using Ghostty and tdf
	vim.g["vimtex_view_general_viewer"] = ""
	vim.g["vimtex_view_general_options"] = ""
	-- vim.g["vimtex_view_general_options"] = "-na Ghostty.app --args -e sh -c \"tdf '@pdf'\""

	vim.g["vimtex_quickfix_enabled"] = 0
	vim.g["vimtex_compiler_latexmk"] = {
		outdir = "build",
		continuous = 1,
		options = {
			"-shell-escape",
			"-verbose",
			"-file-line-error",
			"-synctex=1",
			"-interaction=nonstopmode",
		},
	}
end

return M
