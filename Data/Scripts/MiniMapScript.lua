Task.Wait()
local propMinimapPanel = script.parent:GetCustomProperty("MinimapPanel")
local propMinimapBlock = script.parent:GetCustomProperty("MinimapBlock")
local propMinimapBlocks = script.parent:GetCustomProperty("MinimapBlocks")

local a = nil
local LevelGenerated, a = script.parent.parent:GetCustomProperty("room")
MinimapGenerated = false
levelG = true 

function SpawnMinimap()
	print("OK")
	room = script.parent.parent.parent:GetCustomProperty("room")
	MinimapPanel = World.SpawnAsset(propMinimapPanel, {parent = script.parent})
	MinimapBlocks = World.SpawnAsset(propMinimapPanel, {parent = MinimapPanel})
	print(room)
end


function Tick()
	if (LevelGenerated == true and MinimapGenerated == false) then
		SpawnMinimap()
		MinimapGenerated = true
	end
end
	
	