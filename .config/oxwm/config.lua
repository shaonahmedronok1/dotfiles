---@meta
-------------------------------------------------------------------------------
-- OXWM Configuration File - Converted from Hyprland + River
-------------------------------------------------------------------------------
-- Based on your existing Hyprland and River configurations
-- Adapted for X11 with proper replacements
-------------------------------------------------------------------------------

---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
local modkey = "Mod4" -- Super key (same as your configs)
local terminal = "alacritty"

-- Color palette matching your Hyprland theme + terminal colors
local colors = {
  fg = "#1a1a1a",     -- Dark text for light background
  bg = "#f5f0e8",     -- Cream/beige background matching your terminal!
  cyan = "#00F2FF",   -- Your active border color from Hyprland
  purple = "#7A004D", -- Your inactive border color from Hyprland
  red = "#f7768e",
  green = "#9ece6a",
  blue = "#6dade3",
  grey = "#666666",      -- Darker grey for better contrast on light bg
  lavender = "#a9b1d6",
  dark_text = "#2a2a2a", -- For text on light backgrounds
}

-- Workspace tags (1-10 like your setup)
local tags = { "1", "2", "3", "4" }

-- Status bar font
local bar_font = "monospace:style=Bold:size=10"

-- Status bar blocks (using dark text on light background)
local blocks = {
  oxwm.bar.block.ram({
    format = "RAM: {used}/{total}GB",
    interval = 5,
    color = colors.purple, -- Purple text on cream background
    underline = true,
  }),
  oxwm.bar.block.static({
    text = " │ ",
    interval = 999999999,
    color = colors.grey,
    underline = false,
  }),
  oxwm.bar.block.datetime({
    format = "{}",
    date_format = "%a %b %d - %I:%M %P",
    interval = 1,
    color = colors.dark_text, -- Dark text for readability
    underline = true,
  }),
}

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey)
oxwm.set_tags(tags)

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")
oxwm.set_layout_symbol("monocle", "[M]")

-------------------------------------------------------------------------------
-- Appearance (Matching your Hyprland theme)
-------------------------------------------------------------------------------
-- Borders: 6px width like Hyprland
oxwm.border.set_width(6)
-- Active: cyan (#00F2FF)
oxwm.border.set_focused_color(colors.cyan)
-- Inactive: purple (#7A004D)
oxwm.border.set_unfocused_color(colors.purple)

-- Gaps matching your Hyprland: gaps_out = 11,17,11,17
-- OXWM uses uniform gaps, so we'll average to ~14px outer
oxwm.gaps.set_smart(false)  -- Always show gaps
oxwm.gaps.set_inner(6, 6)   -- Small inner gaps
oxwm.gaps.set_outer(14, 14) -- Outer gaps approximating your setup

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Floating windows (matching your configs)
oxwm.rule.add({ class = "pavucontrol", floating = true })
oxwm.rule.add({ class = "Pavucontrol", floating = true })

-- Alacritty with title "sk" should be centered and large (from your Hyprland rules)
oxwm.rule.add({
  instance = "Alacritty",
  title = "sk",
  floating = true,
})

-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
oxwm.bar.set_font(bar_font)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes matching your terminal's cream background
-- Parameters: (foreground_text, background, border/underline)

-- Unoccupied tags (empty workspaces) - dark text on cream
oxwm.bar.set_scheme_normal(colors.grey, colors.bg, colors.grey)

-- Occupied tags (workspaces with windows) - cyan text on cream
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)

-- Currently selected tag - purple/magenta on cream (matching your theme!)
oxwm.bar.set_scheme_selected(colors.purple, colors.bg, colors.purple)

-- Urgent tags - red text on cream
oxwm.bar.set_scheme_urgent(colors.red, colors.bg, colors.red)

-------------------------------------------------------------------------------
-- Autostart (X11 replacements for your Wayland apps)
-------------------------------------------------------------------------------
-- Polkit agent (replacement for hyprpolkitagent)
oxwm.autostart("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")

-- Wallpaper daemon (X11 replacement for swww-daemon)
-- Use feh or nitrogen - uncomment one:
oxwm.autostart("feh --bg-scale ~/.config/oxwm/wallpapers/drawings-1.png &")
-- oxwm.autostart("nitrogen --restore &")

-- Auto-mounter
oxwm.autostart("udiskie &")

-- Notification daemon (if you use one)
-- oxwm.autostart("dunst &")

-- Compositor for transparency/shadows (optional)
-- oxwm.autostart("picom &")

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------

-- ===== BASICS =====
-- Terminal
oxwm.key.bind({ modkey }, "Return", oxwm.spawn_terminal())

-- App launcher (dmenu replaces fuzzel since OXWM is X11)
-- Install dmenu if not present: sudo pacman -S dmenu
oxwm.key.bind({ modkey }, "Space", oxwm.spawn({ "dmenu_run", "-l", "10" }))

-- Alternative: rofi (more feature-rich)
-- oxwm.key.bind({ modkey }, "Space", oxwm.spawn({ "rofi", "-show", "drun" }))

-- Close window
oxwm.key.bind({ modkey }, "C", oxwm.client.kill())

-- Reload config (Super+Shift+R like you're used to!)
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Alternative reload with Super+Shift+C (in case R acts weird)
oxwm.key.bind({ modkey, "Shift" }, "C", oxwm.restart())

-- Exit OXWM
oxwm.key.bind({ modkey, "Shift" }, "E", oxwm.quit())

-- ===== FOCUS MOVEMENT (VIM KEYS) =====
oxwm.key.bind({ modkey }, "H", oxwm.client.focus_stack(-1))
oxwm.key.bind({ modkey }, "L", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- ===== FOCUS MOVEMENT (ARROW KEYS) =====
oxwm.key.bind({ modkey }, "Left", oxwm.client.focus_stack(-1))
oxwm.key.bind({ modkey }, "Right", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "Down", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "Up", oxwm.client.focus_stack(-1))

-- ===== MOVE WINDOWS (VIM KEYS) =====
oxwm.key.bind({ modkey, "Shift" }, "H", oxwm.client.move_stack(-1))
oxwm.key.bind({ modkey, "Shift" }, "L", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- ===== MOVE WINDOWS (ARROW KEYS) =====
oxwm.key.bind({ modkey, "Shift" }, "Left", oxwm.client.move_stack(-1))
oxwm.key.bind({ modkey, "Shift" }, "Right", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "Down", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "Up", oxwm.client.move_stack(-1))

-- ===== WORKSPACES (1-10) =====
-- Switch to workspace
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))
oxwm.key.bind({ modkey }, "0", oxwm.tag.view(9))

-- Move window to workspace
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))
oxwm.key.bind({ modkey, "Shift" }, "0", oxwm.tag.move_to(9))

