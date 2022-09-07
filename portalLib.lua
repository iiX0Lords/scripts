-----------------------
------- Modules -------
-----------------------

--- Character Clone
local CharacterClone = {}
CharacterClone.__index = CharacterClone

--

local loops = {}

function CharacterClone.new(character)
	local self = setmetatable({}, CharacterClone)

	self.Character = character
	self.Clone = character:Clone()

	self.Clone:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	self.Lookup = self:GetLookup()

	return self
end

--

function CharacterClone:GetLookup()
	local lookup = {}
	local character = self.Character
	for _, item in next, self.Clone:GetChildren() do
		if (item:IsA("BasePart")) then
			item.Anchored = true
			local match = character:FindFirstChild(item.Name)
			lookup[item] = match
		elseif (item:IsA("Accessory")) then
			local match = character:FindFirstChild(item.Name).Handle
			item = item.Handle
			item.Anchored = true
			lookup[item] = match
		elseif (item:IsA("LuaSourceContainer")) then
			item:Destroy()
		end
	end
	return lookup
end

function CharacterClone:Update()
	for fake, real in next, self.Lookup do
		if fake:IsA("Part") then
			pcall(function()
				fake.CFrame = real.CFrame
			end)
		end
	end
end

--- Portal
local UP = Vector3.new(0, 1, 0)
local FOV120 = math.rad(120)
local PI2 = math.pi/2

local VPF = Instance.new("ViewportFrame")
VPF.Size = UDim2.new(1, 0, 1, 0)
VPF.Position = UDim2.new(0.5, 0, 0.5, 0)
VPF.AnchorPoint = Vector2.new(0.5, 0.5)
VPF.BackgroundTransparency = 1

--

local function getCorners(part)
	local corners = {}
	local cf, size2 = part.CFrame, part.Size/2
	for x = -1, 1, 2 do
		for y = -1, 1, 2 do
			for z = -1, 1, 2 do
				table.insert(corners, cf * (size2 * Vector3.new(x, y, z)))
			end
		end
	end
	return corners
end

--

Portal = {}
Portal.__index = Portal

--

function Portal.new(surfaceGUI)
	local self = setmetatable({}, Portal)

	self.SurfaceGUI = surfaceGUI
	self.Camera = Instance.new("Camera", surfaceGUI)
	self.ViewportFrame = VPF:Clone()
	self.ViewportFrame.CurrentCamera = self.Camera
	self.ViewportFrame.Parent = surfaceGUI
	local world = Instance.new("WorldModel",self.ViewportFrame)

	return self
end

function Portal.fromPart(part, enum, parent)
	local surfaceGUI = Instance.new("SurfaceGui")
	surfaceGUI.Face = enum
	surfaceGUI.Adornee = part
	surfaceGUI.ClipsDescendants = true
	surfaceGUI.Parent = parent
	surfaceGUI.ResetOnSpawn = false

	return Portal.new(surfaceGUI)
end

--

function Portal:AddToWorld(item)
	item.Parent = self.ViewportFrame
end

function Portal:ClipModel(model)
	local cf, size = self:GetSurfaceInfo()
	local descendants = model:GetDescendants()
	for i = 1, #descendants do
		local part = descendants[i]
		if (part:IsA("BasePart")) then
			local corners = getCorners(part)
			table.insert(corners, 1, part.Position)

			local pass = false
			for j = 1, #corners do
				if (cf:PointToObjectSpace(corners[j]).z <= 0) then
					pass = true
					break
				end
			end

			if (not pass) then
				part:Destroy()
			end
		end
	end
	return model
end

function Portal:GetPart()
	return self.SurfaceGUI.Adornee
end

