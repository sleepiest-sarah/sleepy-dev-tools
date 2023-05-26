sdtApiTypeControlsMixin = {}

local UI = SleepyDevTools.ApiBrowser.UI

function sdtApiTypeControlsMixin:SystemsButton_OnClick()
  UI.LoadSystemList()
end

function sdtApiTypeControlsMixin:OnLoad()
  
  self.systemsButton:SetScript("OnClick", self.SystemsButton_OnClick)
  --self.saveButton:SetScript("OnClick", self.SaveAsButton_OnClick)
  --self.newButton:SetScript("OnClick", self.NewButton_OnClick)
end