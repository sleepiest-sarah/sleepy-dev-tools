local UI = SleepyDevTools.Watchlist.UI

sdtWatchlistWindowMixin = CreateFromMixins()

function sdtWatchlistWindowMixin:AddItem(item)
  self.watchlist:AddItem(item)
end

function sdtWatchlistWindowMixin:OnLoad()
  UI.Widgets.WatchlistWindow = self
end