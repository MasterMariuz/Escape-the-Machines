-- declare the Randomizing Seed. uses os.time() for local testing. should use time() when testing on server
timeSeed = os.time()
print("TimeSeed: " .. timeSeed)
rand = RandomStream.New(timeSeed)
room = {}
xyOffset = 200
roomCount = 0

--variables to tweak the floor creation
extraRooms = 15
mainRooms = 35
minRoomLength = 1	
maxRoomLength = 12
minFinalRoomLength = 9 
maxFinalRoomLength = 15

propNewFolder = script:GetCustomProperty("NewFolder")

propFloor01 = script:GetCustomProperty("Floor01")
propWall01 = script:GetCustomProperty("Wall01")
propDoor2x1 = script:GetCustomProperty("Door2x1")
propDoor4x1 = script:GetCustomProperty("Door4x1")
propCorner01 = script:GetCustomProperty("Corner01")
propTrigger = script:GetCustomProperty("Trigger")


function initiateTiles (i, newLength, newDepth)
	local tx,tz
	for tx=0,newLength-1 do
		room[i].tile[tx] = {}
		for tz=0,newDepth-1 do
			if((tz==0 and tx==0) or (tz==0 and tx==newLength-1) or (tz==newDepth-1 and tx==0) or (tz==newDepth-1 and tx==newLength-1)) then
				room[i].tile[tx][tz] = {type = "corner"}
			else 
				room[i].tile[tx][tz] = {type = "floor"}
			end
		room[i].tile[tx][tz].direction = {north = false, south = false, east = false, west = false}
		end
	end	
end


function initializeRoom (i)
	local m 
	room[i] = {length = 0, depth = 0, spawnX = 0, spawnZ = 0, tile = {} , linkedRoom = {}, spawnParentConnector = false, active, activeConnector}
	--max linked rooms limit
	for m=0,20 do
		room[i].linkedRoom[m]=0
	end
end


function GenerateLevel() -- Executes the calculations for the values of the new floor

	-- declare initial randomized values that will build the entire floor
	local timer = 0;
	--spawn initial Room
	initializeRoom(1)
	room[1].length = rand:GetInteger(4,12)
	room[1].depth = rand:GetInteger(4,12)
	room[1].spawnX = 0
	room[1].spawnZ = 0
	initiateTiles (1,room[1].length,room[1].depth)
	roomCount = 1

	--create main route until all room blocks have been used up
	for m=0, mainRooms do
		CreateRoom("mainRoute")
	end
	
	--create final room
	CreateRoom("finalRoom")
	
	--main route has been created. Now, we'll create alternate routes
	for m=0, extraRooms do
		CreateRoom("extraRoom")
	end
	SpawnLevel()
	
	
end --ends the function





