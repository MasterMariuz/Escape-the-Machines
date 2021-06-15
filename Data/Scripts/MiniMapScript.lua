--VERY USEFUL to get the player that is running the client
local localPlayer = Game.GetLocalPlayer()

local propMinimapPanel = script.parent:GetCustomProperty("MinimapPanel")
local propMinimapBlock = script.parent:GetCustomProperty("MinimapBlock")
local propMinimapFrame = script.parent:GetCustomProperty("MinimapFrame")
local propMinimapPanelNoClipping = script.parent:GetCustomProperty("MinimapPanelNoClipping")
local propMinimapArrow = script.parent:GetCustomProperty("MinimapArrow")

function InitializeMapData()
	mapData = {}
	block = {}
	activeBlocks = {}
	doorData = {}
	doorAsset= {}
	activeDoors= {}
	xyRatio = 10
	minimapPanelSpawned = false
	colorBlock = {previous, current, change = false}
	blockBorder = 8
	
	if(Object.IsValid(MinimapPanel)) then
		MinimapPanel:Destroy()
		SpawnMinimap()
	end
end


--local room = script.parent.parent.serverUserData.room

function SpawnMinimap()
	print("MINI MAP SPAWNING")
	minimapPanelSpawned = true
	MinimapPanel = World.SpawnAsset(propMinimapPanelNoClipping)
	MinimapPanel.parent = script.parent
	MinimapPanel.name = "MinimapPanel"
			
	MinimapBounds = World.SpawnAsset(propMinimapPanel, {parent = MinimapPanel})
	MinimapBounds.name = "MinimapBounds"
	MinimapBounds.anchor = UIPivot.TOP_LEFT
	MinimapBounds.dock = UIPivot.TOP_LEFT
	MinimapBounds.x = 20
	MinimapBounds.y = 20
	MinimapBounds.width = 360
	MinimapBounds.height = 360
	
	MinimapBackground = World.SpawnAsset(propMinimapBlock, {parent = MinimapBounds})
	MinimapBackground.name = "MinimapBackground"
	MinimapBackground.x = 0
	MinimapBackground.y = 0
	MinimapBackground.width = 360
	MinimapBackground.height = 360
	MinimapBackground:SetColor(Color.New(0,0.012,0.08,0.864))
	
	MinimapFrame = World.SpawnAsset(propMinimapFrame, {parent = MinimapPanel})
	MinimapFrame.name = "Frame"
	
	MinimapArrow = World.SpawnAsset(propMinimapArrow, {parent = MinimapPanel})
	MinimapArrow.name = "Arrow"
	
	MinimapCenterPivot = World.SpawnAsset(propMinimapPanelNoClipping)
	MinimapCenterPivot.parent = MinimapBounds
	MinimapCenterPivot.name = "MinimapCenterPivot"
	MinimapCenterPivot.anchor = UIPivot.TOP_LEFT
	MinimapCenterPivot.dock = UIPivot.TOP_LEFT
	MinimapCenterPivot.x = 180
	MinimapCenterPivot.y = 180
	MinimapCenterPivot.width = 0
	MinimapCenterPivot.height = 0
	
end


function UpdateMapData(i,ix,iz,ilength,idepth)
	print("Updating Map!")
	if(Object.IsValid(MinimapArrow)) then
		if(mapData[i] == nil) then 
			mapData[i] = {x = ix *xyRatio, y = iz *xyRatio, height = idepth *xyRatio, width = ilength *xyRatio}
			print('new registered room width: '..mapData[i].width)
			table.insert(activeBlocks,i)
			block[i] = World.SpawnAsset(propMinimapBlock)
			block[i].parent = MinimapCenterPivot
			block[i].name = "Block "..i
			block[i].x = mapData[i].x - localPlayer:GetWorldPosition().x/20
			block[i].y = mapData[i].y - localPlayer:GetWorldPosition().y/20
			block[i].width = mapData[i].width +blockBorder --the value added is to create an outer border on each block
			block[i].height = mapData[i].height +blockBorder
			block[i]:SetColor(Color.New(0.5,0,0.9,0.8))
		end
		colorBlock.previous = colorBlock.current
		colorBlock.current = i
		if(colorBlock.current == colorBlock.previous) then else
			colorBlock.change = true
		end
		MinimapArrow.parent = MinimapPanel
	end
end

