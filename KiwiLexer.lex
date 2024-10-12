%%
%public
%class TermProjectLexer
%standalone

%{
  java.util.HashSet<String> identifiers = new java.util.HashSet<>();
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]+

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?

// Identifier = [:jletter:] [:jletterdigit:]*
Identifier = [a-zA-Z] ([0-9a-zA-Z])* // no underscore "_"
IntegerLiteral = 0 | [1-9][0-9]*

StringLiteral = \"({EscapeCharacter} | [^\r\n\"])*\"
EscapeCharacter = \\.
UnterminatedStringLiteral = \"({EscapeCharacter} | [^\r\n\"])*

Operator = "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
Parenthesis = "(" | ")"
Semicolon = ";"
Keyword = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"

%%

<YYINITIAL> {
  /* keywords */
  {Keyword}        { System.out.println("keyword: " + yytext()); }

  /* operators */
  {Operator}       { System.out.println("operator: " + yytext()); }

  /* parenthesis and semicolon */
  {Parenthesis}    { System.out.println("parenthesis: " + yytext()); }
  {Semicolon}      { System.out.println("semicolon: " + yytext()); }

  /* identifiers */
  {Identifier}     {
    if (identifiers.add(yytext())) {
      System.out.println("new identifier: " + yytext());
    } else {
      System.out.println("identifier \"" + yytext() + "\" already in symbol table");
    }
  }

  /* integers */
  {IntegerLiteral} { System.out.println("integer: " + yytext()); }
  {IntegerLiteral}{Identifier} {
    System.err.println("Error: Invalid identifier '" + yytext() + "'");
    System.exit(1);
  }

  /* strings */
  {StringLiteral}  { System.out.println("string: " + yytext()); }
  {UnterminatedStringLiteral} {
    System.err.println("Error: String literal is not properly closed by a double-quote '" + yytext() + "'");
    System.exit(1);
  }

  /* comments */
  {Comment}        { /* ignore */ }

  /* whitespace */
  {WhiteSpace}     { /* ignore */ }
}

/* error fallback */
[^] {
  System.err.println("Error: Unexpected character '" + yytext() + "'");
  System.exit(1);
}