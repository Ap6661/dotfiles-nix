local wezterm = require 'wezterm'
return {
	default_prog = {'bash'},

	color_scheme = 'Dracula (Official)',
	font = wezterm.font 'Hack Nerd Font Mono',


  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_decorations = "RESIZE",
  window_padding = {
    left    = 15,
    right   = 15,
    top     = 15,
    bottom  = 15,

  },


  window_background_opacity = 0.8,
  text_background_opacity = 1.0,


  --keys = {
  --  {
  --    key = 'd',
  --    mods = 'CTRL',
  --    action = wezterm.action.ActivateTabRelative(1),
  --  },
  --},

}
