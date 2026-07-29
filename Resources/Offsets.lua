local Version = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Version.lua"
))()

local URL = "https://offsets.imtheo.lol/" .. Version .. "/offsets.hpp"

local success, response = pcall(function()
    return game:HttpGet(URL)
end)

if not success then
    send_notification("Failed to fetch offsets: " .. tostring(response), "warning")
    return nil
end

if not response or #response == 0 then
    send_notification("Offsets response was empty", "warning")
    return nil
end

local Offsets = {}

local NamespaceStack = {}
local CurrentSpace = nil

for Line in response:gmatch("[^\r\n]+") do
    local Namespace = Line:match("^%s*namespace%s+(%w+)%s*{")

    if Namespace then
        table.insert(NamespaceStack, Namespace)

        if Namespace ~= "Offsets" then
            CurrentSpace = Namespace
            Offsets[CurrentSpace] = Offsets[CurrentSpace] or {}
        end
    end

    if CurrentSpace then
        local Name, Hex = Line:match(
            "inline%s+constexpr%s+uintptr_t%s+(%w+)%s*=%s*(0x%x+)"
        )

        if Name and Hex then
            Offsets[CurrentSpace][Name] = tonumber(Hex)
        end
    end

    if Line:match("^%s*}") then
        table.remove(NamespaceStack)

        CurrentSpace = nil

        for i = #NamespaceStack, 1, -1 do
            if NamespaceStack[i] ~= "Offsets" then
                CurrentSpace = NamespaceStack[i]
                break
            end
        end
    end
end

return Offsets
