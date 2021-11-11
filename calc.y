%code requires{
    #include "ast.h"
}

%{

    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

    #define YYERROR_VERBOSE 1
%}

%union{
    const char * string_t;
    int int_t;
    float float_t;
    Expr * expr_t;
    exprlist * expr_list;
    Initializer * Initializer_t;
    InitializerElementList * Initializer_list_t;
    Variables * Variables_t;
}

%token EOL
%token ADD SUB MUL DIV WHILE DO DONE ELSE LET
%token<string_t> IDEN
%token<float_t> NUMBER

%type<expr_t> expr factor term rel assigExpression Variables Initializer
%type<expr_list> exprlist variableslist imput
%%

START: imput
{
    list<Expr *>::iterator it = $1->begin();
    while(it != $1->end()){
        printf("resultado: %f \n", (*it)->evaluate());
        it++;
    }
}
    | exprlist imput
    ;


exprlist: variableslist{ $$ = new exprlist; }
    | exprlist variableslist { $$ = $1;}


variableslist: Variables {$$ = new exprlist; $$->push_back($1);}
    ;

Variables: LET IDEN '=' Initializer { $$ = new Variables($2, $4); }
    | LET IDEN { $$ = new Variables($2, NULL); }
    | assigExpression
    ;

Initializer: assigExpression {
    InitializerElementList * list = new InitializerElementList;
    list->push_back($1);
    $$ = new Initializer($1);
}
    ;

assigExpression: rel;

imput: rel  { $$ = new exprlist; $$->push_back($1); }
    | imput rel  { $$ = $1; $$->push_back($2); }
    ;

rel: rel '>' expr { $$ = new GTExpr($1, $3); }
    | rel '<' expr { $$ = new LTExpr($1, $3); }
    | expr { $$ = $1; }
    ;

expr: expr ADD factor { $$ = new AddExpr($1, $3); }
    | expr SUB factor { $$ = new SubExpr($1, $3); }
    | factor { $$ = $1; }
    ;

factor: factor MUL term { $$ = new MulExpr($1, $3); }
    | factor DIV term { $$ = new DivExpr($1, $3); }
    | term { $$ = $1; }
    ;

term: NUMBER { $$ = new NumExpr($1); }
    ;

%%
