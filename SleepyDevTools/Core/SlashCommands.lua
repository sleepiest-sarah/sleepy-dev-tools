local sdt = require('SleepyDevTools') or SleepyDevTools

local function slashCmd(msg)
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

  if (cmd == "editor") then
    sdt.ModuleLoader.LoadModule(sdt.EDITOR_ADDON_NAME)
  else
    --TODO
    print('usage')
  end
end

SLASH_SleepyDevTools1 = "/sleepydevtools"
SLASH_SleepyDevTools2 = "/sdt"
SlashCmdList["SleepyDevTools"] = slashCmd