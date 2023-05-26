local SleepyDevTools = require('Core.Constants') or SleepyDevTools
local SyntaxHighlighter = SleepyDevTools.SyntaxHighlighter

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
  --TODO support multiple return params
  local parsed_code, error_msg = loadstring(code)
  
  if (parsed_code) then
    local res = {pcall(parsed_code)}
    if (not res[1]) then
      return res[2]
    end
    
    return nil, res[2]
  end
  
  return error_msg
end

function m.ExecuteInteractiveInterpreterCode(input)
  if (string.match(input,"^[A-Za-z_][A-Za-z0-9_]*$")) then --variable
    return m.ExecuteLuaCode(input)
  else                                                     --expression
    return m.ExecuteLuaCode("return " .. input)
  end
end

function m.PrettyFormatTable(t, depth)
  depth = depth or 0
  
  local res = {}
  
  table.insert(res,"{")
  
  if (depth <= SleepyDevTools.MAX_TABLE_TRAVERSE_DEPTH) then
    for k,v in pairs(t) do
      k = stringifyKey(k)
      if (type(v) == "table") then
        table.insert(res, "  "..k.."=")
        table.insert(res, m.PrettyFormatTable(v, depth+1))
      else
        table.insert(res, "  "..k.."="..stringifyValue(v))
      end
    end
  else
    table.insert(res, "...")
  end
  
  table.insert(res,"}")
  
  return res
end

function m.DumpTableToString(t, depth)
  depth = depth or 0
  
  local res = "\n{"
  
  if (depth <= SleepyDevTools.MAX_TABLE_TRAVERSE_DEPTH) then
    for k,v in pairs(t) do
      k = stringifyKey(k)
      if (type(v) == "table") then
        res = res .. "\n  " .. k .. "=" .. m.DumpTableToString(v, depth+1)
      else
        res = res .. "\n  " .. k .. "=" .. stringifyValue(v)
      end
    end
  else
    res = res .. "\n..."
  end
  
  res = res .. "\n}"
  
  return res  
end

function m.HighlightLuaSyntax(code)
  return SyntaxHighlighter.HighlightLuaCode(code)
end

return m