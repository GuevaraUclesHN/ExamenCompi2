%option noyywrap
%option yylineno
%option caseless

%{
    #include <stdio.h>
    #include "tokens.h"
%}

DIGIT [0-9]

%%

[\t \r \n] { /* nada */ }
"+" { return ADD; }
"=" { return '='; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }
";" { return ';'; }
">" { return '>'; }
"<" { return '<'; }
"let" { return LET; }
"while" { return WHILE; }
"do" { return DO; }
"done" { return DONE; }
{DIGIT}+"."{DIGIT}+ {yylval.float_t= atof(yytext); return (NUMBER);}
{DIGIT}+ {yylval.float_t = atof(yytext); return (NUMBER);}
[a-zA-Z]({DIGIT}|[a-zA-Z_0-9]|_)* { yylval.string_t = strdup(yytext); return IDEN; }
. { printf("invalido %c\n", yytext[0]); }
%%