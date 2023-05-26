sdtEditorConsoleMixin = CreateFromMixins(BackdropTemplateMixin)

local lua_manager = SleepyDevTools.LuaManager

local console_history, console_input

function sdtEditorConsoleMixin:ConsoleInput_OnEnterPressed(editbox)
  local text = editbox:GetText()
  if (text ~= "") then
    
    local error_msg, result = lua_manager.ExecuteInteractiveInterpreterCode(text)

    console_history:AddMessage(">>" .. text)
    if (error_msg or result) then
      console_history:AddMessage(error_msg or result)
    end
    
    editbox:SetText("")
  end
end

function sdtEditorConsoleMixin:OnSizeChanged(width, height)
  
end

function sdtEditorConsoleMixin:OnLoad()
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
  
  console_history = self.innerConsoleContainer.consoleHistory
  console_input = self.innerConsoleContainer.consoleInput
  
  console_input:SetScript("OnEnterPressed", function (editbox) sdtEditorConsoleMixin:ConsoleInput_OnEnterPressed(editbox) end)
end