-- ===== LAYOUT CONTROLS =====
-- Toggle floating
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())

-- Fullscreen
oxwm.key.bind({ modkey }, "F", oxwm.client.toggle_fullscreen())

-- Toggle layout between tiling and floating
oxwm.key.bind({ modkey }, "M", oxwm.layout.cycle())

-- Master area width adjustment
oxwm.key.bind({ modkey, "Control" }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey, "Control" }, "L", oxwm.set_master_factor(5))

-- Toggle gaps
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())

-- ===== MULTIMEDIA KEYS =====
-- Audio control (using pactl like your configs)
oxwm.key.bind({}, "XF86AudioMute",
  oxwm.spawn({ "sh", "-c", "pactl set-sink-mute @DEFAULT_SINK@ toggle" }))
oxwm.key.bind({}, "XF86AudioLowerVolume",
  oxwm.spawn({ "sh", "-c", "pactl set-sink-volume @DEFAULT_SINK@ -11%" }))
oxwm.key.bind({}, "XF86AudioRaiseVolume",
  oxwm.spawn({ "sh", "-c", "pactl set-sink-volume @DEFAULT_SINK@ +11%" }))
oxwm.key.bind({}, "XF86AudioMicMute",
  oxwm.spawn({ "sh", "-c", "pactl set-source-mute @DEFAULT_SOURCE@ toggle" }))

-- ===== SCREENSHOTS =====
-- Full screenshot
oxwm.key.bind({ modkey }, "Z",
  oxwm.spawn({ "sh", "-c", "~/.local/bin/screenshot-capture-x11.sh" }))

-- Region screenshot
oxwm.key.bind({ modkey, "Shift" }, "Z",
  oxwm.spawn({ "sh", "-c", "~/.local/bin/screenshot-capture-x11.sh region" }))

-- ===== WALLPAPER CYCLING =====
-- Note: You'll need to adapt your cycle-wallpaper.sh for X11
-- It should use feh instead of swww
oxwm.key.bind({ modkey }, "W",
  oxwm.spawn({ "sh", "-c", "~/.config/oxwm/cycle-wallpaper.sh" }))

-- ===== SK WRAPPER =====
oxwm.key.bind({ modkey }, "I",
  oxwm.spawn({ "alacritty", "--title=sk", "-e", os.getenv("HOME") .. "/.local/bin/sk-open-wrapper" }))

-- ===== SHOW KEYBINDS OVERLAY =====
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-------------------------------------------------------------------------------
-- END OF CONFIG
-------------------------------------------------------------------------------
