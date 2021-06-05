--[[
	-----------------------------------------------
	Registering an item:
		- Call the function Add() with the following arguments
			- name - A readable string used to identify an item in code as well as in-game.
			- icon - The MUID of the icon used in-game by the item.
			- equipment - The MUID of the equipment template spawned and equipped in-game.
			  				  Set to nil to disable.
			- equipmentSlot - The name of the slot used by the equipment.
			- use - The function called from the server upon the items use.
			- drop - The MUID of the pickup object for this item.
		  			 Set to nil to disable.
			- consumable - When set to true the item will disappear upon use.
			- canDestroy - When set to true players can remove this item form their inventory.
			- max - The maximum amount of this item that a single slot can hold.
			- stats - A table with item statistics displayed in the items tooltip.
					  Every entry should be a table with 2-3 entries depending on the type of the stat.
					  Number stats should look like this: {string, number}.
					  Number range stats (with a max value) should look like this: {string, number, number}.
					  String stats should look like this: {string, string}.
			- description - A string containing a description of the item, displayed in its tooltip.

		The errors preventing you from certain argument combinations are here for technical reasons.
		Removing them from code is not a solution.
]]

local items = {byId = {}, byName = {}}

-- registers an item
local function Add(name, icon, equipment, equipmentSlot, use, drop, consumable, canDestroy, max, stats, description)
	items.byId[#items.byId+1] = {name = name, icon = icon, equipment = equipment, equipmentSlot = equipmentSlot, use = use, drop = drop, consumable = consumable, canDestroy = canDestroy, max = max, stats = stats, description = description}
	if items.byId[#items.byId].equipment then
		if items.byId[#items.byId].consumable or items.byId[#items.byId].max > 1 then
			items.byId[#items.byId] = nil
			error("(ItemID " .. #items.byId .. ") An item cannot be both consumable/stackable and equippable at the same time.")
		end
		if items.byId[#items.byId].use then
			if type(items.byId[#items.byId].use) ~= "function" then
				error("(ItemID " .. #items.byId .. ") use has to be a function.")
			end
		end
		if not items.byId[#items.byId].equipmentSlot then
			error("(ItemID " .. #items.byId .. ") No equipmentSlot supplied.")
		end
	end
	if not items.byId[#items.byId].icon then
		error("(ItemID " .. #items.byId .. ") No icon supplied.")
	end
	for k, v in pairs(items.byId[#items.byId].stats) do
		if type(v[2]) == "number" then
			if v[3] then
				if type(v[3]) ~= "number" then
					error("(ItemID " .. #items.byId .. ") Range cap must be a number.")
				end
			end
		end
	end
	items.byName[name] = #items.byId
end

-- REGISTER HERE
-- \/ \/ \/

Add("item", "", nil, "", nil, nil, false, true, 1, {}, "")

-- /\ /\ /\
-- REGISTER HERE

--[[
	Add(name, iconMUID,
		equipmentMUID, equipmentSlot,
		useFunction,
		dropMUID,
		isConsumable, canDestroy, stackAmount,
		statsTable,
		description
	)
]]

return items