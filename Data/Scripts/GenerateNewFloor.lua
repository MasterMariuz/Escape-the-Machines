
function GenerateLevel(room, rand) -- Executes the calculations for the values of the new floor

	-- declare initial randomized values that will build the entire floor
	local roomSize = rand:GetInteger(40,50)
	local rateOfRooms = rand:GetInteger(80,90)
	local floorSizeX = rand:GetInteger(40,50)
	local floorSizeZ = rand:GetInteger(40,50)
	
	local chanceExtraRoute = rand:GetInteger(0,100)
	local timer = 0;

	local roomBlocks = math.floor(floorSizeX * floorSizeZ * rateOfRooms / 100)
	local i = 1 -- index in LUA starts with 1
	while (roomBlocks - 25 > 0) do -- initialize variables that will be used for the room construction
		print("roomBlocks:" .. roomBlocks)
		local spawnX = 0 
		local spawnZ = 0
		local newConnectorX = 0
		local newConnectorZ = 0
		local kConnectorX = 0
		local kConnectorZ = 0
		local k = 0
		local counter = 0
		local kRoomXmin, kRoomXmax, newRoomXmin, newRoomXmax, kRoomZmin, kRoomZmax, newRoomZmin, newRoomZmax, minX, maxX, minZ, maxZ, newLength, newDepth, randomDirection
		room[i] = {length = 0, depth = 0, spawnX = 0, spawnZ = 0}
		if(i == 1) then
			print(room[1].length)
			print(room[1].depth)
			newLength = rand:GetInteger(5,math.floor(22 * roomSize / 100))
			newDepth = rand:GetInteger(5,math.floor(22 * roomSize / 100))
			
			print ("i:"..i.." room.length:"..room[i].length.." newLength:"..newLength)
			room[i].length = newLength
			room[i].depth = newDepth
			room[i].spawnX = spawnX
			room[i].spawnZ = spawnZ
			print ("i:"..i.." room.length:"..room[i].length.." newLength:"..newLength)
			
					
		else 
			repeat 
				newLength = rand:GetInteger(5,math.floor(22 * roomSize / 100))
				newDepth = rand:GetInteger(5,math.floor(22 * roomSize / 100))
				randomDirection = rand:GetInteger(1,4) -- will find a direction to spawn a new room relative to the first room i
				counter = counter + 1
				k = i - 1 - math.floor(counter / 20) -- will check x loops before moving to a previous room (default:20)
				print("case: " .. randomDirection .. " k:" .. k .. " i:" .. i)
				if(randomDirection == 1) then -- spawn on direction [1,0]
					spawnX = room[k].spawnX + room[k].length
					minZ = room[k].spawnZ - (newDepth -1) + 3
					maxZ = room[k].spawnZ + room[k].depth -2
					spawnZ = rand:GetInteger(minZ,maxZ)
					
					kRoomZmin = room[k].spawnZ + 1
					kRoomZmax = room[k].spawnZ + (room[k].depth - 1) - 1
		            newRoomZmin = spawnZ + 1
					newRoomZmax = spawnZ + (newDepth - 1) - 1

					newConnectorX = 0
					minZ = math.max(newRoomZmin, kRoomZmin)
					maxZ = math.min(newRoomZmax, kRoomZmax)
					newConnectorZ = rand:GetInteger(minZ, maxZ) - spawnZ

					kConnectorX = room[k].length - 1
					kConnectorZ = newConnectorZ + spawnZ - room[k].spawnZ
					
				elseif(randomDirection == 2) then -- spawn on direction [-1,0]
					spawnX = room[k].spawnX - newLength
					minZ = room[k].spawnZ - (newDepth -1) + 3
					maxZ = room[k].spawnZ + room[k].depth -2
					spawnZ = rand:GetInteger(minZ,maxZ)
					
					kRoomZmin = room[k].spawnZ + 1
					kRoomZmax = room[k].spawnZ + (room[k].depth - 1) - 1
		            newRoomZmin = spawnZ + 1
					newRoomZmax = spawnZ + (newDepth - 1) - 1

					newConnectorX = newLength - 1
					minZ = math.max(newRoomZmin, kRoomZmin)
					maxZ = math.min(newRoomZmax, kRoomZmax)
					newConnectorZ = rand:GetInteger(minZ, maxZ) - spawnZ

					kConnectorX = 0
					kConnectorZ = newConnectorZ + spawnZ - room[k].spawnZ
				
				elseif(randomDirection == 3) then -- spawn on direction [0,1]
					minX = room[k].spawnX - (newLength - 1) + 3
					maxX = room[k].spawnX + room[k].length - 2
					spawnX = rand:GetInteger(minX, maxX)
					spawnZ = room[k].spawnZ + room[k].depth
					
					kRoomXmin = room[k].spawnX + 1
					kRoomXmax = room[k].spawnX + (room[k].length -1) - 1
					newRoomXmin = spawnX + 1
					newRoomXmax = spawnX + (newLength - 1) - 1
					
					minX = math.max(newRoomXmin, kRoomXmin)
					maxX = math.min(newRoomXmax, kRoomXmax)
					newConnectorX = rand:GetInteger(minX, maxX) - spawnX
					newConnectorZ = 0
					
					kConnectorX = newConnectorX + spawnX - room[k].spawnX
					kConnectorZ = room[k].depth - 1
					
				else -- spawn on direction [0,-1]
					minX = room[k].spawnX - (newLength - 1) + 3
					maxX = room[k].spawnX + room[k].length - 2
					spawnX = rand:GetInteger(minX, maxX)
					spawnZ = room[k].spawnZ - newDepth

					kRoomXmin = room[k].spawnX + 1
					kRoomXmax = room[k].spawnX + (room[k].length - 1) - 1
					newRoomXmin = spawnX + 1
					newRoomXmax = spawnX + (newLength - 1) - 1

					minX = math.max(newRoomXmin, kRoomXmin)
					maxX = math.min(newRoomXmax, kRoomXmax)
					newConnectorX = rand:GetInteger(minX, maxX) - spawnX
					newConnectorZ = newDepth - 1

					kConnectorX = newConnectorX + spawnX - room[k].spawnX
					kConnectorZ = 0
				end --ends switch of 4 options
				
				-- save the values for the current room i on our rooms array				
				print("roomlength:" .. room[i].length .. " newLength:" .. newLength)
				room[i].length = newLength
				room[i].depth = newDepth
				room[i].spawnX = spawnX
				room[i].spawnZ = spawnZ
			until (CheckRoomIntersect(i) == false) -- will check if the room does not overlap another room and loop until it finds a valid XZ place to spawn
		roomBlocks = roomBlocks - (newLength * newDepth)
		print()
		print("Spawned Room [" .. i .. "] on [" .. spawnX .. "," .. spawnZ .. "] dimensions X: " .. newLength .. " Y:" .. newDepth)
		end --ends the if else function
		

		
		i = i + 1
	end -- ends the while do function
	
end --ends the function

-- checks if the room i intersects with every room previously created
function CheckRoomIntersect (i) 
	local xMin, xMax, zMin, zMax, a, x, z
	a = 1
	repeat
		xMin = room[a].spawnX
		xMax = room[a].spawnX + room[a].length - 1
		zMin = room[a].spawnZ 
		zMax = room[a].spawnZ + room[a].depth - 1
		
		x = 0
		repeat
			if (room[i].spawnX + x >= xMin and room[i].spawnX + x <= xMax) then
				z = 0
				repeat
					if(room[i].spawnZ + z >= zMin and room[i].spawnZ + z <= zMax) then
						print()
						print("a:"..a.." x:"..x.." z:"..z.." i:"..i.." room[i]spawnZ:"..room[i].spawnZ.." zMin:"..zMin.." zMax:"..zMax)
						print("INTERSECTS WITH EXISTING ROOM")
						return true
					end
					z = z + 1
				until (z == room[i].depth)
			end
							
			x = x + 1
		until (x == room[i].length)
		
		a = a + 1
	until (a == i)
	return false
end






























