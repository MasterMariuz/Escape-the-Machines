
local propFloor01 = script:GetCustomProperty("Floor01")
local propDoor2x1 = script:GetCustomProperty("Door2x1")
local propDoor4x1 = script:GetCustomProperty("Door4x1")
local propWall01 = script:GetCustomProperty("Wall01")
local propCorner01 = script:GetCustomProperty("Corner01")
local propNewFolder = script:GetCustomProperty("NewFolder")
local propTriggerRoom = script:GetCustomProperty("TriggerRoom")
local propTrigger = script:GetCustomProperty("Trigger")
local propElevator = script:GetCustomProperty("Elevator")
local propElevatorStasisField = script:GetCustomProperty("ElevatorStasisField")
local propNewGroup = script:GetCustomProperty("NewGroup")

local xyOffset = script.parent.parent:GetCustomProperty("xyOffset")

local i, floor, childAsset, asset, floorFolder, connectorFolder, roomFolder, f


function SpawnRoom(i)

	floor[f].room[i].active = true
	local newPosition, newScale, newRotation
	local startX = 0
	local startZ = 0

	
	floorFolder = World.FindObjectByName("Floor "..f)
	if(floorFolder == nil) then
		floorFolder = World.SpawnAsset(propNewGroup, {parent = script.parent})
		floorFolder.name = "Floor "..f
	end
	
	roomFolder = World.FindObjectByName("Room "..i)
	if(roomFolder == nil) then
		roomFolder = World.SpawnAsset(propNewGroup, {parent = floorFolder})
		roomFolder.name = "Room "..i
	end
		
	--spawn the room floor with size x,y
	newPosition = Vector3.New(floor[f].room[i].spawnX*xyOffset+(floor[f].room[i].length*100), (floor[f].room[i].spawnZ*xyOffset)+(floor[f].room[i].depth*100), -25)
	newScale = Vector3.New(floor[f].room[i].length*2, floor[f].room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "RoomFloor "..i
	asset.parent = roomFolder
	
	--trigger for room spawning and despawning
	newPosition = Vector3.New(floor[f].room[i].spawnX*xyOffset+(floor[f].room[i].length*100), (floor[f].room[i].spawnZ*xyOffset)+(floor[f].room[i].depth*100), 300)
	newScale = Vector3.New(floor[f].room[i].length*2-1, floor[f].room[i].depth*2-1, 6)
	asset = World.SpawnAsset(propTriggerRoom, {position = newPosition, scale = newScale})
	asset.name = tostring(i)
	asset.parent = roomFolder
	
	--spawn room ceiling x,y
	newPosition = Vector3.New(floor[f].room[i].spawnX*xyOffset+(floor[f].room[i].length*100), (floor[f].room[i].spawnZ*xyOffset)+(floor[f].room[i].depth*100), 625)
	newScale = Vector3.New(floor[f].room[i].length*2, floor[f].room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "Ceiling "..i
	asset.parent = roomFolder
	
	--spawn First Room Elevator
	if(i==1) then
		newPosition = Vector3.New((floor[f].room[i].spawnX+floor[f].room[i].length/2)*xyOffset, (floor[f].room[i].spawnZ+floor[f].room[i].depth/2)*xyOffset, 0)
		newScale = Vector3.New(1,1,1)
		newRotation = Rotation.New(0,0,0)
		asset = World.SpawnAsset(propElevator, {position = newPosition, scale = newScale, rotation = newRotation})
		asset.name = "FirstRoom Elevator"
		asset.parent = roomFolder
		asset:FindChildByName("ElevatorGlass"):Destroy()
		asset:FindChildByName("ElevatorStasisField"):Destroy()
		asset:FindChildByName("Trigger"):Destroy()
	end
	
	--spawn Final Room Elevator
	if(i==floor[f].finalRoom) then
		newPosition = Vector3.New((floor[f].room[i].spawnX+floor[f].room[i].length/2)*xyOffset, (floor[f].room[i].spawnZ+floor[f].room[i].depth/2)*xyOffset, 0)
		newScale = Vector3.New(1,1,1)
		if(floor[f].room[i].parentDirection == "north") then
			newRotation = Rotation.New(0,0,0)
		elseif(floor[f].room[i].parentDirection == "south") then
			newRotation = Rotation.New(0,0,180)
		elseif(floor[f].room[i].parentDirection == "east") then
			newRotation = Rotation.New(0,0,90)
		elseif(floor[f].room[i].parentDirection == "west") then
			newRotation = Rotation.New(0,0,270)
		end
		asset = World.SpawnAsset(propElevator, {position = newPosition, scale = newScale, rotation = newRotation})
		asset.name = "FinalRoom Elevator"
		asset.parent = roomFolder
		
		--Hide the walls underground
		childAsset = asset:FindChildByName("ElevatorWalls")
		newPosition = childAsset:GetPosition()
		newPosition.z = -300
		childAsset:SetPosition(newPosition)
		childAsset.visibility = Visibility.FORCE_OFF
		
		childAsset = asset:FindChildByName("ElevatorGlass")
		newPosition = childAsset:GetPosition()
		newPosition.z = -600
		childAsset:SetPosition(newPosition)
		childAsset.visibility = Visibility.FORCE_OFF
		
		--Turn On the StasisField color animation
		childAsset = asset:FindChildByName("ElevatorStasisField")
		Events.Broadcast("ToggleElevatorStasisField",childAsset) --connects with GameManager script
	end
	
	--spawn walls on all rooms (except on connector tiles)
	local counter = 0
	local first = 1 -- will count the first tile that connects
	local startConnector =0
	local offset = 0
	
	wallsFolder = World.FindObjectByName("Walls "..i)
	if(wallsFolder == nil) then
		roomFolder = World.SpawnAsset(propNewGroup, {parent = roomFolder})
		roomFolder.name = "Walls "..i
	end
	
	-- spawn the walls in the [-1,0] south side of the room
	for m=0,floor[f].room[i].depth-1 do
		if(floor[f].room[i].tile[0][m].isConnector == true and floor[f].room[i].tile[0][m].direction.south == true and floor[f].room[i].tile[0][m].parentDirection == "south") then 
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(floor[f].room[i].tile[0][m].isConnector == true and floor[f].room[i].tile[0][m].direction.south == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,0)
			startX = -50
			startZ = 100
			if(floor[f].room[i].tile[0][m].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+startX,(floor[f].room[i].spawnZ+m)*xyOffset+startZ+offset,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+startX,(floor[f].room[i].spawnZ+m)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallSouth "..m
			asset.parent = wallsFolder
		end
	end

	
	
	-- spawn the walls in the [1,0] north side of the room
	for m=0,floor[f].room[i].depth-1 do
		if(floor[f].room[i].tile[floor[f].room[i].length-1][m].isConnector == true and floor[f].room[i].tile[floor[f].room[i].length-1][m].direction.north == true and floor[f].room[i].tile[floor[f].room[i].length-1][m].parentDirection == "north") then
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(floor[f].room[i].tile[floor[f].room[i].length-1][m].isConnector == true and floor[f].room[i].tile[floor[f].room[i].length-1][m].direction.north == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,0)
			startX = 250
			startZ = 100
			if(floor[f].room[i].tile[floor[f].room[i].length-1][m].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((floor[f].room[i].spawnX+floor[f].room[i].length-1)*xyOffset+startX,(floor[f].room[i].spawnZ+m)*xyOffset+startZ+offset,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((floor[f].room[i].spawnX+floor[f].room[i].length-1)*xyOffset+startX,(floor[f].room[i].spawnZ+m)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallNorth "..m
			asset.parent = wallsFolder
		end
	end

	
	
	-- spawn the walls in the [0,1] east side of the room
	for m=0,floor[f].room[i].length-1 do
		if(floor[f].room[i].tile[m][0].isConnector == true and floor[f].room[i].tile[m][0].direction.west == true and floor[f].room[i].tile[m][0].parentDirection == "west") then 
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(floor[f].room[i].tile[m][0].isConnector == true and floor[f].room[i].tile[m][0].direction.west == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,90)
			startX = 100
			startZ = -50
			if(floor[f].room[i].tile[m][0].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((floor[f].room[i].spawnX+m)*xyOffset+startX+offset,(floor[f].room[i].spawnZ)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((floor[f].room[i].spawnX+m)*xyOffset+startX,(floor[f].room[i].spawnZ)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallEast "..m
			asset.parent = wallsFolder
			
		end
	end

	
	-- spawn the walls in the [0,-1] west side of the room
	for m=0,floor[f].room[i].length-1 do
		if(floor[f].room[i].tile[m][floor[f].room[i].depth-1].isConnector == true and floor[f].room[i].tile[m][floor[f].room[i].depth-1].direction.east == true and floor[f].room[i].tile[m][floor[f].room[i].depth-1].parentDirection == "east") then
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(floor[f].room[i].tile[m][floor[f].room[i].depth-1].isConnector == true and floor[f].room[i].tile[m][floor[f].room[i].depth-1].direction.east == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,90)
			startX = 100
			startZ = 250
			if(floor[f].room[i].tile[m][floor[f].room[i].depth-1].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((floor[f].room[i].spawnX+m)*xyOffset+startX+offset,(floor[f].room[i].spawnZ+floor[f].room[i].depth-1)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((floor[f].room[i].spawnX+m)*xyOffset+startX,(floor[f].room[i].spawnZ+floor[f].room[i].depth-1)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallWest "..m
			asset.parent = wallsFolder
		end
	end
end	





function SpawnConnector(i)
--depending on the size of the connection, will spawn different doors/connectors	
	floor[f].room[i].activeConnector = true
	
	local m, asset,assetFolder,connectorFolder
	local offsetX = 0
	local offsetY = 0
	
	connectorFolder = World.FindObjectByName("Connectors")
	if(connectorFolder == nil) then
		connectorFolder =  World.SpawnAsset(propNewFolder)
		connectorFolder.name = "Connectors"
		connectorFolder.parent = floorFolder
	end

	assetFolder = World.FindObjectByName("Connector "..i)
	if(assetFolder == nil) then
		assetFolder =  World.SpawnAsset(propNewFolder)
		assetFolder.name = ("Connector "..i)
		assetFolder.parent = connectorFolder
	end

	local counter = 0
	local first = 1 -- will count the first tile that connects
	local startConnector =0
	
	-- each new room has 1 parent only. will check the direction of parent room and spawn only 1 connector to parent room
	-- check north and south sides of the room for parent connector
	for m=0,floor[f].room[i].depth-1 do
		if(floor[f].room[i].tile[0][m].isConnector == true and floor[f].room[i].tile[0][m].direction.south == true and floor[f].room[i].tile[0][m].parentDirection == "south") then 
			if(first==1) then
				first=0
				startConnector = m
			end
		counter=counter+1
		end
		
		if(floor[f].room[i].tile[floor[f].room[i].length-1][m].isConnector == true and floor[f].room[i].tile[floor[f].room[i].length-1][m].direction.north == true and floor[f].room[i].tile[floor[f].room[i].length-1][m].parentDirection == "north") then
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
	end
	
	-- check east and west sides of the room for parent connector
	for m=0,floor[f].room[i].length-1 do
		if(floor[f].room[i].tile[m][0].isConnector == true and floor[f].room[i].tile[m][0].direction.west == true and floor[f].room[i].tile[m][0].parentDirection == "west") then 
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
		
		if(floor[f].room[i].tile[m][floor[f].room[i].depth-1].isConnector == true and floor[f].room[i].tile[m][floor[f].room[i].depth-1].direction.east == true and floor[f].room[i].tile[m][floor[f].room[i].depth-1].parentDirection == "east") then
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
	end
	
	if(floor[f].room[i].parentDirection == "south") then
		offsetX = -100
		offsetY = 0
	elseif(floor[f].room[i].parentDirection == "north") then
		offsetX = -100+(floor[f].room[i].length+1)*xyOffset
		offsetY = 0
	elseif(floor[f].room[i].parentDirection == "west") then
		offsetX = 0
		offsetY = -100
	elseif(floor[f].room[i].parentDirection == "east") then
		offsetX = 0
		offsetY = -100+(floor[f].room[i].depth+1)*xyOffset
	end
	
	m=0
	--spawn connectors along the horizontal axis 
	if(floor[f].room[i].parentDirection == "south" or floor[f].room[i].parentDirection == "north") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			
			--door (no door)
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 300)
			newScale = Vector3.New(2,2,6)
			asset = World.SpawnAsset(propTrigger, {position = newPosition, scale = newScale})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Corridor") --useful data for minimap updates
			
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, (floor[f].room[i].spawnZ+startConnector)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Door1x2")
			
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset+200+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
		
		elseif(counter>=4 and counter <=9) then
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, (floor[f].room[i].spawnZ+startConnector)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door1x4")
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+m)*xyOffset+700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
			
		else -- when size of the room wall is 10 or more
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, (floor[f].room[i].spawnZ+startConnector+m*5)*xyOffset+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = tostring(i)
				asset.parent = assetFolder
				asset:SetNetworkedCustomProperty("doorType", "Door1x4")
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+m)*xyOffset+900)+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorWall 1"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((floor[f].room[i].spawnX)*xyOffset+offsetX, ((floor[f].room[i].spawnZ+startConnector+m)*xyOffset+1700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				assets = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..(m+1)
				asset.parent = assetFolder
			end
		end
	end
	
	--spawn connectors along the vertical axis 
	if(floor[f].room[i].parentDirection == "west" or floor[f].room[i].parentDirection == "east") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			
			--door (no door)
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, 300)
			newScale = Vector3.New(2,2,6)
			asset = World.SpawnAsset(propTrigger, {position = newPosition, scale = newScale})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Corridor")
						
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector)*xyOffset+offsetX, (floor[f].room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door2x1")
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+200+offsetX, ((floor[f].room[i].spawnZ)*xyOffset+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall"
				asset.parent = assetFolder
			end
			
		
		elseif(counter>=4 and counter <=9) then
			--floors
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (floor[f].room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector)*xyOffset+offsetX, (floor[f].room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door4x1")
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+m)*xyOffset+700+offsetX, ((floor[f].room[i].spawnZ)*xyOffset)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..m
				asset.parent = assetFolder
			end
				
			
			
		else -- when size of the room wall is 10 or more
			--floors
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, ((floor[f].room[i].spawnZ)*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, ((floor[f].room[i].spawnZ)*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+m*5)*xyOffset+offsetX, (floor[f].room[i].spawnZ)*xyOffset+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
				asset.name = tostring(i)
				asset.parent = assetFolder
				asset:SetNetworkedCustomProperty("doorType", "Door4x1")
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+m)*xyOffset+900+offsetX, (floor[f].room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorWall 1"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((floor[f].room[i].spawnX+startConnector+m)*xyOffset+1700+offsetX, ((floor[f].room[i].spawnZ)*xyOffset)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..(m+1)
				asset.parent = assetFolder
			end
		end
	end	
end


function PrintLinkedRooms()
	print("*********************************")
	print("*         LINKED ROOMS          *")
	print("*********************************")
	for i=1,floor[f].roomCount do
		local m =0
		while (floor[f].room[i].linkedRoom[m]~=0) do
			print("Room: "..i.." is linked with "..floor[f].room[i].linkedRoom[m])
			m=m+1
		end
		print("Total Links: "..m)
		print()
	end
end

function PlayerCurrentRoom (other)
	local i = 1
	local player = other
	local playerPosition = player:GetWorldPosition()

	while i<=floor[f].roomCount do
		if(playerPosition.x > floor[f].room[i].spawnX*xyOffset and playerPosition.x < (floor[f].room[i].spawnX+floor[f].room[i].length)*xyOffset) then
			if(playerPosition.y > floor[f].room[i].spawnZ*xyOffset and playerPosition.y < (floor[f].room[i].spawnZ+floor[f].room[i].depth)*xyOffset) then
				return i
			end
		end
		i=i+1
	end
	return nil
end



function UpdateActiveRooms (other, currentFloor)
	local g = currentFloor
	local newTask = Task.Spawn(function()
		local i
		local m, n, l, s
		local roomToDestroy, connectorToDestroy
		for i=1,floor[g].roomCount do
			if(floor[g].room[i].active == true) then
				floor[g].room[i].active = false
			end
			if(floor[g].room[i].activeConnector == true) then
				floor[g].room[i].activeConnector = false
			end
		end
		i = PlayerCurrentRoom(other)
		floor[g].room[i].active = true
		print("entered Room: "..i)
		m=0
		while (floor[g].room[i].linkedRoom[m]~=0) do
			l = floor[g].room[i].linkedRoom[m]
			if(floor[g].room[l].active == false) then
				floor[g].room[l].active = true
			else
				SpawnRoom(l)
			end
			m=m+1
		end
		
		m=0
		while (floor[g].room[i].linkedRoom[m]~=0) do
			l = floor[g].room[i].linkedRoom[m]
			if(floor[g].room[l].activeConnector == false) then
				floor[g].room[l].activeConnector = true
			else
				if( Object.IsValid(World.FindObjectByName("Connector "..i)) == false ) then 
					SpawnConnector(l) 
				end
			end
			
			n=0
			while (floor[g].room[l].linkedRoom[n]~=0) do
				s = floor[g].room[l].linkedRoom[n]
				if(floor[g].room[s].activeConnector == false) then
					floor[g].room[s].activeConnector = true
				else
					if( Object.IsValid(World.FindObjectByName("Connector "..i)) == false ) then 
						SpawnConnector(s) 
					end
					--if(not World.FindObjectByName("Room "..s.." ParentConnector")) then SpawnConnector(s) end
				end
				n=n+1
			end
			m=m+1
		end
		
		--destroy inactive rooms
		for i=1,floor[g].roomCount do
			if(floor[g].room[i].active == false) then
				floor[g].room[i].active = nil
				roomToDestroy = World.FindObjectByName("Room "..i)
				roomToDestroy:Destroy()
			end
		end
		
		--destroy inactive connectors
		for i=1,floor[g].roomCount do
			if(floor[g].room[i].activeConnector == false) then
				floor[g].room[i].activeConnector = nil
				connectorToDestroy = World.FindObjectByName("Connector "..i)
				connectorToDestroy:Destroy()
			end
		end
	end)
end

function SpawnLevel(levelToSpawn)
	floor = script.parent.parent.serverUserData.floor
	f = levelToSpawn
	PrintLinkedRooms()
	print()
	print("*********************************")
	print("*       SPAWNING "..floor[f].roomCount.." rooms       *")
	print("*********************************")
	for i=1,3 do
		SpawnRoom(i)
		Task.Wait()
	end
	SpawnConnector(2)
	SpawnConnector(3)
end


Task.Wait(0.5)
--BROADCAST LISTENERS----------------------------------
Events.Connect("SpawnLevel", SpawnLevel)
Events.Connect("UpdateActiveRooms", UpdateActiveRooms)
-------------------------------------------------------





