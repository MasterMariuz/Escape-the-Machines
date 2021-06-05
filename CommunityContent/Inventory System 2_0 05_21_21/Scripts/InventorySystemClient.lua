local config = require(script.parent.parent:GetCustomProperty("ConfigRequire"))
local items = require(script.parent.parent:GetCustomProperty("ItemsRequire"))

local buttonMUID = script:GetCustomProperty("ButtonMUID")
local valueMUID = script:GetCustomProperty("ValueMUID")
local valueBarMUID = script:GetCustomProperty("ValueBarMUID")

local main = script.parent:FindDescendantByName("Inventory")
local scroll = script.parent:FindDescendantByName("Scroll")
local dropdown = script.parent:FindDescendantByName("Dropdown")
local message = script.parent:FindDescendantsByName("Message")
local bg = script.parent:FindDescendantByName("Background")
local dof = script.parent:FindDescendantByName("DOF")
local loading = script.parent:FindDescendantByName("Loading")
local tooltip = script.parent:FindDescendantByName("Tooltip")
local tooltipName = tooltip:FindChildByName("Name")
local tooltipDesc = tooltip:FindChildByName("Description")
local tooltipStats = {}
local overlay = bg:FindChildByName("Overlay")
local dropdownB = {
	move = dropdown:FindChildByName("Move"),
	equip = dropdown:FindChildByName("Equip"),
	use = dropdown:FindChildByName("Use"),
	drop = dropdown:FindChildByName("Drop"),
	destroy = dropdown:FindChildByName("Destroy")
}

local highlights = main:FindDescendantsByName("Bar")
for i = 1, #highlights do
	highlights[i] = highlights[i]:GetChildren()[1]
	highlights[i].visibility = Visibility.INHERIT
end

for i = 1, #message do
	message[i].text = ""
end

local moveSFX = script.parent:FindChildByName("Move SFX")
local dropdownSFX = script.parent:FindChildByName("Dropdown SFX")
local selectSFX = script.parent:FindChildByName("Select SFX")
local openSFX = script.parent:FindChildByName("Open SFX")

loading.visibility = Visibility.INHERIT
tooltip.visibility = Visibility.FORCE_OFF

Task.Wait()

-- broadcast queue
local toSend = {}
local sendWait = 0

-- player data
local data = {}
local loaded = false
local equipped = {}

for i = 1, config.slots do
	data[i] = {config.clear}
end

-- ui
local buttons = {}
local open = false
local mainX = {-360, main.x}
main.x = mainX[1]

-- dropdown
local dropdownCur = nil
local dropdownH = dropdown.height
dropdown.height = 0

-- icon drag
local drag = nil
local dragFrom = nil

-- ui lock
local locked = false

-- tooltip
local tooltipWait = -1
local hover = nil

-- message
local messageLeft = 0

if config.startupList then
	for i = 1, #items.byId do
		print(i, items.byId[i].name)
	end
end

-- fancy print
local function Message(s)
	if not config.log then return end
	print("[" .. Game.GetLocalPlayer().name .. "] Inventory System 2.0 | " .. s)
end

-- inventory open
local function Open(b)
	open = b
	UI.SetCanCursorInteractWithUI(b)
	UI.SetCursorVisible(b)
	if not open then dropdownCur = nil end
	if dropdownCur then dropdownCur = nil end
	if drag ~= nil then
		drag.parent = dragFrom
		drag.x = 0
		drag.y = 0
		drag = nil
	end
	openSFX:Play()
end

local function ShowMessage(string)
	for i = 1, #message do
		message[i].text = string 
		local c = message[i]:GetColor()
		c.a = 1
		message[i]:SetColor(c)
	end
	messageLeft = 5
end
Events.Connect("InventorySystemShowMessage", ShowMessage)

-- data loading finished
local function Loaded()
	loading.visibility = Visibility.FORCE_OFF
end
Events.Connect("InventorySystemLoaded", Loaded)

-- appr
local function Approach(a, b, c, dt)
	if dt then c = c/dt/60 end
	if a < b then
		a = a + c
	end
	if a > b then
		a = a - c
	end
	return a
end

local function Send()
	-- send data in queue to server
	if toSend[1] then
		local r = Events.BroadcastToServer("InventorySystemSend", Game.GetLocalPlayer(), toSend[1][1], toSend[1][2], toSend[1][3], toSend[1][4])
		if r == BroadcastEventResultCode.SUCCESS or r == BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT then
			Message("Sending data to Server: {" .. tostring(toSend[1][1]) .. ", " .. tostring(toSend[1][2]) .. ", " .. tostring(toSend[1][3]) .. ", " .. tostring(toSend[1][4]) .. "}.") 
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
end

local v, avo, lavo, xx, yy, hoverLast, x, w = 0, 0, 0, 0, 0, 0, 0
function Tick(dt)
	if locked then if open then Open(false) end end
	Send()

	local pos = UI.GetCursorPosition()
	-- inventory approach
	v = open and 100 or 0
	avo = Approach(avo, v, math.abs(avo - v)/(open and 4 or 5))

	main.x = math.floor((avo/100)*(mainX[2]-mainX[1])+mainX[1])
	dof:SetSmartProperty("Blend Weight", avo/100+0.0025)
	dof.visibility = (avo < 1) and Visibility.FORCE_OFF or Visibility.INHERIT
	if not config.DOF then dof.visibility = Visibility.FORCE_OFF end
	do
		local b = bg:GetColor()
		b.a = math.min(100, avo*2)/500
		bg:SetColor(b)
	end

	lavo = avo

	-- message
	if messageLeft > 0 then
		messageLeft = messageLeft - dt
	else
		if message[1]:GetColor().a ~= 0 then
			for i = 1, #message do
				local c = message[i]:GetColor()
				c.a = math.max(0, c.a - dt*6)
				message[i]:SetColor(c)
			end
		end
	end

	-- tooltip
	if hover then
		if tooltipWait <= 0 and open and not dropdownCur then
			tooltip.visibility = Visibility.INHERIT
			tooltip.x = pos.x
			tooltip.y = pos.y

			-- tooltip slider approach
			if x then
				if w then
					local it = items.byId[data[tonumber(hover.name)][1]]
					for i = 1, #tooltipStats do
						if type(it.stats[i][2]) == "number" then
							if it.stats[i][3] then
								local v = math.ceil((it.stats[i][2]/it.stats[i][3])*(w - x*2))
								local bar = tooltipStats[i]:FindDescendantByName("Bar")
								if v ~= bar.width then
									bar.width = math.ceil(Approach(
										bar.width, v, math.abs(bar.width - v)/4
									))
								end
							end
						end
					end
				end
			end
		else
			tooltip.visibility = Visibility.FORCE_OFF
		end

		if tooltipWait > 0 then
			tooltipWait = tooltipWait - dt
		end
	else tooltip.visibility = Visibility.FORCE_OFF end


	-- dropdown approach
	v = dropdownCur and dropdownH or 0
	dropdown.height = math.floor(Approach(dropdown.height, v, math.abs(dropdown.height - v)/3))

	-- highlights
	for i = 1, #highlights do
		highlights[i].x = pos.x - highlights[i].parent.x - highlights[i].parent.parent.x - highlights[i].width/2
		highlights[i].y = pos.y - highlights[i].parent.y - highlights[i].parent.parent.y - highlights[i].height/2
	end
	-- drag approach
	if drag then
		if pos.x >= 0 and pos.y >= 0 then
			xx = pos.x - drag.width/2 - drag.parent.x - drag.parent.parent.x
			yy = pos.y - drag.height/2 - drag.parent.y - drag.parent.parent.y
		end
		drag.x = Approach(drag.x, xx, math.abs(drag.x - xx)/4) 
		drag.y = Approach(drag.y, yy, math.abs(drag.y - yy)/4) 
	end
end

-- keybinds
local function OnKeybindPressed(_, k)
	if k == "ability_extra_20" then
		Open(not open)
	end
end
Game.GetLocalPlayer().bindingPressedEvent:Connect(OnKeybindPressed)

