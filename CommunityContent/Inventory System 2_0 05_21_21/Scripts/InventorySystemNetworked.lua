local config = require(script.parent:GetCustomProperty("ConfigRequire"))
local items = require(script.parent:GetCustomProperty("ItemsRequire"))

local function SpawnPickup(player, itemid, amount)
	local pickup = World.SpawnAsset(items.byId[itemid].drop, {position = player:GetWorldPosition()})
	pickup:SetNetworkedCustomProperty("Amount", amount)
end
Events.Connect("InventorySystemSpawnPickup", SpawnPickup)