function Portal:GetSurfaceInfo()
	local part = self.SurfaceGUI.Adornee
	local partCF, partSize = part.CFrame, part.Size

	local back = -Vector3.FromNormalId(self.SurfaceGUI.Face)
	local axis = (math.abs(back.y) == 1) and Vector3.new(back.y, 0, 0) or UP
	local right = CFrame.fromAxisAngle(axis, PI2) * back
	local top = back:Cross(right).Unit

	local cf = partCF * CFrame.fromMatrix(-back*partSize/2, right, top, back)
	local size = Vector3.new((partSize * right).Magnitude, (partSize * top).Magnitude, (partSize * back).Magnitude)

	return cf, size
end

function Portal:RenderFrame(camCF, surfaceCF, surfaceSize)
	local vpf = self.ViewportFrame
	local surfaceGUI = self.SurfaceGUI
	local camera = game.Workspace.CurrentCamera
	local nCamera = self.Camera

	local camCF = camCF or camera.CFrame
	if not (surfaceCF and surfaceSize) then 
		surfaceCF, surfaceSize = self:GetSurfaceInfo()
	end

	local rPoint = surfaceCF:PointToObjectSpace(camCF.p)
	local sX, sY = rPoint.x / surfaceSize.x, rPoint.y / surfaceSize.y

	local scale = 1 + math.max(
		surfaceSize.y / surfaceSize.x, 
		surfaceSize.x / surfaceSize.y, 
		math.max(math.abs(sX), math.abs(sY))*2
	)

	local height = surfaceSize.y/2
	local rDist = (camCF.p - surfaceCF.p):Dot(surfaceCF.LookVector)
	local newFov = 2*math.atan2(height, rDist)
	local clampedFov = math.clamp(math.deg(newFov), 1, 120)
	local pDist = height / math.tan(math.rad(clampedFov)/2)
	local adjust = rDist / pDist

	local factor = (newFov > FOV120 and adjust or 1) / scale
	local scaleCF = CFrame.new(0, 0, 0, factor, 0, 0, 0, factor, 0, 0, 0, 1)

	vpf.Position = UDim2.new(vpf.AnchorPoint.x - sX, 0, vpf.AnchorPoint.y - sY, 0)
	vpf.Size = UDim2.new(scale, 0, scale, 0)
	vpf.BackgroundColor3 = surfaceGUI.Adornee.Color

	local viewportSizeY = camera.ViewportSize.y
	surfaceGUI.CanvasSize = Vector2.new(viewportSizeY*(surfaceSize.x/surfaceSize.y), viewportSizeY)

	nCamera.FieldOfView = clampedFov
	nCamera.CFrame = CFrame.new(camCF.p) * (surfaceCF - surfaceCF.p) * CFrame.Angles(0, math.pi, 0) * scaleCF
end

--- Dual Worlds
local Y_SPIN = CFrame.Angles(0, math.pi, 0)

local PortalClass = Portal

--

local function planeIntersect(point, vector, origin, normal)
	local rpoint = point - origin;
	local t = -rpoint:Dot(normal)/vector:Dot(normal);
	return point + t * vector, t;
end


local function rayPlane(p, v, o, n)
	local r = p - o
	local t = -r:Dot(n) / v:Dot(n)
	return p + t*v, t
end

-- Class

local DualWorlds = {}
DualWorlds.__index = DualWorlds

function DualWorlds.new(character, partA, partB, surface, parent)
	local self = setmetatable({}, DualWorlds)

	self.Character = character
	self.HRP = character:WaitForChild("HumanoidRootPart")
	self.Humanoid = character:WaitForChild("Humanoid")
	self.Enabled = true

	self.PortalA = PortalClass.fromPart(partA, surface, parent)
	self.PortalB = PortalClass.fromPart(partB, surface, parent)

	self.LastCamCF = game.Workspace.CurrentCamera.CFrame

	game:GetService("RunService"):BindToRenderStep("BeforeInput", Enum.RenderPriority.Input.Value - 1, function(dt)
		if not self.Enabled then return end
		game.Workspace.CurrentCamera.CFrame = self.LastCamCF
	end)

	game:GetService("RunService"):BindToRenderStep("AfterCamera", Enum.RenderPriority.Camera.Value + 1, function(dt)
		if not self.Enabled then return end
		self:OnRenderStep(dt)
	end)

	return self
