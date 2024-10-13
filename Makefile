INPUT ?= input.txt

all: run

run: TermProjectLexer.class Main.class
	@java Main $(INPUT) || true

Main.class: Main.java
	@javac Main.java

TermProjectLexer.class: MyLexer.flex
	@jflex -q MyLexer.flex
	@javac TermProjectLexer.java

clean:
	@rm -f *.java~ *.class
