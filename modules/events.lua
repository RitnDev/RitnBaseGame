---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local util = require(ritnlib.defines.other)
local migration = require("core.migrations")
---------------------------------------------------------------------------------------------


local function on_init_mod(event)
    log('RitnBaseGame -> on_init !')
    ------------------------------------------
    local setting_force_disable_enemy = settings.startup[ritnlib.defines.base.settings.force_disabled_enemy.name].value
    local setting_go_nauvis = settings.startup[ritnlib.defines.base.settings.go_nauvis.name].value
    ------------------------------------------ 
    util.callRemoteFreeplay("set_respawn_items")
    util.callRemoteFreeplay("set_skip_intro")
    util.callRemoteFreeplay("set_disable_crashsite")
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
        storage.crashed_ship_items = remote.call("freeplay", "get_ship_items")
        storage.crashed_debris_items = remote.call("freeplay", "get_debris_items")
        storage.crashed_ship_parts = remote.call("freeplay", "get_ship_parts")
    end)
    ------------------------------------------
    log('on_init : RitnBaseGame -> finish !')
end



local function on_configuration_changed(event)
    ------------------------------------------
    local setting_force_disable_enemy = settings.startup[ritnlib.defines.base.settings.force_disabled_enemy.name].value
    local setting_go_nauvis = settings.startup[ritnlib.defines.base.go_nauvis.name].value
    ------------------------------------------
    local enemy = remote.call('RitnCoreGame', "get_enemy")
    if enemy == nil then 
        enemy = {} 
        enemy.active = false
        enemy.force_disable = not setting_force_disable_enemy
        remote.call('RitnCoreGame', "set_enemy", enemy)
    end
    ------------------------------------------
    local options = remote.call('RitnCoreGame', "get_options")
    if options == nil then 
        options = {} 
        options.go_nauvis = setting_go_nauvis
        remote.call('RitnCoreGame', "set_options", options)
    end
    ------------------------------------------
    remote.call('RitnCoreGame', "starting")      
    -- migration storage
    migration.version(0,6,3)
end

---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
-- events :
module.on_init = on_init_mod
module.on_configuration_changed = on_configuration_changed
---------------------------------------------------------------------------------------------
return module