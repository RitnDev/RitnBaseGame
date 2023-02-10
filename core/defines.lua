-----------------------------------------
--               DEFINES               --
-----------------------------------------
local name = "RitnBaseGame"
local mod_name = "__"..name.."__"

local defines = {
    name = name,
    directory = mod_name,

    
    modules = {
        core = mod_name .. ".core.modules",
        ----
        events = mod_name .. ".modules.events",
        interfaces = mod_name .. ".modules.interfaces",
        commands = mod_name .. ".modules.commands",
        ----
        player = mod_name .. ".modules.player",
        lobby = mod_name .. ".modules.lobby",
    },

}


----------------
ritnlib.defines.base = defines
log('declare : ritnlib.defines.base | '.. ritnlib.defines.base.name ..' -> finish !')