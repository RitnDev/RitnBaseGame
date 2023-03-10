---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local flib = require(ritnlib.defines.other)
---------------------------------------------------------------------------------------------
local events = {}

function events.on_init(event)
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
if not global.base.initialize then
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
        last_surface = "" ,
        initialize = true
    }
end
-------------------------------------------
return events