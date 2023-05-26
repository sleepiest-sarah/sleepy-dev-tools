SleepyDevTools.Editor.UI.Manager = {}
local m = SleepyDevTools.Editor.UI.Manager

local ds = SleepyDevTools.Editor.DataServices

function m.buildEditorModel(file)
  local model = {}
  
  model.editor_file = file and ds.GetFile(file) or ds.GetCurrentFile()
  model.editor_file.highlighted_text = SleepyDevTools.LuaManager.HighlightLuaSyntax(model.editor_file.text)
  model.file_list = ds.GetFiles()
  
  return model
end

function m.buildBlankEditorModel()
  local model = {}
  
  model.editor_file = LCTableUtils.shallowCopy(SleepyDevTools.Editor.RecordTemplates.file_record_template)
  model.file_list = ds.GetFiles()
  
  return model
end

return m