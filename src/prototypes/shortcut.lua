data:extend{
  {
    type = "shortcut",
    name = "tlst-toggle-gui",
    icon = {
      filename = "__TaskList__/graphics/shortcut-x32.png",
      y = 0,
      size = 32,
      mipmap_count = 2,
      flags = {"icon"}
    },
    disabled_icon = {
      filename = "__TaskList__/graphics/shortcut-x32.png",
      y = 32,
      size = 32,
      mipmap_count = 2,
      flags = {"icon"}
    },
    small_icon = {
      filename = "__TaskList__/graphics/shortcut-x24.png",
      y = 0,
      size = 24,
      mipmap_count = 2,
      flags = {"icon"}
    },
    disabled_small_icon = {
      filename = "__TaskList__/graphics/shortcut-x24.png",
      y = 24,
      size = 24,
      mipmap_count = 2,
      flags = {"icon"}
    },
    action = "lua",
    toggleable = true,
    associated_control_input = "tlst-toggle-gui"
  }
}