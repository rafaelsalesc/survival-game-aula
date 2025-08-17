-- SERVICES
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local player = Players.LocalPlayer

-- CONSTANTS


-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local inviteFriendsButton:TextButton = hud:FindFirstChild("InviteFriends")


local function promptGameInvite(targetPlayer)
    local res, canInvite = pcall(SocialService.PromptGameInvite, SocialService, targetPlayer)
    return res and canInvite
end

local function openGameInvitePrompt(targetPlayer)
    local promptOpened = promptGameInvite(targetPlayer)
    return promptOpened    
end


inviteFriendsButton.MouseButton1Click:Connect(function()
    openGameInvitePrompt(player)
end)