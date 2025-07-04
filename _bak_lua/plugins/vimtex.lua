return {
	"lervag/vimtex",
	config = function()
		-- if vim.fn.has('win32') or (vim.fn.has('unix') and vim.fn.exists('$WSLENV')) then
		-- vim.g.vimtex_view_general_viewer = "~/.local/bin/sumatrapdf.sh"
		vim.g.vimtex_view_general_viewer = "sumatrapdf.exe"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
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
		-- Enable custom dependency for pythontex in vimtex
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-lualatex",
		}
	end,
}
