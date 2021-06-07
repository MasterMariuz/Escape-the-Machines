Task.Wait() -- wait for trigger to update it's name
local trigger = script.parent
local i = tonumber(trigger.name)
local room 

function OnBeginOverlap(trigger, other)
    -- The object's type must be checked because CoreObjects also overlap triggers
    if other:IsA("Player") then
	    room = script.parent.parent.parent.parent.serverUserData.room
		Events.Broadcast("UpdateActiveRooms", other)
		Events.BroadcastToPlayer(other, "newMapData", i,room[i].spawnX,room[i].spawnZ,room[i].length,room[i].depth)
	end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)