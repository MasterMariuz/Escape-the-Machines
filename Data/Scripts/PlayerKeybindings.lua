
local localPlayer = Game.GetLocalPlayer()
local playerLevel = 30
local MainMenuIsActive = true

--Keybindings
function OnKeyPressed (player, KeyPressed)
	if(KeyPressed == "ability_extra_50") then
		Events.Broadcast("ToggleMainMenu",playerLevel)
		MainMenuIsActive = false
	end
end


localPlayer.bindingPressedEvent:Connect(OnKeyPressed)

