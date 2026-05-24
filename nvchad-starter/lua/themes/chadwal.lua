local M = {}

local lighten = require("base46.colors").change_hex_lightness

M.base_30 = {
	white = "#e8e3e3",
	black = "#000000",
	darker_black = lighten("#000000", -3),
	black2 = lighten("#000000", 6),
	one_bg = lighten("#000000", 10),
	one_bg2 = lighten("#000000", 16),
	one_bg3 = lighten("#000000", 22),
	grey = "#383838",
	grey_fg = lighten("#383838", -10),
	grey_fg2 = lighten("#383838", -20),
	light_grey = "#5f5d5d",
	red = "#bd7476",
	baby_pink = lighten("#bd7476", 10),
	pink = "#9baec1",
	line = "#5f5d5d",
	green = "#959f87",
	vibrant_green = lighten("#959f87", 10),
	blue = "#9baec1",
	nord_blue = lighten("#9baec1", 10),
	yellow = "#dbc093",
	sun = lighten("#dbc093", 10),
	purple = "#9baec1",
	dark_purple = lighten("#9baec1", -10),
	teal = "#554458",
	orange = "#bd7476",
	cyan = "#93ada9",
	statusline_bg = lighten("#000000", 6),
	pmenu_bg = "#383838",
	folder_bg = lighten("#eae6e6", 0),
	lightbg = lighten("#000000", 10),
}

M.base_16 = {
	base00 = "#000000",
	base01 = lighten("#383838", 0),
	base02 = lighten("#383838", 3),
	base03 = lighten("#5f5d5d", 0),
	base04 = lighten("#e6e1e1", 0),
	base05 = "#e8e3e3",
	base06 = lighten("#e8e3e3", 0),
	base07 = "#000000",
	base08 = "#bd7476",
	base09 = "#dbc093",
	base0A = "#9baec1",
	base0B = "#959f87",
	base0C = "#93ada9",
	base0D = lighten("#9baec1", 20),
	base0E = "#9baec1",
	base0F = "#e6e0e0",
}

M.type = "dark"

M.polish_hl = {
	defaults = {
		Comment = {
			italic = true,
			fg = M.base_16.base03,
		},
	},
	Syntax = {
		String = {
			fg = "#9baec1",
		},
	},
	treesitter = {
		["@comment"] = {
			fg = M.base_16.base03,
		},
		["@string"] = {
			fg = "#9baec1",
		},
	},
}

return M
