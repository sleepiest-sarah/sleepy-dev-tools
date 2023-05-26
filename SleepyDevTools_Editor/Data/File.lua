SleepyDevTools.Editor.File = {}
local File = SleepyDevTools.Editor.File

function File:new(o)
  o = o and {name = o.name, text = o.text} or LCTableUtils.shallowCopy(SleepyDevTools.Editor.RecordTemplates.file_record_template)
  
  setmetatable(o, self)
  self.__index = self
  return o
end