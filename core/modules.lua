local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts des fonctions d'interfaces.
modules.events =                require(ritnlib.defines.base.modules.events)
modules.interfaces =            require(ritnlib.defines.base.modules.interfaces)


-- Modules désactivable
if global.base.modules.commands then
    modules.commands =              require(ritnlib.defines.base.modules.commands)
end
if global.base.modules.player then
    modules.player =                require(ritnlib.defines.base.modules.player) 
end
if global.base.modules.lobby then
    modules.lobby =                 require(ritnlib.defines.base.modules.lobby) 
end

-- Inclus la compatibilité avec les mods
if global.base.modules.lobby then
    modules.spaceblock = require(ritnlib.defines.core.mods.spaceblock)
end
------------------------------------------------------------------------------
return modules