(* @authors: Aditya & Gergana *)
(* SAST *)
open Ast

type sop = IAdd | ISub | IMult | IDiv | IEqual | INeq | ILess | ILeq | IGreater | IGeq | IAnd | IOr | IMod |
           FAdd | FSub | FMult | FDiv | FEqual | FNeq | FLess | FLeq | FGreater | FGeq | FMod

type sunary_op = INot | INeg | FNeg

type sexpr_detail =
      SInt_literal of int
    | SFloat_literal of float
    | SChar_literal of char
    | SString_literal of string
    | SArray_literal of int * sexpr list
    | SBinop of sexpr * sop * sexpr
    | SUnop of sunary_op * sexpr
    | SNoexpr    
    | SAssign of slvalue * sexpr
    | SCall of sfunc_dec * sexpr list
    | SLval of slvalue
    | SInst_shape of sshape_dec * sexpr list
    | SShape_fn of string * typ * sfunc_dec * sexpr list 
and 
  sexpr = sexpr_detail * typ
and 
  slvalue_detail = 
      SId of string         
    | SAccess of string * sexpr
    | SShape_var of string * slvalue
and 
  slvalue = slvalue_detail * typ 
and
  stmt_detail =
      SBlock of stmt_detail list
    | SExpr of sexpr
    | SReturn of sexpr
    | SIf of sexpr * stmt_detail
    | SWhile of sexpr * stmt_detail
    | SShape_render of string * string * int * stmt_detail list
and 
  sfunc_dec = {
    sfname    :    string;
    styp    :     typ;
    sformals    :    bind list;
    slocals    :    bind list;
    sbody    :    stmt_detail list;
}
and 
  sshape_dec = {
  ssname   : string;
  spname   :   string option;
  smember_vs : bind list;
  sconstruct : sfunc_dec;
  sdraw    : sfunc_dec;
  smember_fs : sfunc_dec list;
}

type sprogram = bind list * sshape_dec list * sfunc_dec list

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
 | FAdd -> "+"
 | FSub -> "-"
 | FMult -> "*"
 | FDiv -> "/"
 | FMod -> "%"
 | FEqual -> "=="
 | FNeq -> "!="
 | FLess -> "<"
 | FLeq -> "<="
 | FGreater -> ">"
 | FGeq -> ">="

let string_of_suop = function
   INeg -> "-"
 | INot -> "!"
 | FNeg -> "-"

let rec string_of_sexpr (s: sexpr) = match fst s with
   SInt_literal(l) -> string_of_int l
 | SFloat_literal(l) -> string_of_float l
 | SChar_literal(l) -> Char.escaped l
 | SString_literal(l) -> l
 | SArray_literal(len, l) -> string_of_int len ^ ": [" ^ String.concat ", " (List.map string_of_sexpr l) ^ "]"
 | SBinop(e1, o, e2) ->
     string_of_sexpr e1 ^ " " ^ string_of_sop o ^ " " ^ string_of_sexpr e2
 | SUnop(o, e) -> string_of_suop o ^ string_of_sexpr e
 | SAssign(l, e) -> (string_of_slvalue l) ^ " = " ^ string_of_sexpr e
 | SCall(f, el) ->
     string_of_sfdecl f ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
 | SInst_shape(s, el) -> "shape " ^ s.ssname ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
 | SShape_fn(s, styp, f, el) ->
     s ^ "(" ^ (string_of_typ styp) ^ ")." ^ string_of_sfdecl f ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
 | SNoexpr -> ""
 | SLval(l) -> string_of_slvalue l

and string_of_slvalue = function
  SId(s), _ -> s
| SAccess(id, idx), _ -> id ^ "[" ^ string_of_sexpr idx ^ "]"
| SShape_var(s, v), _ -> s ^ "." ^ (string_of_slvalue v)

and string_of_sstmt = function
   SBlock(stmts) ->
     "{\n" ^ String.concat "" (List.map string_of_sstmt stmts) ^ "}\n"
 | SExpr(expr) -> string_of_sexpr expr ^ ";\n";
 | SReturn(expr) -> "return " ^ string_of_sexpr expr ^ ";\n";
 | SIf(e, s) -> "if (" ^ string_of_sexpr e ^ ")\n" ^ string_of_sstmt s
 | SWhile(e, s) -> "while (" ^ string_of_sexpr e ^ ") " ^ string_of_sstmt s
 | SShape_render(s, sname, num_t, stmts) -> sname ^ " " ^ s ^ ".render(" ^ string_of_int(num_t) ^ "){\n" ^ 
     String.concat "" (List.map string_of_sstmt stmts) ^ "}\n"

and string_of_svdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

and string_of_sfdecl fdecl =
 string_of_typ fdecl.styp ^ " " ^
 fdecl.sfname ^ "(" ^ String.concat ", " (List.map snd fdecl.sformals) ^
 ")\n{\n" ^
 String.concat "" (List.map string_of_svdecl fdecl.slocals) ^
 String.concat "" (List.map string_of_sstmt fdecl.sbody) ^
 "}\n"

 let string_of_ssdecl sdecl =
  "Shape " ^ sdecl.ssname ^ "(" ^ String.concat ", " (List.map snd sdecl.sconstruct.sformals) ^
  ")\n Member Variables: " ^ String.concat "" (List.map string_of_svdecl sdecl.smember_vs) ^ 
  "\n Draw: " ^ string_of_sfdecl sdecl.sdraw ^ 
  "\n Member functions: " ^ String.concat "" (List.map string_of_sfdecl sdecl.smember_fs)

let string_of_sprogram (vars, shapes, funcs, _) =
 String.concat "" (List.map string_of_svdecl vars) ^ "\n" ^
 String.concat "\n" (List.map string_of_ssdecl shapes) ^ "\n" ^
 String.concat "\n" (List.map string_of_sfdecl funcs)