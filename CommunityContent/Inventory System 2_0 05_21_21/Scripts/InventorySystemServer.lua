local config = require(script.parent.parent:GetCustomProperty("ConfigRequire"))
local items = require(script.parent.parent:GetCustomProperty("ItemsRequire"))

local data = {}
local toSend = {}
local toSendPlayerLeft = {}
local toSendPlayerBroadcast = {}
local sendWait = 0

local equipment = {}

local function Message(s)
	if not config.log then return end
	print("[Server] Inventory System 2.0 | " .. s)
end

function Tick(dt)
	-- loading
	if sendWait <= 0 then
		-- check if done
		for k, v in pairs(toSendPlayerLeft) do
			if v == 0 then
				toSendPlayerBroadcast[k] = true
				toSendPlayerLeft[k] = -1
			end
		end
		-- finish
		for k, v in pairs(toSendPlayerBroadcast) do
			if v == true then
				local r = Events.BroadcastToPlayer(k, "InventorySystemLoaded")
				if r == BroadcastEventResultCode.SUCCESS or r == BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT then
					Message("Finished sending data to " .. k.name .. ".")
					toSendPlayerBroadcast[k] = false
					if r == BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT then
						Message("Ignore broadcast rate warnings...")
						sendWait = config.loadDelay
					end
				else
					Message("Finishing sending data, ignore broadcast rate warnings...")
					sendWait = config.loadDelay
				end
				break
			end
		end
		-- load
		if toSend[1] then
			local r = Events.BroadcastToPlayer(toSend[1][1], "InventorySystemLoad", toSend[1][2], toSend[1][3], toSend[1][4])
			if r == BroadcastEventResultCode.SUCCESS or r == BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT then
				Message("Sending data to " .. tostring(toSend[1][1].name) .. ": {" .. tostring(toSend[1][2]) .. ", " .. tostring(toSend[1][3]) .. ", " .. tostring(toSend[1][4]) .. "}.")
				toSendPlayerLeft[toSend[1][1]] = toSendPlayerLeft[toSend[1][1]] - 1
				if toSendPlayerLeft[toSend[1][1]] == 0 then
					toSendPlayerBroadcast[toSend[1][1]] = true
					toSendPlayerLeft[toSend[1][1]] = -1
				end
				table.remove(toSend, 1)
				if not config.highTrafficMode then
					sendWait = config.loadDelay
				end
				if r == BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT then
					Message("Sending data, ignore broadcast rate warnings...")
					sendWait = config.loadDelayHTM
				end
			else
				Message("Sending data, ignore broadcast rate warnings...")
				sendWait = config.loadDelayHTM
			end
		end
	else
		sendWait = sendWait - dt
	end
end

local function Sync(player)
	local n = 0
	for i = 1, config.slots do
		if data[player.name][i][1] ~= config.clear then
			table.insert(toSend, {player, "load", i, data[player.name][i]})
			n = n + 1
		end
	end
	toSendPlayerLeft[player] = n
	if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end

	for k, v in pairs(equipment[player.name]) do
		equipment[player.name][k][2] = World.SpawnAsset(items.byId[data[player.name][equipment[player.name][k][1]][1]].equipment)
		equipment[player.name][k][2]:Equip(player)
		table.insert(toSend, {player, "equip", equipment[player.name][k][1], k})
		toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
	end
end

local function Save(player)
	if config.enableStorage then
		Message("Saving data for " .. player.name .. ".")
		local save = Storage.GetPlayerData(player)
		save.inventorySystem = data[player.name]
		save.inventorySystemEquipment = equipment[player.name]
		for k, v in pairs(save.inventorySystemEquipment) do
			if save.inventorySystemEquipment[k][2] ~= nil then
				table.remove(save.inventorySystemEquipment[k], 2)
			end
		end
		Storage.SetPlayerData(player, save)
	else
		Message("Not saving data (config.enableStorage == false).")
	end
end
Game.playerLeftEvent:Connect(Save)

local function OnPlayerJoined(player)
	data[player.name] = (config.enableStorage and Storage.GetPlayerData(player).inventorySystem) or {}
	if not data[player.name].equipped then data[player.name].equipped = {} end
	equipment[player.name] = (config.enableStorage and Storage.GetPlayerData(player).inventorySystemEquipment) or {}

	for i = 1, config.slots do
		if data[player.name][i] == nil then
			data[player.name][i] = {config.clear}
		end
	end

	Task.Wait(2)

	Sync(player)
