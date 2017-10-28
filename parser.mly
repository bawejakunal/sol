/* Ocamlyacc parser for SOL */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE LSQAURE RSQUARE COMMA
%token PLUS MINUS TIMES DIVIDE MODULO ASSIGN NOT
%token EQ NEQ LT LEQ GT GEQ AND OR
%token RETURN IF WHILE INT FLOAT CHAR STRING FUNC
/*%token SHAPE PARENT EXTENDS CONSTRUCT MAIN CONSOLEPRINT LENGTH SETFRAMERATE 
%token DRAW DRAWCURVE DRAWPOINT PRINT
%token TRANSLATE ROTATE RENDER WAIT*/
%token <int> INT_LITERAL
%token <float> FLOAT_LITERAL
%token <char> CHAR_LITERAL
%token <string> STRING_LITERAL
%token <string> ID
%token EOF

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MODULO
%right NOT NEG /* Have to add in parentheses */

%start program
%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [], [](*, [] *)}
 | decls vdecl { let (v, f, s) = $1 in ($2 :: v), f(*, s *)}
 | decls fdecl { let (v, f, s) = $1 in v, ($2 :: f)(*, s *)}
 /*| decls sdecl { let (v, f, s) = $1 in v, f, ($2 :: s) }*/

fdecl:
   FUNC typ ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { typ = $2;
	 fname = $3;
	 formals = $5;
	 locals = List.rev $8;
	 body = List.rev $9 } }
 | FUNC ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE /* Handling case for empty return type */
     { { typ = Void;
   fname = $2;
   formals = $4;
   locals = List.rev $7;
   body = List.rev $8 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    typ ID                   { [($1,$2)] }
  | typ LSQUARE RSQUARE ID   { [($3,$6)] }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }
  | formal_list COMMA typ LSQUARE RSQUARE ID { ($3,$6) :: $1 } (*TODO*)


typ:
    INT { Int }
  | FLOAT { Float }
  | CHAR { Char }
  | typ LSQUARE INT RSQUARE { Array ($3, $1)}
  /* Not adding in Void here*/

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
   typ ID SEMI { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr $1 }
  | RETURN SEMI { Return Noexpr }
  | RETURN expr SEMI { Return $2 }
  | LBRACE stmt_list RBRACE { Block(List.rev $2) }
  | IF LPAREN expr RPAREN stmt { If($3, $5) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }

/*expr_opt:*/
    /* nothing */ /*{ Noexpr }
  | expr          { $1 }*/
/* Removed because only usage was for FOR statements */

array_expr:
    expr    { [$1] }
  | array_expr COMMA expr { $3 :: $1 }

expr:
    INT_LITERAL          { Int_literal($1) }
  | FLOAT_LITERAL          { Float_literal($1) }
  | CHAR_LITERAL          { Char_literal($1) }
  | STRING_LITERAL          { Array_literal(Char, $1) }
  | LSQUARE array_expr RSQUARE        { Array_literal(Void, List.rev $2) }
  | ID               { Id($1) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
  | expr MODULO expr { Binop($1, Modulo,   $3) }
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }
  | MINUS expr %prec NEG { Unop(Neg, $2) }
  | NOT expr         { Unop(Not, $2) }
  | ID ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | LPAREN expr RPAREN { $2 }
  /* TODO: Include expression for typecasting */

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }