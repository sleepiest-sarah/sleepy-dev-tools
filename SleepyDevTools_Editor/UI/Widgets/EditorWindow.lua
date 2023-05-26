local UI = SleepyDevTools.Editor.UI

sdtEditorWindowMixin = CreateFromMixins()

function sdtEditorWindowMixin:GetEditorText()
  return self.editBox:GetText()
end

function sdtEditorWindowMixin:GetEditorFile()
  self.editor_file.text = self:GetEditorText()
  return self.editor_file
end

function sdtEditorWindowMixin:SetEditorText(text)
  text = text or ""
  self.editBox.field:SetText(text)
end

function sdtEditorWindowMixin:Refresh(model)
  self.editor_file = model.editor_file or LCTableUtils.shallowCopy(SleepyDevTools.Editor.RecordTemplates.file_record_template)

  self.editBox:Refresh(self.editor_file)
  self.fileInfo.name:SetText(self.editor_file.name ~= "" and self.editor_file.name or SleepyDevTools.Editor.DEFAULT_FILE_NAME)
  
  self.fileList:Refresh(model)
end

function sdtEditorWindowMixin:OnLoad()
  UI.Widgets.EditorWindow = self
  
  self.consoleOutputContainer:SetTabAnchor("TOPLEFT", "BOTTOMLEFT")
  self.consoleOutputContainer:AddTab("Output", self.consoleOutputContainer.outputWindow)
  self.consoleOutputContainer:AddTab("Console", self.consoleOutputContainer.consoleWindow)
  self.consoleOutputContainer:SelectTab("Console")
end