end
Game.playerJoinedEvent:Connect(OnPlayerJoined)

local function AddItem(player, itemid, amount)
	local left = 0
	if amount >= items.byId[itemid].max then
		left = amount - items.byId[itemid].max
		amount = items.byId[itemid].max
	end
	-- check for free space
	local free = -1
	for i = 1, config.slots do
		if data[player.name][i][1] == itemid then
			local a = math.min(items.byId[itemid].max - data[player.name][i][2], amount)
			if a > 0 then
				left = amount - a
				amount = a
				free = i
			end
		end
	end
	-- find first free slot
	if free == -1 then
		for i = 1, config.slots do
			if data[player.name][i][1] == config.clear then
				free = i
				break
			end
		end
	end
	if amount ~= 0 then
		-- warn
		if free == -1 then
			warn("No free slots available. Cannot manually add " .. amount .. " " .. items.byId[itemid].name .. ".")
			return
		end
		-- add
		if data[player.name][free][1] == config.clear then
			data[player.name][free] = {itemid, amount}
		else
			data[player.name][free][2] = data[player.name][free][2] + amount
		end
		table.insert(toSend, {player, "load", free, data[player.name][free]})
		if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
		toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
	end
	if left > 0 then
		AddItem(player, itemid, left)
	end
end
Events.Connect("InventorySystemAddItem", AddItem)

local function RemoveItem(player, slot, amount)
	if equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot] then
		if equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot][1] == slot then
			Message("(" .. player.name .. ") Unequipping " .. items.byId[data[player.name][slot][1]].name .. ".")
			equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot][2]:Unequip(player)
			equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot][2]:Destroy()
			toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
			table.insert(toSend, {player, "unequip", equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot][1], items.byId[data[player.name][slot][1]].equipmentSlot})
			equipment[player.name][items.byId[data[player.name][slot][1]].equipmentSlot] = {nil}
		end
	end

	data[player.name][slot][2] = data[player.name][slot][2] - amount
	Message("(" .. player.name .. ") Removing " .. items.byId[data[player.name][slot][1]].name .. " from slot " .. slot .. " (x" .. amount .. ").")
	if data[player.name][slot][2] <= 0 then
		data[player.name][slot] = {config.clear}
	end
	
	if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
	table.insert(toSend, {player, "remove", slot, amount})
	toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
end

local function Receive(player, t, d1, d2, d3)
	if t == "move" then
		if data[player.name][d2][1] == config.clear then
			if data[player.name][d1][1] ~= config.clear then
				Message("(" .. player.name .. ") Moved item from slot " .. tostring(d1) .. " to " .. tostring(d2) .. ".")
				data[player.name][d2] = {data[player.name][d1][1], data[player.name][d1][2]}
				data[player.name][d1] = {config.clear}
				for k, v in pairs(equipment[player.name]) do
					if equipment[player.name][k][1] == d1 then
						equipment[player.name][k][1] = d2
					end
				end
			end
		end
	elseif t == "equip" then
		if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
		if items.byId[data[player.name][d1][1]].equipment then
			if not equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot] then
				equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot] = {}
			end
			if equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][1] == nil then
				if data[player.name][d1][1] ~= config.clear then
					if items.byId[data[player.name][d1][1]].equipment then
						Message("(" .. player.name .. ") Equipping " .. items.byId[data[player.name][d1][1]].name .. ".")
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot] = {d1, World.SpawnAsset(items.byId[data[player.name][d1][1]].equipment, {parent = script.parent})}
						if not equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:IsA("Equipment") then error("Inventory System 2.0 | " .. items.byId[data[player.name][d1][1]].name .. " - Invalid equipment.") end
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Equip(player)
						table.insert(toSend, {player, "equip", d1, items.byId[data[player.name][d1][1]].equipmentSlot})
						toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
					end
				end
			elseif equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][1] ~= d1 then
				if data[player.name][d1][1] ~= config.clear then
					if items.byId[data[player.name][d1][1]].equipment then
						Message("(" .. player.name .. ") Unequipping " .. items.byId[data[player.name][d1][1]].name .. ".")
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Unequip(player)
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Destroy()
						table.insert(toSend, {player, "unequip", equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][1], items.byId[data[player.name][d1][1]].equipmentSlot})
						toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
						Message("(" .. player.name .. ") Equipping " .. items.byId[data[player.name][d1][1]].name .. ".")
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot] = {d1, World.SpawnAsset(items.byId[data[player.name][d1][1]].equipment, {parent = script.parent})}
						if not equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:IsA("Equipment") then error("Inventory System 2.0 | " .. items.byId[data[player.name][d1][1]].name .. " - Invalid equipment.") end
						equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Equip(player)
						table.insert(toSend, {player, "equip", d1, items.byId[data[player.name][d1][1]].equipmentSlot})
						toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
					end
				end
			else
				Message("(" .. player.name .. ") Unequipping " .. items.byId[data[player.name][d1][1]].name .. ".")
				equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Unequip(player)
				equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][2]:Destroy()
				toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
				table.insert(toSend, {player, "unequip", equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot][1], items.byId[data[player.name][d1][1]].equipmentSlot})
				equipment[player.name][items.byId[data[player.name][d1][1]].equipmentSlot] = {nil}
			end
		end
	elseif t == "use" then
		if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
		if data[player.name][d1][1] ~= config.clear then
			Message("(" .. player.name .. ") Using " .. items.byId[data[player.name][d1][1]].name .. ".")
			if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
			if items.byId[data[player.name][d1][1]].use then
				items.byId[data[player.name][d1][1]].use()
				if items.byId[data[player.name][d1][1]].consumable then
					RemoveItem(player, d1, 1)
				end
			end
		end
	elseif t == "drop" then
		if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
		if data[player.name][d1][1] ~= config.clear then
			if items.byId[data[player.name][d1][1]].drop then
				Message("(" .. player.name .. ") Dropping " .. items.byId[data[player.name][d1][1]].name .. ".")
				Events.Broadcast("InventorySystemSpawnPickup", player, data[player.name][d1][1], data[player.name][d1][2])
				RemoveItem(player, d1, 1)
			end
		end
	elseif t == "destroy" then
		if toSendPlayerLeft[player] < 0 then toSendPlayerLeft[player] = 0 end
		if data[player.name][d1][1] ~= config.clear then
			Message("(" .. player.name .. ") Destroying " .. items.byId[data[player.name][d1][1]].name .. ".")
			RemoveItem(player, d1, 1)
		end
	end
