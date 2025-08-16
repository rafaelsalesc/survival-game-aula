-- Initialize player module

local PlayerModule = require(game:GetService("ServerStorage").Modules.PlayerModule)

wait(5)
local Players = game:GetService("Players")
for _, player in Players:GetPlayers() do
    PlayerModule.GetHunger(player)
end