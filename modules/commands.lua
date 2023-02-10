-- MODULE : COMMANDS
---------------------------------------------------------------------------------

-- Pour admin seulement : exclure un joueur de sa map.
commands.add_command("surfaces", "", 
function (e)
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")
    local LuaPlayer = {}
    local autorize = false
    local is_player = false

    if e.player_index then 
      LuaPlayer = game.players[e.player_index]
      if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
        autorize = true
        is_player = true
      end
    else 
      autorize = true
    end
    
    if autorize then 
        if is_player then
          -- by player : admin
          for _,surface in pairs(surfaces) do 
            LuaPlayer.print(surface.name)
          end
        else 
          -- by server
          for _,surface in pairs(surfaces) do 
            print(surface.name)
          end
        end
      end
  end
)


---------------------------------------------------------------------------------
return {}
