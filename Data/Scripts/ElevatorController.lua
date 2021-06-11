
local elevator = script.parent
local elevatorWalls = elevator:FindChildByName("ElevatorWalls")
local lightsource = elevator:FindChildByName("LightBeacon")
local trigger = elevator:FindChildByName("Trigger")
local glassWalls = elevator:FindChildByName("ElevatorGlass")
local lightOn = true
local m = 0
local n = 30
if(Object.IsValid(script.parent.parent.parent)) then 
	floorFolder = script.parent.parent.parent
else 
	floorFolder = script.parent.parent
end
print("floorLevel number: "..floorFolder.name)
local floorLevel = CoreString.Split(floorFolder.name," ")
print("floorLevel number: "..floorLevel)

function CloseElevatorWalls(other)
	print("Final Room Elevator Reached!")
	glassWalls.visibility = Visibility.FORCE_ON
	local timeToClose=15 --in frames
	for m=1,timeToClose do
		local newPosition = glassWalls:GetPosition()
		newPosition.z = newPosition.z +600/timeToClose
		glassWalls:SetPosition(newPosition)
		Task.Wait()
	end
	Task.Wait(0.3)
	elevatorWalls.visibility = Visibility.FORCE_ON
	local timeToClose=60 --in frames
	for m=1,timeToClose do
		newPosition = elevatorWalls:GetPosition()
		newPosition.z = newPosition.z +600/timeToClose		
		elevatorWalls:SetPosition(newPosition)
		Task.Wait()
		print("moving elevator frame: "..m)
	end
	print("LEVEL COMPLETE!")
	Events.Broadcast("FinalRoomElevatorReached",other)
end


function StepOnElevatorLight(trigger,other)
	if(other:IsA("Player")) then 
		m=0
		lightOn = true
		if(Object.IsValid(lightsource)==true) then
			repeat
				lightsource:SetColor(Color.New(m/n,0,1))
				m= m+1
				Task.Wait()
			until (m==n or lightOn == false or Object.IsValid(lightsource)==false)
		end
		
		if(elevatorWalls:GetPosition() == Vector3.New(0,0,-300)) then
			CloseElevatorWalls(other)
		end
	end
end

function StepOffElevatorLight(trigger,other)
	if(other:IsA("Player")) then 
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
end

trigger.beginOverlapEvent:Connect(StepOnElevatorLight)
trigger.endOverlapEvent:Connect(StepOffElevatorLight)