if not game:IsLoaded() then
	game.Loaded:Wait()
end

task.wait(1)
version = "{!#version} 2.0.0 {/#version}"
version = string.sub(version,13,17)

local disableLightningTP = true
local disableClTPSound = false

versionText = "player noclip ☄"

--- Locals
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()


--- Services 
local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')
local logservice = game:GetService("LogService")
local debris = game:GetService("Debris")

--- Static
cmds = {}


--- Dynamic
FLYING = false
QEfly = true
flyspeed = 1
vehicleflyspeed = 1
clip = true
local hue = 0
local SAT = 1
local LUM = 1
local SPEED = 1
local colour = nil
local chamFolder = Instance.new("Folder",game.CoreGui)
local datastore = _G.lcd
local loadedModules = datastore:Datastore("PrismaModules")

--- Onload

function createUI()
	Prisma = Instance.new("ScreenGui")
	outline = Instance.new("Frame")
	UICorner = Instance.new("UICorner")
	input = Instance.new("TextBox")
	background = Instance.new("Frame")
	UICorner_2 = Instance.new("UICorner")

	--Properties:

	Prisma.Name = "Prisma"
	Prisma.Parent = game.CoreGui
	Prisma.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Prisma.ResetOnSpawn = false

	outline.Name = "outline"
	outline.Parent = Prisma
	outline.Active = true
	outline.AnchorPoint = Vector2.new(0.5, 0.5)
	outline.BackgroundColor3 = Color3.fromRGB(255, 170, 127)
	outline.Position = UDim2.new(0.5,0,2,0)
	outline.Selectable = true
	outline.Size = UDim2.new(0, 202, 0, 42)

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = outline

	input.Name = "input"
	input.Parent = outline
	input.AnchorPoint = Vector2.new(0.5, 0.5)
	input.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	input.BackgroundTransparency = 1.000
	input.Position = UDim2.new(0.5, 0, 0.5, 0)
	input.Size = UDim2.new(0, 200, 0, 40)
	input.ZIndex = 2
	input.Font = Enum.Font.SourceSans
	input.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
	input.Text = "mdvo"
	input.TextColor3 = Color3.fromRGB(255, 255, 255)
	input.TextSize = 16.000

	background.Name = "background"
	background.Parent = outline
	background.Active = true
	background.AnchorPoint = Vector2.new(0.5, 0.5)
	background.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	background.Position = UDim2.new(0.5, 0, 0.5, 0)
	background.Selectable = true
	background.Size = UDim2.new(0, 200, 0, 40)

	UICorner_2.CornerRadius = UDim.new(0, 4)
	UICorner_2.Parent = background
    
    autocomplete = input:Clone()
    autocomplete.Name = "autocomplete"
    autocomplete.TextColor3 = Color3.fromRGB(0, 0, 0)
    autocomplete.ClearTextOnFocus = false
    autocomplete.TextEditable = false
    autocomplete.Parent = outline
	autocomplete.Visible = false
    autocomplete.ZIndex = 1
	autocomplete.Position = UDim2.new(0.5,0,1.3, 0)
    
    outline.Visible = false
end

createUI()

--- Rainbowify

spawn(function()
    local r = {
        Color3.fromRGB(254, 0, 0);		--red
        Color3.fromRGB(255, 127, 0);	--orange
        Color3.fromRGB(255, 221, 1);	--yellow
        Color3.fromRGB(0, 200, 0);		--green
        Color3.fromRGB(0, 160, 199);	--light blue
        Color3.fromRGB(0, 55, 230);		--dark blue
        Color3.fromRGB(129, 16, 210)}	--purple
    local info = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
    input.TextColor3 = r[1]
	outline.BackgroundColor3 = r[1]
    i = 1
    while true do
        local tween = game:GetService("TweenService"):Create(input, info, {
            TextColor3 = r[i]})
        tween:Play()
		local tween2 = game:GetService("TweenService"):Create(outline, info, {
            BackgroundColor3 = r[i]})
        tween2:Play()

        repeat
            wait(0.1)
            if i == #r then
                i = 1 
            else
                i = i + 1 
            end
        until tween.Completed

    end
end)

--- Main Functions



function parseInput(Zext)
    local text = string.lower(Zext)
    if text == "" then return end

    local args = {}

    for Argument in string.gmatch(text,"[^%s]+") do
		table.insert(args,Argument)
	end

    if isValidCommand(args[1]) then
        local commandT = isValidCommand(args[1],true)

        if commandT.SendFull then
            local asub = nil

			if args[1] == commandT.Command then
				asub = string.len(commandT.Command) + 2
				elseif args[1] == commandT.Alias then
				asub = string.len(commandT.Alias) + 2
			end

			local fstring = string.sub(text,asub,100)
            commandT.CallBack(fstring,args[2],args[3])
        else
            commandT.CallBack(args[2],args[3],args[4])
        end
        
    end
end

function _G.addCMD(command,alias,callback,sendfull)
    local fc = callback
    if callback == nil or callback == "" or type(callback) == "string" then
        fc = sendfull
    end

    table.insert(cmds,{
        Command = command,
        Alias = alias,
        CallBack = fc,
        SendFull = sendfull,
    })
end

local blur = Instance.new("BlurEffect",game.Lighting)
blur.Size = 0

function toggle()
    if outline.Visible == false then
        outline.Visible = true
		
		tweenservice:Create(outline,TweenInfo.new(.1),{
			Position = UDim2.new(0.5,0,0.9,0)
		}):Play()
		pcall(function()
			tweenservice:Create(blur,TweenInfo.new(.1),{
				Size = 7
			}):Play()
		end)
		autocomplete.TextTransparency = 0.54

        input:CaptureFocus()
        else

		tweenservice:Create(outline,TweenInfo.new(.1),{
			Position = UDim2.new(0.5,0,2,0)
		}):Play()
		pcall(function()
			tweenservice:Create(blur,TweenInfo.new(.1),{
				Size = 0
			}):Play()
		end)
		task.wait(.1)
        outline.Visible = false
    end
end

--- Functions



function isValidCommand(String,send)
    for _,v in pairs(cmds) do
        if v.Command == String or v.Alias == String then
            if send then
                return v
                else
                return true
            end
        end
    end
end

function executeCommand(command,arg1,arg2,arg3)
	for i,v in pairs(cmds) do
		if v.Command == command or v.Alias == command then
			v.CallBack(arg1,args2,args3)
		end
	end
end



local waiting = {}
-- function notify(text,colon,imageID,soundid,volume)
-- 	local ded = false
-- 	local function createNotifInstance()
-- 		local NotificationTemplate = Instance.new("TextLabel")
-- 		NotificationTemplate.Name = "NotificationTemplate"
-- 		NotificationTemplate.BackgroundColor3 = Color3.fromRGB(34, 87, 168)
-- 		NotificationTemplate.BorderColor3 = Color3.fromRGB(27, 42, 53)
-- 		NotificationTemplate.BorderSizePixel = 0
-- 		NotificationTemplate.Position = UDim2.new(-0.903124988, 0, 0.931617498, 0)
-- 		NotificationTemplate.Size = UDim2.new(0, 100, 0, 15)
-- 		NotificationTemplate.Font = Enum.Font.Highway
-- 		NotificationTemplate.Text = "Hello there!"
-- 		NotificationTemplate.TextColor3 = Color3.fromRGB(234, 247, 255)
-- 		NotificationTemplate.TextScaled = true
-- 		NotificationTemplate.TextSize = 32.000
-- 		NotificationTemplate.TextWrapped = true

-- 		pcall(function()
-- 			local image = Instance.new("ImageLabel",NotificationTemplate)
-- 			image.Name = "image"
			
-- 			image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
-- 			image.BackgroundTransparency = 1.000
-- 			image.BorderSizePixel = 0
-- 			image.Size = UDim2.new(0.100000001, 0, 1, 0)
-- 			if soundid ~= "error" then
-- 				image.Image = imageID
-- 			else
-- 				image.Image = "rbxassetid://10738342095"
-- 			end
-- 		end)
		

-- 		return NotificationTemplate
-- 	end
	
-- 	local NotificationsGui;
-- 	if Prisma:FindFirstChild("Popups") then
-- 		NotificationsGui = Prisma:FindFirstChild("Popups")
-- 	else
-- 		local Popups = Instance.new("Frame",Prisma)
-- 		local UIListLayout = Instance.new("UIListLayout")
-- 		Popups.Name = "Popups"
-- 		Popups.AnchorPoint = Vector2.new(1, 1)
-- 		Popups.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
-- 		Popups.BackgroundTransparency = 1.000
-- 		Popups.Position = UDim2.new(0.98989898, 0, 0.991729081, 0)
-- 		Popups.Size = UDim2.new(0, 320, 0, 567)

-- 		UIListLayout.Parent = Popups
-- 		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
-- 		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
-- 		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
-- 		UIListLayout.Padding = UDim.new(0, 10)
-- 		NotificationsGui = Popups
-- 	end

-- 	local newNotify = createNotifInstance()
-- 	newNotify.Text = text
-- 	newNotify.Parent = NotificationsGui

-- 	pcall(function()
-- 		local sound = Instance.new("Sound",workspace)
-- 		sound.Volume = volume or 1
-- 		if soundid ~= "error" then
-- 		sound.SoundId = soundid
-- 		else
-- 		sound.SoundId = "rbxassetid://4094488012"
-- 		sound.Volume = 15
-- 		end
-- 		sound.PlayOnRemove = true
-- 		sound:Destroy()
-- 	end)

