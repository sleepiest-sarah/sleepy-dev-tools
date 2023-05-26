local UI = SleepyDevTools.Editor.UI

sdtOutputWindowMixin = CreateFromMixins(BackdropTemplateMixin)

function sdtOutputWindowMixin:AddOutputMessage(text)
  self:AddMessage(text)
end

function sdtOutputWindowMixin:OnLoad()
  UI.Widgets.EditorOutput = self
  
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
  
  self:SetFading(false);
  self:SetFontObject(ConsoleFontSmall);
  self:SetJustifyH("LEFT");
  self:SetHyperlinksEnabled(true);
  self:SetTextCopyable(true);
end