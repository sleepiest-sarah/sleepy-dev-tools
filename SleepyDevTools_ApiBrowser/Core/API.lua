SleepyDevTools.ApiBrowser.API = {}
local api = SleepyDevTools.ApiBrowser.API

local Browser = SleepyDevTools.ApiBrowser

function api.GetWindow()
  return Browser.UI.Widgets.ApiBrowserWindow
end
