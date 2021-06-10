
local button = script.parent
local localPlayer = Game.GetLocalPlayer()
local levelToSpawn

function UpdateLevel(level)
	levelToSpawn = level
	print(levelToSpawn.." updated to this")
end

function GoButtonClicked()
	button.isInteractable = false
	print(levelToSpawn.." rooms will spawn")
	Events.BroadcastToServer("MainMenuGoButtonPressed",levelToSpawn)
	
end

Events.Connect("UpdateLevel", UpdateLevel)
button.clickedEvent:Connect(GoButtonClicked)

