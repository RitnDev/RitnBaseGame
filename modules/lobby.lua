-- MODULE : LOBBY
---------------------------------------------------------------------------------------------
local spaceblock = require(ritnlib.defines.core.mods.spaceblock)
---------------------------------------------------------------------------------------------

-- generate lobby
local function on_chunk_generated(e)
    if storage.base.modules.lobby == false then return end
    if storage.base.lobby.on_chunk_generated then 
        RitnCoreEvent(e):generateLobby()
        ----
        if storage.base.modules.spaceblock then
            remote.call("RitnCoreGame", "spaceblock", e)
        end
    end
end


local function on_player_changed_surface(e)
    if storage.base.modules.lobby == false then return end
    if storage.base.lobby.on_player_changed_surface then 

        local rEvent = RitnCoreEvent(e)
        local rPlayer = RitnCoreEvent(e):getPlayer()

        if rPlayer:isLobby() then

            local rSurface = rEvent:getSurface()
            rSurface:removePlayer(rPlayer.player)
            
            rPlayer:setActive(false)

            -- mettre le rPlayer dans la force "ritn~default"
            rPlayer.player.force = rEvent.FORCE_DEFAULT_NAME

            if storage.base.lobby.setup_lobby_surface then
                local nbSurfaces = remote.call('RitnCoreGame', 'get_values', 'surfaces')
                if nbSurfaces == 1 then
                    -- create new surface
                    rPlayer:createSurface()
                else
                    -- join surface
                    rPlayer:teleport({0,0}, storage.base.last_surface, true)
                end
            end

        end

        ----
        log('on_player_changed_surface')
    end
end


local function on_player_changed_force(e) 
    if storage.base.lobby.on_player_changed_force then
        local rEvent = RitnCoreEvent(e)
        
        -- On sauvegarde l'inventaire de la force avant changement
        local rOldForce = rEvent:getForce()
        if (rOldForce:isForceDefault() == false) then 
            rOldForce:saveInventory(rEvent.player)
            log('>>>>>>>>>>>>>>>>>>>>>>>>>  SAVE_INVENTORY : (OLD FORCE) = ' .. rOldForce.name)
        end

        -- On charge l'inventaire de la force d'arrivée
        local rNewForce = RitnCoreForce(rEvent.player.force)
        if (rNewForce:isForceDefault() == false) then 
            rNewForce:loadInventory(rEvent.player)
            log('>>>>>>>>>>>>>>>>>>>>>>>>>  LOAD_INVENTORY : (NEW FORCE) = ' .. rNewForce.name)
        end

        
        if (rOldForce:isForceDefault() and (rNewForce.name == rEvent.player.name)) then 
            rNewForce:insertInventory(rEvent.player)
            log('>>>>>>>>>>>>>>>>>>>>>>>>>  INSERT_INVENTORY : (NEW FORCE) = ' .. rNewForce.name)
        end

        log('on_player_changed_force')
    end
end


----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_chunk_generated] = on_chunk_generated
module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_player_changed_force] = on_player_changed_force
----------------------
return module