local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = ("Tempest Hub - %s"):format(getgenv().TempestHubVersion or "Unknown Version"),
   Icon = "cat", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Thank you for using Tempest Hub",
   LoadingSubtitle = "by @10.tempest.01 on Discord",
   Theme = "DarkBlue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = true,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "tempest-hub", -- Create a custom folder for your hub/game
      FileName = "main"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "ewjaP4Q8dw", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
    Title = "Tempest Hub",
    Content = "Welcome to Tempest Hub, join Discord at discord.gg/ewjaP4Q8dw",
    Duration = 6.5,
    Image = "cat",
})

-- LOCALS
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local uis = game:GetService("UserInputService")
local stgui = game:GetService("StarterGui")

local MainTab = Window:CreateTab("Main", "parentheses")

local CreditsTab = Window:CreateTab("Credits", "users")
local CreditsSection = CreditsTab:CreateSection("Credits")
local CreditsLabel1 = CreditsTab:CreateLabel("Tempest (@10.tempest.01) - Main Developer", "circle-user")
local CreditsLabel1 = CreditsTab:CreateLabel("ExP (@expfa) - Contributor", "circle-user")

local InfoSection = MainTab:CreateSection("Information")
local InfoLabel1 = MainTab:CreateLabel(("Welcome %s to Tempest Hub"):format(plr.Name), "user-check")
local InfoLabel2 = MainTab:CreateLabel("Join the Discord at discord.gg/ewjaP4Q8dw", "user-check")
local DiscordButton = MainTab:CreateButton({
    Name = "Copy Discord Invite",
    Callback = function()
        setclipboard("discord.gg/ewjaP4Q8dw")
    end,
})

local Divider = MainTab:CreateDivider()

local UITab = Window:CreateTab("UI", "image")
local ThemeSection = UITab:CreateSection("Theme")

local themes = {
    "Default",
    "AmberGlow",
    "Amethyst",
    "Bloom",
    "DarkBlue",
    "Green",
    "Light",
    "Ocean",
    "Serenity"
}

local ThemeDropdown = UITab:CreateDropdown({
    Name = "Theme",
    Options = themes,
    CurrentOption = {"DarkBlue"},
    MultipleOptions = false,
    Flag = "themedropdown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Options)
        Window.ModifyTheme(Options[1])
    end,
})

local DashSection = MainTab:CreateSection("Dash Related")

-- TOGGLES
nosidedashendlag = true
sidedashcancel = true
frontdashcancel = false
nostun = false
deathcounterindicator = false

local nodashcooldownToggle = MainTab:CreateToggle({
    Name = "No Dash Cooldown",
    CurrentValue = false,
    Flag = "nodashcooldown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        workspace:SetAttribute("NoDashCooldown", Value)
    end,
})

local nosidedashendlagToggle = MainTab:CreateToggle({
    Name = "No Side Dash Endlag",
    CurrentValue = true,
    Flag = "nosidedashendlag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        nosidedashendlag = Value
    end,
})

local sidedashCancelToggle = MainTab:CreateToggle({
    Name = "Side Dash Cancel",
    CurrentValue = true,
    Flag = "sidedashcancel", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        sidedashcancel = Value
    end,
})

local sidedashcancelKeybind = MainTab:CreateKeybind({
    Name = "Side Dash Cancel Keybind",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "sidedashcancelKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Keybind)
        
    end,
})

local Label = MainTab:CreateLabel("I recommend keeping this on Q for easy double-tap emote dash replica", "info")

local frontdashcancelToggle = MainTab:CreateToggle({
    Name = "Front Dash Cancel",
    CurrentValue = false,
    Flag = "frontdashcancel", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        frontdashcancel = Value
    end,
})

local frontdashcancelKeybind = MainTab:CreateKeybind({
    Name = "Front Dash Cancel Keybind",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "frontdashcancelKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Keybind)
        
    end,
})

local sidedashdelaySlider  = MainTab:CreateSlider({
   Name = "Side Dash Delay\n(Server Request)",
   Range = {0, 5},
   Increment = 0.1,
   Suffix = "seconds",
   CurrentValue = 0,
   Flag = "sidedashdelay", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)

   end,
})


local Divider = MainTab:CreateDivider()

local CharSection = MainTab:CreateSection("Character")

local sidedashCancelToggle = MainTab:CreateToggle({
    Name = "No Stun",
    CurrentValue = false,
    Flag = "nostun", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        nostun = Value
    end,
})

local noFatigueToggle = MainTab:CreateToggle({
    Name = "No Fatigue (For Jumping)",
    CurrentValue = false,
    Flag = "nofatigue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        workspace:SetAttribute("NoFatigue", Value)
    end,
})

local Divider = MainTab:CreateDivider()

local GlobalSection = MainTab:CreateSection("Global")

local deathcounterindicatorToggle = MainTab:CreateToggle({
    Name = "Death Counter Indicator",
    CurrentValue = false,
    Flag = "deathcounterindicator", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        deathcounterindicator = Value
    end,
})

local Divider = MainTab:CreateDivider()

-- FUNCTIONS

local frontDashArgs = {
	[1] = {
		Dash = Enum.KeyCode.W,
		Key = Enum.KeyCode.Q,
		Goal = "KeyPress"
	}
}

