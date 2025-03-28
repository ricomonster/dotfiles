--- wezterm.lua
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

local wezterm = require("wezterm")
local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--- GLOBALS ---
local WINDOWS = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- Liga SFMono Nerd Font
local FONT_FAMILY = "JetBrainsMono Nerd Font Propo"

-- Theme + Colors
config.color_scheme = "Tokyo Night"

-- Font
config.font = wezterm.font_with_fallback({
	{ family = FONT_FAMILY },
	{ family = "MesloLGL Nerd Font Propo" },
})
config.font_rules = {
	-- Bold-not-italic
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font_with_fallback({
			{
				family = FONT_FAMILY,
				weight = "Bold",
			},
		}),
	},
	-- Bold-and-italic
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({
			{
				family = FONT_FAMILY,
				weight = "Bold",
				italic = true,
			},
		}),
	},
	-- normal-intensity-and-italic
	{
		intensity = "Normal",
		italic = false,
		font = wezterm.font_with_fallback({
			{
				family = FONT_FAMILY,
				weight = "Medium",
			},
		}),
	},
	-- half-intensity-and-italic (half-bright or dim)
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font_with_fallback({
			{
				family = FONT_FAMILY,
				weight = "Light",
				italic = true,
			},
		}),
	},
	-- half-intensity-and-not-italic
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font_with_fallback({
			{
				family = FONT_FAMILY,
				weight = "Light",
			},
		}),
	},
}
config.font_size = 12
config.line_height = 1.2
-- For JetBrainsMono cause I have dotted zeroes
config.harfbuzz_features = { "calt=0", "zero" }

-- UI/UX
config.default_cursor_style = "BlinkingUnderline"
config.default_workspace = "main"
-- config.freetype_load_flags = "NO_HINTING"
-- config.freetype_render_target = "VerticalLcd"
-- config.freetype_load_target = "VerticalLcd"
config.front_end = "WebGpu"
config.enable_tab_bar = false
-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
-- config.window_background_opacity = 0.9
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.5cell",
	bottom = "0cell",
}

-- Misc
config.max_fps = 120
-- config.scrollback_lines = 3000
config.status_update_interval = 1000

-- Windows Override
if WINDOWS then
	-- I'm using Arch Linux, BTW
	config.default_prog = { "wsl", "-d", "Arch", "--cd", "~" }

	config.font_size = 9
	config.line_height = 1.4
end

-- Tab bar
-- I don't like the look of "fancy" tab bar
wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#f7768e"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Time
	-- local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		-- { Text = " | " },
		-- { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

return config
