SleepyDevTools.ApiBrowser.UI.Formatters.SystemListFormatter = {}
local f = SleepyDevTools.ApiBrowser.UI.Formatters.SystemListFormatter

function f:new(model)
  local o = SleepyUI.Formatters.SleepyTableFormatter:new(self)
  
  o.model = model
  
  return o
end

function f:format()
  for _,sys in ipairs(self.model.systems) do
    table.insert(self.buffer, {{text = sys}})
  end
  
  return self.buffer
end