local PlayerHungerUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerHungerUpdated

-- SERVICES
local Players = game:GetService("Players")


-- CONSTANTS


-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local inventoryUI:Frame = leftBar:WaitForChild("Inventory")
local inventoryButton:ImageButton = inventoryUI:WaitForChild("Button")

local invetoryWindow:Frame = hud:WaitForChild("Inventory")


-- inventoryUI.MouseEnter:Connect(--function()
--     -- invetoryWindow.Visible = true
--     -- print("enter")
-- --end
-- )

-- inventoryUI.MouseLeave:Connect(--function()
--     -- invetoryWindow.Visible = false
--     -- print("leave")
-- --end
-- )

inventoryButton.MouseButton1Click:Connect(function()
    invetoryWindow.Visible = not invetoryWindow.Visible
    print(invetoryWindow.Visible )
end)


