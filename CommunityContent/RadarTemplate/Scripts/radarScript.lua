
local ROTATE_CONTAINER = script.parent:GetCustomProperty("RotateContainer"):WaitForObject()
local BLIP_TEMPLATE = script.parent:GetCustomProperty("BlipTemplate")
local RADIUS = script.parent:GetCustomProperty("Radius")
local MAX_BLIP_COUNT = script.parent:GetCustomProperty("MaxBlipCount")

local blipTable = {}
local uiOffset = 150
local localPlayer = Game.GetLocalPlayer()

for i=1,MAX_BLIP_COUNT do
	local blipAssetInstance = World.SpawnAsset(BLIP_TEMPLATE, {parent = ROTATE_CONTAINER.parent})
	blipAssetInstance.isVisible = false
	table.insert(blipTable, blipAssetInstance)
end
	
function Tick()
	ROTATE_CONTAINER.rotationAngle = localPlayer:GetViewWorldRotation().z*-1
	--Task.Wait(.05)
	for i=1,MAX_BLIP_COUNT do
		blipTable[i].isVisible = false
	end
	local radarPlayers = Game.FindPlayersInCylinder(localPlayer:GetWorldPosition(), RADIUS, {ignorePlayers = localPlayer})
	for i,player in pairs(radarPlayers) do
		if blipTable[i] then
			local playerPos = player:GetWorldPosition()
			local localPlayerPos = localPlayer:GetWorldPosition()
	        
			radarPos = localPlayer:GetWorldPosition() - player:GetWorldPosition()
			local distance_value = math.sqrt(((playerPos.x - localPlayerPos.x)*(playerPos.x - localPlayerPos.x))  + ((playerPos.y - localPlayerPos.y)*(playerPos.y - localPlayerPos.y)))
			local scaledDistance = distance_value/RADIUS*uiOffset	
			local deltaYaw = math.deg(math.atan(radarPos.x, radarPos.y)) + localPlayer:GetViewWorldRotation().z
	
			radarPosX = scaledDistance * math.cos(math.rad(deltaYaw)) *-1
			radarPosY = scaledDistance * math.sin(math.rad(deltaYaw))
	
			blipTable[i].x = radarPosX
			blipTable[i].y = radarPosY
			blipTable[i].team = player.team
			blipTable[i].isVisible = true
		end
	end
end


