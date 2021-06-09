
local localPlayer
local localHeadlight

function newPlayerJoined (player,headlight)
	localPlayer = player
	localHeadlight = headlight
	player.bindingPressedEvent:Connect(OnKeyPressed)
end


--Keybindings
function OnKeyPressed (player, KeyPressed)
	if(KeyPressed == "ability_extra_33") then
		if(localHeadlight) then
			local spotlight = localHeadlight:FindDescendantByName("Spotlight")
			local bulb = localHeadlight:FindDescendantByName("bulb")
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

Events.Connect("NewPlayerJoined",newPlayerJoined)
