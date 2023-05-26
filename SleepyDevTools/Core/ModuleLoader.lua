local sdt = require('SleepyDevTools') or SleepyDevTools

sdt.ModuleLoader = {}
sdt.Modules = {}

local module_definitions = {
  Editor = {addon_name = "SleepyDevTools_Editor", namespace = "Editor"},
  Watchlist = {addon_name = "SleepyDevTools_Watchlist", namespace = "Watchlist"},
  ApiBrowser = {addon_name = "SleepyDevTools_ApiBrowser", namespace = "ApiBrowser"}
}

local m = sdt.ModuleLoader

function m.LoadModule(module_name)
  local def = module_definitions[module_name]
  local loaded, reason = LoadAddOn(def.addon_name)
  if (loaded) then
    return sdt.Module:new(def)
  end
end

function m.LoadAllModules()
  for name,module_def in pairs(module_definitions) do
    local loaded_module = m.LoadModule(name)
    if (loaded_module) then
      sdt.Modules[module_def.namespace] = loaded_module
    end
  end
end

return m