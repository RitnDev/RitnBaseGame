-- MODULE : LOBBY
---------------------------------------------------------------------------------------------
local spaceblock = require(ritnlib.defines.core.mods.spaceblock)
---------------------------------------------------------------------------------------------

-- generate lobby
local function on_chunk_generated(e)
    if global.base.modules.lobby == false then return end
    if global.base.lobby.on_chunk_generated then 
        RitnCoreEvent(e):generateLobby()
        ----
        if global.base.modules.spaceblock then
            remote.call("RitnCoreGame", "spaceblock", e)
        end
    end
end


local function on_player_changed_surface(e)
    if global.base.modules.lobby == false then return end
    local rEvent = RitnCoreEvent(e)

    if global.base.lobby.on_player_changed_surface then 

        local rPlayer = RitnCoreEvent(e):getPlayer()

        if string.sub(rPlayer.surface.name, 1, string.len(rEvent.prefix_lobby)) == rEvent.prefix_lobby then
            local rSurface = rEvent:getSurface()
            rSurface:removePlayer(rPlayer.player)
            
            rPlayer:setActive(false)

            local nbSurfaces = remote.call('RitnCoreGame', 'get_values', 'surfaces')
            if nbSurfaces == 1 then
                -- create new surface
                rPlayer:createSurface()
            else
                -- join surface
                rPlayer:teleport({0,0}, global.base.last_surface, true)
            end
        end
        ----
        log('on_player_changed_surface')
    end
end





----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_chunk_generated] = on_chunk_generated
module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
----------------------
return module