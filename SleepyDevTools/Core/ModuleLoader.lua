local sdt = require('SleepyDevTools') or SleepyDevTools

sdt.ModuleLoader = {}
sdt.Modules = {}

local m = sdt.ModuleLoader

function m.LoadModule(module_name)
  local loaded, reason = LoadAddOn(module_name)
end

return m