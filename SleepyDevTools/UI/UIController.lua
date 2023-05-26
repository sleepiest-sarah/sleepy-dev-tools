local UI = SleepyDevTools.UI

local manager = UI.Manager

local ui_initialized = false

function UI.Initialize()
  local loaded_modules = manager.GetModules()

  UI.Widgets.MainWindow:SetModules(loaded_modules)
end

function UI.Open()
  if (not ui_initialized) then
    UI.Initialize()
  end
  
  UI.Widgets.MainWindow:Show()
end