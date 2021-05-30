local spawnedLight = nil
local lightBulbFolder = script:FindAncestorByName("Lightbulb & Switch")
local bulb = lightBulbFolder:FindDescendantByName("Bulb")
local bulbPosition = bulb:GetWorldPosition()

local propLightTemplate = script:GetCustomProperty("LightTemplate")
local switch = script.parent
local switchTrigger = switch:FindChildByName("Trigger")

local lightIsOn = false

-- set the rotations for the desired On and Off positions for the Switch
local onRotation = Rotation.New(0,-60,0)
local offRotation = Rotation.New(-180,-60,180)

-- change the label of the trigger
local function UpdateLabel()
  if lightIsOn == false then
    switchTrigger.interactionLabel = "Turn On"
  else 
    switchTrigger.interactionLabel = "Turn Off"
  end
end

-- Function to rotate the switch On
-- spawns the light and destroys it depending on the switch on/off status
function OnSwitchInteraction()
  if not lightIsOn then
    switch:RotateTo(onRotation,0.5,true)
    spawnedLight = World.SpawnAsset(propLightTemplate, {position = bulbPosition})
  else 
    switch:RotateTo(offRotation,0.5,true)
    spawnedLight:Destroy()
  end 
  UpdateLabel()
  lightIsOn = not lightIsOn
end

-- happens whenever player interacts with the Switch
switchTrigger.interactedEvent:Connect(OnSwitchInteraction)