-- 	-- newNotify.BackgroundColor3 = colour

-- 	if not colon or colon == nil then
-- 		newNotify.BackgroundColor3 = Color3.fromRGB(116, 116, 116)
-- 		-- coroutine.resume(coroutine.create(function()
-- 		-- 	while task.wait() do
-- 		-- 		if ded then
-- 		-- 			break
-- 		-- 		end
-- 		-- 		newNotify.BackgroundColor3 = colour
-- 		-- 	end
-- 		-- end))
-- 	else
-- 		newNotify.BackgroundColor3 = colon
-- 	end

-- 	table.insert(waiting,newNotify)

-- 	newNotify:TweenSize(UDim2.new(0, 380,0, 28), Enum.EasingDirection.Out, Enum.EasingStyle.Back,0.15)
-- 	coroutine.wrap(function()
-- 		wait(3)
-- 		for t = 0,1,0.1 do
-- 			newNotify.BackgroundTransparency = t
-- 			newNotify.TextTransparency = t
-- 			newNotify.image.ImageTransparency = t
-- 			wait()
-- 		end
-- 		wait(0.05)
-- 		for i,v in pairs(waiting) do
-- 			if v == newNotify then
-- 				table.remove(waiting,i)
-- 			end
-- 		end
-- 		ded = true
-- 		newNotify:Destroy()
-- 		if #waiting == 0 then
-- 			NotificationsGui:Destroy()
-- 		end
-- 	end)()
-- end
function notify(text,lifetime,format)
	if lifetime == nil then
		lifetime = 3
	end
	parent = Prisma
	local function createNotifInstance()
		--local new = script.Parent.notifTemp:Clone()
		--new.Visible = true
		--new.Size = UDim2.new(0,20,0,20)
		local notifTemp = Instance.new("Frame")
		local title = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local textfield = Instance.new("TextLabel")
		local progress = Instance.new("Frame")

		--Properties:

		notifTemp.Name = "notifTemp"
		notifTemp.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
		notifTemp.Position = UDim2.new(1.5, 0, 0.850000024, 0)
		notifTemp.Size = UDim2.new(0,20,0,20)
		notifTemp.Visible = false
		notifTemp.Visible = true

		title.Name = "title"
		title.Parent = notifTemp
		title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		title.BackgroundTransparency = 1.000
		title.Position = UDim2.new(0.0275862068, 0, 0.0666666701, 0)
		title.Size = UDim2.new(0, 274, 0, 22)
		title.Font = Enum.Font.Roboto
		title.Text = "Prisma, duh"
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.TextScaled = true
		title.TextSize = 14.000
		title.TextWrapped = true
		title.TextXAlignment = Enum.TextXAlignment.Left

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = notifTemp

		textfield.Name = "textfield"
		textfield.Parent = notifTemp
		textfield.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textfield.BackgroundTransparency = 1.000
		textfield.Position = UDim2.new(0.0275862068, 0, 0.377777785, 0)
		textfield.Size = UDim2.new(0, 274, 0, 40)
		textfield.Font = Enum.Font.Unknown
		textfield.RichText = true
		textfield.Text = text
		textfield.TextColor3 = Color3.fromRGB(255, 255, 255)
		textfield.TextSize = 19.000
		textfield.TextScaled = true
		textfield.TextWrapped = true
		textfield.TextXAlignment = Enum.TextXAlignment.Left

		if format then
			textfield.Text = formatText(text)
		end

		progress.Name = "progress"
		progress.Parent = notifTemp
		progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		progress.BorderSizePixel = 0
		progress.Position = UDim2.new(0, 0, 0.944444418, 0)
		progress.Size = UDim2.new(0, 290, 0, 5)
		return notifTemp
	end
	
	local NotificationsGui;
	if parent:FindFirstChild("Popups") then
		NotificationsGui = parent:FindFirstChild("Popups")
	else
		local Popups = Instance.new("Frame",parent)
		local UIListLayout = Instance.new("UIListLayout")
		Popups.Name = "Popups"
		Popups.AnchorPoint = Vector2.new(1, 1)
		Popups.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Popups.BackgroundTransparency = 1.000
		Popups.Position = UDim2.new(0.98989898, 0, 0.991729081, 0)
		Popups.Size = UDim2.new(0, 320, 0, 567)

		UIListLayout.Parent = Popups
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		UIListLayout.Padding = UDim.new(0, 10)
		NotificationsGui = Popups
	end

	local newNotify = createNotifInstance()
	newNotify.Parent = NotificationsGui
	table.insert(waiting,newNotify)

	newNotify:TweenSize(UDim2.new(0, 290,0, 90), Enum.EasingDirection.Out, Enum.EasingStyle.Back,0.15)

	
	task.spawn(function()
		lifetime = lifetime*100
		for i = 1,lifetime do
			game:GetService("TweenService"):Create(newNotify.progress,TweenInfo.new(.15),{
				Size = UDim2.new(i/lifetime,0,0,5)
			}):Play()
			task.wait(0.01)
		end
		newNotify.title.Visible = false
		newNotify.textfield.Visible = false
		newNotify:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine,0.15)
		task.wait(.15)
		newNotify:Destroy()
	end)
end

function _G.prismaNotify(text,lifetime)
	notify(text,lifetime)
end

function chatNotif(text)
	repeat
		task.wait()
		local Success = pcall(function()
			game.StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = ">> [PRISMA]: "..text;
				Font = Enum.Font.SourceSansBold;
				Color = Color3.fromRGB(255, 255, 255);
				FontSize = 25;
			})
		end)
	until Success
end
function _G.chatNotify(text)
	chatNotif(text)
end

function hsvToRgb(h, s, v)
	local r, g, b
	local i = math.floor(h * 6);
	local f = h * 6 - i;
	local p = v * (1 - s);
	local q = v * (1 - f * s);
	local t = v * (1 - (1 - f) * s);
	i = i % 6
	if i == 0 then r, g, b = v, t, p
	elseif i==1 then r, g, b=q, v, p
	elseif i==2 then r, g, b=p, v, t
	elseif i==3 then r, g, b=p, q, v
	elseif i==4 then r, g, b=t, p, v
	elseif i==5 then r, g, b=v, p, q
	end 
	return r, g, b
end

function getRoot()
    return plr.Character.HumanoidRootPart
end

function round(n)
	return math.floor(n + 0.5)
end

