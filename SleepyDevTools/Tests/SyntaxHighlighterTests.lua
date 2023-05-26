local sh = require('Lua.SyntaxHighlighter')

local lu = require('luaunit')
local string_utils =  require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils

SyntaxHighlighterTests = {}

function WrapTextInColorCode(text, colorHexString)
	return ("|c%s%s|r"):format(colorHexString, text);
end

function SyntaxHighlighterTests:testTokenizeCode()
  local code = "local    cat =     b + 10 / 5"
  
  local res = sh.TokenizeCode(code)
  
  lu.assertEquals(#res, 15)
end

function SyntaxHighlighterTests:testScanSeparators()
  local code = 
[[local a = 5
local b = 7]]
  
  local res = sh.TokenizeCode(code)
  
  lu.assertEquals(#res, 15)
end

function SyntaxHighlighterTests:testCursorTracking()
  local code = 
[[|c00000000local|r a = 5
local b = 7]]

  local cursor_pos = 13
  
  local raw_text, raw_text_pos = sh.MarkCursorPosAndStripColorEscapeSequences(code, cursor_pos)
  
  lu.assertEquals(raw_text_pos, 3)
  
  local new_highlighted_text, new_cursor_pos = sh.HighlightLuaCode(raw_text, raw_text_pos)
  
  lu.assertEquals(new_cursor_pos, 13)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('SyntaxHighlighterTests')