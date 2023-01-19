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
        v[str] = val
    end
end


for i,v in pairs(weapons) do
    for name,val in pairs(v) do
        v[name.."DF"] = val
    end
end

function resetStat(str)
    for i,v in pairs(weapons) do
        v[str] = v[str.."DF"]
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
local misc = Window:CreateTab("Misc")

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

 ESPNEnabled = false

 local sesp = esp:CreateToggle({
    Name = "Player Esp",
    CurrentValue = false,
    Flag = "Toggle9",
    Callback = function(Value)
        if Value == true then
            local cmdlp = game.Players.LocalPlayer
            local cmdp = game.Players

            ESPNEnabled = false
            TrackN = false



            function CreateN(xPlayer, xHead)
                local ESP = Instance.new("BillboardGui", xHead)
                local ESPSquare = Instance.new("Frame", ESP)
                local ESPText = Instance.new("TextLabel", ESP)
                ESP.Name = "ESP"
                ESP.Adornee = xHead
                ESP.AlwaysOnTop = true
                ESP.ExtentsOffset = Vector3.new(0, 1, 0)
                ESP.Size = UDim2.new(0, 5, 0, 5)
                ESPText.Name = "NAME"
                ESPText.BackgroundColor3 = Color3.new(255, 255, 255)
                ESPText.BackgroundTransparency = 1
                ESPText.BorderSizePixel = 0
                ESPText.Position = UDim2.new(0, 0, 0, -40)
                ESPText.Size = UDim2.new(1, 0, 10, 0)
                ESPText.Visible = true
                ESPText.ZIndex = 10
                ESPText.Font = Drawing.Fonts.Monospace--Enum.Font.SourceSansSemibold
                ESPText.TextStrokeTransparency = 0
                ESPText.TextColor = xPlayer.TeamColor
                ESPText.TextSize = 18

                local uitext_size_constraint = Instance.new("UITextSizeConstraint",ESPText)
                uitext_size_constraint.MaxTextSize = 14
                uitext_size_constraint.MinTextSize = 9

                if xPlayer.DisplayName == xPlayer.Name then
                    ESPText.Text = xPlayer.Name
                else
                    ESPText.Text = xPlayer.DisplayName.." ("..xPlayer.Name..")"
                end

                -- if arg == nil then
                
                -- elseif arg == "true" or arg == "yes" then
                -- ESPText.Text = xPlayer.DisplayName
                -- end
                coroutine.resume(coroutine.create(function()
                    while task.wait() do
                        pcall(function()
                        if xHead.Parent.Humanoid.Health <= 0 then
                            coroutine.yield()
                        end

                        if xPlayer:IsFriendsWith(plr.UserId) then
                            ESPText.TextColor3 = colour
                        else
                            ESPText.TextColor = xPlayer.TeamColor
                        end
                    end)
                    end
                end))
            end


            ESPNEnabled = true

            local function Handler(player)
                if player ~= plr and ESPNEnabled then
                    repeat
                        wait()
                        local suc = pcall(function()
                            CreateN(player,player.Character.Head)
                        end)
                    until suc
                end
            end

            for i,v in pairs(game.Players:GetPlayers()) do
                Handler(v)
                v.CharacterAdded:Connect(function()
                    task.wait(1)
                    Handler(v)
                end)
            end

            game.Players.PlayerAdded:Connect(function(play)
                task.wait(1)
                Handler(play)
                play.CharacterAdded:Connect(function()
                    Handler(play)
                end)
            end)
            else
            ESPNEnabled = false
            pcall(function()
            for i,v in pairs(game.Players:GetPlayers()) do
                if v.Character then
                    if v.Character.Head:FindFirstChild("ESP") then
                        v.Character.Head.ESP:Destroy()
                    end
                end
            end
            end)
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
	Range = {5, 1500},
	Increment = 5,
	Suffix = "",
	CurrentValue = 5,
	Flag = "Slider1",
	Callback = function(Value)
		boatSpeed = Value
	end,
})

local stabbing = false

local stab = boateditor:CreateToggle({
    Name = "Boat Stabilizer",
    CurrentValue = false,
    Flag = "stab",
    Callback = function(Value)
        stabbing = Value
    end,
 })

local boatfly = false

boateditor:CreateToggle({
    Name = "Boat Fly",
    CurrentValue = false,
    Flag = "stab",
    Callback = function(Value)
        boatfly = Value
    end,
})

boatflyspeed = 150

boateditor:CreateSlider({
	Name = "Boatfly Speed",
	Range = {150, 5000},
	Increment = 5,
	Suffix = "",
	CurrentValue = 150,
	Flag = "Slider1",
	Callback = function(Value)
		boatflyspeed = Value
	end,
})

