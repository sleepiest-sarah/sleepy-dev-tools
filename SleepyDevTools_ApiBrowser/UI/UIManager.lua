SleepyDevTools.ApiBrowser.UI.Manager = {}
local m = SleepyDevTools.ApiBrowser.UI.Manager

local api_manager = SleepyDevTools.ApiBrowser.ApiManager

function m.BuildSystemListModel()
  local model = {}
  model.type = "systems"
  
  local system_list = api_manager.GetSystemList()
  
  local system_names = {}
  for i,sys in ipairs(system_list) do
    system_names[i] = sys.name
  end
  model.systems = system_names
  
  return model
end

function m.BuildSystemInfoModel(system)
  local model = {}
  model.type = "system"
  model.system = api_manager.GetSystemInfo(system)
  
  return model
end

function m.BuildFunctionInfoModel(func)
  local model = {}
  model.type = "function"
  model.func = api_manager.GetFunctionInfo(func)
  
  return model
end

return m