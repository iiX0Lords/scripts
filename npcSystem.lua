
local runservice = game:GetService("RunService")
local tweenservice = game:GetService("TweenService")


local possibleFirstNames = {"Stella","Zackary","Clara","Lara","Hayden","Steve","Zac","Stee","Steak","Orti","Manein","Cooper","Lilly","Conner","Emma","Stevie","Isabella","Isabela","Issy","George","Georgy","Stein","Tori","Tory","Tracy","Smith","Cindy","Ben","Jessica"}
local possibleLastNames = {"Forbes","Jenkins","Steve","Lara","Koch","Stella","Wadel","Die","Plop","Cave","Deep","Steep","Bean","Kein","Klein","Wats","Orphone","Steak","Jessica","Klemming","Clemmings","Shart","Shit","Dover"}

local npcBrains = {}

local npcModule = {}

local npcs = Instance.new("Folder",workspace)
npcs.Name = "Npc Storage"

local hasbrain = nil

function CreateScript(parent,code)
	function sandbox(var,func)
		local env = getfenv(func)
		local newenv = setmetatable({},{
			__index = function(self,k)
				if k=="script" then
					return var
				else
					return env[k]
				end
			end,
		})
		setfenv(func,newenv)
		return func
	end
	cors = {}
	LocalScript0 = Instance.new("LocalScript")
	LocalScript0.Parent = parent
	table.insert(cors,sandbox(LocalScript0,code))

	for i,v in pairs(cors) do
		spawn(function()
			pcall(v)
		end)
	end
end

