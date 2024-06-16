local scriptUrl = "https://raw.githubusercontent.com/SleepyVibesAlt/MinersBrheheh/main/Keys.lua"

-- Function to fetch and execute Lua script from URL
local function executeScriptFromUrl(url, keyToCheck)
    local success, script = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("Script loaded and executed successfully.")
        if type(script) == "table" and script["Whitelist Data"] then
            local found = false
            for _, entry in ipairs(script["Whitelist Data"]) do
                if entry.Key == keyToCheck then
                    found = true
                    print("Key matched:", keyToCheck)
                    print("  Hwid:", entry.Hwid)
                    print("  Key:", entry.Key)
                    print("  DiscordUserId:", entry.DiscordUserId)
                    print("  RBLXUserId:", entry.RBLXUserId)
                    print("  Blacklisted:", entry.Blacklisted)
                    print("  Activated:", entry.Activated)
                    -- Compare DiscordUserId
                    if entry.DiscordUserId == "YOUR_SPECIFIC_DISCORD_USER_ID" then
                        print("Match found! DiscordUserId matches.")
                    else
                        print("DiscordUserId does not match.")
                    end
                    print("-----------------------")
                    break
                end
            end
            if not found then
                print("Entry with Key:", keyToCheck, "not found.")
            end
        else
            warn("Script did not return a valid 'Whitelist Data' table.")
        end
    else
        warn("Failed to load or execute script:", script)
    end
end

print(keyToCheck)

-- Execute the script and print specific entry by key
executeScriptFromUrl(scriptUrl, keyToCheck)
