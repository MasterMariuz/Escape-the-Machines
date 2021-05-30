local trigger = script.parent

function OnBeginOverlap(trigger, other)
    -- The object's type must be checked because CoreObjects also overlap triggers
    if other:IsA("Player") then
		
		Events.Broadcast("UpdateActiveRooms", other)
	end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)