function sFLY(vfly)
	repeat wait() until plr and plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(plr.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and plr.Character:FindFirstChildOfClass('Humanoid') then
					plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if plr.Character:FindFirstChildOfClass('Humanoid') then
				plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or flyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or flyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or flyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if plr.Character:FindFirstChildOfClass('Humanoid') then
		plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

function findplr(args, tbl)
	if tbl == nil then
		local tbl = game.Players:GetPlayers()
		if args == "me" then
			return plr
		elseif args == "random" then 
			return tbl[math.random(1,#tbl)]
		elseif args == "new" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v.AccountAge < 30 and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "old" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v.AccountAge > 30 and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "bacon" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair") and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "friend" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v:IsFriendsWith(plr.UserId) and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "notfriend" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if not v:IsFriendsWith(plr.UserId) and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "ally" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v.Team == plr.Team and v ~= plr then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "enemy" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v.Team ~= plr.Team then
					vAges[#vAges+1] = v
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "near" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v ~= plr then
					local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - plr.Character.HumanoidRootPart.Position).magnitude
					if math < 30 then
						vAges[#vAges+1] = v
					end
				end
			end
			return vAges[math.random(1,#vAges)]
		elseif args == "far" then
			local vAges = {} 
			for _,v in pairs(tbl) do
				if v ~= plr then
					local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - plr.Character.HumanoidRootPart.Position).magnitude
					if math > 30 then
						vAges[#vAges+1] = v
					end
				end
			end
			return vAges[math.random(1,#vAges)]
		else 
			for _,v in pairs(tbl) do
				if v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower()) then
					return v
				end
			end
		end
	else
		for _, plr in pairs(tbl) do
			if plr.UserName:lower():find(args:lower()) or plr.DisplayName:lower():find(args:lower()) then
				return plr
			end
		end
	end
end

function _G.findplr(args,tbl)
	findplr(args,tbl)
end


function playSound(id,volume,loop,parent)
	local sound = Instance.new("Sound",parent)
	sound.SoundId = id
	sound.PlayOnRemove = true
	sound.Volume = volume
	sound.Looped = loop
	sound:Destroy()
end

local Abinds = {}

function addBind(keycode,Function)
	table.insert(Abinds,{
		Key = keycode,
		CallBack = Function,
        Enabled = true,
	})
end

local modules = {}

function addModule(name,default,callback)
	table.insert(modules,{
		Name = name,
		Enabled = default
	})

	local list;

	for i,v in pairs(modules) do
		if v.Name == name then
			list = v
		end
	end

	spawn(function()
		callback(list)
	end)
end


function formatText(text)
	
	local ColorizePattern = '<font color="%s">%s</font>'
	
	local function Colorize(keyword, color)
		return string.format(ColorizePattern, color, keyword)
	end
	
	local words = {}
	local newWords = {}
	for word in string.gmatch(text,"[^%s]+") do
		table.insert(words,word)
	end
	for i,v in pairs(words) do
		if string.match(v,"!") then
			local colorValues = "#"..string.sub(v,2,7)
			table.insert(newWords,Colorize(string.sub(v,8,300),colorValues))
		else
			table.insert(newWords,v)
		end
	end
	local text = ""
	for i,v in pairs(newWords) do
		--print(v)
		text = text..v.." "
	end
	return text
end



--- Events

local GC = getconnections or get_signal_cons --- Anitafk
if GC then
    for i,v in pairs(GC(plr.Idled)) do
        if v["Disable"] then
            v["Disable"](v)
        elseif v["Disconnect"] then
            v["Disconnect"](v)
        end
    end
    else
end

input.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
	if not enterPressed then return end
	parseInput(input.Text)
end)

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	for i,v in pairs(Abinds) do
		if v.Key == input.KeyCode then
			if v.Enabled then
                v.CallBack()
            end
		end
	end
end)


uis.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.RightAlt and not gameProcessedEvent then
        task.wait(.1)
        toggle()
    end
end)

input.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
    toggle()
end)

uis.InputBegan:Connect(function(keycode, gameProcessedEvent)
	if keycode.KeyCode == Enum.KeyCode.Tab and outline.Visible == true then
		if autocomplete.Text == "" or " " then
			local txt = autocomplete.Text
			task.wait()
			input.Text = txt
			input.CursorPosition = 50
		end
	end
end)

input:GetPropertyChangedSignal("Text"):Connect(function()
    pcall(function()
		if input.Text == "" then
            autocomplete.Text = ""
        else
        local text = input.Text

        local result = nil

        for i,v in pairs(cmds) do
            if v.Alias ~= nil then
                if v.Alias:sub(1,#text):lower() == text then
                    result = v.Alias
                    elseif v.Command:sub(1,#text):lower() == text then
                        result = v.Command
                end
            else
                if v.Command:sub(1,#text):lower() == text then
                    result = v.Command
                end
            end
        end

        if result ~= nil then
            autocomplete.Text = result
            else
            autocomplete.Text = ""
        end
    end
	end)
end)

--- Ping display

function createPing()
	pingLABEL = Instance.new("TextLabel",Prisma)
	pingLABEL.Name = "ping"
	pingLABEL.AnchorPoint = Vector2.new(0.5, 0.5)
	pingLABEL.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
	pingLABEL.BackgroundTransparency = 1.000
	pingLABEL.Position = UDim2.new(0.944444418, 0, 0.954682767, 0)
	pingLABEL.Size = UDim2.new(0, 180, 0, 24)
	pingLABEL.Text = "2008 ms"
	pingLABEL.TextColor3 = Color3.fromRGB(0, 255, 0)
	pingLABEL.TextScaled = true
	pingLABEL.TextSize = 12.000
	pingLABEL.TextWrapped = true
end
createPing()


function editColour(ping)
	if ping < 700 then
		pingLABEL.TextColor3 = Color3.fromRGB(0, 255, 0)
		elseif ping > 700 and ping < 1000 then
		pingLABEL.TextColor3 = Color3.fromRGB(255, 255, 0)
		elseif ping > 1000 then
		pingLABEL.TextColor3 = Color3.fromRGB(255, 0, 0)
	end
end

local canDisplay = false

runservice.RenderStepped:Connect(function(deltaTime)

	if game.CoreGui.RobloxGui:FindFirstChild("PerformanceStats") then
		canDisplay = true
		pingLABEL.Visible = true
		game.CoreGui.RobloxGui:FindFirstChild("PerformanceStats").Visible = false
	else
		canDisplay = false
		pingLABEL.Visible = false
	end

	if canDisplay then
		
		for i,v in pairs(game.CoreGui.RobloxGui:FindFirstChild("PerformanceStats"):GetChildren()) do
			pcall(function()
				if v["StatsMiniTextPanelClass"]["TitleLabel"].Text == "Ping" then
					Rawping = v["StatsMiniTextPanelClass"]["ValueLabel"].Text
					ping = tonumber(string.split(Rawping,".")[1])
					pingLABEL.Text = tostring(ping).." ms"
					editColour(ping)
				end
			end)
		end
	end
end)



local locateTarget = nil

plr.Chatted:Connect(function(message, recipient)
	local prefix = string.sub(message,1,1)
	if prefix == "^" then
		local message = string.sub(message,2,50)
		parseInput(message)
	end
end)



function createLightning(startPos, endPos, segments,size,customTable)

	local points = {}
	local Model = Instance.new ("Model")
	Model.Name = "Lightning"
	Model.Parent = game.Workspace

	for i = 0, segments do
		local offset = Vector3.new(math.random(-1,1),math.random(-2,2),math.random(-1,1))
		local position = startPos + (endPos - startPos).Unit * i * (endPos - startPos).Magnitude / segments

		if i == 0 or i == segments then
			offset = Vector3.new (0,0,0)
		end

		points[#points + 1] = position + offset
	end

	for i = 1, #points do
		if points[i + 1] ~= nil then
			local Lightning = Instance.new("Part")
			Lightning.Material = customTable.Material or Enum.Material.Neon
			Lightning.Anchored = true
			Lightning.CanCollide = customTable.CanCollide or false
			Lightning.Transparency = customTable.Transparency or 0
			Lightning.Color = customTable.Color or Color3.fromRGB(4, 175, 236)
			--Lightning.BrickColor = BrickColor.new("Cyan")
			Lightning.Size = Vector3.new(size,size, (points[i] - points [i + 1]).Magnitude)
			Lightning.CFrame = CFrame.new((points[i] + points[i+1]) / 2, points[i +1])
			Lightning.Parent = Model
		end
	end

	return Model
end

registedBases = {}
_G.currentBase = nil

function _G.registerBase(name,default,data)
	table.insert(registedBases,{
		Name = name,
		Load = data.Load,
		Unloaded = data.Unloaded,
		Data = data,
		Location = nil,
		Enabled = false,
	})
	print("[PRISMA] - Registed ",name," as a base")

	if default then
		for i,v in pairs(registedBases) do
			if v.Name == name then
				_G.currentBase = v
			end
		end
	end
end

local enabled = false
local firstTime = true
local df = nil



function dobasestuff()
	if not enabled then

		if firstTime then
			firstTime = false
			base = _G.currentBase.Load()
			_G.currentBase.Location = base

			-- base:PivotTo(CFrame.new(9000,9000,9000))
			task.wait(1)
		end

		enabled = true
		df = plr.Character.HumanoidRootPart.CFrame
		local char = _G.currentBase.Data.Find(base)
		plr.Character.HumanoidRootPart.CFrame = char
		task.wait(.1)
		_G.currentBase.Enabled = true
	else
		enabled = false
		_G.currentBase.Enabled = false
		plr.Character.HumanoidRootPart.CFrame = df
	end
end

function _G.prismaoverridebase()
	dobasestuff()
end

uis.InputBegan:Connect(function(input,chatting)
	if input.KeyCode == Enum.KeyCode.PageDown and not chatting and _G.currentBase ~= nil then
		dobasestuff()
		-- if not enabled then

        --     if firstTime then
        --         firstTime = false
        --         base = _G.currentBase.Load()
		-- 		_G.currentBase.Location = base

        --         -- base:PivotTo(CFrame.new(9000,9000,9000))
		-- 		task.wait(1)
        --     end

		-- 	enabled = true
		-- 	df = plr.Character.HumanoidRootPart.CFrame
		-- 	local char = _G.currentBase.Data.Find(base)
		-- 	plr.Character.HumanoidRootPart.CFrame = char
		-- 	task.wait(.1)
		-- 	_G.currentBase.Enabled = true
		-- else
		-- 	enabled = false
		-- 	_G.currentBase.Enabled = false
		-- 	plr.Character.HumanoidRootPart.CFrame = df
		-- end
	end
end)

for i,v in pairs(loadedModules) do
	if isfile(v) then
		print("loaded "..v)
		loadstring(readfile(v))()
	end
end

spawn(function()
	while task.wait() do
		local color = hsvToRgb(hue/360, SAT, LUM)
		hue = (hue+SPEED)%360
		colour = Color3.fromHSV(hue/360, SAT, LUM)
	end
end)


local prevPos = nil
local currentPos = nil

local stbp = true

function noServerTween(pos)
	local desired = pos
	getRoot().Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	local tempBlock = Instance.new("Part",workspace)
	tempBlock.Anchored = true
	tempBlock.Transparency = 1
	tempBlock.CanCollide = false
	tempBlock.CFrame = getRoot().CFrame
	tempBlock.CFrame = pos
	workspace.CurrentCamera.CameraSubject = tempBlock

	workspace.FallenPartsDestroyHeight = -math.huge
	getRoot().CFrame = getRoot().CFrame - Vector3.new(0,500)
	task.wait(.05)
	getRoot().CFrame = desired - Vector3.new(0,500)
	task.wait(.01)
	getRoot().CFrame = desired + Vector3.new(0,5,0)
	workspace.CurrentCamera.CameraSubject = getRoot().Parent.Humanoid
	tempBlock:Destroy()
	delay(1,function()
		getRoot().Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	end)
end

--- Binds
addBind(Enum.KeyCode.V,function()
	if mouse.Target == nil then return end
	if not disableClTPSound then
		playSound("rbxassetid://858508159",1,false,workspace)
	end
	prevPos = plr.Character.HumanoidRootPart.CFrame
	currentPos = mouse.Hit + Vector3.new(0,5,0)
    if not stbp then
		plr.Character.HumanoidRootPart.CFrame = mouse.Hit + Vector3.new(0,5,0)
	else
		noServerTween(mouse.Hit + Vector3.new(0,5,0))
	end

end)
uis.InputBegan:Connect(function(input,chatting)
	if input.KeyCode == Enum.KeyCode.LeftBracket and not chatting then
		if prevPos ~= nil then
			plr.Character.HumanoidRootPart.CFrame = prevPos
		end
	end
end)
uis.InputBegan:Connect(function(input,chatting)
	if input.KeyCode == Enum.KeyCode.RightBracket and not chatting then
		if currentPos ~= nil then
			plr.Character.HumanoidRootPart.CFrame = currentPos
		end
	end
end)

if not disableLightningTP then
	task.spawn(function()
		local lightning = Instance.new("Part")
		while task.wait() do
			if prevPos ~= nil and currentPos ~= nil then
				local distance = math.round((prevPos.Position-currentPos.Position).magnitude)/7
				if distance < 20 then
					distance = 5
				end
				lightning:Destroy()
				lightning = createLightning(prevPos.Position,currentPos.Position,distance,.1,{
					Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)),
					--Transparency = 0.5,
				})
			end
		end
	end)
end


addBind(Enum.KeyCode.F6,function(self)
	if clip then
        notify("Noclip Enabled")
		clip = false
		function NoclipLoop()
			if clip == false and plr.Character ~= nil then
				for _, child in pairs(plr.Character:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true then
						child.CanCollide = false
					end
				end
			end
		end
		Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
		else
        notify("Noclip Disabled")
		clip = true
		Noclipping:Disconnect()
	end
end)

addBind(Enum.KeyCode.F5,function()
	if FLYING then
		executeCommand("unfly")
	else
		executeCommand("fly",tostring(flyspeed))
	end
end)

addBind(Enum.KeyCode.F3,function()
	if FLYING then
		NOFLY()
	else
		NOFLY()
		wait()
		sFLY(true)
	end
end)

addBind(Enum.KeyCode.End,function()
	executeCommand("clickdelete")
end)

profly = false





addBind(Enum.KeyCode.F2,function()
	if not profly then
		profly = true

		spawn(function()
			repeat
				task.wait(.2)
				local part = Instance.new("Part")
				part.Color = Color3.new(0.843137, 0.772549, 0.603922)
				part.Size = Vector3.new(4, 1, 4)
				part.Parent = workspace
				part.Transparency = 0.15
				part.CanCollide = false
				part.Anchored = true
				part.Position = plr.Character.HumanoidRootPart.Position - Vector3.new(0,2.6,0)


				local mesh = Instance.new("SpecialMesh")
				mesh.MeshType = Enum.MeshType.FileMesh
				mesh.MeshId = "rbxassetid://6120788966"
				mesh.TextureId = "rbxassetid://6120789019"
				mesh.Scale = Vector3.new(1, 0.5, 1)
				mesh.Parent = part
				game:GetService("TweenService"):Create(mesh,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{
					Scale = Vector3.new(4, 0.5, 4)
				}):Play()
				game:GetService("TweenService"):Create(part,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{
					Transparency = 1
				}):Play()
				game:GetService("Debris"):AddItem(part,1)
			until not profly
		end)

		repeat
			task.wait()
			pro = Instance.new("Part",workspace)
			pro.Anchored = true
			pro.Size = Vector3.new(5,1,5)
			pro.Color = Color3.fromRGB(255, 255, 255)
			pro.Material = Enum.Material.ForceField
			pro.Transparency = 1
	
			local debris = game:GetService("Debris")
			debris:AddItem(pro,1)
			pro.CFrame = plr.Character.HumanoidRootPart.CFrame - Vector3.new(0,3.5,0)
		until not profly
		else
		profly = false
	end
end)

uis.InputBegan:Connect(function(input,chatting)
	if input.KeyCode == Enum.KeyCode.T and not chatting then
		if profly then
			local Sound = Instance.new("Sound",plr.Character.HumanoidRootPart)
			Sound.SoundId = "rbxassetid://4580495407"
			Sound.PlayOnRemove = true
			Sound.Volume = 3
			Sound.TimePosition = .05
			Sound:Destroy()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://188632011"
			local track = plr.Character.Humanoid:LoadAnimation(Anim)
			track:Play()
			track:AdjustSpeed(2)
			local Vele = Instance.new("BodyVelocity",plr.Character.HumanoidRootPart)
			plr.Character.HumanoidRootPart.Anchored = false
			Vele.MaxForce = Vector3.new(1,1,1) * math.huge
			Vele.Velocity = Vector3.new(0,100,0)
			game.Debris:AddItem(Vele,.15)
			local part = Instance.new("Part")
			part.Color = Color3.new(0.843137, 0.772549, 0.603922)
			part.Size = Vector3.new(4, 1, 4)
			part.Parent = workspace
			part.Transparency = 0.15
			part.CanCollide = false
			part.Anchored = true
			part.Position = plr.Character.HumanoidRootPart.Position - Vector3.new(0,2.6,0)


			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.FileMesh
			mesh.MeshId = "rbxassetid://6120788966"
			mesh.TextureId = "rbxassetid://6120789019"
			mesh.Scale = Vector3.new(1, 0.5, 1)
			mesh.Parent = part
			game:GetService("TweenService"):Create(mesh,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{
				Scale = Vector3.new(10, 0.5,  10)
			}):Play()
			game:GetService("TweenService"):Create(part,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{
				Transparency = 1
			}):Play()
			game:GetService("Debris"):AddItem(part,2)
		end
	end
end)

addBind(Enum.KeyCode.F8,function()
	executeCommand("breakvel")
end)

addBind(Enum.KeyCode.F10,function()
	executeCommand("launch")
end)

dfSpeed = 16
sprinting = false
speedvalue = 80

addBind(Enum.KeyCode.F1,function()
	if not sprinting then
		notify("Set to "..speedvalue,.5)
		sprinting = true
		dfSpeed = plr.Character.Humanoid.WalkSpeed
		repeat
			wait()
			pcall(function()
				plr.Character.Humanoid.WalkSpeed = speedvalue
			end)
		until not sprinting
		plr.Character.Humanoid.WalkSpeed = dfSpeed
		else
		notify("Set to "..dfSpeed,.5)
		sprinting = false
		plr.Character.Humanoid.WalkSpeed = dfSpeed
	end
end)

local shiftlock = false
local dfIcon;
addBind(Enum.KeyCode.RightControl,function()
	function shiftLock(toggle)
		local function lock()
			local lookVector = workspace.CurrentCamera.CFrame.LookVector
			local rootPos = getRoot().Position; local distance = 900
			getRoot().CFrame = CFrame.new(rootPos, lookVector * Vector3.new(1, 0, 1) * distance)
			uis.MouseBehavior = Enum.MouseBehavior.LockCenter
			mouse.Icon = "rbxassetid://4264273816"
		end
		if toggle then
			dfIcon = mouse.Icon
			runservice:BindToRenderStep("ShiftLock", 200, lock)
			tweenservice:Create(getRoot().Parent.Humanoid,TweenInfo.new(1),{
				CameraOffset = Vector3.new(2,0,0)
			}):Play()
			plr.Character.Humanoid.Died:Connect(function()
				runservice:UnbindFromRenderStep("ShiftLock")
				uis.MouseBehavior = Enum.MouseBehavior.Default
				shiftlock = false
			end)
		else
			runservice:UnbindFromRenderStep("ShiftLock")
			mouse.Icon = dfIcon
			uis.MouseBehavior = Enum.MouseBehavior.Default
			tweenservice:Create(getRoot().Parent.Humanoid,TweenInfo.new(1),{
				CameraOffset = Vector3.new(0,0,0)
			}):Play()
		end; getRoot().Parent.Humanoid.AutoRotate = not toggle
	end

	if shiftlock then
		shiftlock = false
		shiftLock(false)
	else
		shiftlock = true
		shiftLock(true)
	end
end)

addBind(Enum.KeyCode.F4,function()
	executeCommand("undance")
	executeCommand("dance")
end)


--- Modules


local target;
local enabled = false

function ASDcreate()
	-- Gui to Lua
	-- Version: 3.2

	-- Instances:

	 Prop = Instance.new("ScreenGui")
	 indexes = Instance.new("Frame")
	 UIGridLayout = Instance.new("UIGridLayout")
	 --name = Instance.new("TextLabel")
	 Destroy = Instance.new("TextButton")

	--Properties:

	Prop.Name = "Prop"
	Prop.Parent = game.CoreGui
	Prop.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	indexes.Name = "indexes"
	indexes.Parent = Prop
	indexes.AnchorPoint = Vector2.new(0.5, 0.5)
	indexes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	indexes.BackgroundTransparency = 1.000
	indexes.Position = UDim2.new(0.519444466, 0, 0.608761311, 0)
	indexes.Visible = false
	indexes.Size = UDim2.new(0, 163, 0, 244)

	UIGridLayout.Parent = indexes
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 0)
	UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)

	--name.Name = "name"
	--name.Parent = indexes
	--name.Active = true
	--name.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
	--name.BorderSizePixel = 0
	--name.Selectable = true
	--name.Size = UDim2.new(0, 200, 0, 50)
	--name.Font = Enum.Font.SourceSans
	--name.Text = "Baseplate"
	--name.TextColor3 = Color3.fromRGB(17, 17, 17)
	--name.TextSize = 20.000

	Destroy.Name = "Destroy"
	Destroy.Parent = indexes
	Destroy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Destroy.BorderSizePixel = 0
	Destroy.Size = UDim2.new(0, 200, 0, 50)
	Destroy.Font = Enum.Font.SourceSans
	Destroy.Text = "Destroy"
	Destroy.TextColor3 = Color3.fromRGB(0, 0, 0)
	Destroy.TextScaled = true
end
ASDcreate()

Destroy.MouseButton1Click:Connect(function()
	enabled = false
	target:Destroy()
end)

function createLabel(Type,text,label)
	if label then
		local Text = Instance.new('TextLabel',indexes)
		Text.TextScaled = true
		Text.BorderSizePixel = 0
		Text.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Text.Text = text
	end
	local TYText = Instance.new(Type,indexes)
	TYText.TextScaled = true
	TYText.BorderSizePixel = 0
	TYText.BackgroundColor3 = Color3.fromRGB(255,255,255)
	--TYText.Text = text
	return TYText
end

function move(pos)
	target = mouse.Target
	can.Text = tostring(target.CanCollide)
	trans.Text = target.Transparency
	anch.Text = tostring(target.Anchored)
	
	local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(pos) local screenPoint = Vector2.new(vector.X, vector.Y) indexes.Position = UDim2.new(0,vector.X+indexes.Size.X.Offset/2,0,vector.Y+indexes.Size.Y.Offset/2)
	
	indexes.Visible = true
	
	repeat
		task.wait()
		local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(pos)

		local screenPoint = Vector2.new(vector.X, vector.Y)

		indexes.Position = UDim2.new(0,vector.X+indexes.Size.X.Offset/2,0,vector.Y+indexes.Size.Y.Offset/2)
	until not enabled
	indexes.Visible = false
end

-- mouse.Button1Down:Connect(function()
--     if uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
--         if not enabled then
--             enabled = true
--             move(mouse.Hit.p)
--         else
--             enabled = false
--         end
--     end
-- end)

mouse.Button1Down:Connect(function()
	if enabled then
		enabled = false
	end
end)

trans = createLabel("TextBox","Transparency",true)
trans.Text = ""
trans.InputEnded:Connect(function()
	target.Transparency = tonumber(trans.Text)
end)

anch = createLabel("TextButton","Anchored",true)
anch.Text = ""
anch.MouseButton1Click:Connect(function()
	if anch.Text == "false" then
		anch.Text = "true"
		target.Anchored = true
	else
		anch.Text = "false"
		target.Anchored = false
	end
end)


can = createLabel("TextButton","CanCollide",true)
can.Text = ""
can.MouseButton1Click:Connect(function()
	if can.Text == "false" then
		can.Text = "true"
		target.CanCollide = true
	else
		can.Text = "false"
		target.CanCollide = false
	end
end)

ultra = false

function update()
	local prevHealth = plr.Character.Humanoid.Health
	plr.Character.Humanoid.HealthChanged:Connect(function(health)
		if not ultra then return end
		if health < prevHealth then
			prevHealth = health
			playSound("rbxassetid://7251381246",1,false,workspace)
			local pos = plr.Character.HumanoidRootPart.CFrame
			for i = 1,10 do
				task.wait(.1)
				plr.Character.HumanoidRootPart.CFrame = pos + Vector3.new(math.random(-16,16),0,math.random(-16,16))
			end
		else
			prevHealth = health
		end
		
	end)
end

plr.CharacterAdded:Connect(function()
	task.wait(1)
	update()
end)

-- addModule("speech",true,function(self)
-- 	plr.Chatted:Connect(function(msg)
-- 			local t = {}
--    			msg:gsub(".", function(c) table.insert(t, c) return c end)
-- 			for i,v in pairs(t) do
-- 				playSound("rbxassetid://927636725",1,false,plr.Character.Head)
-- 			end
-- 	end)
-- end)


--- Commands
_G.addCMD("rejoin","rj",function(arg)
	if syn.queue_on_teleport then
		syn.queue_on_teleport('game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()')
	end
	game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players)
	wait(3)
end)

_G.addCMD("setsprint","sprint",function(number)
	speedvalue = tonumber(number) or 80
end)

_G.addCMD("togglebind","bind",function(arg)
	local an;
    if arg == "all" then
		notify("Toggled All Binds")
		for i,v in pairs(Abinds) do
			if v.Enabled then
				v.Enabled = false
			else
				v.Enabled = true
			end
		end
	else
		for i,v in pairs(Abinds) do
			if string.sub(string.lower(tostring(v.Key)),14,100) == arg then
				if v.Enabled then
					notify("Disabled bind for "..tostring(v.Key))
					v.Enabled = false
				else
					notify("Enabled bind for "..tostring(v.Key))
					v.Enabled = true
				end
			else
				an = true
			end
		end
		if an then
			notify("No bind with that keycode")
		end
	end
end)

_G.addCMD("togglemodule","module",function(arg)
	for i,v in pairs(modules) do
		if v.Name == arg then
			if v.Enabled then
				notify("Disabled Module")
				v.Enabled =false
			else
				notify("Enabled Module")
				v.Enabled = true
			end
		end
	end
end)

_G.addCMD("nameesp","esp",function(arg)
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

		if arg == nil then
		ESPText.Text = xPlayer.Name
		elseif arg == "true" or arg == "yes" then
		ESPText.Text = xPlayer.DisplayName
		end
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

end)

_G.addCMD("unesp",nil,function()
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
end)

_G.addCMD("oldui","old",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/specowos/lua-projects/main/small%20projects/project%3A2016/2016raw.lua',true))()
end)

_G.addCMD("walkspeed","ws",function(arg)
	local speed = tonumber(arg)
	local suc = pcall(function()
		if speed == nil then
			local error = plr.Character.Position
		end
		plr.Character.Humanoid.WalkSpeed = speed
	end)
	if suc then
		task.wait(.3)
		else
		task.wait(.3)
	end
end)

_G.addCMD("jumppower","jp",function(arg)
	local jump = tonumber(arg)
	local suc = pcall(function()
		if jump == nil then
			local error = plr.Character.Position
		end
		plr.Character.Humanoid.JumpPower = jump
	end)
	if suc then
		task.wait(.3)
		else
		task.wait(.3)
	end
end)

_G.addCMD("suicide","reset",function(arg)
	plr.Character:BreakJoints()
	task.wait(.1)
end)

walkspeedLoop = nil

_G.addCMD("loopws","lws",function(speed)
	local suc = pcall(function()
	local setspeed = tonumber(speed)
	if setspeed == nil then
		local error = plr.Character.Position
	end
	if walkspeedLoop ~= nil then
		walkspeedLoop:Disconnect()
	end
	walkspeedLoop = plr.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		plr.Character.Humanoid.WalkSpeed = setspeed
	end)
	plr.Character.Humanoid.WalkSpeed = setspeed
end)
	if suc then
		task.wait(.3)
		else
		task.wait(.3)
	end
end)

_G.addCMD("unloopws","unlws",function()
	pcall(function()
		walkspeedLoop:Disconnect()
		walkspeedLoop = nil
		task.wait(.3)
	end)
end)

_G.addCMD("f3x",nil,function()
	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

_G.addCMD("dex",nil,function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()--loadstring(game:HttpGetAsync("https://pastebin.com/raw/fPP8bZ8Z"))()
end)

_G.addCMD("fireclickdetectors","firecd",function()
	task.wait(.3)
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ClickDetector") then
			v.MaxActivationDistance = math.huge
			fireclickdetector(v, math.huge)
		end
	end
end)

_G.addCMD("clickdelete",nil,function()
	pcall(function()
		mouse.Target:Destroy()
	end)
end)

_G.addCMD("soundfucker","fucksounds",function(duration)
		coroutine.resume(coroutine.create(function()

		local duration = duration or 10
		
		if game:GetService("SoundService").RespectFilteringEnabled then
			return
		end

		local sounds = {}

		for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Sound") and v.Parent.Name ~= "HumanoidRootPart" then
				table.insert(sounds,v)
			end
		end


		local con = workspace.DescendantAdded:Connect(function(v)
			if v:IsA("Sound") and v.Parent.Name ~= "HumanoidRootPart" then
				table.insert(sounds,v)
			end
		end)
		wait(.1)
		local start = math.floor(tick())
		repeat
			for i,v in pairs(sounds) do
				v:Play()
				v.Volume = 500
				v.PlaybackSpeed = 1
				--v.TimePosition = math.random(0,v.TimeLength * 1000)/1000
				task.wait()
			end
		until math.floor(tick()) == start + duration
		con:Disconnect()

		for i,v in pairs(sounds) do
			v:Stop()
		end
		coroutine.yield()

	end))
end)

_G.addCMD("hyrdo","rspy",function()
	local owner = "Upbolt"
	local branch = "revision"

	local function webImport(file)
		return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
	end

	webImport("init")
	webImport("ui/main")
end)

_G.addCMD("goto","tp","Teleports to specified player",function(player)
	target = findplr(player)
    if target then
        plr.Character.Humanoid.Jump = true
        plr.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

_G.addCMD("gravity","grav",function(arg)
	grav = tonumber(arg) or 196.2
	workspace.Gravity = grav
end)

_G.addCMD("sit",nil,function()
	plr.Character.Humanoid.Sit = true
end)

_G.addCMD("up",nil,function(amount)
	local degree = tonumber(amount) or 0
	plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,degree,0)
end)

_G.addCMD("forward","thru",function(amount)
	local degree = tonumber(amount) or 0
	plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,degree*-1)
end)

stunned = false
_G.addCMD("stun","ragdoll",function()
	stunned = true
	repeat
		wait()
		plr.Character.Humanoid.PlatformStand = true
	until not stunned
	task.wait(1)
	plr.Character.Humanoid.PlatformStand = true
end)

_G.addCMD("unstun","unragdoll",function()
	stunned = false
	repeat wait()
		plr.Character.Humanoid.PlatformStand = false
	until plr.Character.Humanoid.PlatformStand == false
end)

_G.addCMD("fixcam",nil,function()
	workspace.CurrentCamera:remove()
	wait(.1)
	repeat wait() until plr.Character ~= nil
	workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	plr.CameraMinZoomDistance = 0.5
	plr.CameraMaxZoomDistance = 400
	plr.CameraMode = "Classic"
	plr.Character.Head.Anchored = false
end)

_G.addCMD("sprintspeed","setss",function(value)
	speedvalue = tonumber(value) or 32
end)

_G.addCMD("runfile",nil,function(name)
	str = name..".lua"
	pcall(function()
		loadstring(readfile(str))()
	end)
end)

_G.addCMD("infinite yield","iy",function()
	local iy = Instance.new("Part")
	iy.Name = "IY"
	iy.Parent = plr
	--loadstring(game:HttpGet(('https://raw.githubusercontent.com/iiX0Lords/scripts/main/inf.lua'),true))()
end)

_G.addCMD("execute",nil,function(code)
	pcall(function()
		loadstring(code)()
	end)
end,true)

_G.addCMD("stopsounds","stopall",function()
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Sound") then
			v.Playing = false
		end
	end
end)

_G.addCMD("strength",nil,nil,function()
	for _, child in pairs(plr.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(1000, 0.3, 0.5)
		end
	end
end)

_G.addCMD("unstrength",nil,nil,function()
	for _, child in pairs(plr.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
end)

local desp = false

_G.addCMD("health",nil,nil,function()

	-- local espBottle = Instance.new("Folder",plr.PlayerGui)
	-- espBottle.Name = "DetailedEsp"

	local function createESP(part)
		local Health = Instance.new("BillboardGui")
		local main = Instance.new("Frame")


		Health.Name = "DetailedEsp"
		Health.Parent = part
		Health.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Health.Active = true
		Health.Adornee = part
		Health.AlwaysOnTop = true
		Health.LightInfluence = 1.000
		Health.Size = UDim2.new(0.5, 0, 4.8, 0)
		Health.StudsOffset = Vector3.new(0, -0.5, 0)

		main.Name = "main"
		main.Parent = Health
		main.AnchorPoint = Vector2.new(0.5, 0.5)
		main.Position = UDim2.new(0.5, 0, 0.5, 0)
		main.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		main.Size = UDim2.new(1, 0, 1, 0)
		main.BorderSizePixel = 1
		main.BorderColor3 = Color3.fromRGB(0,0,0)

		coroutine.resume(coroutine.create(function()

			local part = part
			local hum = part.Parent.Humanoid

			part.Parent.Humanoid.Died:Connect(function()
				coroutine.yield()
			end)

			hum.HealthChanged:Connect(function()
				main:TweenSize(UDim2.new(1,0,hum.Health / hum.MaxHealth/10*10,0), Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.5,true)
			
				main.BackgroundColor3 = Color3.fromHSV((hum.Health/hum.MaxHealth)*.3, 1, 1)
			end)

		end))

	end

	desp = true

	repeat
		wait()
		for i,v in pairs(game.Players:GetPlayers()) do
			pcall(function()
			if not v.Character.HumanoidRootPart:FindFirstChild("DetailedEsp") and v ~= plr then
				createESP(v.Character.HumanoidRootPart)
			end
		end)
		end
	until not desp

end)


_G.addCMD("unhealth",nil,nil,function()
	desp = false
	task.wait(1)
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.Character then
			if v.Character.HumanoidRootPart then
				if v.Character.HumanoidRootPart:FindFirstChild("DetailedEsp") then
					v.Character.HumanoidRootPart["DetailedEsp"]:Destroy()
				end
			end
		end
	end
end)

local tracersEnabled = false

_G.addCMD("tracers",nil,nil,function()
	tracersEnabled = true
	local camera = game:GetService("Workspace").CurrentCamera
	local CurrentCamera = workspace.CurrentCamera
	local worldToViewportPoint = CurrentCamera.worldToViewportPoint


	for i,v in pairs(game.Players:GetChildren()) do
		if v ~= plr then
		local Tracer = Drawing.new("Line")
		Tracer.Visible = false
		Tracer.Color = v.TeamColor.Color
		Tracer.Thickness = 1
		Tracer.Transparency = 1

		function lineesp()

			

			loop = game:GetService("RunService").RenderStepped:Connect(function()
				camera = game:GetService("Workspace").CurrentCamera
				if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= plr and v.Character.Humanoid.Health > 0 then
					
					--local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position);
					local ScreenPosition, Vis = camera.WorldToViewportPoint(camera,v.Character.HumanoidRootPart.Position)
					local OPos = camera.CFrame:pointToObjectSpace(v.Character.HumanoidRootPart.Position)
					
					if ScreenPosition.Z < 0 then
						local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
						OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1))))
					end

					local Position = camera.WorldToViewportPoint(camera,camera.CFrame:pointToWorldSpace(OPos))
					
					if v:IsFriendsWith(plr.UserId) then
						Tracer.Color = colour
						else
						Tracer.Color = v.TeamColor.Color
					end
					
					Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 25)
					Tracer.To = Vector2.new(Position.X, Position.Y)
					Tracer.Visible = true
				else
					Tracer.Visible = false
				end
			end)
		end
		coroutine.wrap(lineesp)()
		
		end
	end

	game.Players.PlayerAdded:Connect(function(v)

		local Tracer = Drawing.new("Line")
		Tracer.Visible = false
		Tracer.Thickness = 1
		Tracer.Transparency = 1

		function lineesp()
			loop = game:GetService("RunService").RenderStepped:Connect(function()
				camera = game:GetService("Workspace").CurrentCamera
				if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= plr and v.Character.Humanoid.Health > 0 then
					
					--local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position);
					local ScreenPosition, Vis = camera.WorldToViewportPoint(camera,v.Character.HumanoidRootPart.Position)
					local OPos = camera.CFrame:pointToObjectSpace(v.Character.HumanoidRootPart.Position)
					
					if ScreenPosition.Z < 0 then
						local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
						OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1))))
					end

					local Position = camera.WorldToViewportPoint(camera,camera.CFrame:pointToWorldSpace(OPos))
					Tracer.Color = v.TeamColor.Color
					Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 25)
					Tracer.To = Vector2.new(Position.X, Position.Y)
					Tracer.Visible = true
				else
					Tracer.Visible = false
				end
			end)
		end
		coroutine.wrap(lineesp)()
	end)
