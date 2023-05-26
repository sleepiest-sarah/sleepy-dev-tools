local Scanner = {}
SleepyDevTools.LuaScanner = Scanner

local Token = require('Lua.Token') or SleepyDevTools.Token

local string_utils =  require('Libs.LuaCore.Utils.StringUtils') or LCStringUtils

Scanner.Separators = {
  ["\\n"] = "\\n",
  ["\\t"] = "\\t",
  ["\\r"] = "\\r",
  [" "] = " ",
}
  
Scanner.Operators = {
  ["+"] = "+",
  ["-"] = "-",
  ["*"] = "*",
  ["/"] = "/",
  [">"] = ">",
  ["<"] = "<",
  ["="] = "=",
  ["=="] = "==",
  [">="] = ">=",
  ["<="] = "<=",
  ["%"] = "%"
}

Scanner.Braces = {
  ["["] = "[",
  ["]"] = "]",
  ["{"] = "{",
  ["}"] = "}",
  ["("] = "(",
  [")"] = ")",
}

Scanner.Keywords = {
  ["local"] = "local",
  ["return"] = "return",
  ["function"] = "function",
  ["for"] = "for",
  ["end"] = "end",
  ["do"] = "do",
  ["while"] = "while",
  ["if"] = "if",
  ["else"] = "else",
  ["elseif"] = "elseif",
  ["then"] = "then",
  ["repeat"] = "repeat",
  ["until"] = "until",
  ["break"] = "break",
  ["and"] = "and",
  ["or"] = "or",
  ["not"] = "not",
}

function Scanner:new(code)
  local o = {
    code = code,
    spelling = "",
    char = "",
    index = 1
  }

  setmetatable(o, self)
  self.__index = self
  
  o:next()
  
  return o
end

function Scanner:scan()
  self.spelling = ""
  
  local start_pos = self.index
  local token_type = self:scanToken()
  -- operator scan for comments
  if (token_type == Token.OPERATOR and self.spelling == '=') then
    token_type = Token.ASSIGNMENT
  elseif (token_type == Token.IDENTIFIER and self.Keywords[self.spelling]) then
    token_type = Token.KEYWORD
  end
  
  return Token:new(token_type, self.spelling, start_pos - 1)
end

function Scanner:scanToken()

  if (self.Separators[self.char]) then
    self:accept()
    while (self.Separators[self.char] and self:hasNext()) do
      self:accept()
    end
    return Token.SEPARATOR
  elseif (self.char == "-" and string_utils.charAt(self.code, self.index) == "-") then
    self:accept()
    self:accept()
    if (self.char == "[" and string_utils.charAt(self.code, self.index) == "[") then  --multiline comment
      self:accept()
      self:accept()
      while (self:hasNext()) do
        -- look for ]]--
        if (self.char == "]" and string_utils.charAt(self.code, self.index) == "]"
          and string_utils.charAt(self.code, self.index + 1) == "-" and string_utils.charAt(self.code, self.index + 2) == "-") then
          self:accept()
          self:accept()
          self:accept()
          self:accept()
          break
        end
        self:accept()
      end
    else
      while (self.char ~= '\n' and self:hasNext()) do
        self:accept()
      end
      self:accept()
    end
    return Token.COMMENT
  elseif (self.char == "\"") then
    self:accept()
    while (self.char ~= "\"" and self:hasNext()) do
      self:accept()
    end
    self:accept() --closing quote
    
    return Token.STRINGLITERAL
  elseif (self.char == "'") then
    self:accept()
    while (self.char ~= "'" and self:hasNext()) do
      self:accept()
    end
    self:accept() --closing quote
    
    return Token.STRINGLITERAL
  --multiline string literal
  elseif (self.char == "[" and string_utils.charAt(self.code, self.index) == "[") then
    self:accept()
    self:accept()
    while (self:hasNext()) do
      if (self.char == "]" and string_utils.charAt(self.code, self.index) == "]") then
        self:accept()
        self:accept()
        break
      end
      self:accept()
    end
    
    return Token.STRINGLITERAL
  elseif (self.Operators[self.char]) then
    self:accept()
    if (self.Operators[self.spelling .. self.char]) then
      self:accept()
    end
    return Token.OPERATOR
  elseif (string_utils.isDigit(self.char)) then
    self:accept()
    while (string_utils.isDigit(self.char)) do
      self:accept()
    end
    return Token.INTLITERAL
  elseif (string_utils.isLetter(self.char) or self.char == '_') then
    self:accept()
    while (string_utils.isLetter(self.char) or string_utils.isDigit(self.char) or self.char == '_') do
      self:accept()
    end
    return Token.IDENTIFIER
  elseif (self.Braces[self.char]) then
    self:accept()
    return Token.BRACES
  elseif (self.char == '.') then
    self:accept()
    return Token.DOT
  elseif (self.char == ';') then
    self:accept()
    return Token.SEMICOLON
  elseif (self.char == ':') then
    self:accept()
    return Token.COLON
  elseif (self.char == ',') then
    self:accept()
    return Token.COMMA
  end
  
  self:accept()
end

function Scanner:accept()
  self.spelling = self.spelling .. self.char
  self:next()
end

function Scanner:next()
  self.char = string.sub(self.code, self.index, self.index)
  self.index = self.index + 1
  
  return self.char
end

function Scanner:hasNext()
  return self.char ~= ""
end

return Scanner