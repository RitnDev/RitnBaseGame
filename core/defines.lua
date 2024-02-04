-----------------------------------------
--               DEFINES               --
-----------------------------------------
if not ritnlib then require("__RitnLib__.defines") end
require("__RitnCoreGame__.core.defines")
-----------------------------------------
local name = "RitnBaseGame"
local mod_name = "__"..name.."__"

local defines = {
    name = name,
    directory = mod_name,

    
    modules = {
        core = mod_name .. ".core.modules",
        ----
        globals = mod_name .. ".modules.globals",
        events = mod_name .. ".modules.events",
        interfaces = mod_name .. ".modules.interfaces",
        commands = mod_name .. ".modules.commands",
        ----
        force = mod_name .. ".modules.force",
        player = mod_name .. ".modules.player",
        surface = mod_name .. ".modules.surface",
        lobby = mod_name .. ".modules.lobby",
    },

    
}


-- Prefix
defines.prefix = {
    name = "ritnmods-",
    mod = "basegame-",
}


--settings 
local settings_prefix = defines.prefix.name .. defines.prefix.mod
defines.settings = {
    force_disabled_enemy = {
        name = settings_prefix .. "force-disabled-enemy",
        value = false, 
    },
    go_nauvis = {
        name = settings_prefix .. "go-nauvis",
        value = false, 
    }
}


----------------
ritnlib.defines.base = defines
log('declare : ritnlib.defines.base | '.. ritnlib.defines.base.name ..' -> finish !')