local connectorDoor = script.parent
local trigger = connectorDoor:FindDescendantByName("Trigger")

function OnBeginOverlap(trigger,other)
	if(other:IsA("Player")) then 
		print(connectorDoor.name)
		local i = tonumber(connectorDoor.name)
		print("door i is: "..i)
		local doorType = connectorDoor:GetCustomProperty("doorType")
		local doorPosition = connectorDoor:GetWorldPosition()
		print("Broadcast to player")
		Events.BroadcastToPlayer(other, "DoorOpened", i, doorPosition.x, doorPosition.y, doorType)--Connects with Minimap
	end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