end

-- Public Methods

function DualWorlds:CheckCameraIntersect(surface, size)
	local camCF = game.Workspace.CurrentCamera.CFrame
	local focusCF = game.Workspace.CurrentCamera.Focus

	local v = camCF.p - focusCF.p
	local p, t = rayPlane(focusCF.p, camCF.p - focusCF.p, surface.p, surface.LookVector)
	if (v:Dot(surface.LookVector) < 0 and t >= 0 and t <= 1) then
		local lp = surface:PointToObjectSpace(p)
		if (math.abs(lp.x) <= size.x/2 and math.abs(lp.y) <= size.y/2) then
			return true
		end
	end

	return false
end

function DualWorlds:CameraIntersectOffset(surfaceA, surfaceB)
	local camCF = game.Workspace.CurrentCamera.CFrame
	local focusCF = game.Workspace.CurrentCamera.Focus

	local offset = surfaceA:Inverse() * camCF
	local newCam = surfaceB * Y_SPIN * offset

	local offset = surfaceA:Inverse() * focusCF
	local newFocus = surfaceB * Y_SPIN * offset

	game.Workspace.CurrentCamera.CFrame = newCam
	game.Workspace.CurrentCamera.Focus = newFocus
end

function DualWorlds:InfrontOf(pos, surface, size)
	local lp = (surface - surface.p + pos):PointToObjectSpace(self.HRP.Position)
	if (lp.z <= 0 and math.abs(lp.x) <= size.x/2 and math.abs(lp.y) <= size.y/2) then
		return true
	end
	return false
end

function DualWorlds:CheckCollision(surface, size, dt)
	local p, t = rayPlane(self.HRP.Position, self.HRP.Velocity*dt, surface.p, surface.LookVector)
	local lp = surface:PointToObjectSpace(p)
	if (t >= 0 and t <= 1 and math.abs(lp.x) <= size.x/2 and math.abs(lp.y) <= size.y/2) then
		return true
	end
	return false
end

function DualWorlds:MoveToPortal(surfaceA, surfaceB)
	local hrpCF = self.HRP.CFrame
	local camCF = game.Workspace.CurrentCamera.CFrame
	local velocity = self.HRP.Velocity
	local moveDir = self.Humanoid.MoveDirection

	local hrpOffset = surfaceA:Inverse() * hrpCF
	local c = {hrpOffset:GetComponents()}
	local alteredOffset = CFrame.new(-c[1], select(2, unpack(c)))
	local newHrp = surfaceB * alteredOffset * Y_SPIN

	local lVel = hrpCF:VectorToObjectSpace(velocity)
	local newVel = newHrp:VectorToWorldSpace(lVel)

	local lMove = hrpCF:VectorToObjectSpace(moveDir)
	local newMove = newHrp:VectorToWorldSpace(lMove)

	local camOffset = surfaceA:Inverse() * camCF
	local newCam = surfaceB * Y_SPIN * camOffset

	self.HRP.CFrame = newHrp
	self.HRP.Velocity = newVel
	self.Humanoid:Move(newMove, false)
	return newCam
end

