Task.Wait() -- wait for trigger to update it's name
local trigger = script.parent
local i = tonumber(trigger.name)
local floor
local f = 1 

function OnBeginOverlap(trigger, other)
    -- The object's type must be checked because CoreObjects also overlap triggers
    if other:IsA("Player") then
	    floor = script.parent.parent.parent.parent.parent.serverUserData.floor
	    print(script.parent.parent.parent.parent.parent)
	    --f = currentFloorLevel
		Events.Broadcast("UpdateActiveRooms", other, f)
		Events.BroadcastToPlayer(other, "newMapData", i,floor[f].room[i].spawnX,floor[f].room[i].spawnZ,floor[f].room[i].length,floor[f].room[i].depth)
	end
end

function SetCurrentFloorLevel(floorLevel)
	
end


trigger.beginOverlapEvent:Connect(OnBeginOverlap)