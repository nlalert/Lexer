%%
%public
%class TermProjectLexer
%standalone

%{
  java.util.HashSet<String> identifiers = new java.util.HashSet<>();
%}

LineTerminator     = \r|\n|\r\n
EscapeSequence     = "\\"["btnrf\'\"\\"]
InputCharacter     = [^\\\"\n\r] | {EscapeSequence}
WhiteSpace         = {LineTerminator} | [ \t\f]

/* Comments */
Comment            = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*"([^*]|\*+[^*/])*\*+"/"
EndOfLineComment   = "//".*

/* Identifiers, Literals, and Operators */
Identifier         = [a-zA-Z][a-zA-Z0-9]*
IntegerLiteral     = [0-9]+
StringLiteral      = \"{InputCharacter}*\"
UnterminatedString = \"{InputCharacter}*

Operator           = "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
Parenthesis        = "(" | ")"
Semicolon          = ";"
Keyword            = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"
UnexpectedCharacter = [^a-zA-Z0-9+\-*/=(){}; \t\r\n\f]
InvalidIdentifier = [a-zA-Z0-9]*{UnexpectedCharacter}+[a-zA-Z0-9]*({UnexpectedCharacter}*[a-zA-Z0-9]*)*

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
  {Identifier} { 
    if (identifiers.add(yytext())) {
      System.out.println("new identifier: " + yytext());
    } else {
      System.out.println("identifier \"" + yytext() + "\" already in symbol table");
    }
  }

  {UnexpectedCharacter} {
     System.err.println("Error: Unexpected character: " + yytext());
    //  System.exit(1);
  }
  
  {InvalidIdentifier} {
    System.out.println("Error: invalid identifier: " + yytext());
    // System.exit(1);
  }

  {IntegerLiteral}{Identifier} {
    System.out.println("Error: invalid identifier: " + yytext());
    System.exit(1);
  }
  
  /* Literals */
  {IntegerLiteral} { System.out.println("integer: " + yytext()); }
  {StringLiteral}  { System.out.println("string: " + yytext()); }

  /* Unterminated strings */
  {UnterminatedString} { 
    System.err.println("Error: Unterminated string: " + yytext());
    System.exit(1);
  }

  /* Ignore comments and whitespace */
  {Comment}        { /* Ignore */ }
  {WhiteSpace}     { /* Ignore */ }
}

/* Fallback for unexpected characters */
[^]                { 
  System.err.println("Error");
  System.exit(1);
}
