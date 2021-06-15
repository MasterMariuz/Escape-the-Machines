-- declare the Randomizing Seed. uses os.time() for local testing. should use time() when testing on server
timeSeed = os.time()
print("TimeSeed: " .. timeSeed)
rand = RandomStream.New(timeSeed)
floor = {}

local xyOffset = script.parent.parent:GetCustomProperty("xyOffset")

--variables to tweak the floor creation
mainRooms = script.parent.parent:GetCustomProperty("mainRooms")
rateExtraRooms = script.parent.parent:GetCustomProperty("rateExtraRooms")
minRoomLength = script.parent.parent:GetCustomProperty("minRoomLength")
maxRoomLength = script.parent.parent:GetCustomProperty("maxRoomLength")
minFinalRoomLength = script.parent.parent:GetCustomProperty("minFinalRoomLength")
maxFinalRoomLength = script.parent.parent:GetCustomProperty("maxFinalRoomLength")

propNewFolder = script:GetCustomProperty("NewFolder")


function initializeVariables(levelToSpawn)
	f = levelToSpawn
	floor[f] = {room = {} }
	floor[f].finalRoom = 0
	intersectCount = 0
	levelGeneratorIsWorking = false
end


function initiateTiles (i, newLength, newDepth)
	local tx,tz
	for tx=0,newLength-1 do
		floor[f].room[i].tile[tx] = {}
		for tz=0,newDepth-1 do
			if((tz==0 and tx==0) or (tz==0 and tx==newLength-1) or (tz==newDepth-1 and tx==0) or (tz==newDepth-1 and tx==newLength-1)) then
				floor[f].room[i].tile[tx][tz] = {type = "corner"}
			else 
				floor[f].room[i].tile[tx][tz] = {type = "floor"}
			end
		floor[f].room[i].tile[tx][tz].direction = {north = false, south = false, east = false, west = false}
		end
	end	
end


function initializeRoom (i)
	local m 
	floor[f].room[i] = {length = 0, depth = 0, spawnX = 0, spawnZ = 0, tile = {} , linkedRoom = {}, linkedRoomCount=0, spawnParentConnector = false, active, activeConnector}
	--max linked rooms limit is 5
	for m=0,4 do
		floor[f].room[i].linkedRoom[m]=0
	end
end


function GenerateLevel(localPlayer, levelNumber) -- Executes the calculations for the values of the new floor
	Events.Broadcast("LevelGeneratorHasStarted")
	if(levelGeneratorIsWorking == true) then 
		print("ERROR")
		return "Level Generator Is Busy..."
	else
		levelGeneratorIsWorking = true
	end
	if(floor[levelNumber] == not nil) then 
		return "FLOOR LEVEL EXISTS ON CURRENT SERVER"
	else 
		initializeVariables(levelNumber)
	end
	
	local timer = 0
	local m
	--spawn initial Room
	initializeRoom(1)
	floor[f].room[1].length = 6
	floor[f].room[1].depth = 6
	floor[f].room[1].spawnX = 0
	floor[f].room[1].spawnZ = 0
	initiateTiles (1,floor[f].room[1].length,floor[f].room[1].depth)
	floor[f].roomCount = 1
	
	CreateRoom("firstRoom")
	
	mainRooms = levelNumber+1
	local extraRooms = math.floor(mainRooms*rateExtraRooms/100)
	local progress = 1/(mainRooms+extraRooms+2)
	Events.BroadcastToPlayer(player,"UpdateLoadingBar",progress)
	
	--create main route until all room blocks have been used up
	local c = 0
	for m=1, mainRooms do
		CreateRoom("mainRoute")
		--send broadcast every 10 rooms to update Client Loading Bar (Events are limited to 10 times per second)
		c=c+1
		if(c>=10)then
			progress = floor[f].roomCount/(mainRooms+extraRooms+2)
			Events.BroadcastToPlayer(localPlayer,"UpdateLoadingBar",progress)
			c=0
		end
	end
	--create final room
	CreateRoom("finalRoom")
	--main route has been created. Now, we'll create alternate routes
	c=0
	for m=1, extraRooms do
		CreateRoom("extraRoom")
		c=c+1
		if(c>=10)then
			progress = floor[f].roomCount/(mainRooms+extraRooms+2)
			Events.BroadcastToPlayer(localPlayer,"UpdateLoadingBar",progress)
			c=0
		end
	end
	script.parent.parent.serverUserData.floor = floor --VERY IMPORTANT. PRINTS THE FLOOR DATA FOR OTHER SCRIPTS TO ACCESS AND USE 
	levelGeneratorIsWorking = false
	Events.Broadcast("LevelGeneratedSuccess")
	return "NEW FLOOR GENERATED, SUCCESS!"
end


