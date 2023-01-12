local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')

spawn(function()
    
local shop = plr.PlayerGui.Store.StoreContainer.MainFrame

local container = shop.DetailsFrame.Bottom.PurchaseFrame

local justChanged = false

local name = shop.DetailsFrame.Top.ItemName

local function removespaces(str)
    return str:gsub(" ","")
end

container.EquipButton.MouseButton1Down:Connect(function()
    local ohString1 = removespaces(name.Text)

    game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)
end)

runservice.RenderStepped:Connect(function(deltaTime)
    if shop.DetailsFrame.Middle.StatisticFrame.Stat1.Title.Text == "Speed" then
        if container.BuyButton.Visible == true then
            container.BuyButton.Visible = false
            container.EquipButton.Visible = true
        end
    end
end)

end)

local weapons = require(game:GetService("ReplicatedStorage").Projectiles.ProjectileStatsModule)
weapons = weapons.get()

function setStats(str,val)
    for i,v in pairs(weapons) do
        v[str.."Old"] = v[str]
        v[str] = val
    end
end

function resetStat(str)
    for i,v in pairs(weapons) do
        v[str] = v[str.."Old"]
    end
end

spawn(function()
local weapons = require(plr.PlayerScripts.Shark.SharkController.MovementModule)

plr.PlayerScripts.Shark.SharkController:SetAttribute("Speed", 100)
plr.PlayerScripts.Shark.SharkController:SetAttribute("TurnSpeed", 10)
local v1 = {};
local u1 = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("Inventory").InventoryManager);
local u2 = require(plr.PlayerScripts.Shark.SharkController.DamageModule);
local l__RunService__3 = game:GetService("RunService");
local u4 = 0;
local u5 = require(plr.PlayerScripts.Shark.SharkController.InputModule);
local l__CurrentCamera__6 = game.Workspace.CurrentCamera;

local function u7(p1)
    print("Fetched")
	
	u2.resetKilledBySharkAttributes();
	local l__SharkMain__8 = p1.SharkMain;
	local u9 = 0;
	l__RunService__3:BindToRenderStep("SharkMovement", Enum.RenderPriority.Character.Value, function(p2)
        local l__speed__2 = plr.PlayerScripts.Shark.SharkController:GetAttribute("Speed")--u1.getSharkAssets()[p1.Name].stats.speed;
        if plr.PlayerScripts.Shark.SharkController:GetAttribute("Speed") == nil or plr.PlayerScripts.Shark.SharkController:GetAttribute("Speed") <= 100 then
            l__speed__2 = u1.getSharkAssets()[p1.Name].stats.speed;
        end
		
        local v3 = nil;
		if not l__SharkMain__8:IsDescendantOf(workspace) then
			return;
		end;

		workspace.Flare:ClearAllChildren();
		local v4 = u5.getMovementVector();
		if v4.Magnitude == 0 then
			u9 = math.clamp(u9 - 15, 40, l__speed__2);
		else
			u9 = math.clamp(u9 + 5, 40, l__speed__2 + l__speed__2 * (u4 / 100));
		end;
		local v5 = CFrame.Angles(0, math.atan2(v4.X, v4.Y), 0);
		if v4.Magnitude ~= 0 then
			l__SharkMain__8.Engine.BodyVelocity.Velocity = (l__CurrentCamera__6.CFrame * v5).LookVector * u9;
			l__SharkMain__8.Engine.BodyGyro.CFrame = CFrame.new(l__SharkMain__8.Engine.Position, l__SharkMain__8.Engine.Position + l__SharkMain__8.Engine.Velocity * plr.PlayerScripts.Shark.SharkController:GetAttribute("TurnSpeed"));
		else
			l__SharkMain__8.Engine.BodyVelocity.Velocity = l__SharkMain__8.Engine.CFrame.LookVector * u9;
		end;
		-- if l__SharkMain__8.Engine.Velocity.Magnitude > 400 then
		-- 	l__SharkMain__8.Engine.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
		-- end;
		u2.hunt(p1);
		v3 = l__SharkMain__8.Engine.BodyVelocity.MaxForce;
		if l__SharkMain__8.Engine.Position.Y > 1 then
			l__SharkMain__8.Engine.BodyVelocity.MaxForce = Vector3.new(v3.X, 50000, v3.Z);
			return;
		end;
		l__SharkMain__8.Engine.BodyVelocity.MaxForce = Vector3.new(v3.X, 6000000, v3.Z);
	end);
