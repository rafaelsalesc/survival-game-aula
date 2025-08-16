--usar content provider com preload async de som 

--SERVICES
local ProximityPromptService = game:GetService("ProximityPromptService")
-- local ContentProvider:ContentProvider = game:GetService("ContentProvider")

-- CONSTANT
local PROXIMITY_ACTION = "Mining"
local PICKAXE_SOUND_ID = "rbxassetid://7650230644"

-- MEMBERS
local PlayerModule = require(game:GetService("ServerStorage").Modules.PlayerModule)
local PlayerInventoryUpdated: RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerInventoryUpdated
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://111260589216243"
local isPressing = false
-- ContentProvider:PreloadAsync({PICKAXE_SOUND_ID})

local function playPickAxeSound()
    local pickAxeSound:Sound = Instance.new("Sound", game:GetService("Workspace"))
    pickAxeSound.SoundId = PICKAXE_SOUND_ID
    local random = Random.new()
    local value = random:NextNumber(0.5, 1)

    pickAxeSound.Pitch = value
    pickAxeSound.Parent = workspace
    pickAxeSound:Play()
    
end

local function onPromptTriggered(promptObject: ProximityPrompt, player)
	if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end

	local miningModel = promptObject.Parent
	local miningValue = miningModel:FindFirstChildWhichIsA("NumberValue")
	
    PlayerModule.AddToInventory(player, miningValue.Name, miningValue.Value)
    PlayerInventoryUpdated:FireClient(player, PlayerModule.GetInventory(player))
    
    print(PlayerModule.GetInventory(player))
end

local function onPromptHoldBegan(promptObject: ProximityPrompt, player:Player)
	if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end

    isPressing = true

	local character = player.Character
    local humanoid = character.Humanoid
    local humanoidAnimator = humanoid.Animator
    local animationTrack:AnimationTrack =  humanoidAnimator:LoadAnimation(animation)
    
    while isPressing do
        animationTrack:Play(nil,2, 1.2)  
        playPickAxeSound()
        wait(2)  
    end
    
end

local function onPromptHoldEnded(promptObject, player)
    if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end
    print("parou de rodar")
    isPressing = false
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)
