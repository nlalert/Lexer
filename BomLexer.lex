%%
%public
%class TermProjectLexer
%standalone

%{
  java.util.HashSet<String> identifiers = new java.util.HashSet<>();
%}

/* Definitions */

/* Line terminators */
LineTerminator     = \r|\n|\r\n

/* Escape sequences within strings */
EscapeSequence     = "\\"["btnrf\'\"\\"]

/* Characters allowed inside strings */
InputCharacter     = [^\\\"\n\r] | {EscapeSequence}

/* Whitespace characters to ignore */
WhiteSpace         = {LineTerminator} | [ \t\f]

/* Comments */
/* Traditional (multi-line) comments */
TraditionalComment = "/*"([^*]|\*+[^*/])*\*+"/"

/* End-of-line (single-line) comments */
EndOfLineComment   = "//".*

/* Combined comment rule */
Comment            = {TraditionalComment} | {EndOfLineComment}

/* Operators: multi-character first */
Operator           = "==" | ">=" | "<=" | "++" | "--" | "+" | "-" | "*" | "/" | "=" | ">" | "<"

/* Parentheses */
LeftParenthesis    = "("
RightParenthesis   = ")"

/* Semicolon */
Semicolon          = ";"

/* Keywords */
Keyword            = "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"

/* Integer literals (including leading zeros) */
IntegerLiteral     = [0-9]+

/* Identifiers: start with letter, followed by letters or digits */
Identifier         = [a-zA-Z][a-zA-Z0-9]*
/* Invalid Identifiers: start with a digit followed by letters/digits, or contain non-alphanum characters */
InvalidIdentifier  = [^a-zA-Z\s\(\)][a-zA-Z0-9]+ | [a-zA-Z][a-zA-Z0-9]*[^a-zA-Z0-9\s\(\)\+\-\*\=\/\<\>\";][a-zA-Z0-9]*

/* String literals */
StringLiteral      = \"{InputCharacter}*\"

/* Unterminated string literals */
UnterminatedString = \"{InputCharacter}*

%%

<YYINITIAL> {

/* Ignore whitespace and comments */
{WhiteSpace}          { /* Ignore */ }
{Comment}             { /* Ignore */ }

/* Operators */
{Operator}            { System.out.println("operator: " + yytext()); }

/* Parentheses and Semicolon */
{LeftParenthesis}     { System.out.println("left parenthesis: " + yytext()); }
{RightParenthesis}    { System.out.println("right parenthesis: " + yytext()); }
{Semicolon}           { System.out.println("semicolon: " + yytext()); }

/* Keywords */
{Keyword}             { System.out.println("keyword: " + yytext()); }

/* Integer Literals */
{IntegerLiteral}      { System.out.println("integer: " + yytext()); }

/* Identifiers */
{Identifier}          {
                        if (identifiers.add(yytext())) {
                          System.out.println("new identifier: " + yytext());
                        } else {
                          System.out.println("identifier \"" + yytext() + "\" already in symbol table");
                        }
                      }

/* Invalid Identifiers */
{InvalidIdentifier}   {
                        System.out.println("Error: invalid identifier: " + yytext());
                      }

/* String Literals */
{StringLiteral}       { System.out.println("string: " + yytext()); }

/* Unterminated Strings */
{UnterminatedString}  {
                        System.err.println("Error: Unterminated string: " + yytext());
                      }

/* Fallback for unexpected characters */
[^]                     {
                        System.out.println("Error: Unexpected character '" + yytext() + "'");
                      }

}