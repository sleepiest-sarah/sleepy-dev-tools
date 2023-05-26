local SleepyDevTools = require('Core.Constants') or SleepyDevTools
local Themes = require('Core.Themes') or SleepyDevTools.Themes
local Scanner = require('Lua.Scanner') or SleepyDevTools.LuaScanner

local string_utils =  require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils

SleepyDevTools.SyntaxHighlighter = {}
local m = SleepyDevTools.SyntaxHighlighter

local theme = Themes.Default

local function isWhitespace(char)
  return string.match(char, "[%c%s]")
end

function m.TokenizeCode(code)
  local tokens = {}
  
  local scanner = Scanner:new(code)
  while (scanner:hasNext()) do
    local token = scanner:scan()
    table.insert(tokens, token)
  end
  
--  local start_index = 1
--  for i=1,string.len(code) do
--    if (i >= start_index) then
--      local whitespace = isWhitespace(string.sub(code, i, i))
--      if (whitespace) then
--        table.insert(tokens, string.sub(code, start_index, i-1))
        
--        local j = i
--        local whitespace_str = ""
--        while (true) do
--          whitespace = isWhitespace(string.sub(code, j, j))
--          if (not whitespace) then
--            table.insert(tokens, whitespace_str)
--            i = j
--            start_index = j
--            break
--          end
--          whitespace_str = whitespace_str .. whitespace
--          j = j + 1
--        end
        
--      end
--    end
--  end
  
--  table.insert(tokens, string.sub(code, start_index, string.len(code)))
  
  return tokens
end

function m.HighlightLuaCode(code, cursor_pos)
  local tokenized = m.TokenizeCode(code)

  local highlighted_code = ""
  local new_cursor_pos = cursor_pos
  for _,token in ipairs(tokenized) do
    local spelling = token.spelling
    if (theme[token:getType()]) then
      spelling = WrapTextInColorCode(spelling, theme[token:getType()])
      if (cursor_pos and cursor_pos >= token.pos) then
        new_cursor_pos = new_cursor_pos + (cursor_pos >= token:getEndPosition() and 12 or 10)
      end
        
    end
    highlighted_code = highlighted_code .. spelling
  end
  
  return highlighted_code, new_cursor_pos
end

function m.StripColorEscapeSequences(code)
  local stripped_code = string.gsub(code, "|c%x%x%x%x%x%x%x%x([^|]*)|r", "%1")
  
  return stripped_code
end

function m.MarkCursorPosAndStripColorEscapeSequences(code, cursor_pos)
  --insert a marker to track cursor position after the strip
  code = string_utils.insert(code, cursor_pos, "\6")
    
  local raw_text = m.StripColorEscapeSequences(code)
  
  --find our marker and then delete it
  local raw_text_pos = string.find(raw_text, "\6") - 1
  raw_text = string.gsub(raw_text, "\6", "", 1)
  
  return raw_text, raw_text_pos
end

return m