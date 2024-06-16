local scriptUrl = "https://raw.githubusercontent.com/SleepyVibesAlt/MinersBrheheh/main/Keys.lua"
local player = game.Players.LocalPlayer
local playerId = player.UserId

-- Example function to simulate running a script
local function RunScript()
    print("Running script...")
    -- Replace with your actual script logic
end

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
                    
                    -- Check if entry is activated
                    if not entry.Activated then
                        print("Your key is not activated. Please go and activate your key in our server discord.gg/mobilescripthub")
                    else
                        print("Entry is activated. Running script...")
                        -- Example: Call RunScript function if activated
                        RunScript()
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

-- Example key to check against
local keyToCheck = "7540ea77-199c-4301-ab33-aa3a12ee9f34"  -- Replace with the key you want to check

-- Execute the script and print specific entry by key and check Activated flag
executeScriptFromUrl(scriptUrl, keyToCheck)
