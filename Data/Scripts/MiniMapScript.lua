--VERY USEFUL to get the player that is running the client
local localPlayer = Game.GetLocalPlayer()

local propMinimapPanel = script.parent:GetCustomProperty("MinimapPanel")
local propMinimapBlock = script.parent:GetCustomProperty("MinimapBlock")
local propMinimapFrame = script.parent:GetCustomProperty("MinimapFrame")
local propMinimapPanelNoClipping = script.parent:GetCustomProperty("MinimapPanelNoClipping")
--local propNewGroup = script.parent:GetCustomProperty("NewGroup")
local propMinimapArrow = script.parent:GetCustomProperty("MinimapArrow")


local mapData = {}
local block = {}
local activeBlocks = {}
local xyRatio = 10
local minimapPanelSpawned = false
local colorBlock = {previous, current, change = false}

script.parent.parent.clientUserData.mapData = mapData

--local room = script.parent.parent.serverUserData.room

function SpawnMinimap()
	print("LEVELGENERATED FIRED")
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
	
	
	--MinimapBlocks = World.SpawnAsset(propNewGroup)
	--MinimapBlocks.parent = MinimapPanel
end


function UpdateMapData(i,ix,iz,ilength,idepth)
	print("Updating Map!")
	if(mapData[i] == nil) then 
		mapData[i] = {x = ix, y = iz, height = idepth, width = ilength}
		print('new registered room width: '..mapData[i].width)
		table.insert(activeBlocks,i)
		block[i] = World.SpawnAsset(propMinimapBlock)
		block[i].parent = MinimapCenterPivot
		block[i].name = "Block "..i
		block[i].x = mapData[i].x *xyRatio - localPlayer:GetWorldPosition().x/20
		block[i].y = mapData[i].y *xyRatio - localPlayer:GetWorldPosition().y/20
		block[i].width = mapData[i].width *xyRatio
		block[i].height = mapData[i].height *xyRatio
		MinimapArrow.parent = MinimapPanel
	end
	colorBlock.previous = colorBlock.current
	colorBlock.current = i
	if(colorBlock.current == colorBlock.previous) then else
		colorBlock.change = true
	end


end

function UpdateBlockPositions()
	local m,i
	for m=1, #activeBlocks do
		i= activeBlocks[m]
		block[i].x = mapData[i].x *xyRatio - localPlayer:GetWorldPosition().x/20
		block[i].y = mapData[i].y *xyRatio - localPlayer:GetWorldPosition().y/20
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




function Tick()
	if(localPlayer and minimapPanelSpawned) then
		UpdateBlockPositions()
		UpdatePivotRotation()
		if(#activeBlocks > 1) then
			UpdateColorBlocks()
		end
		--MinimapCenterPivot.x = localPlayer:GetWorldPosition().x/20 *-1 +180
		--MinimapCenterPivot.y = localPlayer:GetWorldPosition().y/20 *-1 +180
	end
end


Events.Connect("LevelGenerated",SpawnMinimap)
Events.Connect("newMapData",UpdateMapData)
