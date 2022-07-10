
local otherPlayer = nil

if _G.terraTarget ~= nil then
	otherPlayer = _G.terraTarget
end

local pronounce = true

local canKillOtherSwords = false

local teamCheck = false

local waitTime = 0.1

task.wait(2)

loadstring(game:HttpGet(("https://raw.githubusercontent.com/iiX0Lords/Building/main/GlobalFunction"),true))()

local plr = game.Players.LocalPlayer


local mouse = plr:GetMouse()

local runservice = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local tweenservice = game:GetService("TweenService")

local following = true
local killaura = false

if otherPlayer ~= nil then
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.Name == otherPlayer then
			plr = v
			elseif v.DisplayName == otherPlayer then
			plr = v
		end
	end
end

if otherPlayer == "rand" or otherPlayer == "random" then
	player = game.Players:GetPlayers()
	local RandomPlayer= player[math.random(1, #player)]
	repeat RandomPlayer = player [math.random(1, #player)] until RandomPlayer ~=  game.Players.LocalPlayer
	plr = RandomPlayer
	
end

if otherPlayer ~= nil and pronounce then
	local args = {
		[1] = "/w "..plr.Name.." "..
		"You have been granted the power of the sword say 'sword on' or 'sword off' to toggle it",
		[2] = "All"
	}
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end

local int = Instance.new("BoolValue",plr)
int.Name = "Sword"

function create()

	-- Created with OtS

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
	mas = Instance.new("Model",game:GetService("Lighting"))
	Model0 = Instance.new("Model")
	Part1 = Instance.new("Part")
	WeldConstraint2 = Instance.new("WeldConstraint")
	WeldConstraint3 = Instance.new("WeldConstraint")
	WeldConstraint4 = Instance.new("WeldConstraint")
	Part5 = Instance.new("Part")
	Part6 = Instance.new("Part")
	Motor7 = Instance.new("Motor")
	Part8 = Instance.new("Part")
	Motor9 = Instance.new("Motor")
	WeldConstraint10 = Instance.new("WeldConstraint")
	WeldConstraint11 = Instance.new("WeldConstraint")
	Part12 = Instance.new("Part")
	Part13 = Instance.new("Part")
	Part14 = Instance.new("Part")
	WeldConstraint15 = Instance.new("WeldConstraint")
	WeldConstraint16 = Instance.new("WeldConstraint")
	WeldConstraint17 = Instance.new("WeldConstraint")
	Part18 = Instance.new("Part")
	WeldConstraint19 = Instance.new("WeldConstraint")
	Part20 = Instance.new("Part")
	WeldConstraint21 = Instance.new("WeldConstraint")
	Part22 = Instance.new("Part")
	WeldConstraint23 = Instance.new("WeldConstraint")
	WeldConstraint24 = Instance.new("WeldConstraint")
	Part25 = Instance.new("Part")
	Part26 = Instance.new("Part")
	WeldConstraint27 = Instance.new("WeldConstraint")
	Part28 = Instance.new("Part")
	Motor29 = Instance.new("Motor")
	WeldConstraint30 = Instance.new("WeldConstraint")
	WeldConstraint31 = Instance.new("WeldConstraint")
	Part32 = Instance.new("Part")
	Motor33 = Instance.new("Motor")
	WeldConstraint34 = Instance.new("WeldConstraint")
	Model0.Name = "Swmord"
	Model0.Parent = mas
	Part1.Name = "Handle"
	Part1.Parent = Model0
	Part1.CFrame = CFrame.new(-0.324791074, 14.8295736, 0.010088861, 1.00000262, 2.38185748e-07, -9.49865353e-07, -2.36381311e-07, 1.00000334, -3.67774717e-08, 1.11046393e-06, 2.3015653e-07, 1.00000429)
	Part1.Position = Vector3.new(-0.3247910737991333, 14.829573631286621, 0.010088860988616943)
	Part1.Color = Color3.new(0.239216, 0.0784314, 0.521569)
	Part1.Size = Vector3.new(1.4539988040924072, 0.18965193629264832, 0.1896519809961319)
	Part1.BottomSurface = Enum.SurfaceType.Smooth
	Part1.BrickColor = BrickColor.new("Dark indigo")
	Part1.CanCollide = false
	Part1.Material = Enum.Material.Granite
	Part1.TopSurface = Enum.SurfaceType.Smooth
	Part1.brickColor = BrickColor.new("Dark indigo")
	Part1.Shape = Enum.PartType.Cylinder
	WeldConstraint2.Parent = Part1
	WeldConstraint2.Part0 = Part1
	WeldConstraint2.Part1 = Part28
	WeldConstraint3.Parent = Part1
	WeldConstraint3.Part0 = Part1
	WeldConstraint3.Part1 = Part13
	WeldConstraint4.Parent = Part1
	WeldConstraint4.Part0 = Part1
	WeldConstraint4.Part1 = Part14
	Part5.Parent = Model0
	Part5.CFrame = CFrame.new(0.202099919, 14.8295326, 0.735302567, 5.13051564e-05, 0.00063275767, 0.999999881, 0.000484880671, 0.999999762, -0.000632782525, -0.99999994, 0.000484913035, 5.09983292e-05)
	Part5.Orientation = Vector3.new(0.03999999910593033, 90, 0.029999999329447746)
	Part5.Position = Vector3.new(0.20209991931915283, 14.829532623291016, 0.7353025674819946)
	Part5.Rotation = Vector3.new(85.38999938964844, 89.97000122070312, -85.36000061035156)
	Part5.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part5.Size = Vector3.new(0.05000012367963791, 0.1500004678964615, 0.15000033378601074)
	Part5.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.BrickColor = BrickColor.new("Black")
	Part5.CanCollide = false
	Part5.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.Material = Enum.Material.DiamondPlate
	Part5.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part5.brickColor = BrickColor.new("Black")
	Part6.Parent = Model0
	Part6.CFrame = CFrame.new(-1.52604568, 14.8295584, 0.0100645432, 1.00000262, 2.33520979e-07, -1.5392668e-06, -2.31728023e-07, 1.00000334, -6.01961233e-07, 1.6998622e-06, 7.95346182e-07, 1.00000429)
	Part6.Position = Vector3.new(-1.5260456800460815, 14.829558372497559, 0.010064543224871159)
	Part6.Color = Color3.new(0.101961, 0.164706, 0.203922)
	Part6.Size = Vector3.new(0.3160868287086487, 0.3160865604877472, 0.31608667969703674)
	Part6.BottomSurface = Enum.SurfaceType.Smooth
	Part6.BrickColor = BrickColor.new("Black")
	Part6.CanCollide = false
	Part6.Material = Enum.Material.DiamondPlate
	Part6.TopSurface = Enum.SurfaceType.Smooth
	Part6.brickColor = BrickColor.new("Black")
	Part6.Shape = Enum.PartType.Cylinder
	Motor7.Name = "mot"
	Motor7.Parent = Part6
	Motor7.C0 = CFrame.new(0, 0, 0, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor7.C1 = CFrame.new(-1.2012372, -1.52587891e-05, -2.24113464e-05, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor7.Part0 = Part6
	Motor7.Part1 = Part1
	Motor7.part1 = Part1
	Part8.Parent = Model0
	Part8.CFrame = CFrame.new(-1.27317607, 14.8295641, 0.0100992974, 1.00000262, 2.3585018e-07, -1.19986373e-06, -2.34056657e-07, 1.00000334, -2.89565747e-07, 1.36045867e-06, 4.82950327e-07, 1.00000429)
	Part8.Position = Vector3.new(-1.2731760740280151, 14.829564094543457, 0.010099297389388084)
	Part8.Color = Color3.new(0.239216, 0.0784314, 0.521569)
	Part8.Size = Vector3.new(0.18965217471122742, 0.18965193629264832, 0.1896519809961319)
	Part8.BottomSurface = Enum.SurfaceType.Smooth
	Part8.BrickColor = BrickColor.new("Dark indigo")
	Part8.CanCollide = false
	Part8.Material = Enum.Material.Granite
	Part8.TopSurface = Enum.SurfaceType.Smooth
	Part8.brickColor = BrickColor.new("Dark indigo")
	Part8.Shape = Enum.PartType.Cylinder
	Motor9.Name = "mot"
	Motor9.Parent = Part8
	Motor9.C0 = CFrame.new(0, 0, 0, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor9.C1 = CFrame.new(-0.948359966, -9.53674316e-06, 1.23977661e-05, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor9.Part0 = Part8
	Motor9.Part1 = Part1
	Motor9.part1 = Part1
	WeldConstraint10.Parent = Part8
	WeldConstraint10.Part0 = Part8
	WeldConstraint10.Part1 = Part32
	WeldConstraint11.Parent = Part8
	WeldConstraint11.Part0 = Part8
	WeldConstraint11.Part1 = Part28
	Part12.Parent = Model0
	Part12.CFrame = CFrame.new(0.202174306, 14.8303814, -0.715225816, -5.32125159e-05, -0.000632683747, 0.999999821, -0.000484670134, -0.999999702, -0.000632709474, 0.999999881, -0.00048470372, 5.29058598e-05)
	Part12.Orientation = Vector3.new(0.03999999910593033, 90, -179.97000122070312)
	Part12.Position = Vector3.new(0.20217430591583252, 14.830381393432617, -0.7152258157730103)
	Part12.Rotation = Vector3.new(85.22000122070312, 89.97000122070312, 94.80999755859375)
	Part12.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part12.Size = Vector3.new(0.05000012367963791, 0.1500004678964615, 0.15000033378601074)
	Part12.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.BrickColor = BrickColor.new("Black")
	Part12.CanCollide = false
	Part12.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.Material = Enum.Material.DiamondPlate
	Part12.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part12.brickColor = BrickColor.new("Black")
	Part13.Parent = Model0
	Part13.CFrame = CFrame.new(0.427220583, 14.8296576, 0.235150054, 4.87040343e-05, 0.000632332987, 1.00000238, 0.000483681186, 1.00000298, -0.00063235464, -1.00000417, 0.000483905722, 4.85587334e-05)
	Part13.Orientation = Vector3.new(0.03999999910593033, 90, 0.029999999329447746)
	Part13.Position = Vector3.new(0.42722058296203613, 14.829657554626465, 0.2351500540971756)
	Part13.Rotation = Vector3.new(0.029999999329447746, 90, 0)
	Part13.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part13.Size = Vector3.new(0.7300014495849609, 0.1500004678964615, 0.10000020265579224)
	Part13.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.BrickColor = BrickColor.new("Black")
	Part13.CanCollide = false
	Part13.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.Material = Enum.Material.DiamondPlate
	Part13.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part13.brickColor = BrickColor.new("Black")
	Part14.Parent = Model0
	Part14.CFrame = CFrame.new(0.427192569, 14.8300591, -0.215011492, -5.28971577e-05, -0.000632684096, 0.999999881, -0.000484298274, -0.999999762, -0.000632709649, 0.999999881, -0.000484331686, 5.25907381e-05)
	Part14.Orientation = Vector3.new(0.03999999910593033, 90, -179.97000122070312)
	Part14.Position = Vector3.new(0.4271925687789917, 14.830059051513672, -0.21501149237155914)
	Part14.Rotation = Vector3.new(85.25, 89.97000122070312, 94.77999877929688)
	Part14.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part14.Size = Vector3.new(0.7300014495849609, 0.1500004678964615, 0.10000020265579224)
	Part14.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.BrickColor = BrickColor.new("Black")
	Part14.CanCollide = false
	Part14.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.Material = Enum.Material.DiamondPlate
	Part14.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part14.brickColor = BrickColor.new("Black")
	WeldConstraint15.Parent = Part14
	WeldConstraint15.Part0 = Part14
	WeldConstraint15.Part1 = Part28
	WeldConstraint16.Parent = Part14
	WeldConstraint16.Part0 = Part14
	WeldConstraint16.Part1 = Part13
	WeldConstraint17.Parent = Part14
	WeldConstraint17.Part0 = Part14
	WeldConstraint17.Part1 = Part26
	Part18.Parent = Model0
	Part18.CFrame = CFrame.new(0.327204943, 14.8303022, -0.615176141, -5.35883482e-05, -0.000632923096, 0.999999881, -0.000484543532, -0.999999762, -0.000632948999, 0.999999881, -0.00048457738, 5.32816557e-05)
	Part18.Orientation = Vector3.new(0.03999999910593033, 90, -179.97000122070312)
	Part18.Position = Vector3.new(0.32720494270324707, 14.830302238464355, -0.6151761412620544)
	Part18.Rotation = Vector3.new(85.19000244140625, 89.97000122070312, 94.83999633789062)
	Part18.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part18.Size = Vector3.new(0.1500004231929779, 0.1500004678964615, 0.10000020265579224)
	Part18.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.BrickColor = BrickColor.new("Black")
	Part18.CanCollide = false
	Part18.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.Material = Enum.Material.DiamondPlate
	Part18.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part18.brickColor = BrickColor.new("Black")
	WeldConstraint19.Parent = Part18
	WeldConstraint19.Part0 = Part18
	WeldConstraint19.Part1 = Part14
	Part20.Parent = Model0
	Part20.CFrame = CFrame.new(0.32718429, 14.8294926, 0.635259926, 5.13403902e-05, 0.000632823794, 1.00000238, 0.000484899036, 1.00000298, -0.000632846786, -1.00000417, 0.00048512526, 5.11940852e-05)
	Part20.Orientation = Vector3.new(0.03999999910593033, 90, 0.029999999329447746)
	Part20.Position = Vector3.new(0.3271842896938324, 14.829492568969727, 0.6352599263191223)
	Part20.Rotation = Vector3.new(0.029999999329447746, 90, 0)
	Part20.Color = Color3.new(0.105882, 0.164706, 0.207843)
	Part20.Size = Vector3.new(0.1500004231929779, 0.1500004678964615, 0.10000020265579224)
	Part20.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.BrickColor = BrickColor.new("Black")
	Part20.CanCollide = false
	Part20.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.Material = Enum.Material.DiamondPlate
	Part20.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part20.brickColor = BrickColor.new("Black")
	WeldConstraint21.Parent = Part20
	WeldConstraint21.Part0 = Part20
	WeldConstraint21.Part1 = Part13
	Part22.Parent = Model0
	Part22.CFrame = CFrame.new(3.9037323, 14.8374729, 0.017061606, -4.81028001e-05, 3.49678994e-05, -1, -6.06141948e-05, 1.00000036, 3.49720976e-05, 1.00000036, 6.06253743e-05, -4.8106529e-05)
	Part22.Orientation = Vector3.new(0, -90, 0)
	Part22.Position = Vector3.new(3.9037322998046875, 14.837472915649414, 0.01706160604953766)
	Part22.Rotation = Vector3.new(0, -90, 0)
	Part22.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part22.Size = Vector3.new(0.274509072303772, 0.06207273527979851, 0.14400014281272888)
	Part22.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.BrickColor = BrickColor.new("Institutional white")
	Part22.CanCollide = false
	Part22.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.Material = Enum.Material.Neon
	Part22.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part22.brickColor = BrickColor.new("Institutional white")
	WeldConstraint23.Parent = Part22
	WeldConstraint23.Part0 = Part22
	WeldConstraint23.Part1 = Part25
	WeldConstraint24.Parent = Part22
	WeldConstraint24.Part0 = Part22
	WeldConstraint24.Part1 = Part26
	Part25.Parent = Model0
	Part25.CFrame = CFrame.new(4.03372955, 14.8374691, 0.0170683935, -4.79195696e-05, 3.48879403e-05, -1, -6.06940157e-05, 1.0000025, 3.48942194e-05, 1.00000203, 6.07673901e-05, -4.79620467e-05)
	Part25.Orientation = Vector3.new(0, -90, 0)
	Part25.Position = Vector3.new(4.033729553222656, 14.837469100952148, 0.017068393528461456)
	Part25.Rotation = Vector3.new(0, -90, 0)
	Part25.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part25.Size = Vector3.new(0.11450907588005066, 0.06207273527979851, 0.14400014281272888)
	Part25.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.BrickColor = BrickColor.new("Institutional white")
	Part25.CanCollide = false
	Part25.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.Material = Enum.Material.Neon
	Part25.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part25.brickColor = BrickColor.new("Institutional white")
	Part26.Parent = Model0
	Part26.CFrame = CFrame.new(2.12876606, 14.8375359, 0.0169754773, -4.77605063e-05, 3.48640606e-05, -1, -6.06091453e-05, 1, 3.486696e-05, 1, 6.06108115e-05, -4.77583926e-05)
	Part26.Orientation = Vector3.new(0, -90, 0)
	Part26.Position = Vector3.new(2.1287660598754883, 14.837535858154297, 0.01697547733783722)
	Part26.Rotation = Vector3.new(0, -90, 0)
	Part26.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part26.Size = Vector3.new(0.4345090687274933, 0.06207273527979851, 3.4140000343322754)
	Part26.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.BrickColor = BrickColor.new("Institutional white")
	Part26.CanCollide = false
	Part26.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.Material = Enum.Material.Neon
	Part26.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	Part26.brickColor = BrickColor.new("Institutional white")
	WeldConstraint27.Parent = Part26
	WeldConstraint27.Part0 = Part26
	WeldConstraint27.Part1 = Part13
	Part28.Parent = Model0
	Part28.CFrame = CFrame.new(-0.388033152, 14.8295736, 0.0100520747, 1.00000262, 2.35850166e-07, -1.19986362e-06, -2.34056643e-07, 1.00000334, -2.89565747e-07, 1.36045855e-06, 4.82950327e-07, 1.00000429)
	Part28.Position = Vector3.new(-0.3880331516265869, 14.829573631286621, 0.010052074678242207)
	Part28.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part28.Size = Vector3.new(1.643650770187378, 0.12643460929393768, 0.12643466889858246)
	Part28.BottomSurface = Enum.SurfaceType.Smooth
	Part28.BrickColor = BrickColor.new("Institutional white")
	Part28.CanCollide = false
	Part28.Material = Enum.Material.Neon
	Part28.TopSurface = Enum.SurfaceType.Smooth
	Part28.brickColor = BrickColor.new("Institutional white")
	Part28.Shape = Enum.PartType.Cylinder
	Motor29.Name = "mot"
	Motor29.Parent = Part28
	Motor29.C0 = CFrame.new(0, 0, 0, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor29.C1 = CFrame.new(-0.0632286072, 0, -3.6239624e-05, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor29.Part0 = Part28
	Motor29.Part1 = Part1
	Motor29.part1 = Part1
	WeldConstraint30.Parent = Part28
	WeldConstraint30.Part0 = Part28
	WeldConstraint30.Part1 = Part13
	WeldConstraint31.Parent = Part28
	WeldConstraint31.Part0 = Part28
	WeldConstraint31.Part1 = Part26
	Part32.Parent = Model0
	Part32.CFrame = CFrame.new(-1.33637667, 14.829587, 0.0100886915, 1.00000262, 2.3585018e-07, -1.19986373e-06, -2.34056657e-07, 1.00000334, -2.89565747e-07, 1.36045867e-06, 4.82950327e-07, 1.00000429)
	Part32.Position = Vector3.new(-1.336376667022705, 14.82958698272705, 0.010088691487908363)
	Part32.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part32.Size = Vector3.new(0.18965217471122742, 0.25286927819252014, 0.2528693377971649)
	Part32.BottomSurface = Enum.SurfaceType.Smooth
	Part32.BrickColor = BrickColor.new("Institutional white")
	Part32.CanCollide = false
	Part32.Material = Enum.Material.Neon
	Part32.TopSurface = Enum.SurfaceType.Smooth
	Part32.brickColor = BrickColor.new("Institutional white")
	Part32.Shape = Enum.PartType.Cylinder
	Motor33.Name = "mot"
	Motor33.Parent = Part32
	Motor33.C0 = CFrame.new(0, 0, 0, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor33.C1 = CFrame.new(-1.01156974, 1.33514404e-05, 1.43051147e-06, 0.342615455, 0.75679493, -0.55666548, -0.92270714, 0.159617245, -0.350904137, -0.176709056, 0.633864403, 0.752987266)
	Motor33.Part0 = Part32
	Motor33.Part1 = Part1
	Motor33.part1 = Part1
	WeldConstraint34.Parent = Part32
	WeldConstraint34.Part0 = Part32
	WeldConstraint34.Part1 = Part6
	for i,v in pairs(mas:GetChildren()) do
		v.Parent = workspace
		pcall(function() v:MakeJoints() end)
	end
	mas:Destroy()
	for i,v in pairs(cors) do
		spawn(function()
			pcall(v)
		end)
	end

	
	for i,v in pairs(Model0:GetChildren()) do
		v.Anchored = true
		v.Material = Enum.Material.Neon
		_G.FE(v,false,waitTime)
	end
	
	Part1.Anchored = true
	
	sword = Model0
	sword.Parent = workspace
	--sword:PivotTo(sword.Handle.CFrame * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))

	main = Instance.new("Part",workspace)
	main.Anchored = true
	main.Transparency = 1
	main.CanCollide = false

end

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	task.wait(1)
	if sword == nil then
		create()
		else
		sword:Destroy()
		create()
	end
end)

game.Players.PlayerRemoving:Connect(function(leaving)
	if leaving == plr then
		killaura = false
		following = false
		sword:Destroy()
	end
end)

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.M and not gameProcessedEvent then
		if not killaura then
			killaura = true
			repeat
				wait()
				
					local Success = pcall(function()
						game.StarterGui:SetCore("ChatMakeSystemMessage", {
							Text = "Sword On";
							Font = Enum.Font.Cartoon;
							Color = Color3.fromRGB(255, 255, 255);
							FontSize = 130;
						})
					end)
				until Success
			else
			killaura = false
			repeat
				wait()
				
					local Success = pcall(function()
						game.StarterGui:SetCore("ChatMakeSystemMessage", {
							Text = "Sword Off";
							Font = Enum.Font.Cartoon;
							Color = Color3.fromRGB(255, 255, 255);
							FontSize = 130;
						})
					end)
				until Success
		end
	end
end)

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

create()

plr.Chatted:Connect(function(message, recipient)
	message = string.lower(message)
	local prefix = string.sub(message,1,5)
	if prefix == "sword" then
		local arg = string.sub(message,7,9)
		print(plr.Name.." Killaura "..arg)
		if arg == "on" then
			killaura = true
			elseif arg == "off" then
			killaura = false
		end
	end
end)

local hue = 0
local SAT = 1
local LUM = 1
local SPEED = 15

spawn(function()
	while true do
		wait()
		
		local color = hsvToRgb(hue/360, SAT, LUM)
		hue = (hue+SPEED)%360
		wait()
		color = Color3.fromHSV(hue/360, SAT, LUM)
		
		for i,v in pairs(sword:GetChildren()) do
			v.Color = color
		end
	end
end)

function goto(part,position,speed)
	local gototween = tweenservice:Create(part,TweenInfo.new(speed),{
		Position = position
	}):Play()
	return gototween
end

function face(part,angle,speed)
	local twenn = tweenservice:Create(part,TweenInfo.new(speed),{
		CFrame = CFrame.lookAt(part.Position,angle)
	}):Play()
	return twenn
end

local range = 50



spawn(function()
	while true do
		wait(.5)
		if killaura then

		local p = game.Players:GetPlayers()
		for i = 2, #p do 
		local v = p[i].Character
		if teamCheck and p[i].Team == plr.Team then
		
		else
		if v and p[i] ~= plr and p[i].Name ~= "Masterpunk2077" and not p[i]:FindFirstChild("Sword") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
			nearestPlayer = p[i]

		following = false
		task.wait(.2)
		local time = 0
		-- for i = 1,10 do
		-- 	local tween = face(main,nearestPlayer.Character.HumanoidRootPart.Position,.1)
		-- 	task.wait(.1)

		-- 	local gototween = tweenservice:Create(main,TweenInfo.new(.1),{
		-- 		Position = nearestPlayer.Character.HumanoidRootPart.Position
		-- 	}):Play()
		-- 	task.wait(.1)
		-- 	-- task.wait(.1)
		-- 	-- local gototween = tweenservice:Create(main,TweenInfo.new(.1),{
		-- 	-- 	CFrame = main.CFrame * CFrame.new(0,0,-4)
		-- 	-- }):Play()
		-- end
		repeat
			time = time + 0.1
			local tween = face(main,nearestPlayer.Character.HumanoidRootPart.Position,.1)
			task.wait(.1)
			local gototween = tweenservice:Create(main,TweenInfo.new(.1),{
				Position = nearestPlayer.Character.HumanoidRootPart.Position
			}):Play()
			task.wait(.1)
		until time == 10 or math.abs((main.Position - v.HumanoidRootPart.Position).Magnitude) <= 2.5
		
		if p[i]:FindFirstChild("Sword") then
			local rand = math.random(1,100)
			if rand >= 70 then
				_G.Kill(v)
			end
			else
			_G.Kill(v)
		end
		
		task.wait(.1)
		following = true
		
		end
		end
		end
		end
		
	end
end)

runservice.RenderStepped:Connect(function()

	sword:PivotTo(main.CFrame)

	if not plr.Character then end
	if not plr.Character.HumanoidRootPart then end
	if not following then return end
	
	tweenservice:Create(main,TweenInfo.new(.5),{
		CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,1.5) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	}):Play()
end)


task.wait(.5)
killaura = true
