%%
%public
%class TermProjectLexer
%standalone
%unicode

%{
  /* Symbol Table */
  java.util.HashSet<String> identifiers = new java.util.HashSet<>();
%}

LineTerminator      = \r|\n|\r\n
WhiteSpace          = {LineTerminator} | [ \t\f]

/* Comments */
Comment             = {TraditionalComment} | {EndOfLineComment}
EndOfLineComment    = "//" [^\n\r]* {LineTerminator}?
TraditionalComment  = "/*" ([^*] | "*"+ [^/])* "*/"
UnterminatedComment = "/*" ([^*] | "*"+ [^/])*

/* Identifiers, Literals, and Operators */
Identifier          = [a-zA-Z0-9]+
IntegerLiteral      = [0-9]+

StringContent       = [^\\\"\n\r] | \\.
StringLiteral       = \"{StringContent}*\"
UnterminatedString  = \"{StringContent}*

Operator            = "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
LeftParenthesis     = "("
RightParenthesis    = ")"
Semicolon           = ";"

Keyword             = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"

%%

<YYINITIAL> {

  /* Keywords */
  {Keyword}             { System.out.println("keyword: " + yytext()); }

  /* Operators */
  {Operator}            { System.out.println("operator: " + yytext()); }

  /* Parenthesis and Semicolon */
  {LeftParenthesis}     { System.out.println("left parenthesis: " + yytext()); }
  {RightParenthesis}    { System.out.println("right parenthesis: " + yytext()); }
  {Semicolon}           { System.out.println("semicolon: " + yytext()); }

  /* Literals */
  {IntegerLiteral}      { System.out.println("integer: " + yytext()); }
  {StringLiteral}       { System.out.println("string: " + yytext()); }

  /* Identifiers */
  {Identifier}          {
    String text = yytext();
    if (Character.isDigit(text.charAt(0))) {
        System.err.println("Error: invalid identifier : " + text);
        System.exit(1);
    } else if (identifiers.add(text)) {
        System.out.println("new identifier: " + text);
    } else {
        System.out.println("identifier \"" + text + "\" already in symbol table");
    }
  }

  /* Unterminated strings */
  {UnterminatedString}  { 
    System.err.println("Error: Unterminated string: " + yytext());
    System.exit(1);
  }

  /* Ignore comments and whitespace */
  {WhiteSpace}          { /* Ignore */ }
  {Comment}             { /* Ignore */ }

  /* Unterminated comment */
  {UnterminatedComment} {
    String text = yytext().split("[\r\n]+")[0];
    System.err.println("Error: Unterminated comment: " + text);
    System.exit(1);
  }
}

/* Fallback for unexpected characters */
[^]                { 
  System.err.println("Error: Unexpected character '" + yytext() + "'");
  System.exit(1);
}
