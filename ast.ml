type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod | Dot

type unary_op = Not | Neg

type typ = 
	  Int
	| Float
	| Char
	| Void (* For internal use *)
	| Array of int * typ (*first int is the size of the array*)
	(* Add in array types/shapes *)

type bind = typ * string

type expr = 
	| Int_literal of int 
	| Float_literal of float
	| Char_literal of char 
	| Array_literal of typ * expr list
	| Binop of expr * op * expr 
	| Unop of unary_op * expr 
	| Noexpr	
	| Assign of string * expr 
	| Call of string * expr list

type stmt = 
	| Block of stmt list
	| Expr of expr
	| Return of expr
	| If of expr * stmt * stmt
	| While of expr * stmt

type func_dec = {
	fname	:	string;
	typ		: 	typ;
	formals	:	bind list;
	locals	:	bind list;
	body	:	stmt list;
}

(*type draw_dec = {
	locals	:	bind_local list;
	body	:	stmt list;
}

type construct_dec = {
	formal	:	bind_formal list;
	locals	:	bind_local list;
	body	:	stmt list;
}

type shape_body = 
	| ShapeConstruct of construct_dec
	| ShapeVar of bind_local
	| ShapeFunc of func_dec

type shape_dec = {
	sname	:	string;
	pname	: 	string;
	draw	:	draw_dec;
	body	:	shape_body list;
}*)

type program = bind list * func_dec list(* * shape_dec list*)




