local WAIT_INTERVAL = 1

local minutesAfterMidnight: number

while true do
    minutesAfterMidnight =  game.Lighting:GetMinutesAfterMidnight() + 3
    game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)
    print(game.Lighting:GetMinutesAfterMidnight())
    wait(.3)
end