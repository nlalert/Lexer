INPUT ?= input.txt

all: run

run: build
	@javac Main.java
	@java Main $(INPUT) || true

build:
	@jflex -q MyLexer.flex

clean:
	@rm -f *.java~ *.class
