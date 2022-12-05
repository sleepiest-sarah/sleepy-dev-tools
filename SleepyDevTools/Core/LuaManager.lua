local SleepyDevTools = require('Core.Constants') or SleepyDevTools

SleepyDevTools.LuaManager = {}
local m = SleepyDevTools.LuaManager

local function stringifyKey(k)
  if (type(k) == "number") then
    return "["..k.."]"
  elseif (type(k) == "string" and tonumber(k)) then
    return "[\""..k.."\"]"
  else
    return k
  end
end

local function stringifyValue(v)
  if (type(v) == "string") then
    return "\""..v.."\""
  elseif (type(v) == "function") then
    return "func"
  elseif (type(v) == "userdata") then
    return "userdata"
  elseif (type(v) == "boolean") then
    return tostring(v)
  else
    return v
  end
end

function m.ExecuteLuaCode(code)
  --TODO pcall and display errors
  local parsed_code = loadstring(code)
  
  parsed_code()
end

function m.PrettyFormatTable(t)
  local res = {}
  
  table.insert(res,"{")
  
  for k,v in pairs(t) do
    k = stringifyKey(k)
    if (type(v) == "table") then
      table.insert(res, "  "..k.."=")
      table.insert(res, m.PrettyFormatTable(v))
    else
      table.insert(res, "  "..k.."="..stringifyValue(v))
    end
  end
  
  table.insert(res,"}")
  
  return res
end

return m