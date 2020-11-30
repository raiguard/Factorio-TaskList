local gui = require("__flib__.gui-beta")

local main_gui = {}

function main_gui.build(player, player_table)
  local refs = gui.build(player.gui.screen, {
    {
      type = "frame",
      direction = "vertical",
      visible = false,
      ref = {"window"},
      actions = {
        on_closed = {gui = "main", action = "close"}
      },
      children = {
        {type = "flow", ref = {"titlebar_flow"}, children = {
          {type = "label", style = "frame_title", caption = {"mod-name.TaskList"}, ignored_by_interaction = true},
          {type = "empty-widget", style = "flib_titlebar_drag_handle", ignored_by_interaction = true},
          {
            type = "sprite-button",
            style = "frame_action_button",
            sprite = "utility/close_white",
            hovered_sprite = "utility/close_black",
            clicked_sprite = "utility/close_black",
            mouse_button_filter = {"left"},
            actions = {
              on_click = {gui = "main", action = "close"}
            }
          }
        }},
        {type = "frame", style = "inside_deep_frame_for_tabs", children = {
          {type = "tabbed-pane", tabs = {
            {tab = {type = "tab", caption = "Personal"}, content = (
              {type = "label", caption = "Foo"}
            )},
            {tab = {type = "tab", caption = "Force"}, content = (
              {type = "label", caption = "Foo"}
            )}
          }},
        }}
      }
    }
  })

  refs.titlebar_flow.drag_target = refs.window
  refs.window.force_auto_center()

  player_table.guis.main = {
    refs = refs,
    state = {
      visible = false
    }
  }
end

function main_gui.destroy(player_table)
  if player_table.guis.main then
    player_table.guis.main.refs.window.destroy()
    player_table.guis.main = nil
  end
end

function main_gui.handle_action(e, msg)
  local player = game.get_player(e.player_index)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.guis.main
  local state = gui_data.state
  local refs = gui_data.refs

  if msg.action == "open" then
    state.visible = true
    refs.window.visible = true
    player.set_shortcut_toggled("tlst-toggle-gui", true)
    player.opened = refs.window
  elseif msg.action == "close" then
    state.visible = false
    refs.window.visible = false
    player.set_shortcut_toggled("tlst-toggle-gui", false)
    if player.opened == refs.window then
      player.opened = nil
    end
  end
end

return main_gui