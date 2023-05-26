local UI = SleepyDevTools.Editor.UI

local lua_manager = SleepyDevTools.LuaManager
local ds = SleepyDevTools.Editor.DataServices
local manager = SleepyDevTools.Editor.UI.Manager

local editor = UI.Widgets.EditorWindow

local ui_initialized = false

local function refreshEditor(file)
  local model = manager.buildEditorModel(file)
  editor:Refresh(model)
end

local function initialize()
  refreshEditor()
  
  ui_initialized = true
end

function UI.TearDown()
  local editor_file = editor:GetEditorFile()
  ds.SaveFile(editor_file)
  ds.SaveCurrentFile(editor_file)
end

function UI.Open()
  if (not ui_initialized) then
    initialize()
  end
  
  UI.Widgets.EditorWindow:Show()
end

function UI.ExecuteEditorCode()
  local editor_text = editor:GetEditorText()
  
  local current_print_handler = getprinthandler()
  setprinthandler(function(msg) UI.Widgets.EditorOutput:AddOutputMessage(msg) end)
  
  local error_msg, result = lua_manager.ExecuteLuaCode(editor_text)
  if (error_msg) then
    UI.Widgets.EditorOutput:AddOutputMessage(error_msg)
  end
  
  setprinthandler(current_print_handler)
end

function UI.LoadFile(name)
  local editor_file = editor:GetEditorFile()
  ds.SaveFile(editor_file)
  refreshEditor(name)
end

function UI.OpenNewFile()
  local model = manager.buildBlankEditorModel()
  editor:Refresh(model)
end

function UI.SaveNewFile(name)
  local editor_file = editor:GetEditorFile()
  local new_file = LCTableUtils.shallowCopy(editor_file)
  new_file.name = name
  ds.SaveFile(new_file)
  refreshEditor()
end

function UI.DeleteCurrentFile()
  local editor_file = editor:GetEditorFile()
  ds.DeleteFile(editor_file)
  refreshEditor()
end