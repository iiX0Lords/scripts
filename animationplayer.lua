
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')


function _G.playID(id,loop)

    local fakeAnim = Instance.new("NumberValue")
    local sda = Instance.new("BoolValue",fakeAnim)
    sda.Name = "Stop"
    sda.Value = false

    local function kftotbl(kf) -- Below this is literal pain..
        tbl3 = {}
        for i,v in pairs(kf:GetDescendants()) do
            if v:IsA("Pose") then
                tbl3[string.sub(v.Name,1,1)..string.sub(v.Name,#v.Name,#v.Name)] = v.CFrame
            end
        end
        return(tbl3)
    end
    
    local function getnext(tbl,number)
        c=100
        rtrnv=0
        for i,v in pairs(tbl) do
            if i>number and i-number<c then
                c=i-number
                rtrnv=i
            end
        end
        return(rtrnv)
    end

    local function reset()
        ogC0s = {
            ["Right Shoulder"] = CFrame.new(1, 0.5, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),
            ["Left Shoulder"] = CFrame.new(-1, 0.5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),
            ["Right Hip"] = CFrame.new(1, -1, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),
            ["Left Hip"] = CFrame.new(-1, -1, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),
        }
    
        for i,v in pairs(plr.Character.Torso:GetChildren()) do
            if ogC0s[v.Name] then
                tweenservice:Create(v,TweenInfo.new(0.1),{
                    C0 =  ogC0s[v.Name]
                }):Play()
            end
        end
    
        hhhh.Parent = plr.Character.Humanoid
        fakeAnim:Destroy()
    end
    
    
    wait(.1) -- Do not change because changing it will break.
    animid="rbxassetid://"..id
    plr = game.Players.LocalPlayer
    char = game:GetService("Players").LocalPlayer.Character
    cframe = char.HumanoidRootPart.CFrame
    torso = game:GetService("Players").LocalPlayer.Character.Torso
    -----------------------------------------------------------
    rs = torso["Right Shoulder"] -- Just took this from another script(Faster).
    ls = torso["Left Shoulder"]
    rh = torso["Right Hip"]
    lh = torso["Left Hip"]
    n = torso["Neck"]
    rj = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart["RootJoint"]
    rsc0 = rs.C0
    lsc0 = ls.C0
    rhc0 = rh.C0
    lhc0 = lh.C0
    rjc0 = rj.C0
    nc0 = n.C0
    gc0 = CFrame.new()
    orsc0 = rs.C0
    olsc0 = ls.C0
    orhc0 = rh.C0
    olhc0 = lh.C0
    orjc0 = rj.C0
    onc0 = n.C0
    count2 = 100
    maxcount2=100
    -----------------------------------------------------------
    game:GetService("RunService").Heartbeat:Connect(function() -- Speed.
        if playanother == true then
            return nil
        else
            count2 = count2+1
            if count2<=maxcount2 then
                rs.Transform=rs.Transform:Lerp(rsc0,count2/maxcount2)
                ls.Transform=ls.Transform:Lerp(lsc0,count2/maxcount2)
                rh.Transform=rh.Transform:Lerp(rhc0,count2/maxcount2)
                lh.Transform=lh.Transform:Lerp(lhc0,count2/maxcount2)
                n.Transform=n.Transform:Lerp(nc0,count2/maxcount2)
                rj.Transform=rj.Transform:Lerp(rjc0,count2/maxcount2)
            end
        end
    end)
    -----------------------------------------------------------
    animid=game:GetObjects(animid)[1]
    anim={}
    for i,v in pairs(animid:GetChildren()) do
        if v:IsA("Keyframe") then
            anim[v.Time]=kftotbl(v)
        end
    end
    
    count = 0
    char=game:GetService("Players").LocalPlayer.Character
    hhhh=game:GetService("Players").LocalPlayer.Character.Humanoid.Animator
    hhhh.Parent = nil
    for _,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
        v:Stop()
    end
    
    plr.CharacterRemoving:Connect(function()
        if playing == true then
            playing = false
        end
    end)
    
spawn(function()
    while wait() do
        for i,oasjdadlasdkadkldjkl in pairs(anim) do

            if sda.Value == true then
                reset()
                break
            end

            asdf=getnext(anim,count)
            v=anim[asdf]
            if v["Lg"] then
                lhc0 = v["Lg"]
            end
            if v["Rg"] then
                rhc0 = v["Rg"]
            end
            if v["Lm"] then
                lsc0 = v["Lm"]
            end
            if v["Rm"] then
                rsc0 = v["Rm"]
            end
            if v["To"] then
                rjc0 = v["To"]
            end
            if v["Hd"] then
                nc0 = v["Hd"]
            end
            count2=0
            maxcount2=asdf-count
            count=asdf

            if sda.Value == true then
                reset()
                break
            end

            wait(asdf-count)

            if sda.Value == true then
                reset()
                break
            end

            count2=maxcount2
            if v["Lg"] then
                char.Torso["Left Hip"].Transform = v["Lg"]
            end
            if v["Rg"] then
                char.Torso["Right Hip"].Transform = v["Rg"]
            end
            if v["Lm"] then
                char.Torso["Left Shoulder"].Transform = v["Lm"]
            end
            if v["Rm"] then
                char.Torso["Right Shoulder"].Transform = v["Rm"]
            end
            if v["To"] then
                char.HumanoidRootPart["RootJoint"].Transform = v["To"]
            end
            if v["Hd"] then
                char.Torso["Neck"].Transform = v["Hd"]
            end
        end
        if not loop then
            reset()
            break
        end
        if sda.Value == true then
            reset()
            break
        end
    end
end)


    if not loop then
        reset()
    else
        return fakeAnim
    end

end
