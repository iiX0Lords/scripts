
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')


local Window = OrionLib:MakeWindow({Name = "SigmaMale9000", HidePremium = false, SaveConfig = false, ConfigFolder = "SigmaMale", IntroEnabled = false})


local toggles = {
    AntiStun = {
        Toggled = false,
        LegitMode = false,
    },
    AutoDodge = {
        Toggled = false,
        TpDistance = 6,
        ActivationDistance = 15,
    }
}

local aStunSection = Window:MakeTab({
	Name = "Anti-Stun",
	Icon = nil,
	PremiumOnly = false
})


aStunSection:AddToggle({
    Name = "Toggle",
    Default = false,
    Callback = function(Value)
        toggles.AntiStun.Toggled = Value
    end
})

aStunSection:AddToggle({
    Name = "Legit Mode",
    Default = false,
    Callback = function(Value)
        toggles.AntiStun.LegitMode = Value
    end
})

function handler(character)
    character.Info.ChildAdded:Connect(function(child)
        if toggles.AntiStun.Toggled then
            if toggles.AntiStun.LegitMode == false then

                if child.Name == "Stun" then
                    child.Name = ""
                end

                else

                if character.Info:FindFirstChild("InSkill") then
                    if child.Name == "Stun" then
                        child.Name = ""
                    end
                end

            end

        end
    end)
end
plr.CharacterAdded:Connect(function(character)
    task.wait(2)
    handler(character)
end)
handler(plr.Character)

--// Auto Dodge

local autoDodge = Window:MakeTab({
	Name = "Auto Dodge",
	Icon = nil,
	PremiumOnly = false
})

autoDodge:AddToggle({
    Name = "Toggle",
    Default = false,
    Callback = function(Value)
        toggles.AutoDodge.Toggled = Value
    end
})

autoDodge:AddSlider({
	Name = "Activation Distance",
	Min = 5,
	Max = 20,
	Default = 15,
	Color = Color3.fromRGB(0, 140, 255),
	Increment = 1,
	ValueName = "Studs",
	Callback = function(Value)
		toggles.AutoDodge.ActivationDistance = Value
	end    
})

autoDodge:AddSlider({
	Name = "TP Distance",
	Min = 1,
	Max = 10,
	Default = 6,
	Color = Color3.fromRGB(0, 140, 255),
	Increment = 1,
	ValueName = "Studs",
	Callback = function(Value)
		toggles.AutoDodge.TpDistance = Value
	end    
})


runservice.RenderStepped:Connect(function(deltaTime)
    if toggles.AutoDodge.Toggled then
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
        radius = toggles.AutoDodge.ActivationDistance
        overlapParams = OverlapParams.new()
        overlapParams.FilterType = Enum.RaycastFilterType.Include
        overlapParams.FilterDescendantsInstances = getRoots()
        
        parts = workspace:GetPartBoundsInRadius(position, radius, overlapParams)
        local characters = {}
        for i,v in pairs(parts) do
            if v.Parent:FindFirstChildOfClass("Humanoid") then
                local char = v.Parent
                if char.Info:FindFirstChild("InSkill") then
                    plr.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,toggles.AutoDodge.TpDistance)
                end
            end
        end
    end
end)

OrionLib:Init()
