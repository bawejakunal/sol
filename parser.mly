/* Ocamlyacc parser for SOL */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE LSQAURE RSQUARE COMMA
%token PLUS MINUS TIMES DIVIDE MODULO ASSIGN NOT
%token EQ NEQ LT LEQ GT GEQ AND OR
%token RETURN IF WHILE INT FLOAT CHAR STRING
%token SHAPE PARENT EXTENDS FUNC CONSTRUCT MAIN CONSOLEPRINT LENGTH SETFRAMERATE 
%token DRAW DRAWCURVE DRAWPOINT PRINT
%token TRANSLATE ROTATE RENDER WAIT
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
%right NOT NEG (* Have to add in parentheses *)

%start program
%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [], [], [] }
 | decls vdecl { let (v, f, s) = $1 in ($2 :: v), f, s }
 | decls fdecl { let (v, f, s) = $1 in v, ($2 :: f), s }
 | decls sdecl { let (v, f, s) = $1 in v, f, ($2 :: s) }

fdecl:
   FUNC typ ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { ftype = $2;
	 fname = $3;
	 formals = $5;
	 locals = List.rev $8;
	 body = List.rev $9 } }
 | FUNC ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE (* Handling case for empty return type *)
     { { ftype = unit;
   fname = $2;
   formals = $4;
   locals = List.rev $7;
   body = List.rev $8 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    typ ID                   { [($1,$2)] }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }
  | formal_list COMMA typ LSQUARE RSQUARE ID { ($3,$6) :: $1 } (* TODO: Check on How to differentiate with arrays *)

typ:
    INT { Int }
  | FLOAT { Float }
  | CHAR { Char }

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
   typ ID SEMI { ($1, $2) }
 | typ LSQUARE INT RSQUARE ID SEMI { ($1, $3, $5) }

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

expr:
    LITERAL          { Literal($1) }
  | TRUE             { BoolLit(true) }
  | FALSE            { BoolLit(false) }
  | ID               { Id($1) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
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

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