end)

_G.addCMD("detailesp","desp",nil,function(tracers)
	executeCommand("health")
	executeCommand("nameesp")
	if not tracers == "false" or not tracers == "no" then
		executeCommand("tracers")
	end
end)

_G.addCMD("launch",nil,nil,function(multiplier)
	if multiplier == nil then
		multiplier = 1
	end
	local char = plr.Character
	local vel = Instance.new("BodyVelocity",char.HumanoidRootPart)
	char.HumanoidRootPart.Anchored = false
	vel.MaxForce = Vector3.new(1,1,1) * math.huge
	vel.Velocity = Vector3.new(0,350 * multiplier,0)
	game:GetService("Debris"):AddItem(vel,.15)
end)

_G.addCMD("breakvelocity","breakvel",nil,function()
	plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
end)

_G.addCMD("nocdlimits",nil,nil,function()
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ClickDetector") then
			v.MaxActivationDistance = math.huge
		end
	end
end)

_G.addCMD("say","talk",nil,function(message)
	local args = {
		[1] = message,
		[2] = "All"
	}
	
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
	
end,true)

_G.addCMD("savetools","save",nil,function()
	local fold = legacyFold:FindFirstChild("SavedTools") or Instance.new("Folder",legacyFold)
	fold.Name = "SavedTools"

	for i,v in pairs(plr.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = fold
		end
	end
	notify("Saved Tools (Load them with 'load')")
end)

_G.addCMD("loadtools","load",nil,function()
	if legacyFold:FindFirstChild("SavedTools") then
		for i,v in pairs(legacyFold.SavedTools:GetChildren()) do
			v.Parent = plr.Backpack
		end
		legacyFold:Destroy()
	end
end)

if game.PlaceId == 402122991 then
	_G.addCMD("modweapon","mod",nil,function()
		local currentWeapon = plr.Character:FindFirstChildOfClass("Tool")
		if currentWeapon == nil then return end
		local WeaponName = currentWeapon.Name

		plr.Character.Humanoid:UnequipTools()

		local ef = require(game:GetService("ReplicatedStorage").ItemStats)

		ef[WeaponName]["coolDown"] = -1
		ef[WeaponName]["maxAmmo"] = math.huge
		ef[WeaponName]["exAmmo"] = math.huge
		ef[WeaponName]["maxExAmmo"] = math.huge
		ef[WeaponName]["reloadTime"] = 0
		ef[WeaponName]["fireType"] = "automatic"
		ef[WeaponName]["range"] = 99999999999
		ef[WeaponName]["damage"] = 99999999999999

		plr.PlayerGui.autoExec.client.Disabled = true
		task.wait(.5)
		plr.PlayerGui.autoExec.client.Disabled = false
		task.wait(2)
		-- plr.Character.Humanoid:EquipTool(currentWeapon)
		-- plr.Character.Humanoid:UnequipTools()
		-- plr.Character.Humanoid:EquipTool(currentWeapon)

		for i,v in pairs(plr.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				plr.Character.Humanoid:EquipTool(v)
				plr.Character.Humanoid:UnequipTools()
			end
		end
		plr.Character.Humanoid:EquipTool(currentWeapon)
		plr.Character.Humanoid:UnequipTools()
		plr.Character.Humanoid:EquipTool(currentWeapon)
	end)
end

_G.addCMD("freeze",nil,nil,function()
	getRoot().Anchored = true
end)

_G.addCMD("unfreeze","thaw",nil,function()
	getRoot().Anchored = false
end)

_G.addCMD('dance', nil, "Dances",function()
	local dances = {"27789359", "30196114", "248263260", "45834924", "33796059", "28488254", "52155728"}
	local animation = Instance.new("Animation")        animation.AnimationId = "rbxassetid://" .. dances[math.random(1, #dances)]
	animTrack = plr.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
	animTrack:Play()
end)

_G.addCMD('undance','nodance', "Stops Dancing",function()
	if animTrack then
		animTrack:Stop()
		animTrack:Destroy()
	end
end)

_G.addCMD("redwoodmessage","message",nil,function(message)
	
local mssg = message

game.Players.LocalPlayer.PlayerGui.GUI.choiceFrame.msg.Text = mssg
game.Players.LocalPlayer.PlayerGui.GUI.choiceFrame.Visible = true

local args = {
	[1] = "FireOtherClients",
	[2] = "displayChoice",
	[3] = "returnToMenu",
	[4] = mssg
}

workspace.resources.RemoteEvent:FireServer(unpack(args))
task.wait(1)
game.Players.LocalPlayer.PlayerGui.GUI.choiceFrame.Visible = false
	
end,true)

_G.addCMD("fly",nil,nil,function(speed)
	NOFLY()
	wait()
	sFLY()
	flyspeed = tonumber(speed) or 1
end)

_G.addCMD("unfly",nil,nil,function(speed)
	NOFLY()
end)

_G.addCMD("vflyspeed","vspeed",nil,function(speed)
	vehicleflyspeed = tonumber(speed) or 1
end)

_G.addCMD("flyspeed","fspeed",nil,function(speed)
	flyspeed = tonumber(speed) or 1
end)

_G.addCMD("setspawn","spawn",nil,function()
	local x,y,z = round(plr.Character.HumanoidRootPart.Position.X),round(plr.Character.HumanoidRootPart.Position.Y),round(plr.Character.HumanoidRootPart.Position.Z)
	notify("Set spawn at "..tostring(Vector3.new(x,y,z)),2)
	if cor ~= nil then
		cor:Disconnect()
	end

	-- local Spawn = getRoot().CFrame

	spawnpart = Instance.new("Part",workspace)
	spawnpart.Anchored = true
	spawnpart.CanCollide = false
	spawnpart.Transparency = 1
	spawnpart.CFrame = getRoot().CFrame

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = {plr.Character}
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	local raycastResult = workspace:Raycast(spawnpart.Position, Vector3.new(0,-1*8,0), raycastParams)
 
	if raycastResult then
		if raycastResult.Instance:IsA("Part") then
		local weld = Instance.new("WeldConstraint",spawnpart)
		spawnpart.Anchored = false
		weld.Part0 = spawnpart
		weld.Part1 = raycastResult.Instance
		notify("Rayhit",3)
		end
	end

	cor = plr.CharacterAdded:Connect(function()
		task.wait(.5)
		getRoot().CFrame = spawnpart.CFrame
	end)

end)

_G.addCMD("deletespawn","unspawn",nil,function()
	if cor ~= nil then
		notify("Deleted spawn",2)
		cor:Disconnect()
		spawnpart:Destroy()
	end
end)

_G.addCMD("view",nil,nil,function(player)
    target = findplr(player)
    if target then
        plr.Character.Humanoid.Jump = true
        workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
    end
end)

_G.addCMD("unview",nil,nil,function(player)
	workspace.CurrentCamera.CameraSubject = getRoot().Parent.Humanoid
end)

_G.addCMD("fullbright","fb",nil,function()
	game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
    game.Lighting.FogEnd = 100000
    game.Lighting.GlobalShadows = false
    game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

local chams = false

_G.addCMD("chams",nil,function(teamcheck)

	function addOut(player,colour)
		local cham = Instance.new("Highlight",chamFolder)
		cham.Name = player.Name
		cham.Adornee = player.Character
		cham.FillTransparency = 1
		cham.OutlineColor = colour
		cham.OutlineTransparency = 0
		player.CharacterAdded:Connect(function(char)
			task.wait(.5)
			if chams then
				cham.Adornee = char
			end
		end)
	end

	chams = true
	for i,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr then
			if teamcheck == "true" then
				if v.Team ~= plr.Team then
					addOut(v,Color3.fromRGB(255,255,255))
				end
			else
				addOut(v,Color3.fromRGB(255,255,255))
			end
		end
	end
	game.Players.PlayerAdded:Connect(function(player)
		task.wait(1)
		addOut(player,Color3.fromRGB(255,255,255))
	end)
end)

_G.addCMD("unchams","uncham",function()
	chams = false
	chamFolder:ClearAllChildren()
end)

LTracer = Drawing.new("Line")
LTracer.Visible = false
LTracer.Thickness = 1
LTracer.Transparency = 1

_G.addCMD("locate","find",function(player)
	if player ~= nil then
	target = findplr(player)
	if target then
		notify("Locating "..target.Name)
		if locCon ~= nil then
			locCon:Disconnect()
		end
		locateTarget = target
		v = locateTarget
		

		function lineesp()

			

			locCon = game:GetService("RunService").RenderStepped:Connect(function()
				camera = game:GetService("Workspace").CurrentCamera
				if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= plr and v.Character.Humanoid.Health > 0 then
					
					--local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position);
					local ScreenPosition, Vis = camera.WorldToViewportPoint(camera,v.Character.HumanoidRootPart.Position)
					local OPos = camera.CFrame:pointToObjectSpace(v.Character.HumanoidRootPart.Position)
					
					if ScreenPosition.Z < 0 then
						local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
						OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1))))
					end

					local Position = camera.WorldToViewportPoint(camera,camera.CFrame:pointToWorldSpace(OPos))
					LTracer.Color = colour
					
					LTracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 25)
					LTracer.To = Vector2.new(Position.X, Position.Y)
					LTracer.Visible = true
				else
					LTracer.Visible = false
				end
			end)
		end
		coroutine.wrap(lineesp)()
	end
