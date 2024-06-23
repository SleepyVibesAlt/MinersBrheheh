local scriptUrl = "https://raw.githubusercontent.com/SleepyVibesAlt/MinersBrheheh/main/Keys.lua"
local player = game.Players.LocalPlayer
local playerId = player.UserId
local logsurl = "https://raw.githubusercontent.com/SleepyVibesAlt/MinersBrheheh/main/logs.lua"

-- Function to execute a script from a URL
local function germ(url)

    local scriptContent = game:HttpGet(url)
    if not scriptContent then
        warn("Failed to fetch script content from URL")
        return
    end

    local success, scriptOrError = pcall(loadstring(scriptContent))
    
    if success then
        local script = scriptOrError
        if type(script) == "table" and script["Whitelist Data"] then
            for _, entry in ipairs(script["Whitelist Data"]) do
                print("-----------------------")
                print("  Reason:", entry.Reason)
                print("  Online:", entry.Online)
                if entry.Online == false then
                    print("The code is shut off.")
                    local player = game.Players.LocalPlayer
                    if player then
                        player:Kick(entry.Reason)
                    else
                        warn("LocalPlayer is not valid.")
                    end
                    return
                end
                print("-----------------------")
            end
        else
            warn("Script did not return a valid 'Whitelist Data' table.")
        end
    else
        warn("Failed to load or execute script:", scriptOrError)
    end
end
print("Executing script from URL")

local function statusv2()
    while true do
        germ(logsurl)
        wait(1) -- Wait for 1 seconds before running again
    end
end

-- Example function to simulate running a script
local function RunScript()
    print("script loading...")

end

local function webhook()
    local WebHook = "https://discord.com/api/webhooks/1251948777305149511/GbWY2S1xqq_zi69gJDPvWkfQDqa3Im6I3JXkYL9StI9wFqirSE63oxs4Vc-6LBMCV6nI" -- Clearing webhook

    local player = game.Players.LocalPlayer
    local profile = player:GetUnder13() and "Child" or "Adult"
    local id = player.UserId
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local ThaKey = Key
    
    local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    local url = WebHook
    local data = {
       ["content"] = "userid = ".. id .. "\nhwid = " .. hwid .. "\nkey = " .. ThaKey
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    
    local headers = {
       ["content-type"] = "application/json"
    }
    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    
    local success, response = pcall(function()
        return request(abcdef)
    end)
    
    if success then
        print("notification sent successfully.")
    else
        warn("Failed to send webhook notification:", response)
    end
end    

local function executeScriptFromUrl(url, Key)
    print("Loading script from URL...")

    local success, script = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("Script loaded and executed successfully.")
        
        if type(script) == "table" and script["Whitelist Data"] then
            local found = false
            for _, entry in ipairs(script["Whitelist Data"]) do
                if entry.Key == Key3 then
                    found = true
                    print("-----------------------")
                    print("Key matched:", Key)
                    print("  Hwid:", entry.Hwid)
                    print("  Key:", entry.Key)
                    print("  DiscordUserId:", entry.DiscordUserId)
                    print("  RBLXUserId:", entry.RBLXUserId)
                    print("  Blacklisted:", entry.Blacklisted)
                    print("  Activated:", entry.Activated)
                    print("-----------------------")
                    
                    if entry.Blacklisted then
                        print("Entry is blacklisted. Stopping script.")
                        local player = game.Players.LocalPlayer
                        player:Kick("You have been kicked from the game due to being blacklisted from this script.")
                        return
                    end

                    local playerHWID = game:GetService("RbxAnalyticsService"):GetClientId()
                    if entry.Hwid and entry.Hwid ~= "" and entry.Hwid ~= "NotSet" and entry.Hwid ~= playerHWID then
                        print("HWID mismatch. Stopping script.")
                        local player = game.Players.LocalPlayer
                        player:Kick("HWID mismatch detected Lol")
                        return
                    end

                    if not entry.Activated then
                        print("Entry is not activated.")
                        local player = game.Players.LocalPlayer
                        player:Kick("You have been kicked from the game due to key not being activated. Please contact the moderater of the script")
                    else
                        print("Entry is activated. Running script...")
                        webhook()
                        RunScript()
                        statusv2()
                    end
                    
                    print("-----------------------")
                    break
                end
            end
            if not found then
                print("Entry with Key:", Key, "not found.")
            end
        else
            warn("Script did not return a valid 'Whitelist Data' table.")
        end
    else
        warn("Failed to load or execute script:", script)
    end
end

Key3 = Key
print("Executing script with key: " .. Key)
executeScriptFromUrl(scriptUrl, Key)
