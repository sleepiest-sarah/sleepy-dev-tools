local UI = SleepyDevTools.Watchlist.UI

local lua_manager = SleepyDevTools.LuaManager
local ds = SleepyDevTools.Watchlist.DataServices

local ui_initialized = false

function UI.Initialize()
  ui_initialized = true
  
  UI.Widgets.WatchlistWindow:AddItem({[1]=1,["1"]="1",a=5, b=3, c="7",d={e=10, f = {g="bear", h="chair",["5"]=20}}})
end

function UI.TearDown()

end

function UI.Open()
  if (not ui_initialized) then
    UI.Initialize()
  end
  
  UI.Widgets.WatchlistWindow:Show()

end
