local UI = SleepyDevTools.Editor.UI

sdtEditorWindowMixin = CreateFromMixins(BackdropTemplateMixin)

function sdtEditorWindowMixin:GetEditorText()
  return self.editBox.field:GetText()
end

function sdtEditorWindowMixin:SetEditorText(text)
  self.editBox.field:SetText(text)
end

function sdtEditorWindowMixin:OnLoad()
  UI.Widgets.EditorWindow = self
  
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
end