spawn(function()
    local walkKeyBinds = {
        Forward = { Key = Enum.KeyCode.W, Direction = Enum.NormalId.Front },
        Backward = { Key = Enum.KeyCode.S, Direction = Enum.NormalId.Back },
        Left = { Key = Enum.KeyCode.A, Direction = Enum.NormalId.Left },
        Right = { Key = Enum.KeyCode.D, Direction = Enum.NormalId.Right }
    }
    
    local targetMoveVelocity = Vector3.new()
    local moveVelocity = Vector3.new()
    local MOVE_ACCELERATION = 100
    pfSpeed = 1
    
    local DFMOVE_ACCELERATION = MOVE_ACCELERATION
    
    function getWalkDirectionCameraSpace()
        workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
        local walkDir = Vector3.new()
    
        for keyBindName, keyBind in pairs(walkKeyBinds) do
            if uis:IsKeyDown(keyBind.Key) then
                walkDir = walkDir + Vector3.FromNormalId( keyBind.Direction )
            end
        end
    
        if walkDir.Magnitude > 0 then --(0, 0, 0).Unit = NaN, do not want
            walkDir = walkDir.Unit --Normalize, because we (probably) changed an Axis so it's no longer a unit vector
        end
    
        return walkDir
    end
    
    function lerp(a, b, c)
        return a + ((b - a) * c)
    end
    
    function getWalkDirectionWorldSpace(dt)
        local walkDir = workspace.CurrentCamera.CFrame:VectorToWorldSpace( getWalkDirectionCameraSpace() )
        walkDir = walkDir --* Vector3.new(1, 0, 1) --Set Y axis to 0
    
        if walkDir.Magnitude > 0 then --(0, 0, 0).Unit = NaN, do not want
            walkDir = walkDir.Unit --Normalize, because we (probably) changed an Axis so it's no longer a unit vector
        end
    
        local moveDir = walkDir
        
        
        
        local targetMoveVelocity = moveDir
        return lerp( moveVelocity, targetMoveVelocity, math.clamp(dt * MOVE_ACCELERATION, 0, 1)*pfSpeed )
    end
    
    
    
    runservice.RenderStepped:Connect(function(dt)
        if boatfly then
            local seat = plr.Character.Humanoid.SeatPart
            if seat == nil then return end
            local boat = seat.Parent.Parent
            if not boat.PrimaryPart:FindFirstChild("BodyGyro") then
                T = boat.PrimaryPart
                BG = Instance.new('BodyGyro')
                BV = Instance.new('BodyVelocity')
                BG.P = 9e4
                BG.Parent = boat.PrimaryPart
                BV.Parent = boat.PrimaryPart
                BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.cframe = boat.PrimaryPart.CFrame
                BV.velocity = Vector3.new(0, 0, 0)
                BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
                boat:SetAttribute("Flyspeed",150)
                else
                BV.Velocity = getWalkDirectionWorldSpace(dt)*boatflyspeed
                BG.cframe = workspace.CurrentCamera.CoordinateFrame
            end
        else
            local seat = plr.Character.Humanoid.SeatPart
            if seat == nil then return end
            local boat = seat.Parent.Parent
            if boat.PrimaryPart:FindFirstChild("BodyGyro") then
                boat.PrimaryPart:FindFirstChild("BodyGyro"):Destroy()
                boat.PrimaryPart:FindFirstChild("BodyVelocity"):Destroy()
            end
        end
    end)
end)

local ezz = false
local autofarming = false


function instaKillShark()



        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        
        local runservice = game:GetService('RunService')
        local uis = game:GetService('UserInputService')
        local tweenservice = game:GetService('TweenService')
    
        local cam = workspace.CurrentCamera
    
    
        local u9 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.ProjectileFire);
        local u10 = require(plr.PlayerScripts.ProjectilesClient.WeaponScript.HitScanFire);
    
        function fire()
            --u9.fire(plr.Character:FindFirstChildOfClass("Tool"),mouse.Hit.p)
            u10.Fire(plr.Character:FindFirstChildOfClass("Tool"),mouse.Hit.p)
        end
    
        function stop()
            u10.Stop()
        end
    
    
        if workspace.Sharks:FindFirstChildOfClass("Model") and plr.Team == game.Teams.Survivor then
    
    
        print("Shark Spawned")
    
    
    
        local shark = workspace.Sharks:FindFirstChildOfClass("Model")
        local sharkbody = shark.SharkMain:WaitForChild("Mesh")
        -- task.wait(2)
        plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(5,20,0)
        print("Setting Camera Subject")
    
        -- workspace.CurrentCamera.CameraSubject = sharkbody.Shark
    
        setStats("Mode",2)
        setStats("MagSize",math.huge)
        setStats("FireRate",math.huge)
        task.wait(.1)
        plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChildOfClass("Tool"))
    
        fire()
        repeat
            task.wait()
            pcall(function()
                plr.Character.HumanoidRootPart.CFrame = sharkbody.PrimaryPart.CFrame * CFrame.new(0,0,0)
            end)
        until not workspace.Sharks:FindFirstChildOfClass("Model")
        task.wait(1)
        stop()
        -- workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
        resetStat("Mode")
        resetStat("MagSize")
        resetStat("FireRate")
    
        if ezz then
            for i = 1,3 do
                local args = {
                    [1] = "ez",
                    [2] = "All"
                }
                
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            end
        end
    end
