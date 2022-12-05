SleepyDevTools.Editor.DataServices = {}
local ds = SleepyDevTools.Editor.DataServices

local da = SleepyDevTools.Editor.DataAccess

function ds.InitializeDatabase()
  da.InitializeDatabase()
end

function ds.SaveAutoFile(text)
  da.SaveAutoFile(text)
end

function ds.GetAutoSavedFile()
  return da.GetAutoSavedFile()
end

return ds