-- MIGRATIONS
------------------------------------------------------------------------
local table = require(ritnlib.defines.table)
------------------------------------------------------------------------
-- migration 0.6.1
local function migration_0_6_1()
    local players = remote.call("RitnCoreGame", "get_players")
    for _,force in pairs(game.forces) do
        local rForce = RitnCoreForce(force)
        for _, surface in pairs(game.surfaces) do 
            -- RitnSurface
            local rSurface = RitnCoreSurface(surface)
            -- on cache les lobby à toutes les forces
            if (rSurface.isLobby) then 
                rForce:setHiddenSurface(surface)
            end
            -- Récupération de la liste des joueurs de la forces
            for _,player in pairs(players) do 
                if rSurface.name ~= player.surface then 
                    if rForce.name == player.force then 
                        rForce:setHiddenSurface(surface)
                    end
                end
            end
        end
    end
end
------------------------------------------------------------------------
local updates_mod = {
    [0] = {
        [6] = {
            [0] = {},
            [1] = {
                migration_0_6_1,
            }
        }
    }
}
------------------------------------------------------------------------
-- migration selon la version
local function version(major, minor, patch)
    log('>>> MIGRATION RitnBaseGame start !')
    if updates_mod[major] ~= nil then 
        if updates_mod[major][minor] ~= nil then 
            if updates_mod[major][minor][patch] ~= nil then 
                for _, migration in pairs(updates_mod[major][minor][patch]) do 
                    migration()
                end
            end
        end
    end
    log('>>> MIGRATION RitnBaseGame finish !')
end

------------------------------------------------------------------------
local migration = {}
------------------------------------------------------------------------
migration.version = version 
------------------------------------------------------------------------
return migration