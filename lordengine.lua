--- General Utility Script ---

--[[

    Documentation

    utility:MakeDraggable(frame) -- Makes a frame of a gui draggable

    utility:CreatePartRegion(part) -- Makes a region3 from a parts pos and size

]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end

version = "{!#version} 1.0.0 {/#version}"
version = string.sub(version,13,17)

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local utility = {}

function utility:MakeDraggable(frame)
        spawn(function()
            local minitial
            local initial
            local isdragging
            local run = game:service('RunService')
            local stepped = run.Stepped
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isdragging = true
                    minitial = input.Position
                    initial = frame.Position
                    local con
                    con = stepped:Connect(function()
                        if isdragging then
                            local delta = Vector3.new(mouse.X, mouse.Y, 0) - minitial
                            frame.Position = UDim2.new(initial.X.Scale, initial.X.Offset + delta.X, initial.Y.Scale, initial.Y.Offset + delta.Y)
                        else
                            con:Disconnect()
                        end
                    end)
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            isdragging = false
                        end
                    end)
            end
        end)
    end)
end

function utility:CreatePartRegion(part)
    local asdf = Region3.new(part.Position - (part.Size/2),part.Position + (part.Size/2))
	return asdf
end

function utility:CastRay(position,direction,filter)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = filter
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(position, direction, raycastParams)

    return raycastResult
end

-- function utility:Cut(part, center, width, height, depth, group)

-- 	local center = part.CFrame:inverse()*part.Position,
-- 	local width = part.Size.X
-- 	local height = part.Size.Y
-- 	local depth = part.Size.Z
-- 	local group = nil

-- 	local corners1 = {
-- 		part.Size*Vector3.new(-.5, 0, -.5), part.Size*Vector3.new( .5, 0, -.5),
-- 		part.Size*Vector3.new( .5, 0,  .5), part.Size*Vector3.new(-.5, 0,  .5)
-- 	}
-- 	local corners2 = {
-- 		center + Vector3.new( width/2, 0, -depth/2), center + Vector3.new( width/2, 0,  depth/2),
-- 		center + Vector3.new(-width/2, 0,  depth/2), center + Vector3.new(-width/2, 0, -depth/2)
-- 	}
-- 	local minx, maxx, minz, maxz = corners1[1].X, corners1[3].X, corners1[1].Z, corners1[3].Z
-- 	for i = 1, #corners2 do
-- 		local c = corners2[i]
-- 		corners2[i] = Vector3.new(math.clamp(c.X, minx, maxx), 0, math.clamp(c.Z, minz, maxz))
-- 	end
-- 	local boxes = {
-- 		{corners1[1], corners2[1]},
-- 		{Vector3.new(corners2[2].X, 0, corners1[2].Z), Vector3.new(corners1[2].X, 0, corners2[2].Z)},
-- 		{corners2[3], corners1[3]},
-- 		{Vector3.new(corners1[4].X, 0, corners2[4].Z), Vector3.new(corners2[4].X, 0, corners1[4].Z)},
-- 		{Vector3.new(corners2[4].X, center.Y + height/2, corners2[4].Z), Vector3.new(corners2[2].X, part.Size.Y/2, corners2[2].Z)},
-- 		{Vector3.new(corners2[4].X, -part.Size.Y/2, corners2[4].Z), Vector3.new(corners2[2].X, center.Y - height/2, corners2[2].Z)}
-- 	}
-- 	local model = group or Instance.new("Model")
-- 	if not group then model.Name = "CutPart" end
-- 	local parts = model:GetChildren()
-- 	if  corners2[1].X == minx or corners2[3].X == maxx
-- 		or corners2[1].Z == maxz or corners2[3].Z == minz
-- 		or center.Y - height/2 >= part.Size.Y/2 or center.Y + height/2 <= -part.Size.Y/2 then
-- 		for i = 2, #parts do parts[i]:Destroy() end
-- 		local new = parts[1] or part:Clone()
-- 		new.CFrame, new.Size = part.CFrame, part.Size
-- 		--new.Anchored = false
-- 		if not parts[1] then new.Parent = model end
-- 		model.Parent, part.Parent = fold
		
-- 		local col = new:Clone()
-- 		col.Parent = fold
-- 		col.Size = col.Size + Vector3.new(.1,.1,.1)

-- 		for i,z in pairs(workspace:FindPartsInRegion3(utility:CreatePartRegion(col),plr.Character)) do
-- 			local weld = Instance.new("WeldConstraint",new)
-- 			weld.Part0 = new
-- 			weld.Part1 = z
-- 		end
-- 		col:Destroy()
-- 		new.Anchored = false
		
-- 		return model
-- 	end
-- 	local index = 1
-- 	for i = 1, #boxes do
-- 		local box = boxes[i]
-- 		local size = box[2] - box[1]
-- 		local new = parts[index] or part:Clone()
-- 		if size.X >= .05 and size.Z >= .05 and (i <= 4 or size.Y >= .05) then
-- 			index = index + 1
-- 			new.Size = size + Vector3.new(0, i <= 4 and part.Size.Y or 0, 0)
-- 			new.CFrame = part.CFrame*CFrame.new((box[1] + box[2])/2)
-- 			new.Parent = fold
-- 			new.Anchored = false
			
-- 			local col = new:Clone()
-- 			col.Parent = fold
-- 			col.Size = col.Size + Vector3.new(.1,.1,.1)
			
-- 			for i,z in pairs(workspace:FindPartsInRegion3(utility:CreatePartRegion(col),plr.Character)) do
-- 				local weld = Instance.new("WeldConstraint",new)
-- 				weld.Part0 = new
-- 				weld.Part1 = z
-- 			end
-- 			col:Destroy()
-- 			new.Anchored = false
			
-- 		end
-- 	end
-- 	for i = index, #boxes do
-- 		if parts[index] then
-- 			parts[index].Parent = nil
-- 		end
-- 	end
-- 	model.Parent, part.Parent = fold
-- 	return model
-- end



utility['version'] = version

_G.lordsengine = utility
print("Loaded LORDS Engine V"..version)
