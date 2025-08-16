--SERVICES
local ProximityPromptService = game:GetService("ProximityPromptService")

-- CONSTANT
local PROXIMITY_ACTION =  {["Eat"] = true, ["Watermelon"] = true}

-- MEMBERS
local PlayerModule = require(game:GetService("ServerStorage").Modules.PlayerModule)
local PlayerHungerUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerHungerUpdated

local function playEatingSound()
    local eatingSound:Sound = Instance.new("Sound", game:GetService("Workspace"))
    eatingSound.SoundId = "rbxassetid://6830313781"
    local random = Random.new()
    local value = random:NextNumber(0.5, 1)

    eatingSound.Pitch = value
    eatingSound.Parent = workspace
    eatingSound:Play()
    
end



local function onPromptTriggered(promptObject:ProximityPrompt, player)
    if not PROXIMITY_ACTION[promptObject.Name] then
        return
    end
    
    local foodModel = promptObject.Parent
    local foodValue = foodModel.Food.Value

    local currentHunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player,currentHunger + foodValue)
    playEatingSound()
    PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))
    
    foodModel:Destroy()
end


ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)