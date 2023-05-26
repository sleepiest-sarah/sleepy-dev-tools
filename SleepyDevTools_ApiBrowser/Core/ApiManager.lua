SleepyDevTools.ApiBrowser.ApiManager = {}
local m = SleepyDevTools.ApiBrowser.ApiManager

local factory = SleepyDevTools.ApiBrowser.ApiObjectFactory

function m.InitializeApiDocumentation()
  LoadAddOn("Blizzard_APIDocumentation")
  LoadAddOn("Blizzard_APIDocumentationGenerated")
end

function m.GetSystemList()
  local res = {}
  
  for i,sys in ipairs(APIDocumentation.systems) do
    res[i] = factory.createBasicSystemObject(sys)
  end  
  
  return res
end

function m.GetSystemInfo(system)

  for i,sys in ipairs(APIDocumentation.systems) do
    if (sys:GetName() == system) then
      return factory.createSystemObject(sys)
    end
  end  
end

function m.GetFunctionInfo(func)
  local func_api = APIDocumentation:FindAPIByName("function", func)
  
  return factory.createFunctionObject(func_api)
end

return m