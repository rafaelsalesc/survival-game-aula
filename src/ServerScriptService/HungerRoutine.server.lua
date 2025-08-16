local Players = game:GetService("Players")
local PlayerModule = require(game:GetService("ServerStorage").Modules.PlayerModule)

--CONSTANTES

local CORE_LOOP_INTERVAL = 1
local HUNGER_DECREMENT = 1

-- MEMBERS
local PlayerLoaded:BindableEvent = game:GetService("ServerStorage").BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = game:GetService("ServerStorage").BindableEvents.PlayerUnloaded
local PlayerHungerUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerHungerUpdated

local function coreLoop(player:Player)
    local isRunning = true
    PlayerUnloaded.Event:Connect(function(player)
        if PlayerUnloaded == player then
            isRunning = false
        end
    end)
    while true do
        if not isRunning then
            break
        end
        local currentHunger = PlayerModule.GetHunger(player)
        PlayerModule.SetHunger(player, currentHunger - HUNGER_DECREMENT)
        -- Notiy client
        PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))
        
        wait(CORE_LOOP_INTERVAL)
    end
end

local function onPlayerLoaded(player:Player)
    spawn(function()
        coreLoop(player)
    end)
end



PlayerLoaded.Event:Connect(onPlayerLoaded)
