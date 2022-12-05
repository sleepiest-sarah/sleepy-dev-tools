PrettyPrintTemplateMixin = {}

local function setupHeaderButton(button)
  button:SetNormalAtlas(button.expanded and "Campaign_HeaderIcon_Open" or "Campaign_HeaderIcon_Closed")
	button:SetPushedAtlas(button.expanded and "Campaign_HeaderIcon_OpenPressed" or "Campaign_HeaderIcon_ClosedPressed");
  button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
	button:SetHitRectInsets(0, -button.ButtonText:GetWidth(), 0, 0);
end

local function setItemStyles(self, item)
  if (item.header) then
    setupHeaderButton(item)
  end
end

function PrettyPrintTemplateMixin:SetObject(obj)
  local formatted_obj = SleepyDevTools.LuaManager.PrettyFormatTable(obj)
  
  self:SetTreeItems(formatted_obj)
end

function PrettyPrintTemplateMixin:OnLoad()
  self:SetOnAcquireCallback(setItemStyles)
end