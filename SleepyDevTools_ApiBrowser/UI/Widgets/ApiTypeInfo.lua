sdtApiTypeInfoMixin = CreateFromMixins(BackdropTemplateMixin)

local UI = SleepyDevTools.ApiBrowser.UI

function sdtApiTypeInfoMixin:SystemList_OnClick(button)
  UI.LoadSystemInfo(button.key)
end

function sdtApiTypeInfoMixin:SystemInfo_OnClick(button)
  UI.LoadFunctionInfo(button.key)
end

function sdtApiTypeInfoMixin:Refresh(model)
  if (model.type == "systems") then
    self.scrollChild.numColumns = 1
    self.scrollChild.template = "sdtTextButtonTemplate"
    
    local formatter = UI.Formatters.SystemListFormatter:new(model)
    self.scrollChild:SetButtonTableItems(formatter:format(), function (button) self:SystemList_OnClick(button) end)
  elseif (model.type == "system") then
    self.scrollChild.numColumns = 1
    self.scrollChild.template = "sdtTextButtonTemplate"
    
    local formatter = UI.Formatters.SystemInfoFormatter:new(model)
    self.scrollChild:SetButtonTableItems(formatter:format(), function (button) self:SystemInfo_OnClick(button) end)
  elseif (model.type == "function") then
    self.scrollChild.numColumns = 2

    local formatter = UI.Formatters.FunctionInfoFormatter:new(model)
    self.scrollChild:SetButtonTableItems(formatter:format())
  end
end

function sdtApiTypeInfoMixin:OnLoad()
  UI.Widgets.TypeInfo = self
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
  

end