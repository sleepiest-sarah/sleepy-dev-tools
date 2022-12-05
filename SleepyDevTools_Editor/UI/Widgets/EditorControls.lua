

sdtEditorControlsMixin = {}

function sdtEditorControlsMixin:RunButton_OnClick()
  SleepyDevTools.Editor.UI.ExecuteEditorCode()
end

function sdtEditorControlsMixin:OnLoad()
  
  self.runButton:SetScript("OnClick", self.RunButton_OnClick)
end