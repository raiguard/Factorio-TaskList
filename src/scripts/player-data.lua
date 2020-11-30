local main_gui = require("scripts.gui.main.controller")

local player_data = {}

function player_data.init(player_index)
  global.players[player_index] = {
    flags = {},
    guis = {},
    settings = {}
  }
end

function player_data.refresh(player, player_table)
  main_gui.destroy(player_table)
  main_gui.build(player, player_table)
end

return player_data