end
Events.Connect("InventorySystemSend", Receive)

-- {player, itemid, amount} > {bool}
local function AddRequest(player, itemid, amount, listenid)
	if amount == nil then error("Inventory System 2.0 | No amount supplied in AddRequest.") end
	if itemid == nil then error("Inventory System 2.0 | No itemid supplied in AddRequest.") end
	if not Player.IsValid(player) then error("Inventory System 2.0 | Player data not initialized.") end
	local n = 0
	for i = 1, config.slots do
		if data[player.name][i][1] == itemid then
			n = n + (items.byId[itemid].max - data[player.name][i][2])
		elseif data[player.name][i][1] == config.clear then
			n = n + items.byId[itemid].max
		end
		if n >= amount then break end
	end
	toSendPlayerLeft[player] = toSendPlayerLeft[player] + 1
	if not (n >= amount) then
		table.insert(toSend, {player, "full"})
	end
	Events.Broadcast("=InventorySystemAddRequest", listenid, (n >= amount))
end
Events.Connect("?InventorySystemAddRequest", AddRequest)

-- {player, slot} > {itemid, amount}
local function SlotRequest(player, slot, listenid)
	if slot == nil then error("Inventory System 2.0 | No slot supplied in SlotRequest.") end
	if Player.IsValid(player) then
		if data[player.name] then
			Events.Broadcast("=InventorySystemSlotRequest", listenid, data[player.name][slot][1],
				data[player.name][slot][1] ~= config.clear and data[player.name][slot][2] or 0
			)
		else error("Inventory System 2.0 | Player data not initialized.") end
	else error("Inventory System 2.0 | Player data not initialized.") end
end
Events.Connect("?InventorySystemSlotRequest", SlotRequest)

-- {player, eqSlot} > {slot, Equipment}
local function EquipmentRequest(player, eqSlot, listenid)
	if player == nil then error("Inventory System 2.0 | No player supplied in EquipmentRequest.") end
	if eqSlot == nil then error("Inventory System 2.0 | No equipment slot supplied in EquipmentRequest.") end
	if Player.IsValid(player) then
		Events.Broadcast("=InventorySystemEquipmentRequest", listenid, equipment[player.name][eqSlot][1], equipment[player.name][eqSlot][2])
	else error("Inventory System 2.0 | Player data not initialized.") end
end
Events.Connect("?InventorySystemEquipmentRequest", EquipmentRequest)