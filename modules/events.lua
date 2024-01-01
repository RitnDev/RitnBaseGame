---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local flib = require(ritnlib.defines.other)
---------------------------------------------------------------------------------------------
local RitnPlayer = require(ritnlib.defines.core.class.player)
local RitnSurface = require(ritnlib.defines.core.class.surface)
local RitnForce = require(ritnlib.defines.core.class.force)
---------------------------------------------------------------------------------------------

local function on_init(event)
    log('RitnBaseGame -> on_init !')
    ------------------------------------------
    flib.callRemoteFreeplay("set_respawn_items")
    flib.callRemoteFreeplay("set_skip_intro")
    flib.callRemoteFreeplay("set_disable_crashsite")
    remote.call('RitnCoreGame', "set_enemy", {
        active = true
    })
    -- for freeplay mode
    pcall(function()
        global.crashed_ship_items = remote.call("freeplay", "get_ship_items")
        global.crashed_debris_items = remote.call("freeplay", "get_debris_items")
        global.crashed_ship_parts = remote.call("freeplay", "get_ship_parts")
    end)
    ------------------------------------------
    log('on_init : RitnBaseGame -> finish !')
end



local function on_configuration_changed(event)
    remote.call('RitnCoreGame', "starting")  
    if global.base.modules.player == false then return end
    if global.base.modules.player.on_player_created then 
    
        for _,LuaPlayer in pairs(game.players) do

            local rPlayer = RitnPlayer(LuaPlayer)
            
            if script.level.campaign_name 
            or script.level.level_name ~= "wave-defense"
            or script.level.level_name ~= "pvp" then 
                -- Creation de la structure de map dans les données
                RitnSurface(rPlayer.surface):addPlayer(rPlayer.player)
                RitnForce(rPlayer.force):addPlayer(rPlayer.player)
            end

            rPlayer:init()
        end
    end
end

-------------------------------------------
script.on_init(on_init)
script.on_configuration_changed(on_configuration_changed)
---------------------------------------------------------------------------------------------
return {}