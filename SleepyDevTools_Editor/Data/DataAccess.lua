SleepyDevTools.Editor.DataAccess = {}
local da = SleepyDevTools.Editor.DataAccess

local templates = SleepyDevTools.Editor.RecordTemplates

local table_utils = require('Libs.LuaCore.Utils.TableUtils') or LCTableUtils

local db

function da.InitializeDatabase()
  sdtEditorDb = sdtEditorDb or {}
  db = sdtEditorDb
  
  db = table_utils.addKeysLeft(sdtEditorDb, templates.editor_db_template)
end

function da.SaveFile(file)
  local file_record = sdtEditorDb.files[name] or table_utils.shallowCopy(templates.file_record_template)
  
  file_record.name = file.name
  file_record.text = file.text
  
  sdtEditorDb.files[file.name] = file
end

function da.SaveCurrentFile(file)
  sdtEditorDb.current_file = sdtEditorDb.files[file.name] and file.name or file
end

function da.DeleteFile(file)
  if (sdtEditorDb.current_file == file.name) then
    sdtEditorDb.current_file = ""
  end
  
  sdtEditorDb.files[file.name] = nil
end

function da.GetCurrentFile()
  local file = sdtEditorDb.current_file
  if (file and type(file) == 'string') then
    return sdtEditorDb.files[file]
  else
    return file
  end
end

function da.GetFiles()
  return sdtEditorDb.files
end

function da.GetFile(name)
  return sdtEditorDb.files[name]
end