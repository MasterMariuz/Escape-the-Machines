
local trigger = script.parent 
local connector = script.parent.parent

function OnBeginOverlap(trigger, other)
	if other:IsA("Player") then
		local rootAsset = script.parent
		local i = tonumber(rootAsset.name)
		local position = rootAsset:GetWorldPosition()
		local doorType = rootAsset:GetCustomProperty("doorType")
		Events.BroadcastToPlayer(other,"DoorOpened",i,position.x,position.y,doorType)
	end
end



trigger.beginOverlapEvent:Connect(OnBeginOverlap)
