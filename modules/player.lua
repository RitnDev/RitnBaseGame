-- MODULE : PLAYER
---------------------------------------------------------------------------------------------
local libInventory = require(ritnlib.defines.class.ritnClass.inventory)
----
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnSurface = require(ritnlib.defines.core.class.surface)
---------------------------------------------------------------------------------------------


local function on_player_created(e) 
    remote.call('RitnCoreGame', "starting")   
    
    local rPlayer = RitnEvent(e):getPlayer()
    
    if script.level.campaign_name 
    or script.level.level_name ~= "wave-defense"
    or script.level.level_name ~= "pvp" then 
        -- Creation de la structure de map dans les données
        local rSurface = RitnSurface(rPlayer.surface):addPlayer(rPlayer.player)
    end
    
    rPlayer:new()

    log('on_player_created')
end


local function on_player_changed_surface(e)
    local rEvent = RitnEvent(e)
    local rPlayer = RitnEvent(e):getPlayer()

    if string.sub(rPlayer.surface.name, 1, string.len(rEvent.prefix_lobby)) ~= rEvent.prefix_lobby then
        -- remove old surface
        local rSurface = rEvent:getSurface()
        rSurface:removePlayer(rPlayer.player)
        -- add new surface
        rSurface = rPlayer:getSurface()
        rSurface:addPlayer(rPlayer.player)
        global.base.last_surface = rSurface.name

        rPlayer:setActive(true) 

        if script.level.level_name == "freeplay" then 
            
            --version freeplay (normal game)
            if rPlayer.force.name ~= "guides" then
                    if game.forces[rSurface.name] then
                        rPlayer.player.force = rSurface.name 
                    else if rSurface.name == "nauvis" then
                        rPlayer.player.force = "player" 
                    end
                end
            end

        end

    end

    log('on_player_changed_surface')
end

  
  
local function on_player_left_game(e)
    local rPlayer = RitnEvent(e):getPlayer()
    local rSurface = rPlayer:getSurface()
    rSurface:removePlayer(rPlayer.player)
    rPlayer:online()
end
  

  
local function on_player_joined_game(e)
    local rPlayer = RitnEvent(e):getPlayer()
    local rSurface = rPlayer:getSurface()
    rSurface:addPlayer(rPlayer.player)
    rPlayer:online()
end




---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
-- Events Player
module.events[defines.events.on_player_created] = on_player_created
module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_player_left_game] = on_player_left_game
module.events[defines.events.on_player_joined_game] = on_player_joined_game
---------------------------------------------------------------------------------------------
return module