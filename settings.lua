require("__RitnBaseGame__.core.defines")
----------------------------------------------------------------------
local RitnSetting = require(ritnlib.defines.class.ritnClass.setting)
----------------------------------------------------------------------
local rSetting_force_disabled_enemy = RitnSetting(ritnlib.defines.base.settings.force_disabled_enemy.name)
rSetting_force_disabled_enemy:setDefaultValueBool(ritnlib.defines.base.settings.force_disabled_enemy.value):new()
----------------------------------------------------------------------
local rSetting_go_nauvis = RitnSetting(ritnlib.defines.base.settings.go_nauvis.name)
rSetting_go_nauvis:setDefaultValueBool(ritnlib.defines.base.settings.go_nauvis.value):new()
----------------------------------------------------------------------