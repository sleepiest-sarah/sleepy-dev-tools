local Token = {}
SleepyDevTools.Token = Token

Token.IDENTIFIER = 0
Token.INTLITERAL = 1
Token.OPERATOR = 2
Token.ASSIGNMENT = 3
Token.KEYWORD = 4
Token.BOOLEAN = 5
Token.DOT = 6
Token.SEMICOLON = 7
Token.COMMA = 8
Token.COLON = 9
Token.BRACES = 10
Token.STRINGLITERAL = 11
Token.SEPARATOR = 12
Token.COMMENT = 13

Token.Type = {}
Token.Type[Token.IDENTIFIER] = "IDENTIFIER"
Token.Type[Token.INTLITERAL] = "INTLITERAL"
Token.Type[Token.OPERATOR] = "OPERATOR"
Token.Type[Token.ASSIGNMENT] = "ASSIGNMENT"
Token.Type[Token.KEYWORD] = "KEYWORD"
Token.Type[Token.BOOLEAN] = "BOOLEAN"
Token.Type[Token.DOT] = "DOT"
Token.Type[Token.SEMICOLON] = "SEMICOLON"
Token.Type[Token.COLON] = "COLON"
Token.Type[Token.COMMA] = "COMMA"
Token.Type[Token.BRACES] = "BRACES"
Token.Type[Token.STRINGLITERAL] = "STRINGLITERAL"
Token.Type[Token.SEPARATOR] = "SEPARATOR"
Token.Type[Token.COMMENT] = "COMMENT"


function Token:new(type, spelling, pos)
  local o = {
    type = type,
    spelling = spelling,
    pos = pos
  }

  setmetatable(o, self)
  self.__index = self
  
  return o
end

function Token:getType()
  return Token.Type[self.type]
end

function Token:getEndPosition()
  return self.pos + string.len(self.spelling)
end

return Token