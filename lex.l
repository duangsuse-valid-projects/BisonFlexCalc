%{
/* Token type identifier */
enum yytokentype {
  PLUS, MINUS, TIMES, DIVIDE,
  MODULO, POWER,
  LPAREN, RPAREN,
  NATURE, FLOAT
};

/* Lexer data token */
union YYSTYPE {
  double flo;
  long num;
};

union YYSTYPE yylval;

/* Number parser functions */
extern long ydtol(char *str);
extern double yftod(char *str);

extern long ybtol(char *binstr);
extern long yotol(char *octstr);
extern long yhtol(char *hexstr);
%}

dot \.

dg [0-9]
bg [01]
og [0-7]
hg [0-9A-Fa-f]

dec {dg}+;
bin 0b{bg}+;
oct 0o{og}+;
hex 0x{hg}+;

flo {dg}*{dot}{dg}+

%%

"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"%" return MODULO;
"^" return POWER;

"(" return LPAREN;
")" return RPAREN;

{dec} { yylval.num = ydtol(yytext); return NATURE; }
{flo} { yylval.flo = yftod(yytext); return FLOAT; }

{bin} { yylval.num = ybtol(yytext); return NATURE; }
{oct} { yylval.num = yotol(yytext); return NATURE; }
{hex} { yylval.num = yhtol(yytext); return NATURE; }

%%

int yywrap() { return 1; }