-- click
local function OnButtonClicked(button, b)
	local icon = button:FindChildByType("UIPanel")
	if drag == nil then
		if icon then
			if dropdownCur == button then
				dropdownCur = nil
			else
				for k, v in pairs(dropdownB) do
					v.visibility = Visibility.INHERIT
					v.isInteractable = true
					v:FindChildByType("UIText"):SetColor(Color.New(1, 1, 1, 1))
				end
				local id = data[tonumber(button.name)][1]
				if id then
					if not items.byId[id].equipment then
						dropdownB.equip.isInteractable = false
						dropdownB.equip:FindChildByType("UIText"):SetColor(Color.New(1, 1, 1, 0.5))
					end
					if not items.byId[id].use then
						dropdownB.use.isInteractable = false
						dropdownB.use:FindChildByType("UIText"):SetColor(Color.New(1, 1, 1, 0.5))
					end
					if not items.byId[id].drop then
						dropdownB.drop.isInteractable = false
						dropdownB.drop:FindChildByType("UIText"):SetColor(Color.New(1, 1, 1, 0.5))
					end
					if not items.byId[id].canDestroy then
						dropdownB.destroy.isInteractable = false
						dropdownB.destroy:FindChildByType("UIText"):SetColor(Color.New(1, 1, 1, 0.5))
					end
				end
				
				local p = UI.GetCursorPosition()
				dropdownCur = button
				dropdown.x = button.x + button.width/2
				dropdown.y = button.y + button.height/2
				dropdown.x = math.min(scroll.width+dropdown.width, dropdown.x)
				dropdown.height = -dropdown.height
			end
			dropdownSFX:Play()
		else
			dropdownCur = nil
		end
	elseif not b then
		if icon == nil then
			drag.parent = button
			drag.x = 0
			drag.y = 0
			drag = nil
			if dragFrom ~= button then
				local f = tonumber(dragFrom.name)
				local t = tonumber(button.name)
				for k, v in pairs(equipped) do
					if v == f then
						equipped[k] = t
					end
				end
				data[t] = {data[f][1], data[f][2]}
				data[f] = {config.clear}
				table.insert(toSend, {"move", f, t})
			end
			moveSFX:Play()
		end
	end
end

local function Equip(slot, eqSlot)
	equipped[eqSlot] = slot
	scroll:FindChildByName(tostring(slot)):FindChildByType("UIPanel"):FindChildByName("Equipped").visibility = Visibility.INHERIT
end

local function Unequip(eqSlot)
	if equipped[eqSlot] ~= nil then
		scroll:FindChildByName(tostring(equipped[eqSlot])):FindChildByType("UIPanel"):FindChildByName("Equipped").visibility = Visibility.FORCE_OFF
		equipped[eqSlot] = nil
	end
end

-- add icon
local function Receive(t, d1, d2)
	if t == "load" then
		data[d1] = {d2[1], d2[2]}
		local icon = scroll:FindChildByName(tostring(d1)):FindChildByType("UIPanel")
		if icon then icon:Destroy() end
		if items.byId[d2[1]].icon == nil then error(items.byId[d2[1]].name .. " doesn't have an icon.") end
		icon = World.SpawnAsset(items.byId[d2[1]].icon, {parent = scroll:FindChildByName(tostring(d1))})
		local text = icon:FindDescendantsByType("UIText")
		for i = 1, #text do
			text[i].text = items.byId[d2[1]].max == 1 and "" or tostring(d2[2])
		end
		ShowMessage("Added (x" .. d2[2] .. ") " .. items.byId[d2[1]].name)
	elseif t == "move" then
		warning("Inventory System 2.0 | Inventory desynced.")
	elseif t == "equip" then
		Unequip(d2)
		Equip(d1, d2)
	elseif t == "unequip" then
		Unequip(d2)
	elseif t == "remove" then
		local icon = scroll:FindChildByName(tostring(d1)):FindChildByType("UIPanel")
		local text = icon:FindDescendantsByType("UIText")
		local n = data[d1][2] - d2
		ShowMessage("Removed (x" .. d2 .. ") " .. items.byId[data[d1][1]].name)
		if n > 0 then
			data[d1][2] = data[d1][2] - d2
			for i = 1, #text do
				text[i].text = items.byId[data[d2][1]].max == 1 and "" or tostring(n)
			end
		else
			data[d1] = {config.clear}
			icon:Destroy()
		end
	elseif t == "lock" then
		locked = true
	elseif t == "unlock" then
		locked = false
	elseif t == "full" then
		ShowMessage("Inventory full")
	end
end
Events.Connect("InventorySystemLoad", Receive)

local function Drag(button)
	if dropdownCur == nil or drag ~= nil then return end
	local icon = dropdownCur:FindChildByType("UIPanel")
	icon.x = icon.parent.x
	icon.y = icon.parent.y
	icon.parent = main
	drag = icon
	dragFrom = dropdownCur
end

