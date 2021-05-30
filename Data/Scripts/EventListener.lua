function OnStateChanged(newState)
    print("New State = " .. newState)
end

Events.Connect("aaaa", OnStateChanged)