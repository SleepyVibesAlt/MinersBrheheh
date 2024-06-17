local scriptUrl = "https://raw.githubusercontent.com/SleepyVibesAlt/MinersBrheheh/main/Keys.lua"
local player = game.Players.LocalPlayer
local playerId = player.UserId

-- Example function to simulate running a script
local function RunScript()
    print("Running script...")
    -- Replace with your actual script logic
end

local function webhook()
    local Webhook = "https://discord.com/api/webhooks/1251948777305149511/GbWY2S1xqq_zi69gJDPvWkfQDqa3Im6I3JXkYL9StI9wFqirSE63oxs4Vc-6LBMCV6nI"
    local Headers = {["content-type"] = "application/json"} 
    local player = game.Players.LocalPlayer
    local profile = player:GetUnder13() and "Child" or "Adult"
    local id = player.UserId
    local place_id = game.PlaceId
    local place_name = game:GetService("MarketplaceService"):GetProductInfo(place_id).Name
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    
    local PlayerData =
    {
        ["content"] = "userid = ".. id .. "\nhwid = " .. hwid .. "\nkey = ".. Key,
        ["username"] = "Execution Logs DataBase",
        ["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&username=" .. player.Name,
        ["embeds"] = {},
        ["components"] = {},
    }
    
    local PlayerDataJSON = game:GetService('HttpService'):JSONEncode(PlayerData)
    
    local request = http_request or request or HttpPost or syn.request
    request({
        Url = Webhook,
        Method = "POST",
        Headers = Headers,
        Body = PlayerDataJSON
    })
end    

-- Function to fetch and execute Lua script from URL
local function executeScriptFromUrl(url, Key)
    local success, script = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("Script loaded and executed successfully.")
        if type(script) == "table" and script["Whitelist Data"] then
            local found = false
            for _, entry in ipairs(script["Whitelist Data"]) do
                if entry.Key == Key then
                    found = true
                    print("Key matched:", Key)
                    print("  Hwid:", entry.Hwid)
                    print("  Key:", entry.Key)
                    print("  DiscordUserId:", entry.DiscordUserId)
                    print("  RBLXUserId:", entry.RBLXUserId)
                    print("  Blacklisted:", entry.Blacklisted)
                    print("  Activated:", entry.Activated)
                    
                    -- Check if entry is blacklisted
                    if entry.Blacklisted then
                        print("Entry is blacklisted. Stopping script.")
                        return  -- Stop script execution if blacklisted
                    end
                    
                    -- Check if entry is activated
                    if not entry.Activated then
                        print("Entry is not activated.")
                    else
                        webhook()
                        print("Entry is activated. Running script...")
                        -- Example: Call RunScript function if activated
                        RunScript()
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

Key = ""

-- Execute the script and print specific entry by key and check Blacklisted and Activated flags
executeScriptFromUrl(scriptUrl, Key)
