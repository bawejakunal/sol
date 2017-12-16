/* Ocamlyacc parser for SOL */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE LSQUARE RSQUARE COMMA
%token PLUS MINUS TIMES DIVIDE MODULO ASSIGN NOT DOT 
%token EQ NEQ LT LEQ GT GEQ AND OR
%token RETURN IF WHILE INT FLOAT CHAR STRING FUNC
%token SHAPE CONSTRUCT DRAW /*PARENT EXTENDS MAIN CONSOLEPRINT LENGTH SETFRAMERATE 
%token DRAWCURVE DRAWPOINT PRINT
%token TRANSLATE ROTATE RENDER WAIT*/
%token <int> INT_LITERAL
%token <float> FLOAT_LITERAL
%token <char> CHAR_LITERAL
%token <string> STRING_LITERAL
%token <string> ID
%token <string> SHAPE_ID
%token EOF

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MODULO
%right NOT NEG /* Have to add in parentheses */
%left DOT
%left LPAREN RPAREN LSQUARE RSQUARE

%start program
%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [], [], [] }
 | decls vdecl { let (v, s, f) = $1 in ($2 :: v), s, f }
 | decls fdecl { let (v, s, f) = $1 in v, s, ($2 :: f) }
 | decls sdecl { let (v, s, f) = $1 in v, ($2 :: s), f }

fdecl:
   FUNC ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE /* Handling case for empty return type */
     { { ftype = Void;
   fname = $2;
   formals = $4;
   locals = List.rev $7;
   body = List.rev $8 } }

 | FUNC typ ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { ftype = $2;
	 fname = $3;
	 formals = $5;
	 locals = List.rev $8;
	 body = List.rev $9 } } 

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    local_typ ID                   { [($1,$2)] }
  | formal_list COMMA local_typ ID { ($3,$4) :: $1 }

typ:
    INT { Int }
  | FLOAT { Float }
  | CHAR { Char }
  | STRING { String }
  | SHAPE_ID { Shape($1) }

/*formal_typ:
    typ {$1}
  | formal_typ LSQUARE RSQUARE { Array(0, $1) }*/
/* Removing because we do not need variable length arrays as function formal parameters */

local_typ:
    typ {$1}
  | local_typ LSQUARE INT_LITERAL RSQUARE { Array ($3, $1)}
  /* Not adding in Void here*/

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
   local_typ ID SEMI { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr $1 }
  | RETURN SEMI { Return Noexpr }
  /*| vdecl { VDecl($1, Noexpr) }
  | local_typ ID ASSIGN expr SEMI { VDecl(($1, $2), $4) }*/
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
  | STRING_LITERAL          { String_literal($1) }
  | LSQUARE array_expr RSQUARE        { Array_literal(List.length $2, List.rev $2) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
  | expr MODULO expr { Binop($1, Mod,   $3) }
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
  | lvalue ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | SHAPE SHAPE_ID LPAREN actuals_opt RPAREN { Inst_shape($2, $4) }
  | ID DOT ID LPAREN actuals_opt RPAREN { Shape_fn($1, $3, $5) }
  | LPAREN expr RPAREN { $2 }
  | lvalue  { Lval($1) }
  /* TODO: Include expression for typecasting */

lvalue:
    ID    { Id($1) }
  | ID LSQUARE expr RSQUARE     { Access($1, $3) } /*Access a specific element of an array*/
  | ID DOT ID   { Shape_var($1, $3) }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }

sdecl:
    SHAPE SHAPE_ID LBRACE vdecl_list cdecl ddecl shape_fdecl_list RBRACE
      { { sname = $2;
      pname = None;
      member_vs = List.rev $4;
      construct = $5; (* NOTE: Make this optional later *)
      draw = $6;
      member_fs = $7;
      }
    }

cdecl:
   CONSTRUCT LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { ftype = Void;
   fname = "constructor";
   formals = $3;
   locals = List.rev $6;
   body = List.rev $7 }
   }

ddecl:
   DRAW LPAREN RPAREN LBRACE vdecl_list stmt_list RBRACE
     { { ftype = Void;
   fname = "draw";
   formals = [];
   locals = List.rev $5;
   body = List.rev $6 }
   }

shape_fdecl_list:
    /* nothing */ { [] }
  | fdecl_list   { List.rev $1 }

fdecl_list:
    fdecl                   { [$1] }
  | fdecl_list fdecl { $2 :: $1 }