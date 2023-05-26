local f = {}
SleepyDevTools.ApiBrowser.UI.Formatters.SystemInfoFormatter = f

function f:new(model)
  local o = SleepyUI.Formatters.SleepyTableFormatter:new(self)
  
  o.model = model
  
  return o
end

function f:format()
  local sys = self.model.system
  
  self:appendRow({text = "Functions (" .. sys.num_functions .. ")"})
  for _,func in ipairs(sys.functions) do
    self:appendRow({text = func.name})
  end
  
  self:appendRow({text = ""})
  
  self:appendRow({text = "Events (" .. sys.num_events .. ")"})
  for _,e in ipairs(sys.events) do
    self:appendRow({text = e.name})
  end
  
  self:appendRow({text = ""})
  
  self:appendRow({text = "Tables (" .. sys.num_tables .. ")"})
  for _,t in ipairs(sys.tables) do
    self:appendRow({text = t.name})
  end
  
  return self.buffer
end