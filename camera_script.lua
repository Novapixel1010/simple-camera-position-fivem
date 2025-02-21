local QBCore = exports['qb-core']:GetCoreObject()
-- Function to get the position the camera is pointing at
function getCameraAimPosition()
    -- Get the camera's position and direction
    local cameraPos = GetGameplayCamCoord()  -- Camera position
    local cameraRot = GetGameplayCamRot(0)  -- Camera rotation

    -- Convert the camera rotation to a vector direction
    local rotation = GetEntityForwardVector(PlayerPedId())  -- Gets the direction you're facing
    local aimPosition = vector3(cameraPos.x + rotation.x * 10.0, cameraPos.y + rotation.y * 10.0, cameraPos.z + rotation.z * 10.0)

    -- Trigger a custom event to handle the camera position
    TriggerEvent("cam:printCameraPos", aimPosition) -- You can change the event name as needed
end

-- Register a command to print the camera's aimed position
RegisterCommand("getCamera", function()
    getCameraAimPosition()
end, false)

-- Optionally bind the "getCameraAimPos" command to a keypress (e.g., F7)
-- RegisterKeyMapping("getCameraAimPos", "Print Camera Aim Position", "keyboard", "F7")

-- Register the custom event for printing camera position
RegisterNetEvent('cam:printCameraPos', function(aimPosition)
    -- Using QBCore to show a notification (adjust according to your framework)
    QBCore.Functions.Notify("Camera is pointing at: x = " .. string.format("%.2f", aimPosition.x) .. 
                             ", y = " .. string.format("%.2f", aimPosition.y) .. 
                             ", z = " .. string.format("%.2f", aimPosition.z), 'success', 30000)  -- 10000 ms = 10 seconds
end)
