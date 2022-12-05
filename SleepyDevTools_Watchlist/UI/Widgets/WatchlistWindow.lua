local UI = SleepyDevTools.Watchlist.UI

sdtWatchlistWindowMixin = CreateFromMixins(BackdropTemplateMixin)

function sdtWatchlistWindowMixin:AddItem(item)
  self.watchlist:AddItem(item)
end

function sdtWatchlistWindowMixin:OnLoad()
  UI.Widgets.WatchlistWindow = self
  
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
end