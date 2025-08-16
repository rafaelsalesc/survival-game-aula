local PlayerModule = {}

-- SERVICES
local Players:Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- CONSTANTS

local PLAYER_DEFAULT_DATA = {
    hunger = 100,
    inventory = {},
    level = 1
}
-- MEMBERS

local playersCached = {} --- Dictionary with all players in the game
local database = DataStoreService:GetDataStore("Survival")
local PlayerLoaded:BindableEvent = game:GetService("ServerStorage").BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = game:GetService("ServerStorage").BindableEvents.PlayerUnloaded


local PlayerHungerUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerHungerUpdated
local PlayerInventoryUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerInventoryUpdated


local function normalizeHunger(hunger:number)
    if hunger < 0 then
        hunger = 0
    end

    if hunger > 100 then
        hunger = 100
    end
    return hunger
end

function PlayerModule.IsLoaded(player:Player)
    local isLoaded = playersCached[player.UserId] and true or false
    return isLoaded
end

function PlayerModule.GetInventory(player:Player):table
    return playersCached[player.UserId].inventory
end

function PlayerModule.SetInventory(player:Player, inventory:table)
    playersCached[player.UserId] = inventory
end

function PlayerModule.AddToInventory(player: Player, key:string, value: number)
    local inventory = playersCached[player.UserId].inventory
    
    if inventory[key]then
        inventory[key] += value
        return
    end
    inventory[key] = value
end

function PlayerModule.GetHunger(player:Player):number
    local hunger = playersCached[player.UserId].hunger
    hunger = normalizeHunger(hunger)

    return hunger
end

--- Sets the hunger of given player
function PlayerModule.SetHunger(player : Player, hunger : number)
    hunger = normalizeHunger(hunger)    
    playersCached[player.UserId].hunger = hunger
    
    
end


--- Gets the hunger of given player
local function onPlayerAdded(player:Player):number
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then
            data = PLAYER_DEFAULT_DATA
        end
        playersCached[player.UserId] = data

        -- Player is fully loaded
        PlayerLoaded:Fire(player)

        PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))
        PlayerInventoryUpdated:FireClient(player, PlayerModule.GetInventory(player) )

    end)
end

local function onPlayerRemoving(player:Player)
    PlayerUnloaded:Fire(player)
    database:SetAsync(player.UserId, playersCached[player.UserId])
    playersCached[player.UserId] = nil
end



Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)


return PlayerModule