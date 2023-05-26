sdtEditBoxMixin = CreateFromMixins(BackdropTemplateMixin)

local string_utils =  require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils

local syntax_highlighter = SleepyDevTools.SyntaxHighlighter

local function LineNumScroller_Update(self)
  if (not self.line_numbers) then
    return
  end
  
  local offset = HybridScrollFrame_GetOffset(self.lineNumScroller)
  local buttons = HybridScrollFrame_GetButtons(self.lineNumScroller)
  
  self.lineNumWidthTester:SetText("test")
  local line_height = self.lineNumWidthTester:GetLineHeight()
  
  for i=1, #buttons do
    local line = offset + i
    
    buttons[i]:SetHeight(line_height)

    if (i <= #self.line_numbers) then
      buttons[i].lineNumber:SetText(self.line_numbers[line])
    else
      buttons[i].lineNumber:SetText("")
    end
  end
  
  --HybridScrollFrame_Update(self.lineNumScroller, #self.line_numbers * line_height, self.lineNumScroller:GetHeight() - 5)
end

function sdtEditBoxMixin:RefreshLineNumbers()
  self.line_numbers = {}
  local line_number = 1
  local i = 1
  local text_inset_left, text_inset_right = self.field:GetTextInsets()
  local edit_box_width = self.field:GetWidth() - text_inset_left - text_inset_right
  for line in string.gmatch(self.field:GetText(), "([^\n]*\n?)") do
    if (#line > 0) then
      self.lineNumWidthTester:SetText(line)
      local line_offset = math.ceil(self.lineNumWidthTester:GetUnboundedStringWidth() / edit_box_width)
      line_offset = line_offset == 0 and 1 or line_offset
      
      for j=1,line_offset do
        self.line_numbers[i] = (j == 1) and tostring(line_number) or ""
        i = i + 1
      end
      line_number = line_number + 1
    end
  end
  LineNumScroller_Update(self)
end

function sdtEditBoxMixin:EditField_OnTextChanged(field, userinput)
  if (userinput) then
    local cursor_pos = self.field:GetCursorPosition()
    local current_text = self.field:GetText()
    
    local raw_text, raw_text_pos = syntax_highlighter.MarkCursorPosAndStripColorEscapeSequences(current_text, cursor_pos)
    
    local new_highlighted_text, new_cursor_pos = syntax_highlighter.HighlightLuaCode(raw_text, raw_text_pos)
    self.field:SetText(new_highlighted_text)
    self.field:SetCursorPosition(new_cursor_pos)
    
    self:RefreshLineNumbers()
  end
end

function sdtEditBoxMixin:OnMouseDown()
  self.field:SetFocus()
end

function sdtEditBoxMixin:OnSizeChanged(width, height)
  self.field:SetWidth(width)
  HybridScrollFrame_CreateButtons(self.lineNumScroller, "sdtLineNumberButtonTemplate", 0, -5, "TOP", "TOP", 0, 0, "TOP", "BOTTOM")
  self:RefreshLineNumbers()
end

function sdtEditBoxMixin:GetText()
  local raw_text = syntax_highlighter.StripColorEscapeSequences(self.field:GetText())
  return raw_text
end

function sdtEditBoxMixin:Refresh(file)
  self.file = file
  
  local highlighted_text = syntax_highlighter.HighlightLuaCode(file.text)
  self.field:SetText(highlighted_text)
  self:RefreshLineNumbers()
end

function sdtEditBoxMixin:OnLoad()
  self:SetBackdrop(SleepyDevTools.UI.Definitions.BACKDROP_DEFAULT)
  
  self:SetScript("OnVerticalScroll", function (self, offset) HybridScrollFrame_SetOffset(self.lineNumScroller, offset) end)
  
  self.field:SetAutoFocus(false)
  self.field:SetScript("OnTextChanged", function(field,userinput) self:EditField_OnTextChanged(field,userinput) end)
  
  self.field:SetTextInsets(35, 5, 5, 0)
  
  self.lineNumScroller.scrollBar = CreateFrame("Slider", "$parentScrollBar", self.lineNumScroller, "HybridScrollBarTemplate")
  self.lineNumScroller.scrollBar:Hide()
  self.lineNumScroller.scrollBar.Show = function() end
  self.lineNumScroller.update = function () LineNumScroller_Update(self) end
  
  self.lineNumWidthTester = self:CreateFontString()
  self.lineNumWidthTester:SetFontObject(self.field:GetFontObject())
  self.lineNumWidthTester:Hide()

  HybridScrollFrame_CreateButtons(self.lineNumScroller, "sdtLineNumberButtonTemplate", 0, -5, "TOP", "TOP", 0, 0, "TOP", "BOTTOM")
end