type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod

type unary_op = Not | Neg

type typ = 
	| Float
	| Int
	| Str 
	| Void

type bind = typ * string

type expr = 
	| Literal of int 
	| Number of float
	| String of string 
	| Binop of expr * op * expr 
	| Unop of unary_op * expr 
	| Noexpr	
	| Assign of string * expr 
	| Array of expr list * typ
	| Construct of string * expr
	| Call of string * expr list

type stmt = 
	| Block of stmt list
	| Expr of expr
	| Return of expr
	| If of expr * stmt * stmt
	| While of expr * stmt

type func_dec = {
	fname	:	string;
	ftype	: 	type;
	formal	:	bind list;
	locals	:	bind list;
	body	:	stmt list;
}

type program = bind list * func_dec list




