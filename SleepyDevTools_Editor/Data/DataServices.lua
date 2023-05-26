SleepyDevTools.Editor.DataServices = {}
local ds = SleepyDevTools.Editor.DataServices

local da = SleepyDevTools.Editor.DataAccess

function ds.InitializeDatabase()
  da.InitializeDatabase()
end

function ds.SaveFile(file)
  if (file.name ~= "") then
    da.SaveFile(file)
  end
end

function ds.SaveCurrentFile(file)
  da.SaveCurrentFile(file)
end

function ds.GetFiles()
  return da.GetFiles()
end

function ds.GetFile(name)
  return da.GetFile(name)
end

function ds.GetCurrentFile()
  return da.GetCurrentFile() or LCTableUtils.shallowCopy(SleepyDevTools.Editor.RecordTemplates.file_record_template)
end

function ds.DeleteFile(file)
  da.DeleteFile(file)
end

return ds