function CreateRoom(type)
	
	Task.Wait()
	roomCount = roomCount + 1
	local i = roomCount
	initializeRoom(i)
	local spawnX = 0 
	local spawnZ = 0
	local newConnectorX = 0
	local newConnectorZ = 0
	local kConnectorX = 0
	local kConnectorZ = 0
	local counter = 0
	local kRoomXmin, kRoomXmax, newRoomXmin, newRoomXmax, kRoomZmin, kRoomZmax, newRoomZmin, newRoomZmax 
	local minX, maxX, minZ, maxZ, newLength, newDepth, randomDirection, o, p, k
	local roomPositionValidation = false --if true, location has been confirmed to be valid and does not intersect with existing rooms	
	
	repeat 
		repeat
			if(type=="finalRoom") then
				newLength = rand:GetInteger(minFinalRoomLength,maxFinalRoomLength)
				newDepth = rand:GetInteger(minFinalRoomLength,maxFinalRoomLength)
			else
				newLength = rand:GetInteger(minRoomLength,maxRoomLength)
				newDepth = rand:GetInteger(minRoomLength,maxRoomLength)
			end
		until(newLength * newDepth >= 6)
		initiateTiles (i,newLength,newDepth)
			-- randomDirection: 1 = north, 2 = south, 3 = east, 4 = west
			randomDirection = rand:GetInteger(1,4) -- will find a direction to spawn a new room relative to the first room i
			counter = counter + 1
			
		if(type=="mainRoute" or type=="finalRoom") then
			k = i - 1 - math.floor(counter / 4) -- will check x loops before moving to a previous room (default:20)
		elseif(type=="extraRoom") then
			k = rand:GetInteger(2,roomCount-1)
		end

		if(randomDirection == 1) then -- spawn on direction [1,0]
			spawnX = room[k].spawnX + room[k].length +1
			minZ = room[k].spawnZ - newDepth +1
			maxZ = room[k].spawnZ + room[k].depth -2
			spawnZ = rand:GetInteger(minZ,maxZ)
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			if(roomPositionValidation == true) then
				for o=0,newDepth-1 do
					for p=0,room[k].depth-1 do
						if(spawnZ+o == room[k].spawnZ+p) then
							--print("room[i].spawnZ:"..room[i].spawnZ.." o:"..o.. " room[k].spawnZ:"..room[k].spawnZ.." p:"..p)
							room[i].parentRoomNumber = k
							room[i].tile[0][o].isConnector = true
							room[k].tile[room[k].length-1][p].isConnector = true
							room[i].parentDirection = "south"
							room[i].tile[0][o].parentDirection = "south"
							room[i].tile[0][o].direction.south = true
							room[k].tile[room[k].length-1][p].direction.north = true
						end
					end
				end
			end

		elseif(randomDirection == 2) then -- spawn on direction [-1,0]
			spawnX = room[k].spawnX - newLength -1
			minZ = room[k].spawnZ - newDepth + 1
			maxZ = room[k].spawnZ + room[k].depth -2
			spawnZ = rand:GetInteger(minZ,maxZ) 
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newDepth-1 do
					for p=0,room[k].depth-1 do
						if(spawnZ+o == room[k].spawnZ+p) then
							--print("room[i].spawnZ:"..room[i].spawnZ.." o:"..o.. " room[k].spawnZ:"..room[k].spawnZ.." p:"..p)
							room[i].parentRoomNumber = k
							room[i].tile[newLength-1][o].isConnector = true
							room[k].tile[0][p].isConnector = true
							room[i].parentDirection = "north"
							room[i].tile[newLength-1][o].parentDirection = "north"
							room[i].tile[newLength-1][o].direction.north = true
							room[k].tile[0][p].direction.south = true
						end
					end
				end
			end
			
		elseif(randomDirection == 3) then -- spawn on direction [0,1]
			minX = room[k].spawnX - (newLength) +1
			maxX = room[k].spawnX + room[k].length -2
			spawnX = rand:GetInteger(minX, maxX)
			spawnZ = room[k].spawnZ + room[k].depth +1
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newLength-1 do
					for p=0,room[k].length-1 do
						if(spawnX+o == room[k].spawnX+p) then
							--print("room[i].spawnZ:"..room[i].spawnZ.." o:"..o.. " room[k].spawnZ:"..room[k].spawnZ.." p:"..p)
							room[i].parentRoomNumber = k
							room[i].tile[o][0].isConnector = true
							room[k].tile[p][room[k].depth-1].isConnector = true
							room[i].parentDirection = "west"
							room[i].tile[o][0].parentDirection = "west"
							room[i].tile[o][0].direction.west = true
							room[k].tile[p][room[k].depth-1].direction.east = true
						end
					end
				end
			end
			
		else -- spawn on direction [0,-1]
			minX = room[k].spawnX - (newLength) + 1
			maxX = room[k].spawnX + room[k].length -2
			spawnX = rand:GetInteger(minX, maxX)
			spawnZ = room[k].spawnZ - newDepth -1
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newLength-1 do
					for p=0,room[k].length-1 do
						if(spawnX+o == room[k].spawnX+p) then
							--print("room[i].spawnZ:"..room[i].spawnZ.." o:"..o.. " room[k].spawnZ:"..room[k].spawnZ.." p:"..p)
							room[i].parentRoomNumber = k
							room[i].tile[o][newDepth-1].isConnector = true
							room[k].tile[p][0].isConnector = true
							room[i].parentDirection = "east"
							room[i].tile[o][newDepth-1].parentDirection = "east"
							room[i].tile[o][newDepth-1].direction.east = true
							room[k].tile[p][0].direction.west = true
						end
					end
				end
			end
		end --ends switch of 4 options
	until (roomPositionValidation == true) -- will check if the room does not overlap another room and loop until it finds a valid XZ place to spawn
	-- save the values for the current room i on our rooms array				
	room[i].length = newLength
	room[i].depth = newDepth
	room[i].spawnX = spawnX
	room[i].spawnZ = spawnZ
	AddLinkedRoom(i,k)
	print("created Room [" .. i .. "] on [" .. room[i].spawnX .. "," .. room[i].spawnZ .. "] dimensions X: " .. room[i].length.. " Y:" .. room[i].depth)
	print()
