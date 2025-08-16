local dummy = workspace.Dummy
local humanoid = dummy.Humanoid

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://111260589216243"

local humanoidAnimator = humanoid.Animator
local animationTrack =  humanoidAnimator:LoadAnimation(animation)

while true do
	animationTrack:Play()
	wait(2)
end