function UpdateBlockPositions()
	local m,i
	for m=1, #activeBlocks do
		i= activeBlocks[m]
		block[i].x = mapData[i].x - localPlayer:GetWorldPosition().x/20 -blockBorder/2 --the value substracted is equal to the value of the added border /2
		block[i].y = mapData[i].y - localPlayer:GetWorldPosition().y/20 -blockBorder/2
	end	
end

function UpdateDoorPositions()
	local m,i
	for m=1, #activeDoors do
		i= activeDoors[m]
		doorAsset[i].x = doorData[i].x - localPlayer:GetWorldPosition().x/20
		doorAsset[i].y = doorData[i].y - localPlayer:GetWorldPosition().y/20
		doorAsset[i].parent = doorAsset[i].parent --to show the Doors on top of the Blocks in the Minimap
	end	
end


function UpdatePivotRotation()
	local playerRotation = localPlayer:GetViewWorldRotation()
	MinimapCenterPivot.rotationAngle = playerRotation.z*-1 -90
end

function UpdateColorBlocks()
	if(colorBlock.change == true) then
		block[colorBlock.current]:SetColor(Color.New(0.5,0,0.9,0.8))
		block[colorBlock.previous]:SetColor(Color.New(0.3,0.3,0.3,1))
		colorBlock.change = false
	end
end


function SpawnNewDoor(i,doorX,doorY,doorType)
	print("Spawning new Door in Minimap: "..i)
	if(doorData[i]==nil  and Object.IsValid(MinimapCenterPivot)) then
		doorData[i] = {x = doorX /20, y = doorY /20, type = doorType}
		table.insert(activeDoors,i)
		doorAsset[i] = World.SpawnAsset(propMinimapBlock, {parent = MinimapCenterPivot})
		doorAsset[i].name = "Door "..i
		
		--doorAsset[i].x = doorData[i].x - localPlayer:GetWorldPosition().x/20
		--doorAsset[i].y = doorData[i].y - localPlayer:GetWorldPosition().y/20
		if(doorData[i].type == "Corridor") then
			doorData[i].width = 1 *xyRatio
			doorData[i].height = 1 *xyRatio
			doorData[i].x = doorData[i].x -5
			doorData[i].y = doorData[i].y -5
		elseif(doorData[i].type == "Door1x2") then
			doorData[i].width = 1 *xyRatio
			doorData[i].height = 2 *xyRatio
			doorData[i].x = doorData[i].x -5
		elseif(doorData[i].type == "Door2x1") then
			doorData[i].width = 2 *xyRatio
			doorData[i].height = 1 *xyRatio
			doorData[i].y = doorData[i].y -5
		elseif(doorData[i].type == "Door1x4") then
			doorData[i].width = 1 *xyRatio
			doorData[i].height = 4 *xyRatio
			doorData[i].x = doorData[i].x -5
		elseif(doorData[i].type == "Door4x1") then
			doorData[i].width = 4 *xyRatio
			doorData[i].height = 1 *xyRatio
			doorData[i].y = doorData[i].y -5
		elseif(doorData[i].type == "DoubleDoor1x4") then
			doorData[i].width = 1 *xyRatio
			doorData[i].height = 9 *xyRatio
			doorData[i].x = doorData[i].x -5
		elseif(doorData[i].type == "DoubleDoor4x1") then
			doorData[i].width = 9 *xyRatio
			doorData[i].height = 1 *xyRatio
			doorData[i].y = doorData[i].y -5
		end
		doorAsset[i].width = doorData[i].width
		doorAsset[i].height = doorData[i].height
		doorAsset[i]:SetColor(Color.New(0.8,0.9,0,1))
		
	end
	

end


function Tick()
	if(localPlayer and minimapPanelSpawned) then
		UpdateBlockPositions()
		UpdateDoorPositions()
		UpdatePivotRotation()
		if(#activeBlocks > 1) then
			UpdateColorBlocks()
		end
		--MinimapCenterPivot.x = localPlayer:GetWorldPosition().x/20 *-1 +180
		--MinimapCenterPivot.y = localPlayer:GetWorldPosition().y/20 *-1 +180
	end
end

--Initialize
InitializeMapData()


--LISTENERS--------------------------------------------------
Events.Connect("SpawnMiniMap",SpawnMinimap)
Events.Connect("newMapData",UpdateMapData)
Events.Connect("DoorOpened",SpawnNewDoor)
Events.Connect("initializeMapData",InitializeMapData)
-------------------------------------------------------------

Task.Wait(1)
--BROADCASTERS--------------------------------------------------
--Events.BroadcastToServer("MinimapSpawned",localPlayer)
----------------------------------------------------------------
