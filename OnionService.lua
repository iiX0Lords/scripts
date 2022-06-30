local onion = {}

local service = Instance.new("Folder",game)
service.Name = "OnionService"

function onion:Negate(part,filter)
	
	table.insert(filter,part)
	
	local fold = Instance.new("Model",workspace)
	fold.Name = "Onion"

	local function CreatePartRegion(part)
		local asdf = Region3.new(part.Position - (part.Size/2),part.Position + (part.Size/2))
		return asdf
	end

	local function finalize(part, center, width, height, depth, group)
		local corners1 = {
			part.Size*Vector3.new(-.5, 0, -.5), part.Size*Vector3.new( .5, 0, -.5),
			part.Size*Vector3.new( .5, 0,  .5), part.Size*Vector3.new(-.5, 0,  .5)
		}
		local corners2 = {
			center + Vector3.new( width/2, 0, -depth/2), center + Vector3.new( width/2, 0,  depth/2),
			center + Vector3.new(-width/2, 0,  depth/2), center + Vector3.new(-width/2, 0, -depth/2)
		}
		local minx, maxx, minz, maxz = corners1[1].X, corners1[3].X, corners1[1].Z, corners1[3].Z
		for i = 1, #corners2 do
			local c = corners2[i]
			corners2[i] = Vector3.new(math.clamp(c.X, minx, maxx), 0, math.clamp(c.Z, minz, maxz))
		end
		local boxes = {
			{corners1[1], corners2[1]},
			{Vector3.new(corners2[2].X, 0, corners1[2].Z), Vector3.new(corners1[2].X, 0, corners2[2].Z)},
			{corners2[3], corners1[3]},
			{Vector3.new(corners1[4].X, 0, corners2[4].Z), Vector3.new(corners2[4].X, 0, corners1[4].Z)},
			{Vector3.new(corners2[4].X, center.Y + height/2, corners2[4].Z), Vector3.new(corners2[2].X, part.Size.Y/2, corners2[2].Z)},
			{Vector3.new(corners2[4].X, -part.Size.Y/2, corners2[4].Z), Vector3.new(corners2[2].X, center.Y - height/2, corners2[2].Z)}
		}
		local model = group or Instance.new("Model")
		if not group then model.Name = "CutPart" end
		local parts = model:GetChildren()
		if  corners2[1].X == minx or corners2[3].X == maxx
			or corners2[1].Z == maxz or corners2[3].Z == minz
			or center.Y - height/2 >= part.Size.Y/2 or center.Y + height/2 <= -part.Size.Y/2 then
			for i = 2, #parts do parts[i]:Destroy() end
			local new = parts[1] or part:Clone()
			new.CFrame, new.Size = part.CFrame, part.Size
			--new.Anchored = false
			if not parts[1] then new.Parent = fold end
			model.Parent, part.Parent = fold

			local col = new:Clone()
			col.Parent = fold
			col.Size = col.Size + Vector3.new(.1,.1,.1)
			for i,z in pairs(workspace:FindPartsInRegion3WithIgnoreList(CreatePartRegion(col),filter)) do
				local weld = Instance.new("WeldConstraint",new)
				weld.Part0 = new
				weld.Part1 = z
			end
			col:Destroy()
			new.Anchored = false
			return model
		end
		local index = 1
		for i = 1, #boxes do
			local box = boxes[i]
			local size = box[2] - box[1]
			local new = parts[index] or part:Clone()
			if size.X >= .05 and size.Z >= .05 and (i <= 4 or size.Y >= .05) then
				index = index + 1
				new.Size = size + Vector3.new(0, i <= 4 and part.Size.Y or 0, 0)
				new.CFrame = part.CFrame*CFrame.new((box[1] + box[2])/2)
				new.Parent = fold
				new.Anchored = false

				local col = new:Clone()
				col.Parent = fold
				col.Size = col.Size + Vector3.new(.1,.1,.1)

				for i,z in pairs(workspace:FindPartsInRegion3WithIgnoreList(CreatePartRegion(col),filter)) do
					local weld = Instance.new("WeldConstraint",new)
					weld.Part0 = new
					weld.Part1 = z
				end
				col:Destroy()
				new.Anchored = false

			end
		end
		for i = index, #boxes do
			if parts[index] then
				parts[index].Parent = nil
			end
		end
		model.Parent, part.Parent = fold
		return model,fold
	end


	local desa = part

	local region = CreatePartRegion(desa)


	for i,v in pairs(workspace:FindPartsInRegion3WithIgnoreList(region,filter)) do
		repeat
			if v:FindFirstChildOfClass("WeldConstraint")  then
				v:FindFirstChildOfClass("WeldConstraint"):Destroy()
			end
		until not v:FindFirstChildOfClass("WeldConstraint")

		local model,debris = finalize(v, v.CFrame:inverse()*desa.Position, desa.Size.X, desa.Size.Y, desa.Size.Z, nil)
		gdebris = debris
		
		model:Destroy()
	end
	
	return gdebris
end

return onion
