-- Initialisation des variables globals
require("core.defines")

-- setup classes
require(ritnlib.defines.core.setup)
log('> imported : ' .. ritnlib.defines.core.setup)

-- Activation de gvv s'il est présent
if script.active_mods["gvv"] then require(ritnlib.defines.gvv)() end
-- envoie des modules à l'event listener :
local listener = require(ritnlib.defines.event).add_libraries(require(ritnlib.defines.base.modules.core))
