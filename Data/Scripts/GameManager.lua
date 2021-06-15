
assetFolder = World.FindObjectByName("SpawnLevel")
elevator = assetFolder:GetCustomProperty("Elevator")
local propFloor01 = assetFolder:GetCustomProperty("Floor01")
local propHeadLight = script:GetCustomProperty("HeadLight")

local spawnWorldFloor,firstRoomElevator, headlight, stasisFieldAsset,stasisFieldColor
local r = 0

local playersGameData = {}
local levelGenerated = false
local levelGeneratorIsBusy = false



function OnKeyPressed(player, KeyPressed)
	if(KeyPressed == "ability_extra_33") then
		if(Object.IsValid(headlight)==true) then
			local spotlight = headlight:FindDescendantByName("Spotlight")
			local bulb = headlight:FindDescendantByName("bulb")
			if(spotlight.visibility == Visibility.FORCE_OFF) then
				spotlight.visibility = Visibility.FORCE_ON
				bulb.visibility = Visibility.FORCE_ON
				print("FLASHLIGHT ON")
			else 
				spotlight.visibility = Visibility.FORCE_OFF
				bulb.visibility = Visibility.FORCE_OFF
				print("FLASHLIGHT OFF")
			end
		end
	end
end



function SpawnInitialPlatform()
	--spawn World Floor
	local newPosition = Vector3.New(0,0,1000)
	local newScale = Vector3.New(2000,2000,0.1)
	local newRotation = Rotation.New(0,0,0)
	spawnWorldFloor = World.SpawnAsset(propFloor01, {parent = assetFolder, position = newPosition, scale = newScale, rotation = newRotation})
	spawnWorldFloor.name = "SpawnWorldFloor"
	
	--spawn Initial Elevator
	newPosition = Vector3.New(0,0,1000)
	newScale = Vector3.New(1,1,1)
	newRotation = Rotation.New(0,0,0)
	firstRoomElevator = World.SpawnAsset(elevator, {parent = assetFolder, position = newPosition, scale = newScale, rotation = newRotation})
	firstRoomElevator.name = "FirstRoom Elevator"	
end

function DestroyInitialPlatform()
	if(Object.IsValid(spawnWorldFloor)) then
		spawnWorldFloor:Destroy()
	end
	if(Object.IsValid(firstRoomElevator)) then
		firstRoomElevator:Destroy()
	end
end

--FIRES WHENEVER A NEW PLAYER JOINS
function OnPlayerJoined(player)
	local id = player.id
	table.insert(playersGameData,id)
	--import data of the player from the Global Server Storage into the game
	playersGameData[id] = {gameStorage = Storage.GetPlayerData(player), playerAsset = player} 
	
	if(playersGameData[id].gameStorage.maxLevel == nil) then
		playersGameData[id].gameStorage.maxLevel = 1
		Storage.SetPlayerData(player,playersGameData[id].gameStorage)
	end
	-----
	playersGameData[id].gameStorage.maxLevel = 1
	Storage.SetPlayerData(player,playersGameData[id].gameStorage)
	-----
	Events.BroadcastToPlayer(player,"ToggleMainMenu",playersGameData[id].gameStorage.maxLevel) --connects with UI Main Menu script
	Events.BroadcastToPlayer(player,"UpdateLevel",playersGameData[id].gameStorage.maxLevel) 
	SpawnInitialPlatform()
	player.bindingPressedEvent:Connect(OnKeyPressed)
	local playerSpawnLocation = script:GetCustomProperty("SpawnLocation")
	player:SetWorldPosition(playerSpawnLocation) 
end




function TogglePlayerMovement(player)
	player.isMovementEnabled = not player.isMovementEnabled
end

function SpawnInitialEquipment(player)
	local playerPosition = player:GetWorldPosition()
	headlight= World.SpawnAsset(propHeadLight, {parent = assetFolder}) 
	headlight:SetWorldPosition(playerPosition) --equips the headlight automatically
end



function initializeGameLevel (player, levelToSpawn)
	local id = player.id
	playersGameData[id].gameStorage.currentLevel = levelToSpawn
	
	Events.Broadcast("GenerateLevel",player,levelToSpawn)
	local waitTime = 0
	repeat
		Task.Wait(1)
		waitTime = waitTime +1
		if(waitTime == 2) then
			Events.BroadcastToPlayer(player, "ShowLoadingBar")
		end
	until(levelGenerated == true) -- wait until the level has been generated completely
	levelGenerated = false
	levelGeneratorIsBusy = false
	
	Events.Broadcast("SpawnLevel",levelToSpawn)
	Task.Wait(0.1)
	Events.BroadcastToPlayer(player, "ToggleMainMenu", levelToSpawn)
	Task.Wait(0.5)
	player:SetWorldPosition(Vector3.New(850,600,500)) 
	DestroyInitialPlatform()
	
	--display current level banner
	Events.BroadcastToPlayer(player,"UIShowLevel",levelToSpawn)
	
	--reset and activate level Timer
	print("START LEVEL TIMER BROADCASTED")
	Events.BroadcastToPlayer(player,"StartLevelTimer")
	
	--delay initial minimap spawning animation
	UI.PrintToScreen("Room Scanner Initializing...", Color.YELLOW)
	Task.Wait(3)
	Events.BroadcastToPlayer(player, "SpawnMiniMap")
	UI.PrintToScreen("Room Scanner Online...", Color.YELLOW)
	--delay Headlight spawning animation
	Task.Wait(0.3)
	UI.PrintToScreen("Headlight Powering Up...", Color.YELLOW)
	Task.Wait(3)
	SpawnInitialEquipment(player)
	UI.PrintToScreen("Headlight Online. Battery Left: 100% ...", Color.YELLOW)
	Task.Wait(3)
	UI.PrintToScreen("Press F to turn On/Off...", Color.YELLOW)
