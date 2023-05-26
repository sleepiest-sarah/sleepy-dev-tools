sdtEditorFilesMixin = CreateFromMixins(BackdropTemplateMixin)

local UI = SleepyDevTools.Editor.UI

function sdtEditorFilesMixin:Refresh(model)
  local file_names = {}
  
  for _,file in pairs(model.file_list) do
    table.insert(file_names, file.name)
  end
  
  self.list:SetButtonListItems(file_names, function(button)self:File_OnClick(button)end)
end

function sdtEditorFilesMixin:File_OnClick(file_button)
  UI.LoadFile(file_button.key)
end

function sdtEditorFilesMixin:OnLoad()
  self.list:SetItemTemplate("UIPanelButtonTemplate")
  
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
end