end


function AddLinkedRoom(i,k)
	local m=0
	while (room[i].linkedRoom[m]~=0) do
		m = m+1
	end
	room[i].linkedRoom[m] = k

	m=0
	while (room[k].linkedRoom[m]~=0) do
		m = m+1
	end
	room[k].linkedRoom[m] = i
end


-- checks if the room i intersects with every room previously created
function CheckRoomIntersect (i,spawnX,spawnZ,newLength,newDepth) 
	Task.Wait()
	local xMin, xMax, zMin, zMax, a, x, z
	a = 1
	repeat
		xMin = room[a].spawnX -1
		xMax = room[a].spawnX + room[a].length-1 +1
		zMin = room[a].spawnZ -1
		zMax = room[a].spawnZ + room[a].depth-1 +1
		
		x = 0
		repeat
			if (spawnX + x >= xMin and spawnX + x <= xMax) then
				z = 0
				repeat
					if(spawnZ + z >= zMin and spawnZ + z <= zMax) then
						print()
						print("a:"..a.." x:"..x.." z:"..z.." i:"..i.." room[i]spawnZ:"..spawnZ.." zMin:"..zMin.." zMax:"..zMax.." newLength:"..newLength.." newDepth:"..newDepth)
						print("INTERSECTS WITH EXISTING ROOM")
						return false
					end
					z = z + 1
				until (z == newDepth)
			end
							
			x = x + 1
		until (x == newLength)
		
		a = a + 1
	until (a == i)
	return true
end

--spawn all the floor tiles on the level
function SpawnLevel()
	--[[for i=1,roomCount do
		SpawnRoom(i)
	end]]
	World.FindObjectByName("initialPlatform"):Destroy()
	SpawnRoom(1)
	SpawnConnector(1)
	
	
	
end

