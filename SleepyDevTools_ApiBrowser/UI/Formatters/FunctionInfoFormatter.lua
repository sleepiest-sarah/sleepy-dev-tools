local f = {}
SleepyDevTools.ApiBrowser.UI.Formatters.FunctionInfoFormatter = f

function f:new(model)
  local o = SleepyUI.Formatters.SleepyTableFormatter:new(self)
  
  o.model = model
  
  return o
end

function f:format()
  local func = self.model.func
  
  self:appendRow({text = "Name:"}, {text = func.name})
  
  self:appendRow({text = ""})
  
  self:appendRow({text = "Arguments:"}, {text = func.params})
  
  self:appendRow({text = ""})
  
  self:appendRow({text = "Returns:"}, {text = func.returns})
  
  return self.buffer
end