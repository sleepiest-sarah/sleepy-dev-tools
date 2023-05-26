sdtMainWindowMixin = CreateFromMixins(BackdropTemplateMixin,SleepyTabbedContainerMixin)

function sdtMainWindowMixin:Tab_OnClick(tab)
  if (self._activeTab) then
    self._activeTab:UnlockHighlight()
    self._activeFrame:Hide()
  end
  
  if (tab.name == "Editor") then
    SleepyDevTools.Editor.UI.Open()
  elseif (tab.name == "Watchlist") then
    SleepyDevTools.Watchlist.UI.Open()
  elseif (tab.name == "ApiBrowser") then
    SleepyDevTools.ApiBrowser.UI.Open()
  end
  
  self._activeTab = tab
  self._activeTab:LockHighlight()
  self._activeFrame = self._tabFrameMap[tab.name]
end

function sdtMainWindowMixin:SetModules(modules)
  for name, mod in pairs(modules) do
    self:AddTab(name, mod.window)
  end
  
  self:SelectTab("Editor")
end

function sdtMainWindowMixin:OnLoad()
  SleepyDevTools.UI.Widgets.MainWindow = self

  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
end