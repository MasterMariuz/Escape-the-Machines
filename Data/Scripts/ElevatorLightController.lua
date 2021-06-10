
local lightsource = script.parent.parent
local trigger = script.parent
local lightOn = true
local m = 0
local n = 30

function StepOnElevatorLight()
	m=0
	lightOn = true
	if(Object.IsValid(lightsource)==true) then
		repeat
			lightsource:SetColor(Color.New(m/n,0,1))
			m= m+1
			Task.Wait()
		until (m==n or lightOn == false or Object.IsValid(lightsource)==false)
	end
end

function StepOffElevatorLight()
	m=0
	lightOn = false
	if(Object.IsValid(lightsource)==true) then
		repeat
			lightsource:SetColor(Color.New(1-m/n,0,1))
			m= m+1
			Task.Wait()
		until (m==n or lightOn == true or Object.IsValid(lightsource)==false)
	end
end

trigger.beginOverlapEvent:Connect(StepOnElevatorLight)
trigger.endOverlapEvent:Connect(StepOffElevatorLight)