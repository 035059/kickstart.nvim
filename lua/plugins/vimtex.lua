return {
	"lervag/vimtex",
	config = function()
		local is_wsl = vim.fn.has("unix") and vim.fn.system("uname -r"):lower():match("microsoft") ~= nil
		if is_wsl then
			vim.g.vimtex_view_general_viewer = "sumatrapdf.exe"
			vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
		else
			vim.g.vimtex_view_method = "zathura"
		end
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 10
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
				"-pdflatex=lualatex",
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				-- "-output-directory=build",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
	end,
}
