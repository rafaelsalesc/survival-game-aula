local PlayerInventoryUpdated:RemoteEvent = game:GetService("ReplicatedStorage").Network.PlayerInventoryUpdated

-- SERVICES
local Players = game:GetService("Players")


-- CONSTANTS


-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local inventoryUI:Frame = leftBar:WaitForChild("Inventory")
local inventoryButton:ImageButton = inventoryUI:WaitForChild("Button")

local inventoryWindow:Frame = hud:WaitForChild("Inventory")
local inventoryWindowOriginalPosition = inventoryWindow.Position.X.Scale
inventoryWindow.Position = UDim2.fromScale(-1, inventoryWindow.Position.Y.Scale)

local bigStoneNumberLabel:TextLabel = inventoryWindow.BigStone.Number
local stoneNumberLabel:TextLabel = inventoryWindow.Stone.Number
local woodNumberLabel:TextLabel = inventoryWindow.Wood.Number


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
    inventoryWindow.Visible = not inventoryWindow.Visible
    if inventoryWindow.Visible then
        inventoryWindow:TweenPosition(UDim2.fromScale(inventoryWindowOriginalPosition,inventoryWindow.Position.Y.Scale, Enum.EasingDirection.Out, Enum.EasingStyle.Quint ))
    else
        inventoryWindow.Position = UDim2.fromScale(-1, inventoryWindow.Position.Y.Scale)
    end
end)


PlayerInventoryUpdated.OnClientEvent:Connect(function(inventory:table)
    
    bigStoneNumberLabel.Text = inventory.BigStone and  inventory.BigStone or 0
    stoneNumberLabel.Text = inventory.Stone and inventory.Stone or 0
    woodNumberLabel.Text = inventory.Wood and inventory.Wood or 0
end)


