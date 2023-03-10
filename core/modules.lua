local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts des fonctions d'interfaces.
modules.events =                require(ritnlib.defines.base.modules.events)
modules.commands =              require(ritnlib.defines.base.modules.commands)

-- Modules désactivable
modules.player =                require(ritnlib.defines.base.modules.player) 
modules.lobby =                 require(ritnlib.defines.base.modules.lobby) 
------------------------------------------------------------------------------
return modules