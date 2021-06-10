local upArrow = script.parent

function UpArrowClicked()
	Events.Broadcast("ChangeLevel",-1)
end

upArrow.clickedEvent:Connect(UpArrowClicked)