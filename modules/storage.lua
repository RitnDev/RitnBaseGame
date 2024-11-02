---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
if storage.base == nil then
    storage.base = { 
        modules = {
            lobby = true,
            surface = true,
            spaceblock = true,
            player = {
                on_player_created = true,
                on_player_changed_surface = true,
            },
        },
        lobby = {
            on_chunk_generated = true,
            on_player_changed_surface = true,
            on_player_changed_force = true,
            setup_lobby_surface = true
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
        storage.base.lobby.on_chunk_generated = false
    end,
    ["disable.lobby.on_player_changed_surface"] = function()  
        storage.base.lobby.on_player_changed_surface = false
    end,
    ["disable.lobby.setup_lobby_surface"] = function()  
        storage.base.lobby.setup_lobby_surface = false
    end,
    ["disable.lobby.on_player_changed_force"] = function()  
        storage.base.lobby.on_player_changed_force = false
    end,
    


    --disable modules
    ["disable.module.player.on_player_created"] = function()
        storage.base.modules.player.on_player_created = false
    end,
    ["disable.module.player.on_player_changed_surface"] = function()
        storage.base.modules.player.on_player_changed_surface = false
    end,
    ["disable.module.surface"] = function()
        storage.base.modules.surface = false
    end,
    ["disable.module.lobby"] = function()
        storage.base.modules.lobby = false
    end,
    ["disable.module.spaceblock"] = function()
        storage.base.modules.spaceblock = false
    end,

}

remote.add_interface("RitnBaseGame", base_interface)
---------------------------------------------------------------------------------------------
return {}