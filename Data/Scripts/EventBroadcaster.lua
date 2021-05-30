local currentState = ""

function SetState(newState)
    currentState = newState
    Events.Broadcast("aaaa", newState)
end

function Tick(deltaTime)
    SetState("Lobby")
    Task.Wait(1)
    SetState("Playing")
    Task.Wait(3)
end