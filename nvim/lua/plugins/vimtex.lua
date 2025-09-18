local M = {
  "lervag/vimtex",
}

function M.config()
  vim.g["vimtex_view_method"] = "general" -- main variant with xdotool (requires X11; not compatible with wayland)
  vim.g["tex_flavor"] = "latex" -- how to read tex files
  vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
  vim.g["tex_indent_brace"] = 0 -- turn off brace indent
  vim.g["vimtex_syntax_enabled"] = 1 -- Syntax highlighting
  -- vim.g["vimtex_context_pdf_viewer"] = "skim" -- external PDF viewer run from vimtex menu command
  vim.g["vimtex_log_ignore"] = { -- Error suppression:
    "Underfull",
    "Overfull",
    "specifier changed to",
    "Token not allowed in a PDF string",
  }
  vim.api.nvim_set_keymap("n", "<leader>r", ":VimtexCompile<CR>", { noremap = true, silent = true })
  vim.g["vimtex_view_skim_sync"] = 1
  vim.g["vimtex_view_skim_activate"] = 1

  vim.g["vimtex_compiler_latexmk"] = {
         aux_dir = ".aux",
         out_dir = "out"
        }

end

return M
