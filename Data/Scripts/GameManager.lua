
assetFolder = World.FindObjectByName("SpawnLevel")
elevator = assetFolder:GetCustomProperty("Elevator")
local propFloor01 = assetFolder:GetCustomProperty("Floor01")
local propHeadLight = script:GetCustomProperty("HeadLight")

local spawnWorldFloor,firstRoomElevator
local headlight, stasisFieldAsset,stasisFieldColor
local r = 0

local playersGameData = {}



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
	--playersGameData[id].gameStorage.level = 1
	--Storage.SetPlayerData(player,playersGameData[id].gameStorage)
	-----
	Events.BroadcastToPlayer(player,"ToggleMainMenu",playersGameData[id].gameStorage.maxLevel)
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
	playersGameData[id].gameStorage.levelSpawned = levelToSpawn
	
	Events.Broadcast("GenerateLevel",player,levelToSpawn)
	Task.Wait(1)
	Events.Broadcast("SpawnLevel",levelToSpawn)
	Task.Wait(0.1)
	Events.BroadcastToPlayer(player, "ToggleMainMenu", levelToSpawn)
	Task.Wait(0.5)
	player:SetWorldPosition(Vector3.New(850,600,500)) 
	DestroyInitialPlatform()
	UI.PrintToScreen("Room Scanner Initializing...", Color.YELLOW)
	Task.Wait(3)
	Events.BroadcastToPlayer(player, "SpawnMiniMap")
	UI.PrintToScreen("Room Scanner Online...", Color.YELLOW)
	Task.Wait(0.3)
	UI.PrintToScreen("Headlight Powering Up...", Color.YELLOW)
	Task.Wait(3)
	SpawnInitialEquipment(player)
	UI.PrintToScreen("Headlight Online. Battery Left: 100% ...", Color.YELLOW)
	Task.Wait(3)
	UI.PrintToScreen("Press F to turn On/Off...", Color.YELLOW)
end


--activates when a player reaches the finalRoom elevator and advances to the next level
function initializeNextLevel (player, levelToSpawn)
	World.FindObjectByName("Floor "..levelToSpawn-1):Destroy() --looks for the Floor Folder and destroyes all the previous Floor Assets
	Events.Broadcast("GenerateLevel",player,levelToSpawn)
	Task.Wait(1)
	Events.Broadcast("SpawnLevel",levelToSpawn)
	Task.Wait(0.5)
	player:SetWorldPosition(Vector3.New(850,600,500)) 
	Events.BroadcastToPlayer(player,"initializeMapData")
end


function ToggleElevatorStasisField(newStasisFieldAsset)
	stasisFieldAsset = newStasisFieldAsset
end

function OnFinalRoomElevatorReached(player)
	local id = player.id
	--updates the new level reached for the player
	playersGameData[id].gameStorage.levelSpawned = playersGameData[id].gameStorage.levelSpawned +1
	if(playersGameData[id].gameStorage.levelSpawned > playersGameData[id].gameStorage.maxLevel) then
		playersGameData[id].gameStorage.maxLevel = playersGameData[id].gameStorage.levelSpawned
		Storage.SetPlayerData(player,playersGameData[id].gameStorage)
	end
	--spawn next level
	initializeNextLevel(player, playersGameData[id].gameStorage.levelSpawned) 
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
-------------------------------------------------------------


--EVENT BROADCASTERS-----------------------------------------

-------------------------------------------------------------