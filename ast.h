#ifndef _AST_H_
#define _AST_H_

#include <list>
#include <string>

using namespace std;


class Expr;
class InitDeclarator;
class Variables;




typedef list<Expr *> exprlist; 
typedef list<Expr *> InitializerElementList;
typedef list<Expr *> VariablesList;

class Expr{
    public:
       virtual float evaluate() = 0;

};


class Variables: public Expr{
    public:
        Variables(string id, Expr * val){
            this->id = id;
            this->val = val;
        }
        string id;
        Expr * val;
        float evaluate();
};


class Initializer: public Expr{
    public:
        Initializer(Expr * expressions){
            this->expression = expression;
        }
        Expr * expression;
        float evaluate();
};


class BinaryExpr: public Expr{
    public:
        BinaryExpr(Expr * expr1, Expr *  expr2){
            this->expr1 = expr1;
            this->expr2 = expr2;  
        }
        Expr *  expr1;
        Expr *  expr2;
};


class assignar:public Expr{
    public:
        assignar(string name,Expr * expr2){
            this->name = name;
         this->expr2 = expr2;   
        }
        string name;
        Expr* expr2;
        float evaluate();
};


class AddExpr : public BinaryExpr{
    public:
        AddExpr(Expr * expr1, Expr *  expr2): BinaryExpr(expr1, expr2)
        {

        }
        float evaluate();
};

class SubExpr : public BinaryExpr{
    public:
        SubExpr(Expr * expr1, Expr *  expr2): BinaryExpr(expr1, expr2)
        {

        }
        float evaluate();
};

class MulExpr : public BinaryExpr{
    public:
        MulExpr(Expr * expr1, Expr *  expr2): BinaryExpr(expr1, expr2)
        {

        }
        float evaluate();
};

class DivExpr : public BinaryExpr{
    public:
        DivExpr(Expr * expr1, Expr *  expr2): BinaryExpr(expr1, expr2)
        {

        }
        float evaluate();
};



class NumExpr: public Expr{
    public: 
        NumExpr(float number){
            this->number = number;
        }
        float number; 
        float evaluate();

};

class GTExpr: public BinaryExpr{
    public:
        GTExpr(Expr * expr1, Expr * expr2): BinaryExpr(expr1, expr2){}
        float evaluate();
};

class LTExpr: public BinaryExpr{
    public:
        LTExpr(Expr * expr1, Expr * expr2): BinaryExpr(expr1, expr2){}
        float evaluate();
};




#endif