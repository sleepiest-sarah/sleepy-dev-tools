local UI = SleepyDevTools.Editor.UI

local lua_manager = SleepyDevTools.LuaManager
local ds = SleepyDevTools.Editor.DataServices

local editor = UI.Widgets.EditorWindow

local ui_initialized = false

function UI.Initialize()
  local autosaved_file = ds.GetAutoSavedFile()
  if (autosaved_file) then
    editor:SetEditorText(autosaved_file.text)
  end
  
  ui_initialized = true
end

function UI.TearDown()
  local editor_text = editor:GetEditorText()
  if (editor_text and editor_text ~= "") then
    ds.SaveAutoFile(editor_text)
  end
end

function UI.Open()
  if (not ui_initialized) then
    UI.Initialize()
  end
  
  UI.Widgets.EditorWindow:Show()
end

function UI.ExecuteEditorCode()
  local editor_text = editor:GetEditorText()
  
  lua_manager.ExecuteLuaCode(editor_text)
end