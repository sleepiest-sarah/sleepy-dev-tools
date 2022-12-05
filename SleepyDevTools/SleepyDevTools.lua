local sdt = SleepyDevTools

local ef = require('Libs.WowEventFramework.WowEventFramework') or WowEventFramework

local function loadAddon(event, addon)
  if (addon == sdt.ADDON_NAME) then
    sdt.ModuleLoader.LoadModule(sdt.WATCHLIST_ADDON_NAME)
  end
end

ef.registerEvent("ADDON_LOADED", loadAddon)

return sdt