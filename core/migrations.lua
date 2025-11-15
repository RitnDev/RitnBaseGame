-- MIGRATIONS
------------------------------------------------------------------------
local table = require(ritnlib.defines.table)
local string = require(ritnlib.defines.string)
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
-- migration 0.6.6 : création de la structures players / forces / surfaces, si le mod est chargé plutard sur une save
-- à ajouter systématiquement dans les futures migrations
local function migration_0_6_6()
    if game.is_multiplayer() then remote.call("RitnCoreGame", "setMultiplayer") end
    
    if storage.base.modules.player then
        if storage.base.modules.player.on_player_created then 
            -- On boucle sur la liste des LuaPlayer
            for _,luaPlayer in pairs(game.players) do
                local rPlayer = RitnCorePlayer(luaPlayer)   
                
                if script.level.campaign_name 
                or script.level.level_name ~= "wave-defense"
                or script.level.level_name ~= "pvp" then 
                    -- Creation de la structure de map dans les données
                    RitnCoreSurface(rPlayer.surface):addPlayer(rPlayer.player)
                    RitnCoreForce(rPlayer.force):addPlayer(rPlayer.player)
                end
                    
                local options = remote.call('RitnCoreGame', 'get_options')
                rPlayer:new(false):setOrigine(string.defaultValue(luaPlayer.surface.name))

                log('on_player_created')
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
            },
            [6] = {
                migration_0_6_6,
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