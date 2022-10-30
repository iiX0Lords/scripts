local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local runservice = game:GetService('RunService')
local StarterPack = game:GetService('StarterPack')
local uis = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')

local tycoon = nil
local cash = plr.leaderstats.Cash

for i,v in pairs(game.workspace.Tycoon.Tycoons:GetChildren()) do
    if v.Owner.Value == plr then
       tycoon = v
    end
end

version = "{!#version} 1.0.0 {/#version}"
version = string.sub(version,13,17)

local cashCollector = tycoon.Essentials.CashCollector



function rebirth()
    repeat
        task.wait()
        getCash()
    until cash.Value >= 500000
end

function getButtons()
    local prices = {}
    for i,v in pairs(tycoon.UnpurchasedButtons:GetChildren()) do
        if not v:FindFirstChild("Gamepass") and not v:FindFirstChild("Clothing") then
            table.insert(prices,v)
        end
    end

    if #prices <= 0 then
        notify("No buttons found (rebirth)",5)
        rebirth()
    end

    return prices
end

function getAllPrices()
    local prices = {}
    for i,v in pairs(getButtons()) do
        table.insert(prices,v.Price.Value)
    end
    return prices
end

function getCash()
    local df = plr.Character.HumanoidRootPart.CFrame
    plr.Character.HumanoidRootPart.CFrame = cashCollector.CFrame+Vector3.new(0,5,0)
    local cashVal = cash.Value
    local timeout = 0
    repeat
        task.wait()
        timeout = timeout + 0.01
    until cash.Value ~= cashVal or timeout >= 6
    plr.Character.HumanoidRootPart.CFrame = df
end

function buyCheapestButton()

    local cheapest = 1000000
    local final = nil

    for i,v in pairs(getButtons()) do
        if v.Price.Value < cheapest then
            cheapest = v.Price.Value
            final = v
        end
    end
    
    if cash.Value > cheapest then
        local df = plr.Character.HumanoidRootPart.CFrame
        pcall(function()
            plr.Character.HumanoidRootPart.CFrame = final.Neon.CFrame
        end)
        local timeout = 0
        repeat
            task.wait()
            timeout = timeout + 0.01
        until not tycoon.UnpurchasedButtons:FindFirstChild(final.Name) or timeout >= 2
        else
        getCash()
    end
end

function notify(text,duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Autofarm";
        Text = text;
        Duration = duration or 1;
    })
end

local enabled = false

uis.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.P and not gameProcessedEvent then
        if enabled then enabled = false else enabled = true end
        notify(tostring(enabled),2)
    end
end)

notify("Loaded Version "..version)

while task.wait() do
    if enabled then
        buyCheapestButton()
    end
end
