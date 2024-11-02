-- MODULE : PLAYER
---------------------------------------------------------------------------------------------


-- Gestion de l'event surface supprimé : on_pre_surface_deleted
local function on_pre_surface_deleted(e)
    if storage.base.modules.surface == false then return end
    RitnCoreEvent(e):getSurface():delete()
    log('on_pre_surface_deleted')
end


---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
-- Events Surface
module.events[defines.events.on_pre_surface_deleted] = on_pre_surface_deleted
---------------------------------------------------------------------------------------------
return module