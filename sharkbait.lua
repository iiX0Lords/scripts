if not game:IsLoaded() then
	game.Loaded:Wait()
end

task.wait(1)
local datastore = _G.lcd
local lastGame = datastore:Datastore("GameJoined")

local HttpService = game:GetService("HttpService");

function SendMessage(Webhook, Message, Botname)
    if not string.find(Webhook, "https://discordapp.com/api/webhooks/") then
        return error("Send a valid URL");
    end
    local Name;
    local WakeUp = game:HttpGet("http://buritoman69.glitch.me");
    local API = "http://buritoman69.glitch.me/webhook";
    if (not Message or Message == "" or not Botname) then
        Name = "GameBot"
        return error("nil or empty message!")
    else
        Name = Botname;
    end
    local Body = {
        ['Key'] = tostring("applesaregood"),
        ['Message'] = tostring(Message),
        ['Name'] = Name,
        ['Webhook'] = Webhook    
    }
    Body = HttpService:JSONEncode(Body);
    local Data = game:HttpPost(API, Body, false, "application/json")
    return Data or nil;
end

function messageSent(str,plr)
    name = ""
    if plr.DisplayName == plr.Name then
        name = plr.Name
    else
        name = plr.DisplayName.." ("..plr.Name..")"
    end

    SendMessage("https://discordapp.com/api/webhooks/1063015077420212294/eTzXo-ZdiUpvj-19kk_4KDEeQfR-_Wl23eLevKhhkkJpTvoGoXSnax5IjP0j3wk05D74", str, name)
end

--messageSent("------------------------------------------",game.Players.LocalPlayer)

if lastGame.Joined == game.PlaceId or lastGame.Joined == nil then
    else
    messageSent("Joined https://www.roblox.com/games/"..game.PlaceId,game.Players.LocalPlayer)
end


lastGame.Joined = game.PlaceId
function handler(plr)
    plr.Chatted:Connect(function(message, recipient)
        messageSent(message,plr)
    end)
end

for i,v in pairs(game.Players:GetPlayers()) do
    handler(v)
end

game.Players.PlayerAdded:Connect(function(plr)
    handler(plr)
end)