function Animate(char)
	CreateScript(char,function()
		Delay(0, function() --Vanilla Animate, Multiple Additions
			function waitForChild(parent, childName)
				local child = parent:findFirstChild(childName)
				if child then return child end
				while true do
					child = parent.ChildAdded:wait()
					if child.Name==childName then return child end
				end
			end
			local Figure = script.Parent
			local Clone = Figure:Clone()
			local Torso = waitForChild(Figure, "Torso")
			local Joints = Torso:GetChildren()
			for All = 1, #Joints do
				if Joints.className == "Motor" or Joints.className == "Motor6D" then
					Joints[All]:Remove()
				end
			end
			local RightShoulder = Instance.new("Motor")
			local LeftShoulder = Instance.new("Motor")
			local RightHip = Instance.new("Motor")
			local LeftHip = Instance.new("Motor")
			local Neck = Instance.new("Motor")
			local Humanoid = waitForChild(Figure, "Humanoid")
			ZStat = 1
			ZStat2 = 0
			local pose = "Standing"
			RightShoulder.Part0 = Torso
			RightShoulder.Part1 = Figure["Right Arm"]
			RightShoulder.MaxVelocity = 0.15
			RightShoulder.Name = "Right Shoulder"
			RightShoulder.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			RightShoulder.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			RightShoulder.Parent = Torso
			LeftShoulder.Part0 = Torso
			LeftShoulder.Part1 = Figure["Left Arm"]
			LeftShoulder.MaxVelocity = 0.15
			LeftShoulder.Name = "Left Shoulder"
			LeftShoulder.C0 = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			LeftShoulder.C1 = CFrame.new(0.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			LeftShoulder.Parent = Torso
			RightHip.Part0 = Torso
			RightHip.Part1 = Figure["Right Leg"]
			RightHip.MaxVelocity = 0.1
			RightHip.Name = "Right Hip"
			RightHip.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			RightHip.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			RightHip.Parent = Torso
			LeftHip.Part0 = Torso
			LeftHip.Part1 = Figure["Left Leg"]
			LeftHip.MaxVelocity = 0.1
			LeftHip.Name = "Left Hip"
			LeftHip.C0 = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			LeftHip.C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			LeftHip.Parent = Torso
			Neck.Part0 = Torso
			Neck.Part1 = Figure["Head"]
			Neck.MaxVelocity = 0.1
			Neck.Name = "Neck"
			Neck.C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
			Neck.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
			Neck.Parent = Torso
			local toolAnim = "None"
			local toolAnimTime = 0
			SpawnModel = Instance.new("Model")
			function onRunning(speed)
				if speed>0 then
					pose = "Running"
				else
					pose = "Standing"
				end
			end
			function onJumping()
				pose = "Jumping"
			end
			function onClimbing()
				pose = "Climbing"
			end
			function onGettingUp()
				pose = "GettingUp"
			end
			function onFreeFall()
				pose = "FreeFall"
			end
			function onFallingDown()
				pose = "FallingDown"
			end
			function onSeated()
				pose = "Seated"
			end
			function onPlatformStanding()
				pose = "PlatformStanding"
			end
			function moveJump()
				RightShoulder.MaxVelocity = 0.5
				LeftShoulder.MaxVelocity = 0.5
				RightShoulder.DesiredAngle = (3.14/ZStat)
				LeftShoulder.DesiredAngle = (-3.14/ZStat)
				RightHip.DesiredAngle = (0)
				LeftHip.DesiredAngle = (0)
			end
			function moveFreeFall()
				RightShoulder.MaxVelocity = 0.5
				LeftShoulder.MaxVelocity = 0.5
				RightShoulder.DesiredAngle = (3.14/ZStat)
				LeftShoulder.DesiredAngle = (-3.14/ZStat)
				RightHip.DesiredAngle = (0)
				LeftHip.DesiredAngle = (0)
			end
			function moveSit()
				RightShoulder.MaxVelocity = 0.15
				LeftShoulder.MaxVelocity = 0.15
				RightShoulder.DesiredAngle = (3.14 /2)
				LeftShoulder.DesiredAngle = (-3.14 /2)
				RightHip.DesiredAngle = (3.14 /2)
				LeftHip.DesiredAngle = (-3.14 /2)
			end
			function getTool()	
				for _, kid in ipairs(Figure:GetChildren()) do
					if kid.className == "Tool" then return kid end
				end
				return nil
			end
			function getToolAnim(tool)
				for _, c in ipairs(tool:GetChildren()) do
					if c.Name == "toolanim" and c.className == "StringValue" then
						return c
					end
				end
				return nil
			end
			function animateTool()
				if (toolAnim == "None") then
					RightShoulder.DesiredAngle = (1.57)
					return
				end
				if (toolAnim == "Slash") then
					RightShoulder.MaxVelocity = 0.5
					RightShoulder.DesiredAngle = (0)
					return
				end
				if (toolAnim == "Lunge") then
					RightShoulder.MaxVelocity = 0.5
					LeftShoulder.MaxVelocity = 0.5
					RightHip.MaxVelocity = 0.5
					LeftHip.MaxVelocity = 0.5
					RightShoulder.DesiredAngle = (1.57)
					LeftShoulder.DesiredAngle = (1.0)
					RightHip.DesiredAngle = (1.57)
					LeftHip.DesiredAngle = (1.0)
					return
				end
			end
			function move(time)
				local amplitude
				local frequency
				if (pose == "Jumping") then
					moveJump()
					return
				end
				if (pose == "FreeFall") then
					moveFreeFall()
					return
				end	 
				if (pose == "Seated") then
					moveSit()
					return
				end
				local climbFudge = 0
				if (pose == "Running") then
					RightShoulder.MaxVelocity = 0.15
					LeftShoulder.MaxVelocity = 0.15
					amplitude = 1
					frequency = 9
				elseif (pose == "Climbing") then
					RightShoulder.MaxVelocity = 0.5 
					LeftShoulder.MaxVelocity = 0.5
					amplitude = 1
					frequency = 9
					climbFudge = 3.14
				else
					amplitude = 0.1
					frequency = 1
				end
				desiredAngle = amplitude * math.sin(time*frequency)
				RightShoulder.DesiredAngle = (desiredAngle + climbFudge) + ZStat2
				LeftShoulder.DesiredAngle = (desiredAngle - climbFudge) -ZStat2
				RightHip.DesiredAngle = (-desiredAngle)
				LeftHip.DesiredAngle = (-desiredAngle)
				local tool = getTool()
				if tool then
					animStringValueObject = getToolAnim(tool)
					if animStringValueObject then
						toolAnim = animStringValueObject.Value
						animStringValueObject.Parent = nil
						toolAnimTime = time + .3
					end
					if time > toolAnimTime then
						toolAnimTime = 0
						toolAnim = "None"
					end
					animateTool()
				else
					toolAnim = "None"
					toolAnimTime = 0
				end
			end
			Humanoid.Running:connect(onRunning)
			Humanoid.Jumping:connect(onJumping)
			Humanoid.Climbing:connect(onClimbing)
			Humanoid.GettingUp:connect(onGettingUp)
			Humanoid.FreeFalling:connect(onFreeFall)
			Humanoid.FallingDown:connect(onFallingDown)
			Humanoid.Seated:connect(onSeated)
			Humanoid.PlatformStanding:connect(onPlatformStanding)
			OriginalTime = 0.1
			Time = OriginalTime
			while Figure.Parent~=nil do
				Time = Time + 0.1
				wait(OriginalTime)
				move(Time)
			end
		end)
	end)
end

function npcModule:pathFindTo(npc,destination,visualize)
	local pathfinding = game:GetService("PathfindingService")

	local rootPart = npc.HumanoidRootPart
	local hum = npc.Humanoid

	local function GetPath(destinations) 

		local path = pathfinding:CreatePath()   

		path:ComputeAsync(rootPart.Position,destinations)

		return path
	end

	local function WalkToWaypoints(tableWaypoints)
		for i,v in pairs(tableWaypoints) do

			-- local vis = Instance.new("Part",workspace)
			-- vis.Anchored = true
			-- vis.Size = Vector3.new(0.1,0.1,0.1)
			-- vis.Position = v.Position
			-- vis.CanCollide = false

			hum:MoveTo(v.Position)
			if v.Action == Enum.PathWaypointAction.Jump then
				hum.Jump = true
			end
			hum.MoveToFinished:Wait()
		end
	end

	local tab = {}

	if visualize then
		for i,v in pairs(GetPath(destination):GetWaypoints()) do
			local vis = Instance.new("Part",workspace)
			vis.Anchored = true
			vis.Size = Vector3.new(0.5,0.5,0.5)
			vis.Color = Color3.fromRGB(255,0,0)
			vis.Position = v.Position
			vis.Shape = "Ball"
			vis.Material = Enum.Material.Neon
			vis.CanCollide = false
			table.insert(tab,vis)
		end
	end

	for i,v in pairs(GetPath(destination):GetWaypoints()) do


		hum:MoveTo(v.Position)
		if v.Action == Enum.PathWaypointAction.Jump then
			hum.Jump = true
		end
		hum.MoveToFinished:Wait()
		if visualize then
			tab[i]:Destroy()
		end
	end
	for i,v in pairs(tab) do
		pcall(function()
			v:Destroy()
		end)
	end
end

function npcModule.createBrain(callback)
	hasbrain = callback
end

function playSound(id,volume,loop,parent)
	local sound = Instance.new("Sound",parent)
	sound.SoundId = id
	sound.PlayOnRemove = true
	sound.Volume = volume
	sound.Looped = loop
	sound:Destroy()
end

function npcModule:makeNpc(pos,colour,customName)
	local npc = game.ReplicatedStorage.Nub:Clone()
	npc.Parent = npcs
	npc["Body Colors"].TorsoColor3 = colour or Color3.fromRGB(math.random(1,255),math.random(1,255),math.random(1,255))
	npc:PivotTo(pos)
	Animate(npc)
	local first = possibleFirstNames[math.random(1,#possibleFirstNames)]
	local last = possibleLastNames[math.random(1,#possibleLastNames)]
	if customName == nil then
		npc.Name = first.." "..last
	else
		npc.Name = customName
	end
	if hasbrain ~= nil then
		table.insert(npcBrains,{
			Body = npc,
			State = "idle",
		})
		local selfBrain = nil
		for i,v in pairs(npcBrains) do
			if v.Body == npc then
				selfBrain = v
			end
		end
		spawn(function()
			hasbrain(npc,selfBrain)
		end)
	end
	return npc
end


return npcModule