else
	if locCon ~= nil then
		LTracer.Visible = false
		locCon:Disconnect()
	end
end
end)

_G.addCMD("notiftest",nil,function()
	notify("This is going to be the longest string in the entire script because i need to test the limits of the notify function ok?",10)
end)

_G.addCMD("selfdestruct","destroy",function()
	local n = 10
	for i = 1,10 do
		task.wait(1)
		notify("Self Destructing in "..tostring(n))
		n = n -1
	end
	task.wait(1)
	for i,v in pairs(workspace:GetDescendants()) do
		pcall(function()
			v:Destroy()
		end)
	end
	notify("L BAZO")
end)

_G.addCMD("mastermode","expertmode",function()
	local fakeHealth = Instance.new("NumberValue",plr)
	fakeHealth.Value = plr.Character.Humanoid.MaxHealth

	function init()
		plr.Character.Humanoid.HealthChanged:Connect(function()
			fakeHealth.Value = plr.Character.Humanoid.Health-25
			if fakeHealth.Value <= 0 then
				plr.Character.Humanoid.Health = 0
			end
		end)
		plr.Character.Humanoid.Died:Connect(function()
			fakeHealth = plr.Character.Humanoid.MaxHealth
		end)
	end
	init()
	plr.CharacterAdded:Connect(function(char)
		task.wait(1)
		init()
	end)
end)

