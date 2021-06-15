
local trigger = script.parent

function OnBeginOverlap(trigger, other)
    -- The object's type must be checked because CoreObjects also overlap triggers
    if other:IsA("Player") then
	    floor = script.parent.parent.parent.parent.parent.serverUserData.floor
	    --f = currentFloorLevel
	    local i = tonumber(trigger.name)
	    Events.Broadcast("RoomTriggerPressed", other, i)
	end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)