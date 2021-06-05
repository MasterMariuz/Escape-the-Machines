local root = script.parent.parent
local itemid = root:GetCustomProperty("ItemID")
local amount = root:GetCustomProperty("Amount")
local listenid = os.date("%X") .. "|" .. math.random()*30
local player

function OnInteracted(_, other)
	if not player then
		player = other
		Events.Broadcast("?InventorySystemAddRequest", other, itemid, amount, listenid)
	end
end

function PickUp(listen, can)
	if listen == listenid then
		if not can then
			player = nil
		else
			Events.Broadcast("InventorySystemAddItem", player, itemid, amount)
			root:Destroy()
		end
	end
end

script.parent.interactedEvent:Connect(OnInteracted)
Events.Connect("=InventorySystemAddRequest", PickUp)