_G.addCMD("ultra",nil,function()
	if not ultra then
		ultra = true
		notify("Enabled Ultra mode")
	else
		ultra = false
		notify("Disabled Ultra mode")
	end
end)

_G.addCMD("damage",nil,function(amount)
	plr.Character.Humanoid.Health = plr.Character.Humanoid.Health - tonumber(amount)
end)

_G.addCMD("serverpopulation","pop",function()
	notify(#game.Players:GetPlayers().." players")
end)

_G.addCMD("headsit","climb",function(arg)
	local target = findplr(arg)
	if target then
		headsitRun = runservice.RenderStepped:Connect(function()
			pcall(function()
				plr.Character.Humanoid.Sit = true
				plr.Character.HumanoidRootPart.CFrame = target.Character.Head.CFrame
			end)
		end)
	end
end)

_G.addCMD("unheadsit","unclimb",function(arg)
	if headsitRun then
		headsitRun:Disconnect()
	end
end)

_G.addCMD("toolloop","tool",function(arg)
	toolloop = runservice.RenderStepped:Connect(function()
		pcall(function()
			plr.Character:FindFirstChildOfClass("Tool"):Activate()
		end)
	end)
end)

_G.addCMD("untoolloop","unloop",function(arg)
	if toolloop then
		toolloop:Disconnect()
	end
end)

_G.addCMD("showinvisible","sight",function(arg)
	local affected = {}
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Part") then
			if v.Transparency == 1 then
				table.insert(affected,v)
				v.Transparency = 0
			end
		end
	end
	task.wait(5)
	for i,v in pairs(affected) do
		v.Transparency = 1
	end
end)

function checkIf(name)
	if isfile("PrismaModules/"..name..".pr") then
		return true
	else
		return false
	end
end

_G.addCMD("loadmodule",nil,function(arg)
	if checkIf(arg) then
		spawn(function()
			notify("Successfully Loaded "..arg)
			table.insert(loadedModules,"PrismaModules/"..arg..".pr")
			loadstring(readfile("PrismaModules/"..arg..".pr"))()
			
		end)
	end
end) 

_G.addCMD("unloadmodule",nil,function(arg)
	if checkIf(arg) then
		for i,v in pairs(loadedModules) do
			if v == "PrismaModules/"..arg..".pr" then
				table.remove(loadedModules,i)
				notify("Unloaded Module")
			end
		end
	end
end) 

_G.addCMD("loopjp","llp",function(speed)
	local suc = pcall(function()
	local setspeed = tonumber(speed)
	if setspeed == nil then
		local error = plr.Character.Position
	end
	if JumpLoop ~= nil then
		JumpLoop:Disconnect()
	end
	JumpLoop = plr.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		plr.Character.Humanoid.JumpPower = setspeed
	end)
	plr.Character.Humanoid.JumpPower = setspeed
end)
	if suc then
		task.wait(.3)
		else
		task.wait(.3)
	end
end)