function CreateRoom(type)
	
	floor[f].roomCount = floor[f].roomCount + 1
	local i = floor[f].roomCount
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
	local countWait=0
	local roomPositionValidation = false --if true, location has been confirmed to be valid and does not intersect with existing rooms	
	
	countWait=0
	repeat 
		--wait 1 frame every 3 loops instead of 1 to generate level 3x faster
		countWait = countWait+1
		refDirection = {}
		if(countWait==4) then
			Task.Wait()
			countWait=0
		end
		repeat
			if(type=="finalRoom") then
				newLength = rand:GetInteger(minFinalRoomLength,maxFinalRoomLength)
				newDepth = rand:GetInteger(minFinalRoomLength,maxFinalRoomLength)
				floor[f].finalRoom = i
			elseif(type=="firstRoom") then
				newLength = rand:GetInteger(8,12)
				newDepth = 4
			else
				newLength = rand:GetInteger(minRoomLength,maxRoomLength)
				newDepth = rand:GetInteger(minRoomLength,maxRoomLength)
			end
		until(newLength * newDepth >= 6)
		initiateTiles (i,newLength,newDepth)
		
		-- randomDirection: 1 = north, 2 = south, 3 = east, 4 = west
		
		if(type == "firstRoom") then
			randomDirection = 1
		else
			randomDirection = rand:GetInteger(1,4) -- will find a direction to spawn a new room relative to the first room i
			counter = counter + 1
		end
		
		repeat
			if(type=="mainRoute" or type=="finalRoom" or type=="firstRoom") then
				k = i-1 -math.floor(counter / 4) -- will check x loops before moving to a previous room (default:20)
				if(k<=2) then
					k=i-1
					counter=0
				end				
				if(i>=4 and k==2) then
					counter=0
					k=3
				end
			elseif(type=="extraRoom") then
				repeat 
					k = rand:GetInteger(2,floor[f].roomCount)
				until (k< floor[f].finalRoom or k> floor[f].finalRoom)
			end
		until(floor[f].room[k].linkedRoomCount<=3) --max linked rooms is 5

		if(randomDirection == 1) then -- spawn on direction [1,0]
			if(type == "firstRoom") then
				spawnX = floor[f].room[k].spawnX + floor[f].room[k].length +1
				spawnZ = floor[f].room[k].spawnZ+1
			else
				spawnX = floor[f].room[k].spawnX + floor[f].room[k].length +1
				minZ = floor[f].room[k].spawnZ - newDepth +1
				maxZ = floor[f].room[k].spawnZ + floor[f].room[k].depth -2
				spawnZ = rand:GetInteger(minZ,maxZ)
			end
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			if(roomPositionValidation == true) then
				for o=0,newDepth-1 do
					for p=0,floor[f].room[k].depth-1 do
						if(spawnZ+o == floor[f].room[k].spawnZ+p) then
							floor[f].room[i].parentRoomNumber = k
							floor[f].room[i].tile[0][o].isConnector = true
							floor[f].room[k].tile[floor[f].room[k].length-1][p].isConnector = true
							floor[f].room[i].parentDirection = "south"
							floor[f].room[i].tile[0][o].parentDirection = "south"
							floor[f].room[i].tile[0][o].direction.south = true
							floor[f].room[k].tile[floor[f].room[k].length-1][p].direction.north = true
						end
					end
				end
			end

		elseif(randomDirection == 2) then -- spawn on direction [-1,0]
			spawnX = floor[f].room[k].spawnX - newLength -1
			minZ = floor[f].room[k].spawnZ - newDepth + 1
			maxZ = floor[f].room[k].spawnZ + floor[f].room[k].depth -2
			spawnZ = rand:GetInteger(minZ,maxZ) 
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newDepth-1 do
					for p=0,floor[f].room[k].depth-1 do
						if(spawnZ+o == floor[f].room[k].spawnZ+p) then
							floor[f].room[i].parentRoomNumber = k
							floor[f].room[i].tile[newLength-1][o].isConnector = true
							floor[f].room[k].tile[0][p].isConnector = true
							floor[f].room[i].parentDirection = "north"
							floor[f].room[i].tile[newLength-1][o].parentDirection = "north"
							floor[f].room[i].tile[newLength-1][o].direction.north = true
							floor[f].room[k].tile[0][p].direction.south = true
						end
					end
				end
			end
			
		elseif(randomDirection == 3) then -- spawn on direction [0,1]
			minX = floor[f].room[k].spawnX - (newLength) +1
			maxX = floor[f].room[k].spawnX + floor[f].room[k].length -2
			spawnX = rand:GetInteger(minX, maxX)
			spawnZ = floor[f].room[k].spawnZ + floor[f].room[k].depth +1
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newLength-1 do
					for p=0,floor[f].room[k].length-1 do
						if(spawnX+o == floor[f].room[k].spawnX+p) then
							floor[f].room[i].parentRoomNumber = k
							floor[f].room[i].tile[o][0].isConnector = true
							floor[f].room[k].tile[p][floor[f].room[k].depth-1].isConnector = true
							floor[f].room[i].parentDirection = "west"
							floor[f].room[i].tile[o][0].parentDirection = "west"
							floor[f].room[i].tile[o][0].direction.west = true
							floor[f].room[k].tile[p][floor[f].room[k].depth-1].direction.east = true
						end
					end
				end
			end
			
		else -- spawn on direction [0,-1]
			minX = floor[f].room[k].spawnX - (newLength) + 1
			maxX = floor[f].room[k].spawnX + floor[f].room[k].length -2
			spawnX = rand:GetInteger(minX, maxX)
			spawnZ = floor[f].room[k].spawnZ - newDepth -1
			roomPositionValidation = CheckRoomIntersect(i,spawnX,spawnZ,newLength,newDepth)
			
			if(roomPositionValidation == true) then
				for o=0,newLength-1 do
					for p=0,floor[f].room[k].length-1 do
						if(spawnX+o == floor[f].room[k].spawnX+p) then
							floor[f].room[i].parentRoomNumber = k
							floor[f].room[i].tile[o][newDepth-1].isConnector = true
							floor[f].room[k].tile[p][0].isConnector = true
							floor[f].room[i].parentDirection = "east"
							floor[f].room[i].tile[o][newDepth-1].parentDirection = "east"
							floor[f].room[i].tile[o][newDepth-1].direction.east = true
							floor[f].room[k].tile[p][0].direction.west = true
						end
					end
				end
			end
		end --ends switch of 4 options
	until (roomPositionValidation == true) -- will check if the room does not overlap another room and loop until it finds a valid XZ place to spawn
	-- save the values for the current room i on our rooms array				
	floor[f].room[i].length = newLength
	floor[f].room[i].depth = newDepth
	floor[f].room[i].spawnX = spawnX
	floor[f].room[i].spawnZ = spawnZ
	AddLinkedRoom(i,k)
	print("created Room [" .. i .. "] on [" .. floor[f].room[i].spawnX .. "," .. floor[f].room[i].spawnZ .. "] dimensions X: " .. floor[f].room[i].length.. " Y:" .. floor[f].room[i].depth)
	print()