end;

weapons.start = function(p3)
    u7(p3)
end


end)

local Window = Rayfield:CreateWindow({
	Name = "Sharkbait",
	LoadingTitle = " ",
	LoadingSubtitle = " ",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "...",
		FileName = "Big Hub"
	},
	KeySystem = false,
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		SaveKey = true,
		Key = "ABCDEF"
	}
})

--Rayfield:Notify("Title Example", "Content/Description Example", 4483362458) -- Notfication -- Title, Content, Image

local boateditor = Window:CreateTab("Boat")
local weaponMods = Window:CreateTab("Weapon Mods")
local shark = Window:CreateTab("Shark")
local esp = Window:CreateTab("ESP")

local espEnabled = false

local sesp = esp:CreateToggle({
    Name = "Shark Esp",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        espEnabled = Value

        

        if Value == true then
            else
            for i,v in pairs(workspace.Sharks:GetChildren()) do
                v:FindFirstChild("Highlight"):Destroy()
            end
        end
    end,
 })

runservice.RenderStepped:Connect(function(deltaTime)
    if espEnabled then
        for i,v in pairs(workspace.Sharks:GetChildren()) do
            if not v:FindFirstChild("Highlight") then
                
                local name = v.Name
                local highlight = Instance.new("Highlight",v)
                local ESP = Instance.new("BillboardGui", highlight)
                local ESPSquare = Instance.new("Frame", ESP)
                local ESPText = Instance.new("TextLabel", ESP)
                ESP.Name = "ESP"
                ESP.Adornee = v
                ESP.AlwaysOnTop = true
                ESP.ExtentsOffset = Vector3.new(0, 1, 0)
                ESP.Size = UDim2.new(0, 5, 0, 5)
                ESPText.Name = "NAME"
                ESPText.BackgroundColor3 = Color3.new(255, 255, 255)
                ESPText.BackgroundTransparency = 1
                ESPText.BorderSizePixel = 0
                ESPText.Position = UDim2.new(0, 0, 0, -10)
                ESPText.Size = UDim2.new(1, 0, 10, 0)
                ESPText.Visible = true
                ESPText.ZIndex = 10
                ESPText.Font = Enum.Font.SourceSansSemibold
                ESPText.TextStrokeTransparency = 0
                ESPText.TextColor3 = Color3.fromRGB(255,0,255)
                ESPText.TextSize = 18

                local uitext_size_constraint = Instance.new("UITextSizeConstraint",ESPText)
                uitext_size_constraint.MaxTextSize = 14
                uitext_size_constraint.MinTextSize = 9

                local connection = nil

                connection = runservice.RenderStepped:Connect(function()
                    pcall(function()
                        local health = plr.PlayerGui.HUD.TopBar.HealthBar.HealthValue
                        if not ESPText or health.Parent.Visible ~= true then
                            connection:Disconnect()
                        end
                        ESPText.Text = tostring(math.round((v.PrimaryPart.Parent.Mesh.PrimaryPart.Position - plr.Character.HumanoidRootPart.Position).magnitude)).." studs"
                    end)
                end)

                
                highlight.FillTransparency = 0
                highlight.OutlineTransparency = 1
                highlight.FillColor = Color3.fromRGB(255,0,255)
                highlight.Adornee = v
            end
        end
    end
end)

local sspeed = shark:CreateSlider({
	Name = "Shark Speed",
	Range = {100, 1000},
	Increment = 5,
	Suffix = "",
	CurrentValue = 100,
	Flag = "Slider5",
	Callback = function(Value)
		plr.PlayerScripts.Shark.SharkController:SetAttribute("Speed", Value)
	end,
})

