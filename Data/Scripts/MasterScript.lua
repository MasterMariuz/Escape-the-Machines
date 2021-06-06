-- declare the Randomizing Seed. uses os.time() for local testing. should use time() when testing on server
timeSeed = os.time()
print("TimeSeed: " .. timeSeed)
rand = RandomStream.New(timeSeed)

room = {}
intersectCount = 0

local xyOffset = script.parent.parent:GetCustomProperty("xyOffset")

--variables to tweak the floor creation
mainRooms = script.parent.parent:GetCustomProperty("mainRooms")
rateExtraRooms = script.parent.parent:GetCustomProperty("rateExtraRooms")
extraRooms = math.floor(mainRooms*rateExtraRooms/100)
minRoomLength = script.parent.parent:GetCustomProperty("minRoomLength")
maxRoomLength = script.parent.parent:GetCustomProperty("maxRoomLength")
minFinalRoomLength = script.parent.parent:GetCustomProperty("minFinalRoomLength")
maxFinalRoomLength = script.parent.parent:GetCustomProperty("maxFinalRoomLength")

propNewFolder = script:GetCustomProperty("NewFolder")

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
	room[i] = {length = 0, depth = 0, spawnX = 0, spawnZ = 0, tile = {} , linkedRoom = {}, linkedRoomCount=0, spawnParentConnector = false, active, activeConnector}
	--max linked rooms limit is 5
	for m=0,4 do
		room[i].linkedRoom[m]=0
	end
end


function GenerateLevel() -- Executes the calculations for the values of the new floor

	local timer = 0
	local m
	--spawn initial Room
	initializeRoom(1)
	room[1].length = rand:GetInteger(4,12)
	room[1].depth = rand:GetInteger(4,12)
	room[1].spawnX = 0
	room[1].spawnZ = 0
	initiateTiles (1,room[1].length,room[1].depth)
	roomCount = 1
	
	CreateRoom("mainRoute")

	--create main route until all room blocks have been used up
	for m=1, mainRooms do
		CreateRoom("mainRoute")
	end
	
	print(i)
	--create final room
	CreateRoom("finalRoom")
	
	--main route has been created. Now, we'll create alternate routes
	for m=1, extraRooms do
		CreateRoom("extraRoom")
	end
	script.parent.parent.serverUserData.room = room 
	script.parent.parent.serverUserData.roomCount = roomCount
	
end





function CreateRoom(type)
	
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
	local countWait=0
	local roomPositionValidation = false --if true, location has been confirmed to be valid and does not intersect with existing rooms	
	
	countWait=0
	repeat 
		--wait 1 frame every 3 loops instead of 1 to generate level 3x faster
		countWait = countWait+1
		refDirection = {}
		if(countWait==5) then
			Task.Wait()
			countWait=0
		end
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
		
		repeat
			if(type=="mainRoute" or type=="finalRoom") then
				k = i - 1 - math.floor(counter / 4) -- will check x loops before moving to a previous room (default:20)
			elseif(type=="extraRoom") then
				k = rand:GetInteger(2,roomCount)
			end
		until(room[k].linkedRoomCount<=3) --max linked rooms is 5

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
	room[i].linkedRoomCount = room[i].linkedRoomCount+1

	m=0
	while (room[k].linkedRoom[m]~=0) do
		m = m+1
	end
	room[k].linkedRoom[m] = i
	room[k].linkedRoomCount = room[k].linkedRoomCount+1
end


-- checks if the room i intersects with every room previously created
function CheckRoomIntersect (i,spawnX,spawnZ,newLength,newDepth) 
	local xMin, xMax, zMin, zMax, a, x, z
	a = 1
	local counter =0
	repeat
		--delay every x loops to prevent instruction limit exceeded error
		counter = counter+1
		if (counter==100) then
			Task.Wait()
			counter =0
		end
		
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
	print(playerPosition)
	while i<=roomCount do
		print(player)
		print(player.name)
		if(playerPosition.x > room[i].spawnX*xyOffset and playerPosition.x < (room[i].spawnX+room[i].length)*xyOffset) then
			if(playerPosition.y > room[i].spawnZ*xyOffset and playerPosition.y < (room[i].spawnZ+room[i].depth)*xyOffset) then
				return i
			end
		end
		i=i+1
	end
	return nil
end


function OnPlayerJoined (player)
	local m, k
	local i = PlayerCurrentRoom(player)
	Events.BroadcastToPlayer(player,"newMapData",i,room[i].spawnX,room[i].spawnZ,room[i].length,room[i].depth)

	for m=0,4 do
		k=room[i].linkedRoom[m]
		if(k>0) then
			Events.BroadcastToPlayer(player,"newMapData",k,room[k].spawnX,room[k].spawnZ,room[k].length,room[k].depth)
		end
	end
end

GenerateLevel()



--save server values for other scripts (like SpawnLevel) to access and start running




--script.parent.parent:SetNetworkedCustomProperty("roomCount",roomCount) --the property must have Property Networking enabled in order to be able to modify it
--script.parent.parent:SetNetworkedCustomProperty("LevelGenerated",true)



--BROADCASTERS----------------------------------------
--Task.Wait() --send broadcast 1 frame after all Listeners have been established
Events.Broadcast("LevelGenerated")
Events.BroadcastToAllPlayers("LevelGenerated")
------------------------------------------------------
local player = Game.FindNearestPlayer(Vector3.New(0,0,0))
OnPlayerJoined(player)

Game.playerJoinedEvent:Connect(OnPlayerJoined)







