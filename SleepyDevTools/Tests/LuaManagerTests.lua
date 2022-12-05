--local lt = require('Libs.LuaTesting.LuaTesting')

local lm = require('Core.LuaManager')

local lu = require('luaunit')

LuaManagerTests = {}

function LuaManagerTests.testPrettyFormatTable()
  local res = lm.PrettyFormatTable({a=5,b="10"})
  
  lu.assertNotNil(res)
  
  res = lm.PrettyFormatTable({a=5,b="10",c={d=15}})
  
  
  lu.assertNotNil(res)
end

lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE
lu.LuaUnit.run('LuaManagerTests')