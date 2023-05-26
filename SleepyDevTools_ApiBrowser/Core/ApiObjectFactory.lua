SleepyDevTools.ApiBrowser.ApiObjectFactory = {}
local m = SleepyDevTools.ApiBrowser.ApiObjectFactory

function m.createEventObject(event)
  local obj = {
    name = event:GetName(),
    payload = event:GetPayloadString()
  }
  
  return obj
end

function m.createFunctionObject(func)
  local obj = {
    name = func:GetName(),
    params = func:GetArgumentString(),
    returns = func:GetReturnString()
  }
  
  return obj
end

function m.createTableObject(table)
  local obj = {
    name = table:GetName()
  }
  
  return obj
end

function m.createBasicSystemObject(system)
  local obj = {
    name = system:GetName(),
    namespace = system:GetNamespaceName(),
    num_functions = system:GetNumFunctions(),
    num_events = system:GetNumEvents(),
    num_tables = system:GetNumTables()
  }
  
  return obj
end

function m.createSystemObject(system)
  local obj = m.createBasicSystemObject(system)
  
  obj.functions = {}
  obj.events = {}
  obj.tables = {}
  
  for i,f in ipairs(system.Functions) do
    table.insert(obj.functions, m.createFunctionObject(f))
  end
  
  for i,e in ipairs(system.Events) do
    table.insert(obj.events, m.createEventObject(e))
  end
  
  for i,t in ipairs(system.Tables) do
    table.insert(obj.tables, m.createTableObject(t))
  end
  
  return obj
end

return m