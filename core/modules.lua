local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts des fonctions d'interfaces.
modules.globals =               require(ritnlib.defines.base.modules.globals)
modules.events =                require(ritnlib.defines.base.modules.events)
modules.commands =              require(ritnlib.defines.base.modules.commands)

------------------------------------------------------------------------------
modules.force =                require(ritnlib.defines.base.modules.force)
------------------------------------------------------------------------------
-- Modules désactivable
modules.player =                require(ritnlib.defines.base.modules.player)  
modules.surface =               require(ritnlib.defines.base.modules.surface) 
modules.lobby =                 require(ritnlib.defines.base.modules.lobby) 
------------------------------------------------------------------------------
return modules