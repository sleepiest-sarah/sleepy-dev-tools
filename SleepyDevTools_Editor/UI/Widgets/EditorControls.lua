sdtEditorControlsMixin = {}

local UI = SleepyDevTools.Editor.UI

local function createSaveStaticPopupDialog(self)
  StaticPopupDialogs["SDT_SAVE_FILE_AS"] = {
    text = "",
    button1 = SAVE,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 31,
    hideOnEscape = 1,
    OnAccept = function(self) sdtEditorControlsMixin.SaveDialog_OnAccept(self, self.editBox:GetText()) end,
    OnCancel = function(self) sdtEditorControlsMixin.SaveDialog_OnCancel(self) end,
    OnShow = function(self)
      self.button1:Disable();
      self.button2:Enable();
      self.editBox:SetFocus();
    end,
    OnHide = function(self)
      self.editBox:SetText("");
    end,
    EditBoxOnEnterPressed = function(self)
      if ( self:GetParent().button1:IsEnabled() ) then
        StaticPopup_OnClick(self:GetParent(), 1);
      end
    end,
    EditBoxOnTextChanged = function (self)
      StaticPopup_StandardNonEmptyTextHandler(self);
    end,
    EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
  }
end

function sdtEditorControlsMixin:RunButton_OnClick()
  SleepyDevTools.Editor.UI.ExecuteEditorCode()
end

function sdtEditorControlsMixin:SaveAsButton_OnClick()
  StaticPopup_Show("SDT_SAVE_FILE_AS")
end

function sdtEditorControlsMixin:NewButton_OnClick()
  UI.OpenNewFile()
end

function sdtEditorControlsMixin:DeleteButton_OnClick()
  UI.DeleteCurrentFile()
end

function sdtEditorControlsMixin:SaveDialog_OnAccept(name)
  UI.SaveNewFile(name)
end

function sdtEditorControlsMixin:SaveDialog_OnCancel()
  
end

function sdtEditorControlsMixin:OnLoad()
  createSaveStaticPopupDialog(self)
  
  self.runButton:SetScript("OnClick", self.RunButton_OnClick)
  self.saveButton:SetScript("OnClick", self.SaveAsButton_OnClick)
  self.newButton:SetScript("OnClick", self.NewButton_OnClick)
  self.deleteButton:SetScript("OnClick", self.DeleteButton_OnClick)
end