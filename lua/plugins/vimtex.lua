return {
	"lervag/vimtex",
	config = function()
		-- if vim.fn.has('win32') or (vim.fn.has('unix') and vim.fn.exists('$WSLENV')) then
		-- vim.g.vimtex_view_general_viewer = "~/.local/bin/sumatrapdf.sh"
		vim.g.vimtex_view_general_viewer = "sumatrapdf.exe"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
		-- end
	end,
}
