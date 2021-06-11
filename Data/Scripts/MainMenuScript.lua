
local MainMenuContainer = script.parent
local propMainMenuPanel = MainMenuContainer:GetCustomProperty("MainMenuPanel")
local propMouseCursor = MainMenuContainer:GetCustomProperty("MouseCursor")

local localPlayer = Game.GetLocalPlayer()
local screenSize
local MainMenuPanel,MouseCursor, currentLevel

function MainMenu(playerLevel)
	currentLevel = playerLevel
	if(Object.IsValid(MainMenuPanel)) then
		MainMenuPanel:Destroy()
		if(Object.IsValid(MouseCursor)) then
			MouseCursor:Destroy()
		end
		UI.SetCanCursorInteractWithUI(false)
		Events.BroadcastToServer("TogglePlayerMovement",localPlayer)
	else
		screenSize = UI.GetScreenSize()
		MouseCursor = World.SpawnAsset(propMouseCursor, {parent = MainMenuContainer})
		MainMenuPanel = World.SpawnAsset(propMainMenuPanel, {parent = MainMenuContainer, position = Vector3.New(50,50,0)})
		MainMenuPanel.name = "MainMenuPanel"
		MainMenuPanel.width = math.floor(screenSize.x)-50
		MainMenuPanel.height = math.floor(screenSize.y) -50
		UI.SetCanCursorInteractWithUI(true)
		MainMenuPanel:FindChildByName("CurrentLevelNumber"):FindChildByName("Text").text = tostring(currentLevel)
		Events.BroadcastToServer("TogglePlayerMovement",localPlayer)
	end
end

-- will add or remove levels whenever player clicks the up or down arrows int he Main Menu, Level section
function ChangeLevel(numberOflevels) 
	currentLevel = currentLevel + numberOflevels
	MainMenuPanel:FindChildByName("CurrentLevelNumber"):FindChildByName("Text").text = tostring(currentLevel)
	Events.Broadcast("UpdateLevel",currentLevel)
end


function Tick()
	if(Object.IsValid(MouseCursor)) then 
		MouseCursor.x = UI.GetCursorPosition().x -17
		MouseCursor.y = UI.GetCursorPosition().y +5
		MouseCursor.parent = MouseCursor.parent
	end
end


Events.Connect("ToggleMainMenu",MainMenu)
Events.Connect("ChangeLevel",ChangeLevel)