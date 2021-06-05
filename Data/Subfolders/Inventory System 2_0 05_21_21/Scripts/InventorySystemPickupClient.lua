local root = script.parent.parent
local float = root:GetCustomProperty("FloatAnimation")
local rotate = root:GetCustomProperty("RotateAnimation")

if not float and not rotate then goto skip end

local floatRange = root:GetCustomProperty("FloatRange")
local floatReduction = root:GetCustomProperty("FloatReduction")
local rotateSpeed = root:GetCustomProperty("RotateSpeed")

local model = root:GetCustomProperty("Model"):GetObject()
local speed = 0
local add = 1
local max = floatRange
local up = true

local trigger = root:FindChildByName("Trigger")
local lock = false

model:SetPosition(Vector3.New(0))

local function Float(dt)
	local p = model:GetPosition()
	p.z = p.z + speed/floatReduction*dt*60
	model:SetPosition(p)
end

local function Rotate(dt)
	local r = model:GetRotation()
	r.y = r.y + rotateSpeed * speed/100*dt*60
	r.z = r.z + rotateSpeed*dt*60
	model:SetRotation(r)
end

function Tick(dt)
	if speed >= 0 then
		if speed >= max then
			up = false
		end
	else
		if speed <= -max then
			up = true
		end
	end
	speed = speed + add * (up == true and 1 or -1)*dt*60
	if float then Float(dt) end
	if rotate then Rotate(dt) end
end

::skip::