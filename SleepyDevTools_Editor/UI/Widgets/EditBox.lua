sdtEditBoxMixin = CreateFromMixins(BackdropTemplateMixin)

function sdtEditBoxMixin:EditField_OnEditFocusLost(field)

end

function sdtEditBoxMixin:EditField_OnEditFocusGained(field)

end

function sdtEditBoxMixin:OnLoad()
  
  self.field:SetAutoFocus(false)
  
  self.field:SetScript("OnEditFocusLost", self.EditField_OnEditFocusLost)
  self.field:SetScript("OnEditFocusGained", self.EditField_OnEditFocusGained)
  
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
end