_G.addCMD("unloopjp","unljp",function()
	pcall(function()
		JumpLoop:Disconnect()
		JumpLoop = nil
		task.wait(.3)
	end)
end)

local waypoints = {}

_G.addCMD("waypoint","wp",function(name)
	local found = false
    for i,v in pairs(waypoints) do
		if v.Name == name then
			found = true
		end
	end
	if not found then
		table.insert(waypoints,{
			Name = name,
			CF = getRoot().CFrame
		})
		notify("Set waypoint "..name.." at "..tostring(math.round(getRoot().Position.X)).." "..
		tostring(math.round(getRoot().Position.Y)).." "..
		tostring(math.round(getRoot().Position.Z)))
	else
		local act = nil
		for i,v in pairs(waypoints) do
			if v.Name == name then
				act = v
			end
		end
		getRoot().CFrame = act.CF
		notify("Teleported to "..act.Name)
	end
end)

_G.addCMD("formatnotif","fnotif",function(arg)
	notify(arg,4,true)
end,true)

_G.addCMD("listloadedmodules","lmodules",function()
	for i,v in pairs(loadedModules) do
		chatNotif(v)
	end
end)

_G.addCMD("refresh","re",function()
	local old = getRoot().CFrame
	plr.Character:Destroy()
	reloadev = plr.CharacterAdded:Connect(function()
		task.wait(.5)
		getRoot().CFrame = old
		reloadev:Disconnect()
	end)
end)