-- use item using dropdown options
local function Dropdown(button)
	if button.name == "Move" then
		Drag(button)
	elseif button.name == "Equip" then
		loading.visibility = Visibility.INHERIT
		table.insert(toSend, {"equip", tonumber(dropdownCur.name)})
	elseif button.name == "Use" then
		loading.visibility = Visibility.INHERIT
		table.insert(toSend, {"use", tonumber(dropdownCur.name)})
	elseif button.name == "Drop" then
		loading.visibility = Visibility.INHERIT
		table.insert(toSend, {"drop", tonumber(dropdownCur.name)})
	elseif button.name == "Destroy" then
		loading.visibility = Visibility.INHERIT
		table.insert(toSend, {"destroy", tonumber(dropdownCur.name)})
	end
	for k, v in pairs(dropdownB) do
		v.visibility = Visibility.FORCE_OFF
	end
	dropdownCur = nil
	selectSFX:Play()
end

local function Hover(button)
	if button:FindChildByType("UIPanel") then
		tooltipWait = config.tooltipDelay
		hover = button

		local it = items.byId[data[tonumber(button.name)][1]]

		tooltipName.text = it.name
		tooltipDesc.text = it.description
		local ns = tooltipName:ComputeApproximateSize()
		local ds = tooltipDesc:ComputeApproximateSize()
		w = math.floor(math.max(ns.x, ds.x)) + tooltipName.x*2
		
		local y = tooltipName.y + ns.y
		x = tooltipName.x

		tooltip.width = w

		tooltipDesc.y = y
		y = y + math.ceil(ds.y)

		local sp = 6
		if #it.stats > 0 then y = y + 10 end
		for i = 1, #it.stats do
			if type(it.stats[i][2]) == "number" and it.stats[i][3] then
				tooltipStats[#tooltipStats+1] = World.SpawnAsset(valueBarMUID, {parent = tooltip})
				tooltipStats[#tooltipStats].x = x
				tooltipStats[#tooltipStats].y = y
				tooltipStats[#tooltipStats].text = tostring(it.stats[i][1])
				tooltipStats[#tooltipStats]:FindDescendantByName("Value").text = tostring(it.stats[i][2])

				y = y + tooltipStats[#tooltipStats].height + 2
				sp = 8
			else
				tooltipStats[#tooltipStats+1] = World.SpawnAsset(valueMUID, {parent = tooltip})
				tooltipStats[#tooltipStats].x = x
				tooltipStats[#tooltipStats].y = y
				tooltipStats[#tooltipStats].text = tostring(it.stats[i][1] .. ":")
				tooltipStats[#tooltipStats]:FindDescendantByName("Value").text = tostring(it.stats[i][2])

				y = y + tooltipStats[#tooltipStats].height + 2
				sp = 5
			end
		end

		Task.Wait()

		for i = 1, #tooltipStats do
			if type(it.stats[i][2]) == "number" and it.stats[i][3] then
				w = math.ceil(math.max(w, (tooltipStats[i]:FindDescendantByName("Value"):ComputeApproximateSize() + tooltipStats[#tooltipStats]:ComputeApproximateSize()).x) + 10)
			else
				w = math.ceil(math.max(w, (tooltipStats[i]:FindDescendantByName("Value"):ComputeApproximateSize() + tooltipStats[#tooltipStats]:ComputeApproximateSize()).x) + 10)
			end
		end

		tooltip.width = w

		for i = 1, #tooltipStats do
			if type(it.stats[i][2]) == "number" and it.stats[i][3] then
				tooltipStats[i]:FindChildByName("Background").width = w - x*2
				tooltipStats[i]:FindDescendantByName("Bar").width = 0
			else
				tooltipStats[i]:FindChildByName("Background").width = w - x*2
			end
		end

		--y = y + tooltipName.y
		tooltip.height = math.floor(y+sp)
	else hover = nil end
end

local function Unhover(button)
	hover = nil
	for i = 1, #tooltipStats do
		tooltipStats[1]:Destroy()
		table.remove(tooltipStats, 1)
	end
end

for k, v in pairs(dropdownB) do
	v.clickedEvent:Connect(Dropdown)
end

-- create slots
for i = 1, config.slots do
	buttons[i] = World.SpawnAsset(buttonMUID, {parent = scroll})
	buttons[i].name = tostring(i)
	buttons[i].x = 10 + (i-1)%3 * 105
	buttons[i].y = math.floor((i-1)/3) * 105
	buttons[i].clickedEvent:Connect(OnButtonClicked)
	buttons[i].hoveredEvent:Connect(Hover)
	buttons[i].unhoveredEvent:Connect(Unhover)
end
overlay.clickedEvent:Connect(OnButtonClicked, true)
dropdown.parent = nil
dropdown.parent = scroll