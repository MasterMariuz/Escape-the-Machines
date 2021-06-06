--VERY USEFUL to get the player that is running the client
local localPlayer = Game.GetLocalPlayer()

local propMinimapPanel = script.parent:GetCustomProperty("MinimapPanel")
local propMinimapBlock = script.parent:GetCustomProperty("MinimapBlock")
local propNewGroup = script.parent:GetCustomProperty("NewGroup")

local mapData = {}
script.parent.parent.clientUserData.mapData = mapData

--local room = script.parent.parent.serverUserData.room

function SpawnMinimap()
	--print(script.parent.parent.serverUserData.room)
	--room = script.parent.parent.serverUserData.room
	MinimapPanel = World.SpawnAsset(propMinimapPanel)
	MinimapPanel.parent = script.parent
	MinimapBlocks = World.SpawnAsset(propNewGroup)
	MinimapBlocks.parent = MinimapPanel
	print(room)
	
end


function UpdateMapData(i,ix,iz,ilength,idepth)
	print("Updating Map!")
	print(mapData[i])
	if(mapData[i] == nil) then 
		mapData[i] = {x = ix, z = iz, length = ilength, depth = idepth}
		print('new registered room length: '..mapData[i].length)
	end

end




Events.Connect("LevelGenerated",SpawnMinimap)
Events.Connect("newMapData",UpdateMapData)
