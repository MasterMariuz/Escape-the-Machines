
local PlayersFolder = script.parent
local propPlayerHandler = PlayersFolder:GetCustomProperty("PlayerHandler")
local propHeadLight = PlayersFolder:GetCustomProperty("HeadLight")
--local allPlayers = {}

function OnPlayerJoined (player)
	local newPlayer = World.SpawnAsset(propPlayerHandler, {parent = PlayersFolder})
	newPlayer.name = (player.name.." Script")
	local playerPosition = player:GetWorldPosition()
	local newHeadLight = World.SpawnAsset(propHeadLight, {parent = newPlayer})
	newHeadLight:SetWorldPosition(playerPosition)
	Task.Wait()
	player:SetWorldPosition(Vector3.New(300,300,300))
	Events.Broadcast("NewPlayerJoined",player,newHeadLight)
	--table.insert(allPlayers,player)	
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
