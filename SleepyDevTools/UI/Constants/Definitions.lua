local sdt = SleepyDevTools

sdt.UI.Definitions = {}

local texture_path = "Interface\\AddOns\\"..sdt.ADDON_NAME.."\\UI\\Textures"

sdt.UI.Definitions.BACKDROP_DEFAULT = {
  bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
  tile=true,
  tileSize = 32,
  edgeSize = 16,
  insets = {left=4, right=4, top=4, bottom=4}
}