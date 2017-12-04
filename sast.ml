open Ast

type sop = IAdd | ISub | IMult | IDiv | IEqual | INeq | ILess | ILeq | IGreater | IGeq | IAnd | IOr | IMod (*| Dot*)
(* I = integer, may add floats, strings *)

type sunary_op = INot | INeg

type sexpr_detail =
      SInt_literal of int
    | SFloat_literal of float
    | SChar_literal of char
    | SString_literal of string
    | SArray_literal of int * sexpr list
    | SId of string         (* VDecl ? of bind * expr *)
    | SBinop of sexpr * sop * sexpr
    | SUnop of sunary_op * sexpr
    | SNoexpr    
    | SAssign of string * sexpr
    | SCall of sfunc_dec * sexpr list
    | SAccess of string * sexpr

and sexpr = sexpr_detail * typ

and stmt_detail =
      SBlock of stmt_detail list
    | SExpr of sexpr
    (* | SVDecl of bind * sexpr *)
    | SReturn of sexpr
    | SIf of sexpr * stmt_detail
    | SWhile of sexpr * stmt_detail

and sfunc_dec = {
    sfname    :    string;
    styp    :     typ;
    sformals    :    bind list;
    slocals    :    bind list;
    sbody    :    stmt_detail list;
}

type sprogram = bind list * sfunc_dec list(* * shape_dec list*)

(* Pretty-printing functions *)

let string_of_sop = function
   IAdd -> "+"
 | ISub -> "-"
 | IMult -> "*"
 | IDiv -> "/"
 | IMod -> "%"
 | IEqual -> "=="
 | INeq -> "!="
 | ILess -> "<"
 | ILeq -> "<="
 | IGreater -> ">"
 | IGeq -> ">="
 | IAnd -> "&&"
 | IOr -> "||"
 (*| Dot -> "."*)

let string_of_suop = function
   INeg -> "-"
 | INot -> "!"

let rec string_of_sexpr (s: sexpr) = match fst s with
   SInt_literal(l) -> string_of_int l
 | SFloat_literal(l) -> string_of_float l
 | SChar_literal(l) -> Char.escaped l
 | SString_literal(l) -> l
 | SArray_literal(len, l) -> string_of_int len ^ ": [" ^ String.concat ", " (List.map string_of_sexpr l) ^ "]"
 | SId(s) -> s
 | SBinop(e1, o, e2) ->
     string_of_sexpr e1 ^ " " ^ string_of_sop o ^ " " ^ string_of_sexpr e2
 | SUnop(o, e) -> string_of_suop o ^ string_of_sexpr e
 | SAssign(v, e) -> v ^ " = " ^ string_of_sexpr e
 | SCall(f, el) ->
     string_of_sfdecl f ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
 | SNoexpr -> ""
 | SAccess(id, idx) -> id ^ ".[" ^ string_of_sexpr idx ^ "]"

and string_of_sstmt = function
   SBlock(stmts) ->
     "{\n" ^ String.concat "" (List.map string_of_sstmt stmts) ^ "}\n"
 | SExpr(expr) -> string_of_sexpr expr ^ ";\n";
 (* | SVDecl(id, expr) -> string_of_typ (fst id) ^ " " ^ snd id ^ ": " ^ string_of_sexpr expr *)
 | SReturn(expr) -> "return " ^ string_of_sexpr expr ^ ";\n";
 | SIf(e, s) -> "if (" ^ string_of_sexpr e ^ ")\n" ^ string_of_sstmt s
 | SWhile(e, s) -> "while (" ^ string_of_sexpr e ^ ") " ^ string_of_sstmt s

and string_of_svdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

and string_of_sfdecl fdecl =
 string_of_typ fdecl.styp ^ " " ^
 fdecl.sfname ^ "(" ^ String.concat ", " (List.map snd fdecl.sformals) ^
 ")\n{\n" ^
 String.concat "" (List.map string_of_svdecl fdecl.slocals) ^
 String.concat "" (List.map string_of_sstmt fdecl.sbody) ^
 "}\n"

let string_of_sprogram (vars, funcs) =
 String.concat "" (List.map string_of_svdecl vars) ^ "\n" ^
 String.concat "\n" (List.map string_of_sfdecl funcs)