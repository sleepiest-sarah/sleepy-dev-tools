sdtWatchlistMixin = {}

function sdtWatchlistMixin:AddItem(item)
  local item_frame = CreateFrame("FRAME", nil, self, "sdtPrettyPrintTemplate")
  item_frame:SetSize(200, 400)
  item_frame:SetObject(item)
  table.insert(self.items, item_frame)
  
  self:DoLayout(self.items)
end

function sdtWatchlistMixin:OnLoad()
  self.items = {}
end