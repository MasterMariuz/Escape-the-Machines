
local GameUIContainer = script.parent:FindChildByName("GameUI")
local propUIPanel = GameUIContainer:GetCustomProperty("UIPanel")
local propUITextBox = GameUIContainer:GetCustomProperty("UITextBox")
local localPlayer = Game.GetLocalPlayer()
local startTime, levelTimer, deltaTime, UILevelTimerPanel, UILevelTimerText
local previousTime = time()
local firstSpawn = true
local timerMin =0
local timerHour =0
local timerIsActive =false

function UIShowLevel (level)
	local screenSize = UI.GetScreenSize()
	local showLevelBannerPanel= World.SpawnAsset(propUIPanel,{parent = GameUIContainer})
	showLevelBannerPanel.name = "LevelBannerPanel"
	showLevelBannerPanel.y = 150
	showLevelBannerPanel.width = 500
	showLevelBannerPanel.height = 300
	showLevelBannerPanel.anchor = UIPivot.TOP_CENTER
	showLevelBannerPanel.dock = UIPivot.TOP_CENTER
	
	local showLevelBannerText= World.SpawnAsset(propUITextBox,{parent = showLevelBannerPanel})
	showLevelBannerText.name = "LevelText"
	showLevelBannerText.width = 500
	showLevelBannerText.height = 300
	showLevelBannerText.anchor = UIPivot.TOP_CENTER
	showLevelBannerText.dock = UIPivot.TOP_CENTER
	showLevelBannerText.text = "Level: "..level
	
	local textColor = Color.New(1,0,0,1)
	local timerUnit = 0.1
	local timerTicks = 50 --multiplies by timerUnit to get total time for Task.Wait()
	local fade = 1
	for m=1,timerTicks do 
		fade = fade - 1/timerTicks
		textColor = Color.New(1,0,0,fade)
		showLevelBannerText:SetColor(textColor)
		Task.Wait(timerUnit)
	end
	showLevelBannerPanel:Destroy()
end


--Keybindings
function OnKeyPressed (KeyPressed)
	if(KeyPressed == "ability_extra_50") then
		Events.BroadcastToServer("MainMenuKeyPressed",localPlayer)
		ToggleLevelTimer()
	end
end

function DisplayDestroyLevelTimer()
	local screenSize = UI.GetScreenSize()
	if(Object.IsValid(GameUIContainer:FindChildByName("LevelTimer"))) then
		GameUIContainer:FindChildByName("LevelTimer"):Destroy()
	else
		UILevelTimerPanel = World.SpawnAsset(propUIPanel,{parent = GameUIContainer})
		UILevelTimerPanel.name = "LevelTimer"
		UILevelTimerPanel.y = 50
		UILevelTimerPanel.x = -50
		UILevelTimerPanel.width = 300
		UILevelTimerPanel.height = 200
		UILevelTimerPanel.anchor = UIPivot.TOP_RIGHT
		UILevelTimerPanel.dock = UIPivot.TOP_RIGHT
		
		UILevelTimerText= World.SpawnAsset(propUITextBox,{parent = UILevelTimerPanel})
		UILevelTimerText.name = "Text"
		UILevelTimerText.width = 300
		UILevelTimerText.height = 200
		UILevelTimerText.anchor = UIPivot.TOP_RIGHT
		UILevelTimerText.dock = UIPivot.TOP_RIGHT
		UILevelTimerText.justification = TextJustify.RIGHT
		UILevelTimerText.text = "Elapsed Time: "..levelTimer
	end
end

function ToggleLevelTimer()
	timerIsActive = not timerIsActive
end



function StartLevelTimer()
	startTime = time()
	levelTimer = time() - startTime
	timerIsActive = true
	print("StartLevelTimer finished")
	print(levelTimer)
end


function FinalRoomElevatorReached ()
	DisplayDestroyLevelTimer()
	firstSpawn = true
	Events.BroadcastToServer("SaveNewTimeLevelComplete", levelTimer) --connects with GameManager, sends levelTimer data
end


function NewTimeEntry (currentLevel)
	UI.PrintToScreen("CONGRATULATIONS, NEW LEVEL COMPLETED: "..currentLevel)
	print("CONGRATULATIONS, NEW LEVEL COMPLETED: "..currentLevel)
	UI.PrintToScreen("hour: "..timerHour.." Min: "..timerMin.." Sec: "..levelTimer)
	print("hour: "..timerHour.." Min: "..timerMin.." Sec: "..levelTimer)
end

function NewTimeRecord (currentLevel)
	UI.PrintToScreen("NEW RECORD! Level: "..currentLevel)
	print("NEW RECORD! Level: "..currentLevel)
	UI.PrintToScreen("in seconds: "..levelTimer)
	print("in seconds: "..levelTimer)
end


function ShowTimeRecord (currentLevel, timeRecord)
	UI.PrintToScreen("Personal Best for Level: "..currentLevel)
	print("Personal Best for Level: "..currentLevel)
	UI.PrintToScreen("in seconds: "..timeRecord)
	print("in seconds: "..timeRecord)
end




function Tick()
	deltaTime = time() - previousTime
	previousTime = time()
	if(timerIsActive == true and not(levelTimer == nil)) then
		levelTimer = levelTimer + deltaTime
		if(levelTimer >= 2) then --wait this seconds before spawning the timer for the first time
			if(firstSpawn == true) then
				firstSpawn = false
				DisplayDestroyLevelTimer()
			end
			if(levelTimer >= 60) then
				timerMin = timerMin +1
				levelTimer = levelTimer -60
			end
			if(timerMin >= 60) then
				timerHour = timerHour +1
				timerMin = timerMin -60
			end
		end
		
		--print the time in hours, mins and secs
		if(Object.IsValid(UILevelTimerText)) then 
			local th, tm, ts
			if(timerHour<=9) then
				th = "0"..timerHour
			else 
				th = timerHour
			end
			if(timerMin<=9) then
				tm = "0"..timerMin
			else
				tm = timerMin
			end
			if(math.floor(levelTimer)<=9) then
				ts = "0"..math.floor(levelTimer)
			else
				ts = math.floor(levelTimer)
			end
			
			if(timerHour >=1) then 
				UILevelTimerText.text = "Elapsed Time: "..th..":"..tm..":"..ts
			elseif(timerMin >=1) then
				UILevelTimerText.text = "Elapsed Time: "..timerMin.." min "..math.floor(levelTimer).." sec"
			else
				UILevelTimerText.text = "Elapsed Time: "..math.floor(levelTimer).." sec"
			end
		end
	elseif(timerIsActive == false) then
		--do nothing
	end
end




localPlayer.bindingPressedEvent:Connect(OnKeyPressed)
Events.Connect("UIShowLevel",UIShowLevel)
Events.Connect("StartLevelTimer",StartLevelTimer)
Events.Connect("NewTimeEntry",NewTimeEntry)
Events.Connect("NewTimeRecord",NewTimeRecord)
Events.Connect("ShowTimeRecord",ShowTimeRecord)
Events.Connect("FinalRoomElevatorReached",FinalRoomElevatorReached)
Events.Connect("ToggleLevelTimer",ToggleLevelTimer)
--Events.Connect("PauseLevelTimer",PauseLevelTimer)