end


function OnFinalRoomElevatorReached(player)
	local id = player.id
	--register level data timer
	Events.BroadcastToPlayer(player,"FinalRoomElevatorReached") --connects with UI Manager (client)
	Task.Wait() --wait for data to be received from the player's client
	
	--updates the new level reached for the player
	newLevel = playersGameData[id].gameStorage.currentLevel +1
	playersGameData[id].gameStorage.currentLevel = newLevel

	if(newLevel > playersGameData[id].gameStorage.maxLevel) then
		playersGameData[id].gameStorage.maxLevel = newLevel
		Storage.SetPlayerData(player,playersGameData[id].gameStorage)
	end

	Events.Broadcast("GenerateLevel",player,newLevel)
	repeat
		Task.Wait(1)
	until(levelGenerated == true) -- wait until the level has been generated completely
	levelGenerated = false
	levelGeneratorIsBusy = false
	
	Events.Broadcast("SpawnLevel",newLevel)
	Task.Wait(0.5)
	World.FindObjectByName("Floor "..newLevel-1):Destroy()
	player:SetWorldPosition(Vector3.New(850,600,100)) 
	Task.Wait(0.1)
	Events.BroadcastToPlayer(player,"initializeMapData")
	Events.BroadcastToPlayer(player,"UIShowLevel",newLevel)
	
	--reset and activate level Timer
	Events.BroadcastToPlayer(player,"StartLevelTimer")
	
end




function ToggleElevatorStasisField(newStasisFieldAsset)
	stasisFieldAsset = newStasisFieldAsset
end

function UpdateActiveRooms (other, f, i)
	print("SPAWNING NEW ROOMS AND DESTROYING OLD ROOMS")
	--local newTask = Task.Spawn(function()
		local floor = script.parent.parent.serverUserData.floor
		local m, n, l, s
		local roomToDestroy, connectorToDestroy
		for m=1,floor[f].roomCount do
			if(floor[f].room[m].active == true) then
				floor[f].room[m].active = false
			end
			if(floor[f].room[m].activeConnector == true) then
				floor[f].room[m].activeConnector = false
			end
		end
		print("f:"..f.." i:"..i)
		floor[f].room[i].active = true
		print("entered Room: "..i)
		m=0
		print(floor[f].room[i].linkedRoom)
		while (floor[f].room[i].linkedRoom[m]~=0) do
			l = floor[f].room[i].linkedRoom[m]
			if(floor[f].room[l].active == false) then
				floor[f].room[l].active = true
			else
				Events.Broadcast("SpawnRoom", l) --connects with SpawnLevel script
			end
			m=m+1
		end
		
		m=0
		while (floor[f].room[i].linkedRoom[m]~=0) do
			l = floor[f].room[i].linkedRoom[m]
			if(floor[f].room[l].activeConnector == false) then
				floor[f].room[l].activeConnector = true
			else
				if( Object.IsValid(World.FindObjectByName("Connector "..l)) == false ) then 
					Events.Broadcast("SpawnConnector",l) --connects with SpawnLevel script
					print("Spawned Connector: "..l)
				end
			end
			
			n=0
			while (floor[f].room[l].linkedRoom[n]~=0) do
				s = floor[f].room[l].linkedRoom[n]
				if(floor[f].room[s].activeConnector == false) then
					floor[f].room[s].activeConnector = true
				else
					if( Object.IsValid(World.FindObjectByName("Connector "..s)) == false ) then 
						Events.Broadcast("SpawnConnector",s) --connects with SpawnLevel script
						print("Spawned Connector: "..s)
					end
				end
				n=n+1
			end
			m=m+1
		end
		
		--destroy all inactive rooms
		for i=1,floor[f].roomCount do
			if(floor[f].room[i].active == false) then
				floor[f].room[i].active = nil
				roomToDestroy = World.FindObjectByName("Room "..i)
				roomToDestroy:Destroy()
				Task.Wait()
			end
		end
		
		--destroy all inactive connectors
		for i=1,floor[f].roomCount do
			if(floor[f].room[i].activeConnector == false) then
				floor[f].room[i].activeConnector = nil
				connectorToDestroy = World.FindObjectByName("Connector "..i)
				connectorToDestroy:Destroy()
				Task.Wait()
			end
		end
	--end)
