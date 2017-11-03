(* Semantic checking for the SOL compiler *)

open Ast

module StringMap = Map.Make(String)

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
  let check_assign lvaluet rvaluet context err =
     match context with
       "Call" -> (let types = (lvaluet, rvaluet) in match types with
         | (Array(_, t1), Array(_, t2)) -> if t1 == t2 then lvaluet else raise err
         | _ -> if lvaluet == rvaluet then lvaluet else raise err)
       | "Assign" -> (let types = (lvaluet, rvaluet) in match types with
         | (Array(l1, t1), Array(l2, t2)) -> if t1 == t2 && l1 == l2 then lvaluet else raise err
         | _ -> if lvaluet == rvaluet then lvaluet else raise err)
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
     { typ = Void; fname = "consolePrint"; formals = [(String, "x")];
       locals = []; body = [] } (StringMap.add "intToFloat"
     { typ = Float; fname = "intToFloat"; formals = [(Int, "x")];
       locals = []; body = [] } (StringMap.add "floatToInt"
     { typ = Int; fname = "floatToInt"; formals = [(Float, "x")];
       locals = []; body = [] } (StringMap.add "intToString"
     { typ = String; fname = "intToString"; formals = [(Int, "x")];
       locals = []; body = [] } (StringMap.add "floatToString"
     { typ = String; fname = "floatToString"; formals = [(Float, "x")];
       locals = []; body = [] } (StringMap.add "charToString"
     { typ = String; fname = "charToString"; formals = [(Char, "x")];
       locals = []; body = [] } (StringMap.add "length"
     { typ = Int; fname = "length"; formals = [(Array(Int_literal(0), Void), "x")];
       locals = []; body = [] } (StringMap.singleton "setFramerate"
     { typ = Void; fname = "setFramerate"; formals = [(Float, "x")];
       locals = []; body = [] })))))))
  in
     
  let function_decls = List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
                         built_in_decls functions
  in

  let function_decl s = try StringMap.find s function_decls
       with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  let _ = function_decl "main" in (* Ensure "main" is defined *)

  let check_function func =

    List.iter (check_not_void (fun n -> "illegal void formal " ^ n ^
      " in " ^ func.fname)) func.formals;

    report_duplicate (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);

    List.iter (check_not_void (fun n -> "illegal void local " ^ n ^
      " in " ^ func.fname)) func.locals;

    report_duplicate (fun n -> "duplicate local " ^ n ^ " in " ^ func.fname)
      (List.map snd func.locals);

    (* Type of each variable (global, formal, or local *)
    let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m)
	StringMap.empty (globals @ func.formals @ func.locals )
    in

    let type_of_identifier s =
      try StringMap.find s symbols
      with Not_found -> raise (Failure ("undeclared identifier " ^ s))
    in

    (* Return the type of an expression or throw an exception *)
    let rec expr = function
	      Int_literal _ -> Int
      | Float_literal _ -> Float
      | Char_literal _ -> Char
      | String_literal _ -> String
      | Array_literal(l, s) -> let prim_type = List.fold_left (fun t1 e -> let t2 = expr e in 
          if t1 == t2 then t1 
          else raise (Failure("Elements of differing types found in array " ^ string_of_expr (Array_literal(l, s)) ^ ": " ^ 
            string_of_typ t1 ^ ", " ^ string_of_typ t2))) 
        (expr (List.hd (s))) (List.tl s) in 
        Array(Int_literal(List.length s), prim_type)
      | Id s -> let t = type_of_identifier s in 
        (match t with
          Array(l, t) -> if expr l == Int then t else raise(Failure("Array size should be an integer expression"))
        | _ -> t)
      | Access(id, idx) -> let t = type_of_identifier id and t_ix = expr idx in 
          let eval_type = function
            Array(_, a_t) -> if t_ix == Int (* Cannot check if index is within array bounds because the value cannot be evaluated at this stage *)
              then a_t
              else raise (Failure("Improper array element access: ID " ^ id ^ ", index " ^ 
                string_of_expr idx))
            | _ -> raise (Failure(id ^ "is not an array type"))
          in eval_type t
      | Binop(e1, op, e2) as e -> let t1 = expr e1 and t2 = expr e2 in
	(match op with
    Add | Sub | Mult | Div | Mod when t1 = Int && t2 = Int -> Int
  | Add | Sub | Mult | Div | Mod when t1 = Float && t2 = Float -> Float
	| Equal | Neq when t1 = t2 -> Int
	| Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Int
  | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Int
	| And | Or when t1 = Int && t2 = Int -> Int
  | _ -> raise (Failure ("illegal binary operator " ^
              string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
              string_of_typ t2 ^ " in " ^ string_of_expr e))
        )
      | Unop(op, e) as ex -> let t = expr e in
	 (match op with
	   Neg when t = Int -> Int
   | Neg when t = Float -> Float
	 | Not when t = Int -> Int
   | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
	  		   string_of_typ t ^ " in " ^ string_of_expr ex))
        )
      | Noexpr -> Void
      | Assign(var, e) as ex -> let lt = type_of_identifier var
                                and rt = expr e in
        (match lt with 
        (* Check that the array size is specified by an integer-type expression *)
            Array(l, _) -> if expr l == Int then
                check_assign lt rt "Assign" (Failure ("illegal assignment " ^ string_of_typ lt ^
				         " = " ^ string_of_typ rt ^ " in " ^ 
				         string_of_expr ex))
              else raise(Failure("Array size should be an integer expression"))
          | _ -> check_assign lt rt "Assign" (Failure ("illegal assignment " ^ string_of_typ lt ^
            " = " ^ string_of_typ rt ^ " in " ^ 
            string_of_expr ex)))
      | Call(fname, actuals) as call -> let fd = function_decl fname in
         if List.length actuals != List.length fd.formals then
           raise (Failure ("expecting " ^ string_of_int
             (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
         else (* TODO: Add special case for checking type of actual array vs formal array *)
           List.iter2 (fun (ft, _) e -> let et = expr e in
              ignore (check_assign ft et "Call"
                (Failure ("illegal actual argument found " ^ string_of_typ et ^
                " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
             fd.formals actuals;
           fd.typ
    in

    let check_bool_expr e = if expr e != Int
     then raise (Failure ("expected Int expression (that evaluates to 0 or 1) in " ^ string_of_expr e))
     else () in

    (* Verify a statement or throw an exception *)
    let rec stmt = function
	Block sl -> let rec check_block = function
           [Return _ as s] -> stmt s
         | Return _ :: _ -> raise (Failure "nothing may follow a return")
         | Block sl :: ss -> check_block (sl @ ss)
         | s :: ss -> stmt s ; check_block ss
         | [] -> ()
        in check_block sl
      | Expr e -> ignore (expr e)
      | Return e -> let t = expr e in if t = func.typ then () else
         raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
                         string_of_typ func.typ ^ " in " ^ string_of_expr e))
           
      | If(p, b1) -> check_bool_expr p; stmt b1
      | While(p, s) -> check_bool_expr p; stmt s
    in

    stmt (Block func.body)
   
  in
  List.iter check_function functions