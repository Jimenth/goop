local Version = tostring(game:GetClientVersion())
local MainSource = "https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Extra/Offsets/{Version}/Offsets.hpp"

local Sources = {
    "https://getvexor.fyi/offsets.hpp"
}

local Offsets = {}

--// Helpers

local function Notify(Message)
    send_notification("Offsets: " .. Message, "warning")
end

local function Expand(Url)
    return (Url:gsub("{Version}", function()
        return Version
    end))
end

local function Fetch(Url)
    local Ok, Response = pcall(function()
        return game:HttpGet(Url)
    end)

    if Ok and type(Response) == "string" and #Response > 0 then
        return Response
    end

    return nil
end

local function VersionMatches(Embedded)
    if not Embedded or not Version then
        return true
    end

    return Embedded == Version
        or Embedded:find(Version, 1, true) ~= nil
        or Version:find(Embedded, 1, true) ~= nil
end

--// Parser

local function ParseInto(Target, Response)
    local Stack = {}
    local Current = nil
    local Added = 0

    local function Resolve()
        for Index = #Stack, 1, -1 do
            if Stack[Index]:lower() ~= "offsets" then
                return Stack[Index]
            end
        end

        return nil
    end

    for Line in Response:gmatch("[^\r\n]+") do
        local Namespace = Line:match("^%s*namespace%s+([%w_]+)%s*{")

        if Namespace then
            table.insert(Stack, Namespace)
            Current = Resolve()

            if Current then
                Target[Current] = Target[Current] or {}
            end
        end

        if Current then
            local Name, Hex = Line:match("inline%s+constexpr%s+uintptr_t%s+([%w_]+)%s*=%s*(0x%x+)")

            if Name and Target[Current][Name] == nil then
                Target[Current][Name] = tonumber(Hex)
                Added += 1
            end
        end

        if Line:match("^%s*}") then
            table.remove(Stack)
            Current = Resolve()
        end
    end

    return Added
end

--// Loader

local function Load(Template)
    local Url = Expand(Template)
    local Response = Fetch(Url)

    if not Response then
        Notify("failed to fetch -- " .. Url)
        return 0
    end

    local Embedded = Response:match('roblox_version%s*=%s*"([^"]+)"')

    if not VersionMatches(Embedded) then
        Notify(("%s reports version %s but expected %s -- using it anyway"):format(Url, tostring(Embedded), Version))
    end

    local Added = ParseInto(Offsets, Response)

    if Added == 0 then
        Notify("fetched " .. Url .. " but no offsets were parsed out of it")
    end

    return Added
end

if Load(MainSource) == 0 then
    local Seen = { [Expand(MainSource)] = true }

    for _, Template in ipairs(Sources) do
        local Url = Expand(Template)

        if not Seen[Url] then
            Seen[Url] = true
            Load(Template)
        end
    end
end

if next(Offsets) == nil then
    Notify("no offsets could be loaded from any source")
    return nil
end

return Offsets