end



function OnRoomTriggerPressed(player, i)
	local f = playersGameData[player.id].gameStorage.currentLevel
	UpdateActiveRooms(player,f,i)
	local floor = script.parent.parent.serverUserData.floor
	Events.BroadcastToPlayer(player, "newMapData", i,floor[f].room[i].spawnX,floor[f].room[i].spawnZ,floor[f].room[i].length,floor[f].room[i].depth)
end

--IS THIS FUNCTION NEEDED????
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

function MainMenuKeyPressed(player)
	local id = player.id
	local currentLevel = playersGameData[id].gameStorage.currentLevel
	Events.BroadcastToPlayer(player,"ToggleMainMenu",currentLevel)
end


function LevelGeneratedSuccess()
	levelGenerated = true
end

function LevelGeneratorHasStarted()
	levelGeneratorIsBusy = true
end

function SaveNewTimeLevelComplete(player, levelTimer)
	local id = player.id
	if(playersGameData[id].gameStorage.levelTimeRecord == nil) then
		playersGameData[id].gameStorage.levelTimeRecord = {}
		warn("level time record registry does not exist. Creating {}")
	end
	local currentLevel = playersGameData[id].gameStorage.currentLevel
	
	if(not(playersGameData[id].gameStorage.levelTimeRecord[currentLevel] == nil) and playersGameData[id].gameStorage.levelTimeRecord[currentLevel]<0) then
		playersGameData[id].gameStorage.levelTimeRecord[currentLevel] = 9999
		Storage.SetPlayerData(player,playersGameData[id].gameStorage)
		warn("STORAGE LEVEL TIMER DATA IS LESS THAN 0. RESETTING TO 9999")
	end
	
	if(playersGameData[id].gameStorage.levelTimeRecord[currentLevel] == nil) then
		playersGameData[id].gameStorage.levelTimeRecord[currentLevel] = levelTimer --in seconds
		Storage.SetPlayerData(player,playersGameData[id].gameStorage)
		Events.BroadcastToPlayer(player,"NewTimeEntry",currentLevel) --first time level completed
		warn("FIRST TIME COMPLETED! SAVING NEW DATA TO SERVER STORAGE")
	else
		if(levelTimer < playersGameData[id].gameStorage.levelTimeRecord[currentLevel]) then --new Record!
			playersGameData[id].gameStorage.levelTimeRecord[currentLevel] = levelTimer --in seconds
			Storage.SetPlayerData(player,playersGameData[id].gameStorage)
			Events.BroadcastToPlayer(player,"NewTimeRecord",currentLevel)
		else
			local timeRecord = playersGameData[id].gameStorage.levelTimeRecord[currentLevel]
			Events.BroadcastToPlayer(player,"ShowTimeRecord",currentLevel,timeRecord) --show Personal Best in UI
		end
	end
	warn("New Level Record registered: "..currentLevel.." time(sec): "..levelTimer)
end


function Tick()
	if(Object.IsValid(stasisFieldAsset)) then
		local g
		local changeRate = 0.01
		if(r<=0.05) then
			change = 1
		elseif(r>=0.95) then
			change = -1
		end
		r = r + change*changeRate
		g = 1-r
		local newColor = Color.New(r,g,1,0.01)
		stasisFieldAsset:SetColor(newColor)
	end
	Task.Wait()
end





--EVENT LISTENERS--------------------------------------------
Game.playerJoinedEvent:Connect(OnPlayerJoined)
Events.ConnectForPlayer("MainMenuGoButtonPressed",initializeGameLevel)
Events.ConnectForPlayer("TogglePlayerMovement",TogglePlayerMovement)
Events.Connect("ToggleElevatorStasisField",ToggleElevatorStasisField)
Events.Connect("FinalRoomElevatorReached",OnFinalRoomElevatorReached)
Events.Connect("RoomTriggerPressed",OnRoomTriggerPressed) --from each room's trigger, activates when player touches a new room's floor
Events.Connect("LevelGeneratedSuccess",LevelGeneratedSuccess) -- connects with MasterScript. checks if the level generated successfully
Events.Connect("LevelGeneratorHasStarted",LevelGeneratorHasStarted) -- connects with MasterScript. checks if the Level Generator has fired and is currently working
Events.ConnectForPlayer("SaveNewTimeLevelComplete",SaveNewTimeLevelComplete) --connects with UIManager to get the level finished elapsed time to complete
-------------------------------------------------------------

Events.ConnectForPlayer("MainMenuKeyPressed",MainMenuKeyPressed)


--EVENT BROADCASTERS-----------------------------------------

-------------------------------------------------------------