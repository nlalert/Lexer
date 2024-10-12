input ?= input.txt
output ?= output.txt
lexer ?= KiwiLexer.lex

generate:
	jflex $(lexer)

run: generate
	java TermProjectLexer.java $(input) > $(output)
	make clean

clean:
	rm TermProjectLexer.java~