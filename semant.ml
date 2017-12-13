(* Semantic checking for the SOL compiler *)

open Ast
open Sast

module StringMap = Map.Make(String)

type symbol_table = {
  parent: symbol_table option;
  mutable
  variables: bind list
}

type translation_environment = {
  scope: symbol_table;
}

let rec find_variable (scope: symbol_table) name = 
  try
    List.find (fun (_, s) -> s = name) scope.variables
  with Not_found -> 
    match scope.parent with
    | Some(p) -> find_variable p name
    | _ -> raise Not_found

let find_local (scope: symbol_table) name = 
  try
    let _ = List.find (fun (_, s) -> s = name) scope.variables in
      raise(Failure("Local variable already declared with name " ^ name))
  with Not_found -> ()

(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check (globals, functions) =

  (* Raise an exception if the given list has a duplicate *)
  let report_duplicate exceptf list =
    let rec helper = function
	n1 :: n2 :: _ when n1 = n2 -> raise (Failure (exceptf n1))
      | _ :: t -> helper t
      | [] -> ()
    in helper (List.sort compare list)
  in

  (* Raise an exception if a given binding is to a void type *)
  let check_not_void exceptf = function
      (Void, n) -> raise (Failure (exceptf n))
    | _ -> ()
  in
  
  (* Raise an exception of the given rvalue type cannot be assigned to
     the given lvalue type *)
  let check_assign lvaluet rvaluet err =
    let types = (lvaluet, rvaluet) in match types with
        (Array(l1, t1), Array(l2, t2)) -> if t1 == t2 && l1 == l2 then lvaluet else raise err
      | _ -> if lvaluet == rvaluet then lvaluet else raise err
  in
   
  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;
   
  report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

  (**** Checking Functions ****)

  if List.mem "consolePrint" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function consolePrint may not be defined")) else ();

  if List.mem "setFramerate" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function setFramerate may not be defined")) else ();

  if List.mem "length" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function length may not be defined")) else ();

  report_duplicate (fun n -> "duplicate function " ^ n)
    (List.map (fun fd -> fd.fname) functions);

  (* Function declaration for a named function *)
  let built_in_decls =  StringMap.add "consolePrint"
     { ftype = Void; fname = "consolePrint"; formals = [(String, "x")];
       locals = []; body = [] } (StringMap.add "intToFloat"
     { ftype = Float; fname = "intToFloat"; formals = [(Int, "x")];
       locals = []; body = [] } (StringMap.add "floatToInt"
     { ftype = Int; fname = "floatToInt"; formals = [(Float, "x")];
       locals = []; body = [] } (StringMap.add "intToString"
     { ftype = Int; fname = "intToString"; formals = [(String, "s"); (Int, "x")];
       locals = []; body = [] } (StringMap.add "floatToString"
     { ftype = Int; fname = "floatToString"; formals = [(String, "s"); (Float, "x")];
       locals = []; body = [] } (StringMap.add "charToString"
     { ftype = Int; fname = "charToString"; formals = [(String, "s"); (Char, "x")];
       locals = []; body = [] } (StringMap.singleton "setFramerate"
     { ftype = Void; fname = "setFramerate"; formals = [(Float, "x")];
       locals = []; body = [] }))))))
  in
     
  let function_decls = List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
                         built_in_decls functions
  in

  let function_decl s = try StringMap.find s function_decls
       with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  let _ = function_decl "main" in (* Ensure "main" is defined *)

  let check_function g_env func =

    List.iter (check_not_void (fun n -> "illegal void formal " ^ n ^
      " in " ^ func.fname)) func.formals;

    report_duplicate (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);

    List.iter (check_not_void (fun n -> "illegal void local " ^ n ^
      " in " ^ func.fname)) func.locals;

    report_duplicate (fun n -> "duplicate local " ^ n ^ " in " ^ func.fname)
      (List.map snd func.locals);

    (* Type of each variable (global, formal, or local *)
    (* let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m)
	StringMap.empty (globals @ func.formals @ func.locals )
    in

    let type_of_identifier s =
      try StringMap.find s symbols
      with Not_found -> raise (Failure ("undeclared identifier " ^ s))
    in *)
    let map_op tup = match tup with
        (Add, Int) -> IAdd
      | (Sub, Int) -> ISub
      | (Mult, Int) -> IMult
      | (Div, Int) -> IDiv
      | (Equal, Int) -> IEqual
      | (Neq, Int) -> INeq
      | (Less, Int) -> ILess
      | (Leq, Int) -> ILeq
      | (Greater, Int) -> IGreater
      | (Geq, Int) -> IGeq
      | (And, Int) -> IAnd
      | (Or, Int) -> IOr
      | (Mod, Int) -> IMod
      | (_, _) -> raise(Failure("Invalid operation " ^ (string_of_op (fst tup)) ^ " for type " ^ (string_of_typ (snd tup)))) in

    (* Return the type of an expression or throw an exception *)
    let rec expr env = function
	      Int_literal i -> SInt_literal(i), Int
      | Float_literal f -> SFloat_literal(f), Float
      | Char_literal c -> SChar_literal(c), Char
      | String_literal s -> SString_literal(s), String
      | Array_literal(l, s) as a -> let prim_type = List.fold_left (fun t1 e -> let t2 = snd (expr env e) in 
          if t1 == t2 then t1 
          else raise (Failure("Elements of differing types found in array " ^ string_of_expr (a) ^ ": " ^ 
            string_of_typ t1 ^ ", " ^ string_of_typ t2))) 
        (snd (expr env (List.hd (s)))) (List.tl s) in 
        (if l == List.length s then
          let s_s = List.map (fun e -> expr env e) s in
          SArray_literal(l, s_s), Array(l, prim_type)
        else raise(Failure("Something wrong with auto-assigning length to array literal " ^ string_of_expr a))) 
      | Binop(e1, op, e2) as e -> 
          let ta = expr env e1 and tb = expr env e2 
          in let _, t1 = ta and _, t2 = tb in
	(match op with
    Add | Sub | Mult | Div | Mod when t1 = Int && t2 = Int -> SBinop(ta, map_op (op, Int), tb), Int
  (*| Add | Sub | Mult | Div | Mod when t1 = Float && t2 = Float -> Float *)
	| Equal | Neq when t1 = t2 && t1 = Int -> SBinop(ta, map_op (op, Int), tb), Int
	| Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> SBinop(ta, map_op (op, Int), tb), Int
 (* | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Int*)
	| And | Or when t1 = Int && t2 = Int -> SBinop(ta, map_op (op, Int), tb), Int
  | _ -> raise (Failure ("illegal binary operator " ^
              string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
              string_of_typ t2 ^ " in " ^ string_of_expr e))
        )
      | Unop(op, e) as ex -> 
          let t1 = expr env e 
          in let _, t = t1 in
	 (match op with
	   Neg when t = Int -> SUnop(INeg, t1), Int
   (*| Neg when t = Float -> Float *)
	 | Not when t = Int -> SUnop(INot, t1), Int
   | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
	  		   string_of_typ t ^ " in " ^ string_of_expr ex))
        )
      | Noexpr -> SNoexpr, Void
      | Assign(lval, e) as ex -> 
          let (slval, lt) = lval_expr env lval and (rexpr, rt) = expr env e in          
        ignore(check_assign lt rt (Failure ("illegal assignment " ^ string_of_typ lt ^
            " = " ^ string_of_typ rt ^ " in " ^ 
            string_of_expr ex)));
        SAssign(slval, (rexpr, rt)), lt
      | Call(fname, actuals) as call -> let fd = function_decl fname in
         if List.length actuals != List.length fd.formals then
           raise (Failure ("expecting " ^ string_of_int
             (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
         else (* TODO: Add special case for checking type of actual array vs formal array *)
           List.iter2 (fun (ft, _) e -> let _, et = expr env e in
              ignore (check_assign ft et 
                (Failure ("illegal actual argument found " ^ string_of_typ et ^
                " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
             fd.formals actuals;
           let sactuals = List.map (fun a -> expr env a) actuals in
           let s_fd = {sfname = fd.fname; styp = fd.ftype; sformals = fd.formals; slocals = fd.locals; 
             sbody = []} in 
             (* Not converting the body to a list of stmt_details, to prevent recursive conversions, 
             and also because this detail is not needed when making a function call *)
           SCall(s_fd, sactuals), fd.ftype
      | Lval l -> let slval = (lval_expr env l) in
        let (slval_det, ltyp) = slval in
        SLval(slval_det), ltyp

    and lval_expr env = function
        Id s -> (try
          let (t, _) = find_variable env.scope s 
          in ((SId(s), t), t)
          with Not_found -> raise(Failure("Undeclared identifier " ^ s)))
      | Access(id, idx) -> (try 
          let (t, _) = find_variable env.scope id 
          and (idx', t_ix) = expr env idx in 
          let eval_type = function
            Array(_, a_t) -> if t_ix == Int (* Cannot check if index is within array bounds because the value cannot be evaluated at this stage *)
              then a_t
              else raise (Failure("Improper array element access: ID " ^ id ^ ", index " ^ 
                string_of_expr idx))
          | _ -> raise (Failure(id ^ "is not an array type"))
          in ((SAccess(id, (idx', t_ix)), eval_type t), eval_type t)
          with Not_found -> raise(Failure("Undeclared identifier " ^ id)))
    
    and check_bool_expr env e = (let (e', t) = (expr env e) in if t != Int (* This is not supposed to be recursive! *)
     then raise (Failure ("expected Int expression (that evaluates to 0 or 1) in " ^ string_of_expr e))
     else (e', t))

    (* Verify a statement or throw an exception *)
    and stmt env = function
	Block sl -> let rec check_block env = function
           [Return _ as s] -> [stmt env s]
         | Return _ :: _ -> raise (Failure "nothing may follow a return")
         (* | Block sl :: ss -> (check_block env sl) @ check_block env ss *) (* What were you thinking, Edwards? *)
         | s :: ss -> stmt env s :: check_block env ss
         | [] -> []
        in let scope' = {parent = Some(env.scope); variables = []}
        in let env' = {scope = scope'}
        in let sl = check_block env' sl in
        scope'.variables <- List.rev scope'.variables;
        SBlock(sl)
      | Expr e -> SExpr(expr env e)
      (* | VDecl(b, e) -> let _ = find_local env.scope (snd b) in 
          env.scope.variables <- b :: env.scope.variables;
          (* Check that the expression type is compatible with the type of the variable 
            EXCEPT when the expression is a Noexpr
          *)
          let lt = fst b in
          let e' = expr env e in
          let rt = snd (e') in let _ = (match rt with
          | Void -> lt
          | _ -> check_assign lt rt "Assign" (Failure ("illegal assignment " ^ string_of_typ lt ^
              " = " ^ string_of_typ rt ^ " in " ^ 
              string_of_expr e))) in
          SVDecl(b, e') *)
      | Return e -> let e', t = expr env e in if t = func.ftype then SReturn((e', t)) else
         raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
                         string_of_typ func.ftype ^ " in " ^ string_of_expr e))
           
      | If(p, b1) -> let e' = check_bool_expr env p in SIf(e', stmt env b1)
      | While(p, s) -> let e' = check_bool_expr env p in SWhile(e', stmt env s)
    in

    let l_scope = {parent = Some(g_env.scope); variables = func.formals @ func.locals} in
    let l_env = {scope = l_scope} in

    {sfname = func.fname; styp = func.ftype; sformals = func.formals; slocals = func.locals; 
             sbody = let sbl = stmt l_env (Block func.body) in match sbl with
             | SBlock(sl) -> sl
             | _ -> raise(Failure("This isn't supposed to happen!"))}
             
   
  in
  let g_scope = {parent = None; variables = globals} in
  let g_env = {scope = g_scope} in
  (globals, List.map (function f -> let s_f = check_function g_env f in match s_f.styp with
    | Void -> s_f
    | _ -> let last_s = List.hd (List.rev s_f.sbody) in (match last_s with
      | SReturn(_) -> s_f
      | _ -> raise(Failure("Function must have return statement of type " ^ string_of_typ s_f.styp)))
    ) functions)