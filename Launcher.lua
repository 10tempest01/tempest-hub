getgenv().TempestHubVersion = "v1.4.1"

local supportedGames = {
    "3808081382" -- TSB
}

if table.find(supportedGames, tostring(game.GameId)) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/10tempest01/tempest-hub/refs/heads/main/Games/" .. game.GameId .. ".lua"))()
end
