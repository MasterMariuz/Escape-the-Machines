
local MainMenuContainer = script.parent
local propMainMenuPanel = MainMenuContainer:GetCustomProperty("MainMenuPanel")
local propMouseCursor = MainMenuContainer:GetCustomProperty("MouseCursor")
local propLoadingBar = MainMenuContainer:GetCustomProperty("LoadingBar")

local localPlayer = Game.GetLocalPlayer()
local screenSize
local MainMenuPanel,MouseCursor, currentLevel, GoButton, LoadingBar, progressBar


function GoButtonClicked(GoButton)
	GoButton.isInteractable = false
	Events.BroadcastToServer("MainMenuGoButtonPressed",currentLevel)
end


function MainMenu(incomingLevel)
	currentLevel = incomingLevel
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
		MainMenuPanel = World.SpawnAsset(propMainMenuPanel, {parent = MainMenuContainer})
		MainMenuPanel.name = "MainMenuPanel"
		MainMenuPanel.width = math.floor(screenSize.x)-50
		MainMenuPanel.height = math.floor(screenSize.y) -50
		UI.SetCanCursorInteractWithUI(true)
		--Start Button 
		GoButton = MainMenuPanel:FindChildByName("GoButton")
		GoButton.clickedEvent:Connect(GoButtonClicked,GoButton)
		
		MainMenuPanel:FindChildByName("CurrentLevelNumber"):FindChildByName("Text").text = tostring(currentLevel)
		Events.BroadcastToServer("TogglePlayerMovement",localPlayer)
	end
end

-- will add or remove levels whenever player clicks the up or down arrows int he Main Menu, Level section
function ChangeLevel(numberOflevels) 
	currentLevel = currentLevel + numberOflevels
	MainMenuPanel:FindChildByName("CurrentLevelNumber"):FindChildByName("Text").text = tostring(currentLevel)
	print("new Level changed to: "..currentLevel)
end

function ShowLoadingBar()
	LoadingBar = World.SpawnAsset(propLoadingBar, {parent = MainMenuPanel})
	LoadingBar.name = "LoadingBar"
	progressBar = LoadingBar:FindChildByName("ProgressBar")
	progressBar.progress = 0
end

function UpdateLoadingBar(progress)
	print("Check if Loading Bar exists")
	if(Object.IsValid(LoadingBar)) then
		print("Loading Bar exists!")
		progressBar.progress = progress --between 0 and 1
	end
end




function Tick()
	if(Object.IsValid(MouseCursor)) then 
		MouseCursor.x = UI.GetCursorPosition().x -17
		MouseCursor.y = UI.GetCursorPosition().y +5
		MouseCursor.parent = MouseCursor.parent
	end
end


Events.Connect("ToggleMainMenu",MainMenu)
Events.Connect("ChangeLevel",ChangeLevel) --connected from Up/Down Arrows for Current Level
Events.Connect("ShowLoadingBar",ShowLoadingBar)
Events.Connect("UpdateLoadingBar",UpdateLoadingBar)

						
