type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod (*| Dot*)

type unary_op = Not | Neg

type typ = 
	  Int
	| Float
	| Char
	| String
	| Void (* For internal use *)
	| Array of expr * typ (*first expr is the size of the array*)
	(* Add in shapes *)
and
   expr = 
	  Int_literal of int 
	| Float_literal of float
	| Char_literal of char 
	| String_literal of string
	| Array_literal of typ * expr list
	| Id of string
	| Binop of expr * op * expr 
	| Unop of unary_op * expr 
	| Noexpr	
	| Assign of string * expr 
	| Call of string * expr list 
	| Access of string * expr

type bind = typ * string

type stmt = 
	  Block of stmt list
	| Expr of expr
	| Return of expr
	| If of expr * stmt
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

(* Pretty-printing functions *)

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "&&"
  | Or -> "||"
  (*| Dot -> "."*)

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let rec string_of_expr = function
    Int_literal(l) -> string_of_int l
  | Float_literal(l) -> string_of_float l
  | Char_literal(l) -> Char.escaped l
  | String_literal(l) -> l
  | Array_literal(t, l) -> string_of_typ t ^ ": [" ^ String.concat ", " (List.map string_of_expr l) ^ "]"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | Access(id, idx) -> id ^ ".[" ^ string_of_expr idx ^ "]"
 
 and

string_of_typ = function
    Int -> "int"
  | Float -> "float"
  | Char -> "char"
  | Void -> "void"
  | String -> "string"
  | Array(s,t) -> string_of_typ t ^ " [" ^ string_of_expr s ^ "]"

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (vars, funcs) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
