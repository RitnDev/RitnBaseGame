---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
if global.base == nil then
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
end

---------------------------------------------------------------------------------------------
-- REMOTE FUNCTIONS INTERFACE
---------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------
return {}