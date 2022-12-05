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

function da.SaveAutoFile(text)
  db.autosave = table_utils.shallowCopy(templates.file_record_template)
  db.autosave.text = text
end

function da.GetAutoSavedFile()
  return db.autosave
end