
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')


--12248207321

function loadInstanceWithScripts(id,parent)

    -- local oldReq

    -- oldReq = hookfunction(require, function(instance)
    --     print(instance.Name)

    --     if instance.Source then
    --         return loadstring(instance.Source)()
    --     end

    --     return oldReq(instance)
    -- end)

    local loadedInstance = game:GetObjects(id)[1]
    loadedInstance.Parent = parent
    local function loadScriptInEnviroment(Script,source)
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
        LocalScript0 = Script
        table.insert(cors,sandbox(LocalScript0,loadstring(source)))
    
        for i,v in pairs(cors) do
            spawn(function()
                pcall(v)
            end)
        end
    end

    if loadedInstance:IsA("Script") or loadedInstance:IsA("LocalScript") then
        loadScriptInEnviroment(loadedInstance,loadedInstance.Source)
    end
    
    for i,v in pairs(loadedInstance:GetDescendants()) do
        if v:IsA("LocalScript") or v:IsA("Script") then
            if v.Enabled then
                loadScriptInEnviroment(v,v.Source)
            end
        end
    end


    return loadedInstance
end
_G.core = true
loadInstanceWithScripts("rbxassetid://12248306304",plr.PlayerScripts)
