type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod

type unary_op = Not | Neg

type typ = 
	  Int
	| Float
	| Char
	| String
	| Void (* For internal use *)
	| Array of int * typ (*first expr is the size of the array*)
	| Shape of string
and
   expr = 
	  Int_literal of int 
	| Float_literal of float
	| Char_literal of char 
	| String_literal of string
	| Array_literal of int * expr list
	| Binop of expr * op * expr 
	| Unop of unary_op * expr 
	| Noexpr	
	| Assign of lvalue * expr 
	| Call of string * expr list 
	| Lval of lvalue
	| Inst_shape of string * expr list
	| Shape_fn of string * string * expr list 
and
	lvalue = 
	  Id of string
	| Access of string * expr
	| Shape_var of string * string

type bind = typ * string

type stmt = 
	  Block of stmt list
	| Expr of expr
	(* | VDecl of bind * expr *)
	| Return of expr
	| If of expr * stmt
	| While of expr * stmt

type func_dec = {
	fname	:	string;
	ftype	: 	typ;
	formals	:	bind list;
	locals	:	bind list;
	body	:	stmt list;
}

type shape_dec = {
	sname		:	string;
	pname		: 	string option; (*parent name*)
	member_vs	:	bind list;
	construct	:	func_dec;
	draw		:	func_dec;
	member_fs	:	func_dec list;
}

type program = bind list * shape_dec list * func_dec list

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

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let rec string_of_expr = function
    Int_literal(l) -> string_of_int l
  | Float_literal(l) -> string_of_float l
  | Char_literal(l) -> Char.escaped l
  | String_literal(l) -> l
  | Array_literal(len, l) -> string_of_int len ^ ": [" ^ String.concat ", " (List.map string_of_expr l) ^ "]"
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(l, e) -> (string_of_lvalue l) ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Inst_shape(s, el) -> "shape " ^ s ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Shape_fn(s, f, el) ->
      s ^ "." ^ f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | Lval(l) -> string_of_lvalue l
 
 and

string_of_lvalue = function
  Id(s) -> s
| Access(id, idx) -> id ^ "[" ^ string_of_expr idx ^ "]"
| Shape_var(s, v) -> s ^ "." ^ v

and string_of_typ = function
    Int -> "int"
  | Float -> "float"
  | Char -> "char"
  | Void -> "void"
  | String -> "string"
  | Array(l,t) -> string_of_typ t ^ " [" ^ string_of_int l ^ "]"
  | Shape(s) -> "Shape " ^ s

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  (* | VDecl(id, expr) -> string_of_typ (fst id) ^ " " ^ snd id ^ ": " ^ string_of_expr expr *)
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.ftype ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_sdecl sdecl =
  "Shape " ^ sdecl.sname ^ "(" ^ String.concat ", " (List.map snd sdecl.construct.formals) ^
  ")\n Member Variables: " ^ String.concat "" (List.map string_of_vdecl sdecl.member_vs) ^ 
  "\n Draw: " ^ string_of_fdecl sdecl.draw ^ 
  "\n Member functions: " ^ String.concat "" (List.map string_of_fdecl sdecl.member_fs)

let string_of_program (vars, shapes, funcs) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_sdecl shapes) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
