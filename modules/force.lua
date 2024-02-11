-- MODULE : FORCE
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnForce = require(ritnlib.defines.core.class.force)
---------------------------------------------------------------------------------------------


local function on_force_cease_fire_changed(e)
    -- nothing
end



local function on_force_created(e)
    log('> on_force_created')
    --nothing
end



local function on_force_friends_changed(e)
    -- nothing
end



local function on_force_reset(e)
    -- nothing
end



local function on_forces_merged(e)
    local rEvent = RitnEvent(e)
    RitnForce.delete(rEvent.source_name)
end



local function on_forces_merging(e)
    local rEvent = RitnEvent(e)
    local rForce = rEvent:getForce()
    local players = RitnForce(rEvent.source):listPlayers()

    for player_name,_ in ipairs(players) do 
        rForce:addPlayer(player_name)
    end

end


---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
-- Events Force
module.events[defines.events.on_force_cease_fire_changed] = on_force_cease_fire_changed
module.events[defines.events.on_force_created] = on_force_created
module.events[defines.events.on_force_friends_changed] = on_force_friends_changed
module.events[defines.events.on_force_reset] = on_force_reset
module.events[defines.events.on_forces_merged] = on_forces_merged
module.events[defines.events.on_forces_merging] = on_forces_merging
---------------------------------------------------------------------------------------------
return module