end

shark:CreateButton({
    Name = "Shark Instakill",
    Callback = function()
        spawn(function()
            instaKillShark()
        end)
    end
})

local autofarm = shark:CreateToggle({
    Name = "Autofarm",
    CurrentValue = false,
    Flag = "auto",
    Callback = function(Value)
        autofarming = Value
        spawn(function()
            while autofarming do
                task.wait()
                instaKillShark()
            end
        end)
    end,
})



shark:CreateToggle({
    Name = "Spam Ez After",
    CurrentValue = false,
    Flag = "ez",
    Callback = function(Value)
       ezz = Value
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
            local clone = config.PIDforward.I_MAX:Clone()
            clone.Parent = config.PIDforward
            clone.Name = "MaxSpeedOld"
        end

        if boatSpeed == 5 then
            engine.MaxSpeed.Value = engine.MaxSpeedOld.Value
            config.PIDforward.I_MAX.Value = config.PIDforward.MaxSpeedOld.Value
            if engine.Parent:FindFirstChild("UnderwaterConfigs") then
                engine.Parent:FindFirstChild("UnderwaterConfigs")["PIDforward"]["I_MAX"].Value = engine.MaxSpeedOld.Value
            end
            else
            engine.MaxSpeed.Value = boatSpeed
            config.PIDforward.I_MAX.Value = boatSpeed
            if engine.Parent:FindFirstChild("UnderwaterConfigs") then
                engine.Parent:FindFirstChild("UnderwaterConfigs")["PIDforward"]["I_MAX"].Value = boatSpeed
            end
        end
        if stabbing then
            if not boat:FindFirstChild("CriticalComponents").TP:FindFirstChild("Stabber") then
                local gyro = Instance.new("BodyGyro",boat:FindFirstChild("CriticalComponents").TP)
                gyro.MaxTorque = Vector3.new(math.huge,0,math.huge)
                gyro.Name = "Stabber"
            end   
            else
            if boat:FindFirstChild("CriticalComponents").TP:FindFirstChild("Stabber") then
                boat:FindFirstChild("CriticalComponents").TP:FindFirstChild("Stabber"):Destroy()
            end   
        end
        
        
    end)
end)

function setDefaultStats(str)
    for i,v in pairs(weapons) do
        v[str.."DF"] = v[str]
    end
end



local frate = weaponMods:CreateSlider({
	Name = "Firerate",
	Range = {5, 600},
	Increment = 5,
	Suffix = "",
	CurrentValue = 5,
	Flag = "Slider2",
	Callback = function(Value)
        if Value == 5 then
            resetStat("Mode",2)
            resetStat("FireRate",Value)
            else
            setStats("Mode",2)
            setStats("FireRate",Value)
        end
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
 
local rawboats = require(game.Players.LocalPlayer.PlayerScripts.Inventory.InventoryManager)
local boatNames = {}
for i,v in pairs(rawboats.getBoatAssets()) do
    table.insert(boatNames,i)
end

 local selector = boateditor:CreateDropdown({
    Name = "Select Boat",
    Options = boatNames,
    CurrentOption = "1",
    Flag = "Dropdown2",
    Callback = function(Option)
        local ohString1 = Option

    game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)
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

local invisPart = Instance.new("Part",workspace)
invisPart.Anchored = true
invisPart.Size = Vector3.new(4,1,4)
invisPart.Position = Vector3.new(0,-0.4,0)
invisPart.Transparency = 1
invisPart.CanCollide = false

local jesusing = false

jesusConnection = runservice.RenderStepped:Connect(function(deltaTime)
    pcall(function()

        if jesusing then
            invisPart.CanCollide = true
            invisPart.Position = Vector3.new(plr.Character.HumanoidRootPart.Position.X,-0.4,plr.Character.HumanoidRootPart.Position.Z)
        else
            invisPart.CanCollide = false
        end

        if plr.Character.Humanoid.Sit == true then
            invisPart.CanCollide = false
        end

        if plr.Character.HumanoidRootPart.Position.Y <= -0.3 then
            invisPart.CanCollide = false
        end
    end)
end)

 local jesus = misc:CreateToggle({
    Name = "Jesus",
    CurrentValue = false,
    Flag = "JesusToggle",
    Callback = function(Value)
        if Value then
            jesusing = true
            else
            jesusing = false
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

local dbb = misc:CreateButton({
    Name = "Delete Barriers",
    Callback = function()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "ExtraBarrier" or v.Name == "Barrier" then
                v:Destroy()
            end
        end
    end,
 })


local instaKilling = false



local settings = Window:CreateTab("Settings")

local Button = settings:CreateButton({
	Name = "Destroy UI",
	Callback = function()
		Rayfield:Destroy()
	end,
})

