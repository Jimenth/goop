local Version = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Version.lua"))()
local Source = "https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Extra/Offsets/" .. Version .. "/Offsets.hpp"

local Offsets = {}

local function ParseSource(Response)
    local Stack = {}
    local Current = nil

    local function Resolve()
        for Index = #Stack, 1, -1 do
            if Stack[Index]:lower() ~= "offsets" then
                return Stack[Index]
            end
        end
        return nil
    end

    for Line in Response:gmatch("[^\r\n]+") do
        local Namespace = Line:match("^%s*namespace%s+(%w+)%s*{")
        if Namespace then
            table.insert(Stack, Namespace)
            Current = Resolve()
            if Current then
                Offsets[Current] = Offsets[Current] or {}
            end
        end

        if Current then
            local Name, Hex = Line:match(
                "inline%s+constexpr%s+uintptr_t%s+(%w+)%s*=%s*(0x%x+)"
            )
            if Name and Hex and Offsets[Current][Name] == nil then
                Offsets[Current][Name] = tonumber(Hex)
            end
        end

        if Line:match("^%s*}") then
            table.remove(Stack)
            Current = Resolve()
        end
    end
end

local function VersionMatches(Embedded)
    if not Embedded or not Version then
        return true
    end
    local Target = tostring(Version)
    return Embedded == Target or Embedded:find(Target, 1, true) ~= nil or Target:find(Embedded, 1, true) ~= nil
end

local Ok, Response = pcall(function()
    return game:HttpGet(Source)
end)

if not Ok or not Response or #Response == 0 then
    send_notification("Offsets: failed to fetch -- " .. Source, "warning")
    return nil
end

local Embedded = Response:match('roblox_version%s*=%s*"([^"]+)"')
if not VersionMatches(Embedded) then
    send_notification("Offsets: fetched file reports version " .. tostring(Embedded) .. " but expected " .. tostring(Version) .. " -- using it anyway", "warning")
end

ParseSource(Response)

if next(Offsets) == nil then
    send_notification("Offsets: fetched successfully but no offsets were parsed out of it", "warning")
    return nil
end

return Offsets