local function frontDash()
	plr.Character.Communicate:FireServer(unpack(frontDashArgs))
end

local function noEndlagSetup(char)
	local connection = uis.InputBegan:Connect(function(input, t)
	    
		if t then return end
		
		if nosidedashendlag and input.KeyCode == Enum.KeyCode.Q and (not uis:IsKeyDown(Enum.KeyCode.D)) and (not uis:IsKeyDown(Enum.KeyCode.A)) and (not uis:IsKeyDown(Enum.KeyCode.S)) and not char:FindFirstChild("Freeze") and not char:FindFirstChild("Slowed") then
			frontDash()
		end
	end)
	
	char.Destroying:Connect(function()
		connection:Disconnect()
	end)
end

local function stopAnimation(char, animationId)
    
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	
	if humanoid then
	    
		local animator = humanoid:FindFirstChildWhichIsA("Animator")
		
		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				if track.Animation and track.Animation.AnimationId == "rbxassetid://" .. tostring(animationId) then
					track:Stop()
				end
			end
		end
	end
end

local function isAnimationRunning(char, animationId)
    
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	
	if humanoid then
	    
		local animator = humanoid:FindFirstChildWhichIsA("Animator")
		
		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				if track.Animation and track.Animation.AnimationId == "rbxassetid://" .. tostring(animationId) then
					return true
				else
					return false
				end
			end
		end
	end
end

local function emoteDashSetup(char)
	local hrp = char:WaitForChild("HumanoidRootPart")
	local connection = uis.InputBegan:Connect(function(input, t)
	    
		if t then return end
		
		if sidedashcancel and input.KeyCode == Enum.KeyCode[sidedashcancelKeybind.CurrentKeybind] and (not uis:IsKeyDown(Enum.KeyCode.W)) and (not uis:IsKeyDown(Enum.KeyCode.S)) and (not isAnimationRunning(char, 10491993682)) then
			local vel = hrp:FindFirstChild("dodgevelocity")
			if vel then
				vel:Destroy()
				stopAnimation(char, 10480793962)
				stopAnimation(char, 10480796021)
			end
		end
	end)
	
	char.Destroying:Connect(function()
		connection:Disconnect()
	end)
end

local function frontDashCancelSetup(char)
	local hrp = char:WaitForChild("HumanoidRootPart")
	local connection = uis.InputBegan:Connect(function(input, t)
	    
		if t then return end
		
		if frontdashcancel and input.KeyCode == Enum.KeyCode[frontdashcancelKeybind.CurrentKeybind] then
			local vel = hrp:FindFirstChild("moveme")
			if vel then
				vel:Destroy()
			end
		end
	end)
	char.Destroying:Connect(function()
		connection:Disconnect()
	end)
end

local stunAspects = {
    "Slowed",
    "ComboStun",
    "Freeze"
}

local function noStunSetup(char)
    char.ChildAdded:Connect(function(c)
        if nostun and table.find(stunAspects, c.Name) then
            task.wait()
            c:Destroy()
        end 
    end)
end

-- lol
workspace:SetAttribute("VIPServer", plr.UserId)
workspace:SetAttribute("VIPServerOwner", plr.Name)

local function deathcounterindicatorSetup(char)
    char.ChildAdded:Connect(function(c)
        if deathcounterindicator and c.Name == "Counter" then
            local hl = Instance.new("Highlight", char)
            hl.Name = "lalala"
        end
    end)

    char.ChildRemoved:Connect(function(c)
        if c.Name == "Counter" then
            if char:FindFirstChild("lalala") then
                char.lalala:Destroy()
            end
        end
    end)   
end

for _, player in pairs(plrs:GetPlayers()) do
    if player.Character then
        deathcounterindicatorSetup(player.Character)
    end
    player.CharacterAdded:Connect(deathcounterindicatorSetup)
end

plrs.PlayerAdded:Connect(function(player)
    if player.Character then
        deathcounterindicatorSetup(player.Character)
    end
    player.CharacterAdded:Connect(deathcounterindicatorSetup)
end)

if plr.Character then
	noEndlagSetup(plr.Character)
	emoteDashSetup(plr.Character)
    noStunSetup(plr.Character)
    frontDashCancelSetup(plr.Character)
end

plr.CharacterAdded:Connect(emoteDashSetup)
plr.CharacterAdded:Connect(noEndlagSetup)
plr.CharacterAdded:Connect(noStunSetup)
plr.CharacterAdded:Connect(frontDashCancelSetup)

-- prob should use hookmetamethod but not many executors support it nowadays so idrc :sob:
local mt = getrawmetatable(game)
if setreadonly then setreadonly(mt, false) end

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    
    local method = getnamecallmethod()
    
    if method == "FireServer" and self.Name == "Communicate" then
        local args = {...}
        if args[1]["Dash"] and args[1]["Dash"] == Enum.KeyCode.D or args[1]["Dash"] == Enum.KeyCode.A then
            task.wait(sidedashdelaySlider.CurrentValue or 0)
            return oldNamecall(self, ...)
        end
    end

    return oldNamecall(self, ...)
end)

if setreadonly then setreadonly(mt, true) end

Rayfield:LoadConfiguration()