local boatSpeed = 5
local ogBoatSpeed = 0

local bspeed = boateditor:CreateSlider({
	Name = "Boat Speed",
	Range = {5, 500},
	Increment = 1,
	Suffix = "",
	CurrentValue = 5,
	Flag = "Slider1",
	Callback = function(Value)
		boatSpeed = Value
	end,
})

runservice.RenderStepped:Connect(function(deltaTime)
    pcall(function()
        local seat = plr.Character.Humanoid.SeatPart
        if seat == nil then return end
        local boat = seat.Parent.Parent
        local config = boat:FindFirstChild("Configuration")
        local engine = config.Engine
        if not engine:FindFirstChild("MaxSpeedOld") then
            local clone = engine.MaxSpeed:Clone()
            clone.Parent = engine
            clone.Name = "MaxSpeedOld"
        end
        if boatSpeed == 5 then
            engine.MaxSpeed.Value = engine.MaxSpeedOld.Value
            if engine.Parent:FindFirstChild("UnderwaterConfigs") then
                engine.Parent:FindFirstChild("UnderwaterConfigs")["PIDforward"]["I_MAX"].Value = engine.MaxSpeedOld.Value
            end
            else
            engine.MaxSpeed.Value = boatSpeed
            if engine.Parent:FindFirstChild("UnderwaterConfigs") then
                engine.Parent:FindFirstChild("UnderwaterConfigs")["PIDforward"]["I_MAX"].Value = boatSpeed
            end
        end

        
        
    end)
end)

local frate = weaponMods:CreateSlider({
	Name = "Firerate",
	Range = {3, 600},
	Increment = 1,
	Suffix = "",
	CurrentValue = 3,
	Flag = "Slider2",
	Callback = function(Value)
        setStats("Mode",2)
		setStats("FireRate",Value)
	end,
})

local moded = weaponMods:CreateDropdown({
    Name = "Firing Mode",
    Options = {"1","2"},
    CurrentOption = "1",
    Flag = "Dropdown1",
    Callback = function(Option)
        setStats("Mode",tonumber(Option))
    end,
 })

local recoil = weaponMods:CreateToggle({
    Name = "No-recoil",
    CurrentValue = false,
    Flag = "Toggle2",
    Callback = function(Value)
        if Value then
            setStats("Recoil",Vector3.new(0,0,0))
            else
            resetStat("Recoil")
        end
    end,
 })

local recoil = weaponMods:CreateToggle({
    Name = "Infinite Ammo",
    CurrentValue = false,
    Flag = "Toggle4",
    Callback = function(Value)
        if Value then
            setStats("MagSize",math.huge)
            else
            resetStat("MagSize")
        end
    end,
 })

-- local inf = weaponMods:CreateButton({
--     Name = "Infinite Ammo",
--     Callback = function()
--         setStats("MagSize",9999999)
--     end,
--  })