function SpawnRoom(i)

	room[i].active = true
	local newPosition, newScale, newRotation
	local startX = 0
	local startZ = 0
	local asset, floorFolder
	
	floorFolder = World.FindObjectByName("Floor "..i)
	if(floorFolder == nil) then
		floorFolder = World.SpawnAsset(propNewFolder)
		floorFolder.name = "Floor "..i
		floorFolder.parent = World.FindObjectByName("FloorAssets")
	end
		
	--spawn the room floor with size x,y
	newPosition = Vector3.New(room[i].spawnX*200+(room[i].length*100), (room[i].spawnZ*200)+(room[i].depth*100), -25)
	newScale = Vector3.New(room[i].length*2, room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "RoomFloor "..i
	asset.parent = World.FindObjectByName("Floor "..i)
	
	--trigger for room spawning and despawning update
	newPosition = Vector3.New(room[i].spawnX*200+(room[i].length*100), (room[i].spawnZ*200)+(room[i].depth*100), 300)
	newScale = Vector3.New(room[i].length*2-1, room[i].depth*2-1, 6)
	asset = World.SpawnAsset(propTrigger, {position = newPosition, scale = newScale})
	asset.name = "Trigger "..i
	asset.parent = floorFolder
	
	--[[spawn room ceiling x,y
	newPosition = Vector3.New(room[i].spawnX*200+(room[i].length*100), (room[i].spawnZ*200)+(room[i].depth*100), 625)
	newScale = Vector3.New(room[i].length*2, room[i].depth*2, 0.5)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
	asset.name = "Ceiling "..i
	asset.parent = World.FindObjectByName("Floor "..i)]]
	
	
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
				if(m==0) then offset = -50 else offset = 50 end
				newPosition = Vector3.New((room[i].spawnX)*200+startX,(room[i].spawnZ+m)*200+startZ+offset,0)
				newScale = Vector3.New(1,1.4,1)
			else
				newPosition = Vector3.New((room[i].spawnX)*200+startX,(room[i].spawnZ+m)*200+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallSouth "..m
			asset.parent = World.FindObjectByName("Floor "..i)
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
				if(m==0) then offset = -50 else offset = 50 end
				newPosition = Vector3.New((room[i].spawnX+room[i].length-1)*200+startX,(room[i].spawnZ+m)*200+startZ+offset,0)
				newScale = Vector3.New(1,1.4,1)
			else
				newPosition = Vector3.New((room[i].spawnX+room[i].length-1)*200+startX,(room[i].spawnZ+m)*200+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallNorth "..m
			asset.parent = World.FindObjectByName("Floor "..i)
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
				if(m==0) then offset = -50 else offset = 50 end
				newPosition = Vector3.New((room[i].spawnX+m)*200+startX+offset,(room[i].spawnZ)*200+startZ,0)
				newScale = Vector3.New(1,1.4,1)
			else
				newPosition = Vector3.New((room[i].spawnX+m)*200+startX,(room[i].spawnZ)*200+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallEast "..m
			asset.parent = World.FindObjectByName("Floor "..i)
			
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
				if(m==0) then offset = -50 else offset = 50 end
				newPosition = Vector3.New((room[i].spawnX+m)*200+startX+offset,(room[i].spawnZ+room[i].depth-1)*200+startZ,0)
				newScale = Vector3.New(1,1.4,1)
			else
				newPosition = Vector3.New((room[i].spawnX+m)*200+startX,(room[i].spawnZ+room[i].depth-1)*200+startZ,0)
				newScale = Vector3.New(1,1,1)
			end
			asset = World.SpawnAsset(propWall01, {position = newPosition, rotation = newRotation, scale = newScale})
			asset.name = "WallWest "..m
			asset.parent = World.FindObjectByName("Floor "..i)
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
		connectorFolder.parent = World.FindObjectByName("FloorAssets")
	end
	
	assetFolder = World.FindObjectByName("Floor "..i.." ParentConnector")
	if(assetFolder == nil) then
		assetFolder =  World.SpawnAsset(propNewFolder)
		assetFolder.name = "Floor "..i.." ParentConnector"
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
		offsetX = -100+(room[i].length+1)*200
		offsetY = 0
	elseif(room[i].parentDirection == "west") then
		offsetX = 0
		offsetY = -100
	elseif(room[i].parentDirection == "east") then
		offsetX = 0
		offsetY = -100+(room[i].depth+1)*200
	end
	
	m=0
	--spawn connectors along the horizontal axis 
	if(room[i].parentDirection == "south" or room[i].parentDirection == "north") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*200)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*200)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, (room[i].spawnZ+startConnector)*200+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorDoor"
			asset.parent = assetFolder
			
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*200+200+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
		
		elseif(counter>=4 and counter <=9) then
			--floor
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*200)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, (room[i].spawnZ+startConnector)*200+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = "ConnectorDoor"
			asset.parent = assetFolder
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+m)*200+700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..i
				asset.parent = assetFolder
			end
			
		else -- when size of the room wall is 10 or more
			--floor
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+(counter/2))*200)+offsetY, -25)
			newScale = Vector3.New(2,2*counter,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((room[i].spawnX)*200+offsetX, (room[i].spawnZ+startConnector+m*5)*200+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorDoor "..(m+1)
				asset.parent = assetFolder
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+m)*200+900)+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((room[i].spawnX)*200+offsetX, ((room[i].spawnZ+startConnector+m)*200+1700)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,0)
				assets = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorDoor "..(m+1)
				asset.parent = assetFolder
			end
		end
	end
	
	--spawn connectors along the vertical axis 
	if(room[i].parentDirection == "west" or room[i].parentDirection == "east") then 

		if(counter==1) then
			--floor
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*200+offsetX, (room[i].spawnZ*200)+offsetY, -25)
			newScale = Vector3.New(2,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			
		elseif(counter>=2 and counter<=3) then
			--floor
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*200+offsetX, (room[i].spawnZ*200)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX+startConnector)*200+offsetX, (room[i].spawnZ)*200+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor2x1, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorDoor"
			asset.parent = assetFolder
			--walls
			if(counter > 2) then
				newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*200+200+offsetX, ((room[i].spawnZ)*200+offsetY), 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall"
				asset.parent = assetFolder
			end
			
		
		elseif(counter>=4 and counter <=9) then
			--floors
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*200+offsetX, (room[i].spawnZ*200)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors
			newPosition = Vector3.New((room[i].spawnX+startConnector)*200+offsetX, (room[i].spawnZ)*200+offsetY, 0)
			newScale = Vector3.New(1,1,1)
			newRotation = Rotation.New(0,0,0)
			asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
			asset.name = "ConnectorDoor"
			asset.parent = assetFolder
			--walls
			for m=1, counter-4 do -- walls spawn only when counter is 5 or more
				newPosition = Vector3.New((room[i].spawnX+startConnector+m)*200+700+offsetX, ((room[i].spawnZ)*200)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..m
				asset.parent = assetFolder
			end
				
			
			
		else -- when size of the room wall is 10 or more
			--floors
			newPosition = Vector3.New((room[i].spawnX+startConnector+(counter/2))*200+offsetX, ((room[i].spawnZ)*200)+offsetY, -25)
			newScale = Vector3.New(2*counter,2,0.5)
			asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale})	
			asset.name = "ConnectorFloor"
			asset.parent = assetFolder
			--doors	
			for m=0,1 do
				newPosition = Vector3.New((room[i].spawnX+startConnector+m*5)*200+offsetX, (room[i].spawnZ)*200+offsetY, 0)
				newScale = Vector3.New(1,1,1)
				newRotation = Rotation.New(0,0,0)
				asset = World.SpawnAsset(propDoor4x1, {position = newPosition, scale = newScale, rotation = newRotation})	
				asset.name = "ConnectorDoor "..(m+1)
				asset.parent = assetFolder
			end
			--walls
			-- wall between the 2 doors
			newPosition = Vector3.New((room[i].spawnX+startConnector+m)*200+900+offsetX, (room[i].spawnZ)*200+offsetY, 0)
			newScale = Vector3.New(2,1,1)
			newRotation = Rotation.New(0,0,90)
			asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
			asset.name = "ConnectorWall"
			asset.parent = assetFolder
			-- walls after the 2nd door
			for m=1, counter-9 do -- walls spawn only when counter is 10 or more
				newPosition = Vector3.New((room[i].spawnX+startConnector+m)*200+1700+offsetX, ((room[i].spawnZ)*200)+offsetY, 0)
				newScale = Vector3.New(2,1,1)
				newRotation = Rotation.New(0,0,90)
				asset = World.SpawnAsset(propWall01, {position = newPosition, scale = newScale, rotation = newRotation})
				asset.name = "ConnectorWall "..m
				asset.parent = assetFolder
			end
		end
	end
