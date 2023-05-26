SleepyDevTools.Editor.RecordTemplates = {}
local rt = SleepyDevTools.Editor.RecordTemplates

rt.file_record_template = {
  text = "",
  name = ""
}

rt.editor_db_template = {
  files = {
    -- map of file_record_template.name to file_record_template
  },
  current_file = ""--file_record_template.name
}