function DualWorlds:OnRenderStep(dt)
	local portalA, portalB = self.PortalA, self.PortalB
	local surfaceA, sizeA = portalA:GetSurfaceInfo()
	local surfaceB, sizeB = portalB:GetSurfaceInfo()

	-- collision check

	self.LastCamCF = game.Workspace.CurrentCamera.CFrame

	if (self:CheckCollision(surfaceA, sizeA, dt)) then
		self.LastCamCF = self:MoveToPortal(surfaceA, surfaceB)
	elseif (self:CheckCollision(surfaceB, sizeB, dt)) then
		self.LastCamCF = self:MoveToPortal(surfaceB, surfaceA)
	end

	-- camera adjustment

	if (self:CheckCameraIntersect(surfaceA, sizeA)) then
		self:CameraIntersectOffset(surfaceA, surfaceB)
	elseif (self:CheckCameraIntersect(surfaceB, sizeB)) then
		self:CameraIntersectOffset(surfaceB, surfaceA)
	end

	-- render portal

	local camCF = game.Workspace.CurrentCamera.CFrame

	local offset = surfaceA:Inverse() * camCF
	local newCamCF = surfaceB * Y_SPIN * offset
	portalA:RenderFrame(newCamCF, surfaceB * Y_SPIN, sizeB)

	local offset = surfaceB:Inverse() * camCF
	local newCamCF = surfaceA * Y_SPIN * offset
	portalB:RenderFrame(newCamCF, surfaceA * Y_SPIN, sizeA)
end

_G.PortalLib = {}

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')

local portalFold = Instance.new("Folder",workspace)
portalFold.Name = "Portals"
surfaces = Instance.new("Folder",game.CoreGui)

function _G.PortalLib.finalize(doorA,doorB)
	local world = Instance.new("Folder",game.Lighting)

	
	for i,v in pairs(workspace:GetDescendants()) do
		pcall(function()
			if not v.Parent:FindFirstChild("Humanoid") then
			if not v.Parent.Parent:FindFirstChild("Humanoid") then
				if not v:IsDescendantOf(portalFold) then
					if v.ClassName == "Part" then
						local clone = v:Clone()
						clone.Parent = world
					end
				end
			end
			end
		end)
	end

	--

	dualWorld = DualWorlds.new(plr.Character, doorA, doorB, Enum.NormalId.Front, surfaces) --- used to be require

	dualWorld.PortalA:AddToWorld(dualWorld.PortalB:ClipModel(world:Clone()))
	dualWorld.PortalB:AddToWorld(dualWorld.PortalA:ClipModel(world:Clone()))

	--

	local characterClone = CharacterClone --- used to be require
	local clones = {}

	local function onCharacter(character)
		if (character) then
			character.Archivable = true
			character:WaitForChild("Humanoid") -- weird bug

			local cloneA = characterClone.new(character)
			local cloneB = characterClone.new(character)
			dualWorld.PortalA:AddToWorld(cloneA.Clone)
			dualWorld.PortalB:AddToWorld(cloneB.Clone)
			table.insert(clones, cloneA)
			table.insert(clones, cloneB)
		end
	end

	onAdded = game.Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(onCharacter)
	end)

	wait(1)

	for _, player in next, game.Players:GetPlayers() do
		onCharacter(player.Character)
		player.CharacterAdded:Connect(onCharacter)
	end

	renderStep = game:GetService("RunService").RenderStepped:Connect(function(dt)
		for i = 1, #clones do
			clones[i]:Update()
		end
	end)
	
	
end

function _G.PortalLib.makePortal()
	local door = Instance.new("Part",portalFold)
	door.Size = Vector3.new(8,11,1)
	door.Orientation = Vector3.new(0,-90,0)
	door.Material = Enum.Material.Plastic
	door.Anchored = true
	door.CanCollide = false
	door.Reflectance = 1
	door.BrickColor = BrickColor.new("Institutional white")
	return door
end

function _G.PortalLib.reset(portal1,portal2,keep)
	local aPos = portal1.CFrame
	local bPos = portal2.CFrame
	local aSize = portal1.Size
	local bSize = portal2.Size
	renderStep:Disconnect()
	onAdded:Disconnect()
	portal1:Destroy()
	portal2:Destroy()
	dualWorld.Enabled = false
    for i,v in pairs(surfaces:GetChildren()) do
        v:Destroy()
    end
	if keep then
		local a = _G.PortalLib.makePortal()
		a.CFrame = aPos
		a.Size = aSize
		local b = _G.PortalLib.makePortal()
		b.CFrame = bPos
		b.Size = bSize
		_G.PortalLib.finalize(a,b)
	end
end
