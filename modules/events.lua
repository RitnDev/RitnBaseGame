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
    local setting_force_disable_enemy = settings.startup[ritnlib.defines.base.settings.force_disabled_enemy.name].value
    local setting_go_nauvis = settings.startup[ritnlib.defines.base.settings.go_nauvis.name].value
    ------------------------------------------ 
    flib.callRemoteFreeplay("set_respawn_items")
    flib.callRemoteFreeplay("set_skip_intro")
    flib.callRemoteFreeplay("set_disable_crashsite")
    ------------------------------------------
    local enemy = remote.call('RitnCoreGame', "get_enemy")
        if enemy == nil then enemy = {} end
        enemy.active = false
        enemy.force_disable = not setting_force_disable_enemy
    remote.call('RitnCoreGame', "set_enemy", enemy)
    ------------------------------------------
    local options = remote.call('RitnCoreGame', "get_options")
        if options == nil then options = {} end
        options.go_nauvis = setting_go_nauvis
    remote.call('RitnCoreGame', "set_options", options)
    ------------------------------------------
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
    ------------------------------------------
    local setting_force_disable_enemy = settings.startup[ritnlib.defines.base.settings.force_disabled_enemy.name].value
    local setting_go_nauvis = settings.startup[ritnlib.defines.base.settings.go_nauvis.name].value
    ------------------------------------------
    local enemy = remote.call('RitnCoreGame', "get_enemy")
        if enemy == nil then enemy = {} end
        enemy.active = false
        enemy.force_disable = not setting_force_disable_enemy
    remote.call('RitnCoreGame', "set_enemy", enemy)
    ------------------------------------------
    local options = remote.call('RitnCoreGame', "get_options")
        if options == nil then options = {} end
        options.go_nauvis = setting_go_nauvis
    remote.call('RitnCoreGame', "set_options", options)
    ------------------------------------------

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