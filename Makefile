INPUT ?= input.txt

all: run

run: TermProjectLexer.java Main.class
	@java Main $(INPUT) || true

Main.class: Main.java
	@javac Main.java

TermProjectLexer.java: MyLexer.flex
	@jflex -q MyLexer.flex

clean:
	@rm -f *.java~ *.class
