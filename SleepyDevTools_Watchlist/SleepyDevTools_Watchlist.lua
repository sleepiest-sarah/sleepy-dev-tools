local wl = SleepyDevTools.Watchlist

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

--local ds = SleepyDevTools.Watchlist.DataServices

local function loadAddon(event, addon)
  if (addon == wl.ADDON_NAME) then
    --ds.InitializeDatabase()
    --wl.UI.Open()
  end
end

local function playerLogout()
  wl.UI.TearDown()
end

ef.registerEvent("ADDON_LOADED", loadAddon)
ef.registerEvent("PLAYER_LOGOUT", playerLogout)