end

function PrintLinkedRooms()
	for i=1,roomCount do
		local m =0
		while (room[i].linkedRoom[m]~=0) do
			print("Room: "..i.." is linked with "..room[i].linkedRoom[m])
			m=m+1
		end
		print("Total Links: "..m)
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
	
	m=0
	while (room[i].linkedRoom[m]~=0) do
		l = room[i].linkedRoom[m]
		if(room[l].active == false) then
			room[l].active = true
		else
			SpawnRoom(l)
		end
		m=m+1
	end
	
	m=0
	while (room[i].linkedRoom[m]~=0) do
		l = room[i].linkedRoom[m]
		if(room[l].activeConnector == false) then
			room[l].activeConnector = true
		else
			if(not World.FindObjectByName("Floor "..l.." ParentConnector")) then SpawnConnector(l) end
		end
		
		n=0
		while (room[l].linkedRoom[n]~=0) do
			s = room[l].linkedRoom[n]
			if(room[s].activeConnector == false) then
				room[s].activeConnector = true
			else
				if(not World.FindObjectByName("Floor "..s.." ParentConnector")) then SpawnConnector(s) end
			end
			n=n+1
		end
		m=m+1
	end
	
	--destroy inactive rooms
	for i=1,roomCount do
		if(room[i].active == false) then
			room[i].active = nil
			floorToDestroy = World.FindObjectByName("Floor "..i)
			floorToDestroy:Destroy()
		end
	end
	
	--destroy inactive connectors
	for i=1,roomCount do
		if(room[i].activeConnector == false) then
			room[i].activeConnector = nil
			connectorToDestroy = World.FindObjectByName("Floor "..i.." ParentConnector")
			connectorToDestroy:Destroy()
		end
	end
end


function test()
	for i=1,1 do
		print("enter")
	end
end

function SpawnInitialPlatform()
	newPosition = Vector3.New(200,200,700)
	newScale = Vector3.New(4,4,.5)
	newRotation = Rotation.New(0,0,0)
	asset = World.SpawnAsset(propFloor01, {position = newPosition, scale = newScale, rotation = newRotation})
	asset.name = "initialPlatform"
	asset.parent = World.FindObjectByName("FloorAssets")
end



SpawnInitialPlatform()
GenerateLevel()
PrintLinkedRooms()
Events.Connect("UpdateActiveRooms", UpdateActiveRooms)
test()














