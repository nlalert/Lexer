# Term Report Lexer
Define lexical specifications for JFlex to generate a lexer for us.

## To Build `TermProjectLexer.java`
You must have [JFlex](https://jflex.de/) installed on your machine.
Then use this command to send flex file be read by JFlex to generate Java code.
```sh
jflex <file_name>
```

In my case:
```sh
jflex KiwiLexer.lex
```

## To Run
```sh
java TermProjectLexer.java <input_file>
```

### Using `Makefile`
You must have `make` installed on your machine (I'm sorry Windows fellas, it might be more complicated on your OS).

This command reads `input.txt` then writes to `output.txt`:
```sh
make run
```

Example with arguments
```sh
make run input=test.txt lexer=JohnLexer.lex
```