local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")
local migration = require("__flib__.migration")

local global_data = require("scripts.global-data")
local migrations = require("scripts.migrations")
local player_data = require("scripts.player-data")

local main_gui = require("scripts.gui.main.controller")

-- -----------------------------------------------------------------------------
-- EVENT HANDLERS

-- BOOTSTRAP

event.on_init(function()
  global_data.init()

  for i in pairs(game.players) do
    player_data.init(i)
    player_data.refresh(game.get_player(i), global.players[i])
  end
end)

event.on_configuration_changed(function(e)
  if migration.on_config_changed(e, migrations) then
    for i, player_table in pairs(global.players) do
      player_data.refresh(game.get_player(i), player_table)
    end
  end
end)

-- CUSTOM INPUT

event.register("tlst-toggle-gui", function(e)
  local player = game.get_player(e.player_index)
  local player_table = global.players[e.player_index]
  if player_table.guis.main.state.visible then
    main_gui.handle_action(e, {gui = "main", action = "close"})
  else
    main_gui.handle_action(e, {gui = "main", action = "open"})
  end

end)

-- GUI

gui.hook_events(function(e)
  local msg = gui.read_action(e)
  if msg then
    if msg.gui == "main" then
      main_gui.handle_action(e, msg)
    end
  end
end)

-- PLAYER

event.on_player_created(function(e)
  player_data.init(e.player_index)
  player_data.refresh(game.get_player(e.player_index), global.players[e.player_index])
end)

event.on_player_removed(function(e)
  global.players[e.player_index] = nil
end)

-- SHORTCUT

event.on_lua_shortcut(function(e)
  local player = game.get_player(e.player_index)
  local player_table = global.players[e.player_index]
  if player_table.guis.main.state.visible then
    main_gui.handle_action(e, {gui = "main", action = "close"})
  else
    main_gui.handle_action(e, {gui = "main", action = "open"})
  end
end)