SleepyDevTools.Module = {}
local Module = SleepyDevTools.Module

function Module:new(def)
  local o = {
    namespace = def.namespace,
    addon_name = def.addon_name,
    window = SleepyDevTools[def.namespace].API.GetWindow()
  }

  setmetatable(o, self)
  self.__index = self
  return o
end