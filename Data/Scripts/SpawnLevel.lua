
local propFloor01 = script:GetCustomProperty("Floor01")
local propDoor2x1 = script:GetCustomProperty("Door2x1")
local propDoor4x1 = script:GetCustomProperty("Door4x1")
local propWall01 = script:GetCustomProperty("Wall01")
local propCorner01 = script:GetCustomProperty("Corner01")
local propNewFolder = script:GetCustomProperty("NewFolder")
local propTriggerRoom = script:GetCustomProperty("TriggerRoom")
local propFloorFolder = script:GetCustomProperty("FloorFolder")
local propTrigger = script:GetCustomProperty("Trigger")
local propElevator = script:GetCustomProperty("Elevator")

local i, roomCount, room, finalRoom
local player = World.FindObjectByName("player")

local xyOffset = script.parent.parent:GetCustomProperty("xyOffset")


function SpawnRoom(i)

	room[i].active = true
	local newPosition, newScale, newRotation
	local startX = 0
	local startZ = 0
	local asset, floorFolder
	
	floorFolder = World.FindObjectByName("Room "..i)
	if(floorFolder == nil) then
		floorFolder = World.SpawnAsset(propNewFolder)
		floorFolder.name = "Room "..i
		floorFolder.parent = script.parent
	end
		
	--spawn the room floor with size x,y
	newPosition = Vector3.New(room[i].spawnX*xyOffset+(room[i].length*100), (room[i].spawnZ*xyOffset)+(room[i].depth*100), -25)
	newScale = Vector3.New(room[i].length*2, room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "RoomFloor "..i
	asset.parent = World.FindObjectByName("Room "..i)
	
	--trigger for room spawning and despawning
	newPosition = Vector3.New(room[i].spawnX*xyOffset+(room[i].length*100), (room[i].spawnZ*xyOffset)+(room[i].depth*100), 300)
	newScale = Vector3.New(room[i].length*2-1, room[i].depth*2-1, 6)
	asset = World.SpawnAsset(propTriggerRoom, {position = newPosition, scale = newScale})
	asset.name = tostring(i)
	asset.parent = floorFolder
	
	--spawn room ceiling x,y
	newPosition = Vector3.New(room[i].spawnX*xyOffset+(room[i].length*100), (room[i].spawnZ*xyOffset)+(room[i].depth*100), 625)
	newScale = Vector3.New(room[i].length*2, room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "Ceiling "..i
	asset.parent = World.FindObjectByName("Room "..i)
	
	--spawn walls on all rooms (except on connector tiles)
	local counter = 0
	local first = 1 -- will count the first tile that connects
	local startConnector =0
	local offset = 0
	
	-- spawn the walls in the [-1,0] south side of the room
	for m=0,room[i].depth-1 do
		if(room[i].tile[0][m].isConnector == true and room[i].tile[0][m].direction.south == true and room[i].tile[0][m].parentDirection == "south") then 
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(room[i].tile[0][m].isConnector == true and room[i].tile[0][m].direction.south == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,0)
			startX = -50
			startZ = 100
			if(room[i].tile[0][m].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+startX,(room[i].spawnZ+m)*xyOffset+startZ+offset,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+startX,(room[i].spawnZ+m)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallSouth "..m
			asset.parent = World.FindObjectByName("Room "..i)
		end
	end

	
	
	-- spawn the walls in the [1,0] north side of the room
	for m=0,room[i].depth-1 do
		if(room[i].tile[room[i].length-1][m].isConnector == true and room[i].tile[room[i].length-1][m].direction.north == true and room[i].tile[room[i].length-1][m].parentDirection == "north") then
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(room[i].tile[room[i].length-1][m].isConnector == true and room[i].tile[room[i].length-1][m].direction.north == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,0)
			startX = 250
			startZ = 100
			if(room[i].tile[room[i].length-1][m].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((room[i].spawnX+room[i].length-1)*xyOffset+startX,(room[i].spawnZ+m)*xyOffset+startZ+offset,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((room[i].spawnX+room[i].length-1)*xyOffset+startX,(room[i].spawnZ+m)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallNorth "..m
			asset.parent = World.FindObjectByName("Room "..i)
		end
	end

	
	
	-- spawn the walls in the [0,1] east side of the room
	for m=0,room[i].length-1 do
		if(room[i].tile[m][0].isConnector == true and room[i].tile[m][0].direction.west == true and room[i].tile[m][0].parentDirection == "west") then 
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(room[i].tile[m][0].isConnector == true and room[i].tile[m][0].direction.west == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,90)
			startX = 100
			startZ = -50
			if(room[i].tile[m][0].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((room[i].spawnX+m)*xyOffset+startX+offset,(room[i].spawnZ)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((room[i].spawnX+m)*xyOffset+startX,(room[i].spawnZ)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallEast "..m
			asset.parent = World.FindObjectByName("Room "..i)
			
		end
	end

	
	-- spawn the walls in the [0,-1] west side of the room
	for m=0,room[i].length-1 do
		if(room[i].tile[m][room[i].depth-1].isConnector == true and room[i].tile[m][room[i].depth-1].direction.east == true and room[i].tile[m][room[i].depth-1].parentDirection == "east") then
			--[[if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1]]
		elseif(room[i].tile[m][room[i].depth-1].isConnector == true and room[i].tile[m][room[i].depth-1].direction.east == true) then
			--do nothing (do not spawn a wall)
		else
			newRotation = Rotation.New(0,0,90)
			startX = 100
			startZ = 250
			if(room[i].tile[m][room[i].depth-1].type == "corner") then
				if(m==0) then offset = -75 else offset = 75 end
				newPosition = Vector3.New((room[i].spawnX+m)*xyOffset+startX+offset,(room[i].spawnZ+room[i].depth-1)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1.6,1)
			else
				newPosition = Vector3.New((room[i].spawnX+m)*xyOffset+startX,(room[i].spawnZ+room[i].depth-1)*xyOffset+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallWest "..m
			asset.parent = World.FindObjectByName("Room "..i)
		end
	end
end	





function SpawnConnector(i)
--depending on the size of the connection, will spawn different doors/connectors	
	room[i].activeConnector = true
	
	local m, asset,assetFolder,connectorFolder
	local offsetX = 0
	local offsetY = 0

	connectorFolder = World.FindObjectByName("Connectors")
	if(connectorFolder == nil) then
		connectorFolder = World.SpawnAsset(propNewFolder)
		connectorFolder.name = "Connectors"
		connectorFolder.parent = script.parent
	end
	
	assetFolder = World.FindObjectByName("Room "..i.." ParentConnector")
	if(assetFolder == nil) then
		assetFolder =  World.SpawnAsset(propNewFolder)
		assetFolder.name = "Room "..i.." ParentConnector"
		assetFolder.parent = connectorFolder
	end

	local counter = 0
	local first = 1 -- will count the first tile that connects
	local startConnector =0
	
	-- each new room has 1 parent only. will check the direction of parent room and spawn only 1 connector to parent room
	-- check north and south sides of the room for parent connector
	for m=0,room[i].depth-1 do
		if(room[i].tile[0][m].isConnector == true and room[i].tile[0][m].direction.south == true and room[i].tile[0][m].parentDirection == "south") then 
			if(first==1) then
				first=0
				startConnector = m
			end
		counter=counter+1
		end
		
		if(room[i].tile[room[i].length-1][m].isConnector == true and room[i].tile[room[i].length-1][m].direction.north == true and room[i].tile[room[i].length-1][m].parentDirection == "north") then
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
	end
	
	-- check east and west sides of the room for parent connector
	for m=0,room[i].length-1 do
		if(room[i].tile[m][0].isConnector == true and room[i].tile[m][0].direction.west == true and room[i].tile[m][0].parentDirection == "west") then 
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
		
		if(room[i].tile[m][room[i].depth-1].isConnector == true and room[i].tile[m][room[i].depth-1].direction.east == true and room[i].tile[m][room[i].depth-1].parentDirection == "east") then
			if(first==1) then
				first=0
				startConnector = m
			end
			counter=counter+1
		end
	end
	
	if(room[i].parentDirection == "south") then
		offsetX = -100
		offsetY = 0
	elseif(room[i].parentDirection == "north") then
		offsetX = -100+(room[i].length+1)*xyOffset
		offsetY = 0
	elseif(room[i].parentDirection == "west") then
		offsetX = 0
		offsetY = -100
	elseif(room[i].parentDirection == "east") then
		offsetX = 0
		offsetY = -100+(room[i].depth+1)*xyOffset
	end
	
	m=0
	--spawn connectors along the horizontal axis 
	if(room[i].parentDirection == "south" or room[i].parentDirection == "north") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
			--ceiling
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			
			--door (no door)
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 300)
			newScale = Vector3.New(2,2,6)
			asset = World.SpawnAsset(propTrigger, {position = newPosition, scale = newScale})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Corridor")
			
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, (room[i].spawnZ+startConnector)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Door1x2")
			
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset+200+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
		
		elseif(counter>=4 and counter <=9) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, (room[i].spawnZ+startConnector)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door1x4")
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+m)*xyOffset+700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
			
		else -- when size of the room wall is 10 or more
			--floor
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, (room[i].spawnZ+startConnector+m*5)*xyOffset+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = tostring(i)
				asset.parent = assetFolder
				asset:SetNetworkedCustomProperty("doorType", "Door1x4")
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+m)*xyOffset+900)+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorWall 1"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((room[i].spawnX)*xyOffset+offsetX, ((room[i].spawnZ+startConnector+m)*xyOffset+1700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				assets = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..(m+1)
				asset.parent = assetFolder
			end
		end
	end
	
	--spawn connectors along the vertical axis 
	if(room[i].parentDirection == "west" or room[i].parentDirection == "east") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
			--ceiling
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			
			--door (no door)
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, 300)
			newScale = Vector3.New(2,2,6)
			asset = World.SpawnAsset(propTrigger, {position = newPosition, scale = newScale})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType","Corridor")
						
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX+startConnector)*xyOffset+offsetX, (room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door2x1")
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+200+offsetX, ((room[i].spawnZ)*xyOffset+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall"
				asset.parent = assetFolder
			end
			
		
		elseif(counter>=4 and counter <=9) then
			--floors
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, (room[i].spawnZ*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX+startConnector)*xyOffset+offsetX, (room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = tostring(i)
			asset.parent = assetFolder
			asset:SetNetworkedCustomProperty("doorType", "Door4x1")
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((room[i].spawnX+startConnector+m)*xyOffset+700+offsetX, ((room[i].spawnZ)*xyOffset)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..m
				asset.parent = assetFolder
			end
				
			
			
		else -- when size of the room wall is 10 or more
			--floors
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, ((room[i].spawnZ)*xyOffset)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--ceiling
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*xyOffset+offsetX, ((room[i].spawnZ)*xyOffset)+offsetY, 625)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorCeiling"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((room[i].spawnX+startConnector+m*5)*xyOffset+offsetX, (room[i].spawnZ)*xyOffset+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
				asset.name = tostring(i)
				asset.parent = assetFolder
				asset:SetNetworkedCustomProperty("doorType", "Door4x1")
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((room[i].spawnX+startConnector+m)*xyOffset+900+offsetX, (room[i].spawnZ)*xyOffset+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorWall 1"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((room[i].spawnX+startConnector+m)*xyOffset+1700+offsetX, ((room[i].spawnZ)*xyOffset)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..(m+1)
				asset.parent = assetFolder
			end
		end
	end
	
	--spawn First Room Elevator
	if(i==1) then
		newPosition = Vector3.New((room[i].spawnX+room[i].length/2)*xyOffset, (room[i].spawnZ+room[i].depth/2)*xyOffset, 0)
		newScale = Vector3.New(1,1,1)
		newRotation = Rotation.New(0,0,0)
		asset = World.SpawnAsset(propElevator, {position = newPosition, scale = newScale, rotation = newRotation})
		asset.name = "FirstRoom Elevator"
		asset.parent = assetFolder
	end
	
	--spawn Final Room Elevator
	if(i==finalRoom) then
		newPosition = Vector3.New((room[i].spawnX+room[i].length/2)*xyOffset, (room[i].spawnZ+room[i].depth/2)*xyOffset, 0)
		newScale = Vector3.New(1,1,1)
		if(room[i].parentDirection == "north") then
			newRotation = Rotation.New(0,0,0)
		elseif(room[i].parentDirection == "south") then
			newRotation = Rotation.New(0,0,180)
		elseif(room[i].parentDirection == "east") then
			newRotation = Rotation.New(0,0,90)
		elseif(room[i].parentDirection == "west") then
			newRotation = Rotation.New(0,0,270)
		end
		asset = World.SpawnAsset(propElevator, {position = newPosition, scale = newScale, rotation = newRotation})
		asset.name = "FinalRoom Elevator"
		asset.parent = assetFolder
	end
	
end


function PrintLinkedRooms()
	print("*********************************")
	print("*         LINKED ROOMS          *")
	print("*********************************")
	roomCount = script.parent.parent.serverUserData.roomCount
	print(roomCount)
	for i=1,roomCount do
		local m =0
		while (room[i].linkedRoom[m]~=0) do
			print("Room: "..i.." is linked with "..room[i].linkedRoom[m])
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

	while i<=roomCount do
		if(playerPosition.x > room[i].spawnX*xyOffset and playerPosition.x < (room[i].spawnX+room[i].length)*xyOffset) then
			if(playerPosition.y > room[i].spawnZ*xyOffset and playerPosition.y < (room[i].spawnZ+room[i].depth)*xyOffset) then
				return i
			end
		end
		i=i+1
	end
	return nil
end



function UpdateActiveRooms (other)
	local newTask = Task.Spawn(function()
		local i
		local m, n, l, s
		local floorToDestroy, connectorToDestroy
		for i=1,roomCount do
			if(room[i].active == true) then
				room[i].active = false
			end
			if(room[i].activeConnector == true) then
				room[i].activeConnector = false
			end
		end
		i = PlayerCurrentRoom(other)
		room[i].active = true
		print("entered Room: "..i)
		m=0
		while (room[i].linkedRoom[m]~=0) do
			l = room[i].linkedRoom[m]
			if(room[l].active == false) then
				room[l].active = true
			else
				SpawnRoom(l,World.FindObjectByName("FloorAssets"))
			end
			m=m+1
		end
		
		m=0
		while (room[i].linkedRoom[m]~=0) do
			l = room[i].linkedRoom[m]
			if(room[l].activeConnector == false) then
				room[l].activeConnector = true
			else
				if(not World.FindObjectByName("Room "..l.." ParentConnector")) then SpawnConnector(l) end
			end
			
			n=0
			while (room[l].linkedRoom[n]~=0) do
				s = room[l].linkedRoom[n]
				if(room[s].activeConnector == false) then
					room[s].activeConnector = true
				else
					if(not World.FindObjectByName("Room "..s.." ParentConnector")) then SpawnConnector(s) end
				end
				n=n+1
			end
			m=m+1
		end
		
		--destroy inactive rooms
		for i=1,roomCount do
			if(room[i].active == false) then
				room[i].active = nil
				floorToDestroy = World.FindObjectByName("Room "..i)
				floorToDestroy:Destroy()
			end
		end
		
		--destroy inactive connectors
		for i=1,roomCount do
			if(room[i].activeConnector == false) then
				room[i].activeConnector = nil
				connectorToDestroy = World.FindObjectByName("Room "..i.." ParentConnector")
				connectorToDestroy:Destroy()
			end
		end
	end)
end

function SpawnLevel()
	room = script.parent.parent.serverUserData.room
	roomCount = script.parent.parent.serverUserData.roomCount
	finalRoom = script.parent.parent.serverUserData.finalRoom
	PrintLinkedRooms()
	print()
	print("*********************************")
	print("*       SPAWNING "..roomCount.." rooms       *")
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





