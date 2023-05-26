local apib = SleepyDevTools.ApiBrowser

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local function loadAddon(event, addon)
  if (addon == apib.ADDON_NAME) then
    apib.ApiManager.InitializeApiDocumentation()
  end
end

local function playerLogout()
  apib.UI.TearDown()
end

ef.registerEvent("ADDON_LOADED", loadAddon)
ef.registerEvent("PLAYER_LOGOUT", playerLogout)