weaponMods:CreateButton({
    Name = "Shark Instakill Gun (Deactivates after kill)",
    Callback = function()

        if not plr.Backpack:FindFirstChildOfClass("Tool") or plr.Character:FindFirstChildOfClass("Tool") then
            return
        end

        function InstaKill()
            spawn(function()
            
            local hum = plr.Character.Humanoid
            
            hum:UnequipTools()
            
            
            
            
            
            local l__CollectionService__1 = game:GetService("CollectionService");
            local l__UserInputService__2 = game:GetService("UserInputService");
            local u3 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.WeaponUIModule);
            local l__mouse__4 = game.Players.LocalPlayer:GetMouse();
            local l__CurrentCamera__5 = game.Workspace.CurrentCamera;
            
            
            
            
            
            setStats("ProjectileSpeed",9999999999)
            setStats("Range",999999999999)
            setStats("FireRate",99999999999)
            setStats("MagSize",math.huge)
            setStats("Mode",2)
            task.wait(.1)
            hum:EquipTool(plr.Backpack:FindFirstChildOfClass("Tool"))
            local commonFunctions = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.CommonWeaponFunctions)
            
            local OGraycastFromCamera = commonFunctions.raycastFromCamera
            local OGraycastFromWeapon = commonFunctions.raycastFromWeapon
            
            commonFunctions.raycastFromCamera = function(p2,p3)
             
                local sharks = workspace.Sharks:GetChildren()
            
                for i,v in pairs(sharks) do
                    return v.PrimaryPart.Parent.Mesh.PrimaryPart, v.PrimaryPart.Parent.Mesh.PrimaryPart.Position , Enum.NormalId.Front
                end
                
            end
            
            commonFunctions.raycastFromWeapon = function(p6, p7)
                local sharks = workspace.Sharks:GetChildren()
                for i,v in pairs(sharks) do
                    return v.PrimaryPart.Parent.Mesh.PrimaryPart, v.PrimaryPart.Parent.Mesh.PrimaryPart.Position
                end
            end
            
            local projFire = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.ProjectileFire)
            
            local u1 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.BulletCountModule);
            local u2 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.WeaponUIModule);
            local u14 = require(game.ReplicatedStorage.Projectiles.ProjectileStatsModule);
            local u4 = 0;
            local u5 = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("Misc"):WaitForChild("MouseModule"));
            local u6 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.RecoilModule);
            local u7 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.CommonWeaponFunctions);
            local u8 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.WeaponAnimations);
            
            local oldFIRE = projFire.fire
            
            projFire.fire = function(p1, p2)
                -- if not u1.CanFireBullet() then
                -- 	if not u1.isReloading() then
                -- 		u2.displayReloadButton();
                -- 	end;
                -- 	return;
                -- end;
                local l__Handle__5 = p1:FindFirstChild("Handle");
                if not l__Handle__5 or not p1:IsDescendantOf(workspace) then
                    return;
                end;
                local v6 = u14.get()[p1.Name];
                local l__FireRate__7 = v6.FireRate;
                local l__Mode__8 = v6.Mode;
                local v9 = tick();
                if v9 - u4 < 1 / l__FireRate__7 then
                    return;
                end;
                u4 = v9;
                -- local v10, v11 = u5:CastWithIgnoreList({}, true, false);
                v11 = nil
                for i,v in pairs(workspace.Sharks:GetChildren()) do
                    v11 = v.PrimaryPart.Parent.Mesh.PrimaryPart
                end
                if v11 then
                    u2.displayBulletDelayTime(l__FireRate__7);
                    u6.applyRecoil(u14.get()[p1.Name].Recoil);
                    u1.BulletFired(p1);
                    u7.muzzleEffects(p1);
                    u8.playFire(p1);
                    local v12 = Instance.new("Attachment", game.Workspace.Terrain);
                    v12.WorldPosition = l__Handle__5.Position;
                    local v13 = game.SoundService.WeaponSounds.ShotFired[v6.SoundName]:Clone();
                    v13.Parent = v12;
                    v13.PlayOnRemove = true;
                    v12:Destroy();
                    game.ReplicatedStorage.Projectiles.Events.Weapons.HitScanFire:FireServer(v11);
                end;
            end;
            
            
            local health = plr.PlayerGui.HUD.TopBar.HealthBar.HealthValue
            
            repeat
                task.wait()
            until tonumber(health.Text) <= 0 or health.Parent.Visible == false
            
            projFire.fire = oldFIRE
            commonFunctions.raycastFromCamera = OGraycastFromCamera
            commonFunctions.raycastFromWeapon = OGraycastFromWeapon
            
            resetStat("ProjectileSpeed",900000)
            resetStat("Range",9000000)
            resetStat("FireRate",90000)
            resetStat("Mode",90000)
            resetStat("MagSize",90000)
            end)
            end
        InstaKill()
    end
})

local settings = Window:CreateTab("Settings")

local Button = settings:CreateButton({
	Name = "Destroy UI",
	Callback = function()
		Rayfield:Destroy()
	end,
})

