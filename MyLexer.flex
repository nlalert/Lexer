%%
%public
%class TermProjectLexer
%standalone

%{
  java.util.HashSet<String> identifiers = new java.util.HashSet<>();
%}

LineTerminator      = \r|\n|\r\n
EscapeSequence      = "\\"["btnrf\'\"\\"]
InputCharacter      = [^\\\"\n\r] | {EscapeSequence}
WhiteSpace          = {LineTerminator} | [ \t\f]

/* Comments */
Comment             = {TraditionalComment} | {EndOfLineComment}
TraditionalComment  = "/*" [^*]* "*" + "/" 
EndOfLineComment    = "//" [^\n\r]* {LineTerminator}?

/* Identifiers, Literals, and Operators */
Identifier          = [a-zA-Z][a-zA-Z0-9]*
UnexpectedCharacter = [^+\-*/=><(); \n\r\t\a\f0-9a-zA-Z\"]+
InvalidIdentifier   = ({Identifier}{UnexpectedCharacter}.*) | ({UnexpectedCharacter}{Identifier}.*)
IntegerLiteral      = [0-9]+
StringLiteral       = \"{InputCharacter}*\"
UnterminatedString  = \"{InputCharacter}*

Operator            = "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
Parenthesis         = "(" | ")"
Semicolon           = ";"
Keyword             = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"

%%

<YYINITIAL> {

  /* Keywords */
  {Keyword}        { System.out.println("keyword: " + yytext()); }

  /* Operators */
  {Operator}       { System.out.println("operator: " + yytext()); }

  /* Parenthesis and Semicolon */
  {Parenthesis}    { System.out.println("parenthesis: " + yytext()); }
  {Semicolon}      { System.out.println("semicolon: " + yytext()); }

  /* Identifiers */
  {Identifier}     { 
    if (identifiers.add(yytext())) {
      System.out.println("new identifier: " + yytext());
    } else {
      System.out.println("identifier \"" + yytext() + "\" already in symbol table");
    }
  }

  /* Invalid Identifiers: Contains at least one invalid character */
  {InvalidIdentifier} { 
    System.out.println("Error: invalid identifier: " + yytext());
  }

  {IntegerLiteral}{Identifier} {
    System.out.println("Error: invalid identifier: " + yytext());
  }

  {UnexpectedCharacter} {
    System.out.println("Error: Unexpected character: " + yytext());
  }
  
  /* Literals */
  {IntegerLiteral} { System.out.println("integer: " + yytext()); }
  {StringLiteral}  { System.out.println("string: " + yytext()); }

  /* Unterminated strings */
  {UnterminatedString} { 
    System.err.println("Error: Unterminated string: " + yytext());
  }

  /* Ignore comments and whitespace */
  {Comment}        { /* Ignore */ }
  {WhiteSpace}     { /* Ignore */ }
}

[^] {
  System.err.println("Error");
}