local UI = SleepyDevTools.ApiBrowser.UI

local manager = SleepyDevTools.ApiBrowser.UI.Manager

local ui_initialized = false

function UI.Refresh()
  
end

function UI.Initialize()
  ui_initialized = true
end

function UI.TearDown()

end

function UI.Open()
  if (not ui_initialized) then
    UI.Initialize()
  end
  
  UI.Widgets.ApiBrowserWindow:Show()
end

function UI.LoadSystemList()
  local model = manager.BuildSystemListModel() 
  UI.Widgets.TypeInfo:Refresh(model)
end

function UI.LoadSystemInfo(system)
  local model = manager.BuildSystemInfoModel(system) 
  UI.Widgets.TypeInfo:Refresh(model)
end

function UI.LoadFunctionInfo(func)
  local model = manager.BuildFunctionInfoModel(func)
  UI.Widgets.TypeInfo:Refresh(model)
end