local editor = SleepyDevTools.Editor

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local ds = SleepyDevTools.Editor.DataServices

local function loadAddon(event, addon)
  if (addon == editor.ADDON_NAME) then
    ds.InitializeDatabase()
    --editor.UI.Open()
  end
end

local function playerLogout()
  editor.UI.TearDown()
end

ef.registerEvent("ADDON_LOADED", loadAddon)
ef.registerEvent("PLAYER_LOGOUT", playerLogout)