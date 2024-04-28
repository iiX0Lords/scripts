local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "SigmaMale9000",
	LoadingTitle = "Kissing Dudes",
	LoadingSubtitle = "Enjoying It",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "...",
		FileName = "Siguma"
	},
	KeySystem = false,
	KeySettings = {
		Title = "dsadas",
		Subtitle = "dadsadsadsa",
		Note = "Jdadsaddaassa",
		SaveKey = true,
		Key = "ABCDEF"
	}
})

local main = Window:CreateTab("Main")

local toggles = {
    AntiStun = false,
    AlwaysCanJump = false,
    Aimbot = false,
}

--// Stun Shit

local stun = main:CreateToggle({
    Name = "Anti-Stun",
    CurrentValue = false,
    Flag = "stun",
    Callback = function(Value)
        toggles.AntiStun = Value
    end,
})
local canjump = main:CreateToggle({
    Name = "Always Can Jump",
    CurrentValue = false,
    Flag = "jump",
    Callback = function(Value)
        toggles.AlwaysCanJump = Value
    end,
})

function handler(character)
    character.Info.ChildAdded:Connect(function(child)
        if toggles.AntiStun then
            if child.Name == "Stun" then
                child.Name = ""
            end
        end
        if toggles.AlwaysCanJump then
            if child.Name == "NoJump" then
                child.Name = ""
            end
        end

    end)
end
plr.CharacterAdded:Connect(function(character)
    task.wait(2)
    handler(character)
end)
handler(plr.Character)


--// AutoPArry

local Radius = 1

local aimbotBtn = main:CreateToggle({
    Name = "Auto-Parry",
    CurrentValue = false,
    Flag = "aimbtn",
    Callback = function(Value)
        toggles.Aimbot = Value
    end,
})

local aimbotRadius = main:CreateSlider({
    Name = "Radius",
    Range = {1, 15},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = Radius,
    Flag = "aimslider",
    Callback = function(Value)
        Radius = Value
        print(Value)
    end,
})

local distanceTP = 5
local tpDistance = main:CreateSlider({
    Name = "TP Distance",
    Range = {1, 15},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = distanceTP,
    Flag = "aimslider",
    Callback = function(Value)
        distanceTP = Value
    end,
})

function block()
    game:GetService("ReplicatedStorage").Knit.Knit.Services.BlockService.RE.Activated:FireServer()
end
function unblock()
    game:GetService("ReplicatedStorage").Knit.Knit.Services.BlockService.RE.Deactivated:FireServer()
end

runservice.RenderStepped:Connect(function(deltaTime)
    if toggles.Aimbot then
        function getRoots()
            local roots = {}
            for _,player in pairs(game.Players:GetChildren()) do
                if player ~= plr then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        table.insert(roots,player.Character.HumanoidRootPart)
                    end
                end
            end
            return roots
        end
        
        position = plr.Character.HumanoidRootPart.Position
        radius = Radius
        overlapParams = OverlapParams.new()
        overlapParams.FilterType = Enum.RaycastFilterType.Include
        overlapParams.FilterDescendantsInstances = getRoots()
        
        parts = workspace:GetPartBoundsInRadius(position, radius, overlapParams)
        local characters = {}
        for i,v in pairs(parts) do
            if v.Parent:FindFirstChildOfClass("Humanoid") then
                local char = v.Parent
                if char.Info:FindFirstChild("InSkill") then
                    -- spawn(function()
                    --     block()
                    --     print("blockiong")
                    --     repeat
                    --         task.wait()
                    --     until not char.Info:FindFirstChild("InSkill")
                    --     unblock()
                    --     print("fduunblock")
                    -- end)
                    plr.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,distanceTP)
                end
            end
        end
    end
end)
