%{
#include <stdio.h>
#include <math.h>

extern int yylineno;

void yyerror(char *str) {
  fprintf(stderr, "Calc error: %s\n", str);
}

extern int yylex();

long ydtol(char *str) {
  printf("%s", str);
  return 1;
};

double yftod(char *str) {
  printf("%s", str);
  return 1;
};

long ybtol(char *binstr) {
  printf("%s", binstr);
  return 1;
};

long yotol(char *octstr) {
  printf("%s", octstr);
  return 1;
};

long yhtol(char *hexstr) {
  printf("%s", hexstr);
  return 1;
};
%}

%union { double flo; long num; }

%token <flo> FLOAT
%token <num> NATURE

%token PLUS MINUS TIMES DIVIDE
       MODULO POWER LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%left MODULO

%right POWER

%type <flo> dexpr
%type <num> lexpr

%type <flo> FloatCalc
%type <num> NatureCalc

%start result

%%

result:
      | NatureCalc { printf("%ld", $1); }
      | FloatCalc { printf("%f", $1); }
      ;

NatureCalc:
      lexpr PLUS lexpr { $$ = $1 + $3; }
      ;

FloatCalc:
      dexpr PLUS dexpr { $$ = $1 + $3; }
      ;

lexpr: NATURE;
dexpr: FLOAT;

%%

int main(int argc, const char *argv[]) {
  yyparse();
  return 0;
}