end


function AddLinkedRoom(i,k)
	local m=0
	while (floor[f].room[i].linkedRoom[m]~=0) do
		m = m+1
	end
	floor[f].room[i].linkedRoom[m] = k
	floor[f].room[i].linkedRoomCount = floor[f].room[i].linkedRoomCount+1

	m=0
	while (floor[f].room[k].linkedRoom[m]~=0) do
		m = m+1
	end
	floor[f].room[k].linkedRoom[m] = i
	floor[f].room[k].linkedRoomCount = floor[f].room[k].linkedRoomCount+1
end


-- checks if the room i intersects with every room previously created
function CheckRoomIntersect (i,spawnX,spawnZ,newLength,newDepth) 
	local xMin, xMax, zMin, zMax, a, x, z
	a = 1
	local counter =0
	repeat
		--delay every x loops to prevent instruction limit exceeded error
		counter = counter+1
		if (counter==50) then
			Task.Wait()
			counter =0
		end
		
		xMin = floor[f].room[a].spawnX -1
		xMax = floor[f].room[a].spawnX + floor[f].room[a].length-1 +1
		zMin = floor[f].room[a].spawnZ -1
		zMax = floor[f].room[a].spawnZ + floor[f].room[a].depth-1 +1
		
		x = 0
		repeat
			if (spawnX + x >= xMin and spawnX + x <= xMax) then
				z = 0
				repeat
					if(spawnZ + z >= zMin and spawnZ + z <= zMax) then
						intersectCount = intersectCount+1
						local rate = math.floor((i/intersectCount)*100)
						print()
						print("a:"..a.." x:"..x.." z:"..z.." i:"..i.." XY:["..spawnX..","..spawnZ.."] xMinMax:"..xMin..","..xMax.." zMinMax:"..zMin..","..zMax.." newLength:"..newLength.." newDepth:"..newDepth)
						print("ERROR COUNT: "..intersectCount.." ... INTERSECTS WITH EXISTING ROOM")
						print("Rate of Success: "..rate.."%")
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


--script.parent.parent:SetNetworkedCustomProperty("roomCount",roomCount) --the property must have Property Networking enabled in order to be able to modify it
--local player = Game.FindNearestPlayer(Vector3.New(0,0,0))

--LISTENERS--------------------------------------------------
Events.Connect("GenerateLevel", GenerateLevel)
-------------------------------------------------------------


--BROADCASTERS----------------------------------------
--Task.Wait() --send broadcast 1 frame after all Listeners have been established
------------------------------------------------------







