-- local wezterm = require 'wezterm';
-- local scheme = wezterm.get_builtin_color_schemes()["kanagawabones"]

-- function recompute_padding(window)
--   local window_dims = window:get_dimensions();
--   local overrides = window:get_config_overrides() or {}

--   if not window_dims.is_full_screen then
--     if not overrides.window_padding then
--       -- not changing anything
--       return;
--     end
--     overrides.window_padding = nil;
--   else
--     -- Use only the middle 33%
--     local third = math.floor(window_dims.pixel_width / 3)
--     local new_padding = {
--       left = third,
--       right = third,
--       top = 0,
--       bottom = 0
--     };
--     if overrides.window_padding and new_padding.left == overrides.window_padding.left then
--       -- padding is same, avoid triggering further changes
--       return
--     end
--     overrides.window_padding = new_padding

--   end
--   window:set_config_overrides(overrides)
-- end

-- wezterm.on("window-resized", function(window, pane)
--   recompute_padding(window)
-- end);

-- wezterm.on("window-config-reloaded", function(window)
--   recompute_padding(window)
-- end);

-- return {
--   default_prog = {"wsl", "--cd", "~"},
--   -- Fonts
--   font = wezterm.font("JetBrainsMonoNL Nerd Font"),
--   font_size = 9.0,
--   line_height = 1.2,

--   -- Colors
--   win32_system_backdrop = "Mica",
--   window_background_opacity = 0,
--   inactive_pane_hsb = {
--     hue = 1.0,
--     saturation = 0.7,
--     brightness = 0.8,
--   },

--   -- UI
--   color_scheme = "kanagawabones",
--   colors = {
-- 		tab_bar = {
-- 			background = scheme.background,
-- 		},
-- 	},
--   default_cursor_style  = "SteadyUnderline",
--   -- tab_bar_at_bottom = true,
--   use_fancy_tab_bar = false,
--   window_decorations = 'INTEGRATED_BUTTONS | RESIZE',

--   -- Custom keymaps
--   keys = {
--     { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
--     { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
--     { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
--     { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
--   },
-- }
-- wezterm configuration
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	-- makes nicer error messages for config errors
	config = wezterm.config_builder()
end

--- GLOBALS ---
local WINDOWS = wezterm.target_triple == "x86_64-pc-windows-msvc"
local FLATPAK = os.getenv("container") == "flatpak"

config.check_for_updates = true

-- NOTE: do not use login shells as they make it load profile each time and
-- when there is no need to do that, except in containers
if WINDOWS then
	-- default_domain = "WSL:Ubuntu"
	config.default_prog = { "wsl", "--cd", "~" }
else
	local shell = os.getenv("SHELL")
	if FLATPAK or not shell then
		-- shell var in flatpak is always /bin/sh so default to zsh
		shell = "/usr/bin/zsh"
	end

	config.launch_menu = {
		-- TAKE CARE NOT TO CHANGE LABELS AS IT IS USED TO START SPECIFIC
		-- SHELL FROM DESKTOP
		-- {
		--     label = 'Daily',
		--     args = { 'distrobox', 'enter', 'daily' },
		-- },
		-- {
		--     label = 'Toolbox',
		--     args = { 'toolbox-enter-wrapper' },
		-- },
		-- {
		-- 	label = "System Shell",
		-- 	args = { shell },
		-- },
	}

	-- default to first menu item
	-- config.default_prog = config.launch_menu[1].args
end

-- EVENTS
-- add menu subcommand `wezterm start menu <index|label>`
wezterm.on("gui-startup", function(cmd_obj)
	local tab = nil
	local pane = nil
	local window = nil

	if cmd_obj and cmd_obj.args then
		local args = cmd_obj.args

		local command = args[1]
		if command == "menu" and args[2] then
			local arg = args[2]
			local index = tonumber(arg)

			if index ~= nil then
				-- try to spawn the launch menu with the specific index
				tab, pane, window = wezterm.mux.spawn_window(config.launch_menu[index] or {})
			else
				-- the argument is not a number so try to match it with a label
				for _, menu_item in ipairs(config.launch_menu) do
					if arg and string.lower(menu_item.label) == string.lower(arg) then
						tab, pane, window = wezterm.mux.spawn_window(menu_item)
					end
				end

				-- no matches found, spawn the default
				tab, pane, window = wezterm.mux.spawn_window({})
			end
		end
	end

	-- fallback to default way it works so i dont break anything
	if window == nil then
		tab, pane, window = wezterm.mux.spawn_window(cmd_obj or {})
	end
end)

wezterm.on("update-right-status", function(window, pane)
	local user_vars = pane:get_user_vars()

	local icon = user_vars.window_prefix
	if not icon or icon == "" then
		-- fallback for the icon,
		icon = ""
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#333333" } },
		{ Text = " " .. wezterm.pad_right(icon, 3) },
	}))

	local title = pane:get_title()
	local date = " " .. wezterm.strftime("%H:%M %d-%m-%Y") .. " "

	-- figure out a way to center it
	window:set_right_status(wezterm.format({
		{ Background = { Color = "#555555" } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = "#333333" } },
		{ Text = date },
	}))
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _)
	-- i do not like how i can basically hide tabs if i zoom in
	local is_zoomed = ""
	if tab.active_pane.is_zoomed then
		is_zoomed = "z"
	end

	return {
		{ Text = " " .. tab.tab_index + 1 .. is_zoomed .. " " },
	}
end)

--- THEMING ---
--- Themes available: tokyonight_night, kanagawa
config.color_scheme = "tokyonight_night"
config.font = wezterm.font_with_fallback({
	-- { family = "JetBrainsMonoNL Nerd Font" },
	-- { family = "MesloLGL Nerd Font Propo" },
	-- { family = "RobotoMono Nerd Font" },
	{ family = "Liga SFMono Nerd Font" },
})

config.freetype_load_flags = "NO_HINTING"
-- config.freetype_render_target = "Light"
config.freetype_load_target = "Light"
config.font_size = 11
config.line_height = 1.3
-- config.cell_width = 1
config.front_end = "WebGpu"

config.window_padding = {
	-- left = '6px',
	left = 0,
	-- right = '6px',
	right = 0,
	-- top = '2px',
	top = 0,
	bottom = 0,
}

local window_min = " 󰖰 "
local window_max = " 󰖯 "
local window_close = " 󰅖 "
config.tab_bar_style = {
	window_hide = window_min,
	window_hide_hover = window_min,
	window_maximize = window_max,
	window_maximize_hover = window_max,
	window_close = window_close,
	window_close_hover = window_close,
}

config.tab_max_width = 100

-- makes the tabbar look more like TUI
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true -- you can drag using the tab bar

--- BEHAVIOUR ---
config.hide_mouse_cursor_when_typing = true
config.default_cursor_style = "BlinkingUnderline"

-- remove all link parsing
config.hyperlink_rules = {}

-- makes alt act as regular alt
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "RESIZE"

-- TODO remove window frame when fullscreen
-- TODO change frame color depending on the user var
config.window_frame = {
	border_left_width = "3px",
	border_right_width = "3px",
	border_bottom_height = "3px",
	border_top_height = "3px",
	border_left_color = "gray",
	border_right_color = "gray",
	border_bottom_color = "gray",
	border_top_color = "gray",
}

return config
