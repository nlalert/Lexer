input ?= input.txt
output ?= output.txt
lexer ?= KiwiLexer.lex

generate:
	jflex $(lexer)
	javac TermProjectLexer.java

run: generate
	java TermProjectLexer $(input) > $(output)
	rm TermProjectLexer.java~

test:
	python3 test.py

clean:
	rm TermProjectLexer.java
	rm TermProjectLexer.java~
	rm *.class