sdtApiBrowserWindowMixin = {}

local UI = SleepyDevTools.ApiBrowser.UI

function sdtApiBrowserWindowMixin:Refresh()
  --self.systemList:SetSystems(systems)
end

function sdtApiBrowserWindowMixin:OnLoad()
  UI.Widgets.ApiBrowserWindow = self
end