_G.addCMD("help",nil,function()
	local amountOfCmds = #cmds
	for i,v in pairs(cmds) do
		print(v.Command)
	end
	chatNotif("Press F9 to see commands")
end)

_G.addCMD("disableservertween","dst",function()
	stbp = true
	notify("Changed Click Tp Mode")
end)
_G.addCMD("enableservertween","est",function()
	stbp = false
	notify("Clicktp Mode Set To Normal")
end)


_G.addCMD("loopsit","lsit",function()
	sitloop = runservice.RenderStepped:Connect(function()
		pcall(function()
			if plr.Character.Humanoid.Sit ~= true then
				plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
			end

			plr.Character.Humanoid.Sit = true
		end)
	end)
end)
_G.addCMD("unloopsit","unlsit",function()
	sitloop:Disconnect()
end)

_G.addCMD("spin",nil,function(speed)
	local spinSpeed = tonumber(speed) or 20
	for i,v in pairs(getRoot():GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = getRoot()
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
end)
_G.addCMD("unspin",nil,function()
	for i,v in pairs(getRoot():GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
end)

_G.addCMD("unloadbase","unbase",function()
	notify("Unloaded ".._G.currentBase.Name)
	firstTime = true
	_G.currentBase.Unloaded()
	_G.currentBase = nil
	_G.currentBase.Location = nil
	_G.currentBase.Enabled = false
	-- Location = nil,
	-- 	Enabled = false,
end)
_G.addCMD("loadbase","base",function(name)
	if _G.currentBase ~= nil then
		executeCommand("unloadbase")
	end
	for i,v in pairs(registedBases) do
		if v.Name == name then
			notify("Loaded "..name)
			_G.currentBase = v
		end
	end
end)

_G.addCMD("playernoclip","pnoclip",function()
	task.spawn(function()
		local plrs = game:GetService("Players")
		connections = {}

		for _,anti in pairs(plrs:GetPlayers()) do
			if anti ~= plrs.LocalPlayer then
				connections[anti.Name] = {}
				if workspace:FindFirstChild(anti.Name) then
					connections[anti.Name]["connection01"] = game:GetService("RunService").Heartbeat:Connect(function()
						for _,non in pairs(anti.Character:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
					connections[anti.Name]["connection02"] = game:GetService("RunService").Stepped:Connect(function()
						for _,non in pairs(anti.Character:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
					connections[anti.Name]["connection03"] = game:GetService("RunService").RenderStepped:Connect(function()
						for _,non in pairs(anti.Character:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
				end
				
				anti.CharacterAdded:Connect(function(br)
					connections[anti.Name]["connection01"] = game:GetService("RunService").Heartbeat:Connect(function()
						for _,non in pairs(br:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
					connections[anti.Name]["connection02"] = game:GetService("RunService").Stepped:Connect(function()
						for _,non in pairs(br:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
					connections[anti.Name]["connection03"] = game:GetService("RunService").RenderStepped:Connect(function()
						for _,non in pairs(br:GetDescendants()) do
							if non:IsA("BasePart") then
								non.CanCollide = false
							end
						end
					end)
				end)
				
				anti.CharacterRemoving:Connect(function()
					for _,dis in pairs(connections[anti.Name]) do
						dis:Disconnect()
					end
				end)
			end
		end

		plrConnection = plrs.PlayerAdded:Connect(function(anti)
			connections[anti.Name] = {}
			if workspace:FindFirstChild(anti.Name) then
				connections[anti.Name]["connection01"] = game:GetService("RunService").Heartbeat:Connect(function()
					for _,non in pairs(anti.Character:GetDescendants()) do
						if non:IsA("BasePart") then
							non.CanCollide = false
						end
					end
				end)
				-- connections[anti.Name]["connection02"] = game:GetService("RunService").Stepped:Connect(function()
				-- 	for _,non in pairs(anti.Character:GetDescendants()) do
				-- 		if non:IsA("BasePart") then
				-- 			non.CanCollide = false
				-- 		end
				-- 	end
				-- end)
				-- connections[anti.Name]["connection03"] = game:GetService("RunService").RenderStepped:Connect(function()
				-- 	for _,non in pairs(anti.Character:GetDescendants()) do
				-- 		if non:IsA("BasePart") then
				-- 			non.CanCollide = false
				-- 		end
				-- 	end
				-- end)
			end
			
			anti.CharacterAdded:Connect(function(br)
				connections[anti.Name]["connection01"] = game:GetService("RunService").Heartbeat:Connect(function()
					for _,non in pairs(br:GetDescendants()) do
						if non:IsA("BasePart") then
							non.CanCollide = false
						end
					end
				end)
				-- connections[anti.Name]["connection02"] = game:GetService("RunService").Stepped:Connect(function()
				-- 	for _,non in pairs(br:GetDescendants()) do
				-- 		if non:IsA("BasePart") then
				-- 			non.CanCollide = false
				-- 		end
				-- 	end
				-- end)
				-- connections[anti.Name]["connection03"] = game:GetService("RunService").RenderStepped:Connect(function()
				-- 	for _,non in pairs(br:GetDescendants()) do
				-- 		if non:IsA("BasePart") then
				-- 			non.CanCollide = false
				-- 		end
				-- 	end
				-- end)
			end)
			
			anti.CharacterRemoving:Connect(function()
				for _,dis in pairs(connections[anti.Name]) do
					dis:Disconnect()
				end
			end)
		end)

		plrRemoving = plrs.PlayerRemoving:Connect(function(anti)
			if table.find(connections, anti.Name) then
				table.remove(connections, table.find(connections, anti.Name))
			end
		end)

		-- for _,h in pairs(workspace:GetChildren()) do
		-- 	if h:IsA("Accessory") then
		-- 		repeat
		-- 			game:GetService("RunService").Stepped:Wait()
		-- 			h:FindFirstChild("Handle").CanCollide = false
		-- 		until (h:FindFirstChild("Handle") == nil)
		-- 	end
		-- end

		childaddedNo = workspace.ChildAdded:Connect(function(h)
			if h:IsA("Accessory") then
				repeat
					game:GetService("RunService").Stepped:Wait()
					h:FindFirstChild("Handle").CanCollide = false
				until (h:FindFirstChild("Handle") == nil)
			end
		end)
	end)
end)

_G.addCMD("playerclip","pclip",function(name)
	plrConnection:Disconnect()
	plrRemoving:Disconnect()
	childaddedNo:Disconnect()
	for i,v in pairs(connections) do
		v["connection01"]:Disconnect()
		-- v["connection02"]:Disconnect()
		-- v["connection03"]:Disconnect()
	end
end)



local notifColour = Color3.fromRGB(255, 255, 255)

repeat
	task.wait()
    local Success = pcall(function()
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "> Loaded Prisma";
            Font = Enum.Font.Cartoon;
            Color = notifColour;
            FontSize = 130;
        })
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "> Version "..version;
            Font = Enum.Font.Cartoon;
            Color = notifColour;
            FontSize = 130;
        })
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "> "..versionText;
            Font = Enum.Font.Cartoon;
            Color = notifColour;
            FontSize = 130;
        })
    end)
until Success

if game.PlaceId == 292439477 then
	executeCommand("bind","all")
end
