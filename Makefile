CC   := clang
LEX  := flex
YACC := bison

LEXFLAGS := --yylineno

all: calc

calc: parse.o lexer.o
	$(CC) -o $@ $?

lexer.c: lex.l
	$(LEX) $(LEXFLAGS) -o $@ $?

parse.c: cal.y
	$(YACC) $(YACCFLAGS) -o $@ $?

lexer.o: lexer.c
parse.o: parse.c

.PHONY: clean all

clean:
	$(RM) *.c *.o calc
