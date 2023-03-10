---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local flib = require(ritnlib.defines.other)
---------------------------------------------------------------------------------------------
local events = {}

local function on_init(event)
    global.base = { 
        modules = {
            lobby = true,
            spaceblock = true,
            player = {
                on_player_created = true,
                on_player_changed_surface = true,
            },
        },
        lobby = {
            on_chunk_generated = true,
            on_player_changed_surface = true,
        },
        last_surface = ""
    }
    log('RitnBaseGame -> on_init !')
    ------------------------------------------
    local base_interface = {
        -- lobby (events)
        ["disable.lobby.on_chunk_generated"] = function()
            global.base.lobby.on_chunk_generated = false
        end,
        ["disable.lobby.on_player_changed_surface"] = function()  
            global.base.lobby.on_player_changed_surface = false
        end,
    
        --disable modules
        ["disable.module.player.on_player_created"] = function()
            global.base.modules.player.on_player_created = false
        end,
        ["disable.module.player.on_player_changed_surface"] = function()
            global.base.modules.player.on_player_changed_surface = false
        end,
        ["disable.module.lobby"] = function()
            global.base.modules.lobby = false
        end,
        ["disable.module.spaceblock"] = function()
            global.base.modules.spaceblock = false
        end,
    
    }
    remote.add_interface("RitnBaseGame", base_interface)
    ----------------------------------------------------
    flib.callRemoteFreeplay("set_respawn_items")
    flib.callRemoteFreeplay("set_skip_intro")
    flib.callRemoteFreeplay("set_disable_crashsite")
    remote.call('RitnCoreGame', "set_enemy", {
        active = true
    })
    ----
    pcall(function() 
        global.crashed_ship_items = remote.call("freeplay", "get_ship_items")
        global.crashed_debris_items = remote.call("freeplay", "get_debris_items")
        global.crashed_ship_parts = remote.call("freeplay", "get_ship_parts")
    end)
    ----
    log('on_init : RitnBaseGame -> finish !')
end

-------------------------------------------
-- INIT GLOBAL MOD
-------------------------------------------
--[[ if not global.base then
    global.base = { 
        modules = {
            commands = true,
            lobby = true,
            spaceblock = true,
            player = {
                on_player_created = true,
                on_player_changed_surface = true,
            },
        },
        lobby = {
            on_chunk_generated = true,
            on_player_changed_surface = true,
        },
        last_surface = "",
        initialize = true
    }
end ]]


script.on_init(on_init)
-------------------------------------------
return events