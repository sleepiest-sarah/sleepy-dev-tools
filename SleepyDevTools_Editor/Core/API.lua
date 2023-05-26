SleepyDevTools.Editor.API = {}
local api = SleepyDevTools.Editor.API

local Editor = SleepyDevTools.Editor

function api.GetWindow()
  return Editor.UI.Widgets.EditorWindow
end
