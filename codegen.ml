(* Code generation: translate takes a semantically checked AST and
produces LLVM IR

LLVM tutorial: Make sure to read the OCaml version of the tutorial

http://llvm.org/docs/tutorial/index.html

Detailed documentation on the OCaml LLVM library:

http://llvm.moe/
http://llvm.moe/ocaml/

*)

module L = Llvm
module A = Ast
module S = Sast

module StringMap = Map.Make(String)

let translate (globals, functions) =
  let context = L.global_context () in
  let the_module = L.create_module context "SOL"
  and i32_t  = L.i32_type   context
  and f32_t  = L.double_type context
  and i8_t   = L.i8_type    context
  and void_t = L.void_type  context in

  let rec ltype_of_typ = function
      A.Int -> i32_t
    | A.Float -> f32_t
    | A.Char -> i8_t
    | A.String -> L.pointer_type i8_t
    | A.Void -> void_t
    | A.Array(l, t) -> L.array_type (ltype_of_typ t) l 
    in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in

  (* Declare printf(), which the consolePrint built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Declare the built-in startSDL(), which initializes the SDL environment *)
  let startSDL_t = L.var_arg_function_type i32_t [| |] in
  let startSDL_func = L.declare_function "startSDL" startSDL_t the_module in

  (* Declare the built-in runSDL(), which initializes the SDL environment *)
  let runSDL_t = L.var_arg_function_type i32_t [| |] in
  let runSDL_func = L.declare_function "runSDL" runSDL_t the_module in

  (* (* Declare the built-in intToFloat() function *)
  let intToFloat_t = L.function_type f32_t [|i32_t|] in
  let intToFloat_func = L.declare_function "intToFloat" intToFloat_t the_module in

  (* Declare the built-in floatToInt() function *)
  let floatToInt_t = L.function_type i32_t [|f32_t|] in
  let floatToInt_func = L.declare_function "floatToInt" floatToInt_t the_module in *)

  (* Declare the built-in intToString() function *)
  let sprintf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t; L.pointer_type i8_t |] in
  let sprintf_func = L.declare_function "sprintf" sprintf_t the_module in
  (* (* Declare the built-in floatToString() function *)
  let floatToString_t = L.function_type (L.pointer_type i8_t) [|f32_t|] in
  let floatToString_func = L.declare_function "floatToString" floatToString_t the_module in
  (* Declare the built-in charToString() function *)
  let charToString_t = L.function_type (L.pointer_type i8_t) [|i8_t|] in
  let charToString_func = L.declare_function "charToString" charToString_t the_module in

  (* Declare the built-in length() function *)
  let length_t = L.function_type i32_t [|L.struct_type context [|L.pointer_type i32_t; i32_t|]|] in
  let length_func = L.declare_function "length" length_t the_module in

  (* Declare the built-in setFramerate() function *)
  let setFramerate_t = L.function_type void_t [|f32_t|] in
  let setFramerate_func = L.declare_function "setFramerate" setFramerate_t the_module in *)

  (* Define each function (arguments and return type) so we can call it *)
  let function_decls =
    let function_decl m sfdecl =
      let name = sfdecl.S.sfname
      and formal_types =
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) sfdecl.S.sformals)
      in let ftype = (match name with
          "main" -> L.function_type i32_t formal_types
        | _ -> L.function_type (ltype_of_typ sfdecl.S.styp) formal_types) in
      StringMap.add name (L.define_function name ftype the_module, sfdecl) m in
    List.fold_left function_decl StringMap.empty functions in
  
  (* Fill in the body of the given function *)
  let build_function_body sfdecl =
    (* ignore(print_string sfdecl.S.sfname); *)
    let (the_function, _) = StringMap.find sfdecl.S.sfname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    (* SPECIAL CASE: For the main(), add in a call to the initalization of the SDL window *)
    let _ = match sfdecl.S.sfname with
        "main" -> ignore(L.build_call startSDL_func [|  |] "startSDL" builder) 
      | _ -> () in
    (* TODO: Consider storing the returned value somewhere, return that as an error *)
    
    let string_format_str = L.build_global_stringptr "%s\n" "fmt" builder in
    let int_format_str = L.build_global_stringptr "%d" "int_fmt" builder in
    let float_format_str = L.build_global_stringptr "%f" "flt_fmt" builder in
    let char_format_str = L.build_global_stringptr "%c" "char_fmt" builder in
    let const_zero = L.const_int i32_t 0 in
    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = L.set_value_name n p;
	let local = L.build_alloca (ltype_of_typ t) n builder in
	ignore (L.build_store p local builder);
	StringMap.add n local m in

      let add_local m (t, n) =
	let local_var = L.build_alloca (ltype_of_typ t) n builder
	in StringMap.add n local_var m in

      let formals = List.fold_left2 add_formal StringMap.empty sfdecl.S.sformals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals sfdecl.S.slocals in

    (* Return the value for a variable or formal argument *)
    let lookup n = try StringMap.find n local_vars
                   with Not_found -> StringMap.find n global_vars
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder = function
	      S.SInt_literal(i), _ -> L.const_int i32_t i
      | S.SFloat_literal(f), _ -> L.const_float f32_t f
      | S.SChar_literal(c), _ -> L.const_int i8_t (Char.code c)
      | S.SString_literal(s), _ -> L.build_global_stringptr s "tmp" builder
      | S.SNoexpr, _ -> const_zero
      | S.SArray_literal(_, s), A.Array(_, prim_typ) -> 
          L.const_array (ltype_of_typ prim_typ) (Array.of_list (List.map (fun e -> expr builder e) s))
      | S.SArray_literal(_, _), _ -> raise(Failure("Invalid Array literal being created!"))
      | S.SBinop (e1, op, e2), _ ->
	    let e1' = expr builder e1
	    and e2' = expr builder e2 in
        (match op with
          S.IAnd -> L.build_and 
            (L.build_icmp L.Icmp.Ne e1' const_zero "tmp" builder) 
            (L.build_icmp L.Icmp.Ne e2' const_zero "tmp" builder) 
            "tmp" builder
        | S.IOr -> L.build_or 
          (L.build_icmp L.Icmp.Ne e1' const_zero "tmp" builder) 
          (L.build_icmp L.Icmp.Ne e2' const_zero"tmp" builder) 
          "tmp" builder
        | _ ->  (match op with
            S.IAdd    -> L.build_add
          | S.ISub    -> L.build_sub
          | S.IMult   -> L.build_mul
          | S.IDiv    -> L.build_sdiv
          | S.IMod    -> L.build_srem
          | S.IEqual  -> L.build_icmp L.Icmp.Eq
          | S.INeq    -> L.build_icmp L.Icmp.Ne
          | S.ILess   -> L.build_icmp L.Icmp.Slt
          | S.ILeq    -> L.build_icmp L.Icmp.Sle
          | S.IGreater-> L.build_icmp L.Icmp.Sgt
          | S.IGeq    -> L.build_icmp L.Icmp.Sge
          | _ -> raise(Failure("Found some binary operator that isn't handled!"))
          ) e1' e2' "tmp" builder
        )
	      
      | S.SUnop(op, e), _ ->
	    let e' = expr builder e in
	      (match op with
	        S.INeg    -> L.build_neg e' "tmp" builder
        | S.INot    -> L.build_icmp L.Icmp.Eq e' const_zero "tmp" builder)
      | S.SAssign (lval, s_e), _ -> let e' = expr builder s_e in
	                   ignore (L.build_store e' (lval_expr builder lval) builder); e'
      (* L.build_call consolePrint_func [| (expr builder e) |] "consolePrint" builder *)
      (* | A.Call ("intToFloat", [e]) ->
      L.build_call intToFloat_func [| (expr builder e) |] "intToFloat" builder
      | A.Call ("floatToInt", [e]) ->
      L.build_call floatToInt_func [| (expr builder e) |] "floatToInt" builder
      | A.Call ("intToString", [e]) ->
      L.build_call intToString_func [| (expr builder e) |] "intToString" builder
      | A.Call ("floatToString", [e]) ->
      L.build_call floatToString_func [| (expr builder e) |] "floatToString" builder
      | A.Call ("charToString", [e]) ->
      L.build_call charToString_func [| (expr builder e) |] "charToString" builder
      | A.Call ("length", [e]) ->
      L.build_call length_func [| (expr builder e) |] "length" builder
      | A.Call ("setFramerate", [e]) ->
      L.build_call setFramerate_func [| (expr builder e) |] "setFramerate" builder *)
      | S.SCall (s_f, act), _ -> let f_name = s_f.S.sfname in 
      let actuals = List.rev (List.map (expr builder) (List.rev act)) in (* Why reverse twice? *)
      
      (match f_name with
          "consolePrint" -> L.build_call printf_func (Array.of_list (string_format_str :: actuals)) "printf" builder
        | "intToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 12) "intToString" builder in
            let final_result = List.hd act in 
            let result_name = (match final_result with
              | S.SLval(S.SId(s), _), _ -> s
              | _ -> raise(Failure("Cannot pass a non-variable name to store the value of intToString!"))) in
            let arg = List.tl actuals in
            ignore(L.build_call sprintf_func (Array.of_list (result :: int_format_str :: arg)) "intToStringResult" builder);
            L.build_store result (lookup result_name) builder;
        | "floatToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 20) "floatToString" builder in
            let final_result = List.hd act in 
            let result_name = (match final_result with
              | S.SLval(S.SId(s), _), _ -> s
              | _ -> raise(Failure("Cannot pass a non-variable name to store the value of floatToString!"))) in
            let arg = List.tl actuals in
            ignore(L.build_call sprintf_func (Array.of_list (result :: float_format_str :: arg)) "floatToStringResult" builder);
            L.build_store result (lookup result_name) builder;
        | "charToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 2) "charToString" builder in
            let final_result = List.hd act in 
            let result_name = (match final_result with
              | S.SLval(S.SId(s), _), _ -> s
              | _ -> raise(Failure("Cannot pass a non-variable name to store the value of charToString!"))) in
            let arg = List.tl actuals in
            ignore(L.build_call sprintf_func (Array.of_list (result :: char_format_str :: arg)) "charToStringResult" builder);
            L.build_store result (lookup result_name) builder;
        | _ -> let (fdef, fdecl) = StringMap.find f_name function_decls in
	        let result = (match fdecl.S.styp with A.Void -> ""
                                            | _ -> f_name ^ "_result") in
          L.build_call fdef (Array.of_list actuals) result builder)
      | S.SLval(l), _ -> let lval = lval_expr builder (l) in
        L.build_load lval "tmp" builder
    
    and lval_expr builder = function
      (S.SId(s), _) -> lookup s
    | (S.SAccess(id, idx), el_typ) -> 
      (* ignore(print_string "access"); *)
      let arr = lookup id in
      let idx' = expr builder idx in
      let arr_len = L.array_length (ltype_of_typ el_typ)
      in (* if (idx' < const_zero || idx' >= (L.const_int i32_t arr_len)) 
        then raise(Failure("Attempted access out of array bounds"))
        (* TODO: figure out how to check for access out of array bounds *)
        else  *)L.build_gep arr [| const_zero ; idx' |] "tmp" builder
      (*let id' = lookup id 
      and idx' = expr builder idx in
      if idx' < (expr builder (A.Int_literal 0)) || idx' > id'.(1) then raise(Failure("Attempted access out of array bounds"))
      else L.const_int i32_t idx'*)
    in

    (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> (* ignore(print_string "Found no return statement!");  *)ignore (f builder) in
	
    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt builder = function
	      S.SBlock sl -> List.fold_left stmt builder sl
      | S.SExpr e -> ignore (expr builder e); builder
      (* | S.SVDecl ((t, n), e) -> let var = L.build_alloca (ltype_of_typ t) n builder in
          let e' = expr builder e in
          ignore(L.build_store e' var builder); builder *)
      | S.SReturn e -> ignore (match sfdecl.S.styp with
	        A.Void -> L.build_ret_void builder
	      | _ -> L.build_ret (expr builder e) builder); builder
      | S.SIf (predicate, then_stmt) ->
          let pred' = expr builder predicate in 
          let llty_str = L.string_of_lltype (L.type_of pred') in (* TODO: Find a less hack-y way to do this! *)
          let bool_val = 
            (match llty_str with
                "i32" -> (L.build_icmp L.Icmp.Ne pred' const_zero "tmp" builder)
              | "i1" -> pred'
              | _ -> raise(Failure("Type of predicate is wrong!"))) in

        	let merge_bb = L.append_block context "merge" the_function in

        	let then_bb = L.append_block context "then" the_function in
        	add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
        	  (L.build_br merge_bb);

          ignore (L.build_cond_br bool_val then_bb merge_bb builder);
          L.builder_at_end context merge_bb

      | S.SWhile (predicate, body) ->
          let pred_bb = L.append_block context "while" the_function in
      	  ignore (L.build_br pred_bb builder);

      	  let body_bb = L.append_block context "while_body" the_function in
      	  add_terminal (stmt (L.builder_at_end context body_bb) body)
      	    (L.build_br pred_bb);

      	  let pred_builder = L.builder_at_end context pred_bb in
          let pred' = expr pred_builder predicate in 
          let llty_str = L.string_of_lltype (L.type_of pred') in (* TODO: Find a less hack-y way to do this! *)
          let bool_val = 
            (match llty_str with
                "i32" -> (L.build_icmp L.Icmp.Ne pred' const_zero "tmp" pred_builder)
              | "i1" -> pred'
              | _ -> raise(Failure("Type of predicate is wrong!"))) in
          
      	  let merge_bb = L.append_block context "merge" the_function in
      	  ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
      	  L.builder_at_end context merge_bb

    in

    (* Build the code for each statement in the function *)
    let new_builder = stmt builder (S.SBlock sfdecl.S.sbody) in

    (* SPECIAL CASE: For the main(), add in a call to the main rendering of the SDL window *)
    let _ = match sfdecl.S.sfname with
        "main" -> let runSDL_ret = L.build_alloca i32_t "runSDL_ret" new_builder in 
          ignore(L.build_store (L.build_call runSDL_func [|  |] "runSDL_ret" new_builder) runSDL_ret new_builder); 
          ignore(L.build_ret (L.build_load runSDL_ret "runSDL_ret" new_builder) new_builder)
      | _ -> () in
    (* TODO: Consider storing the returned value somewhere, return that as an error *)

    (* Add a return if the last block falls off the end *)
    (* add_terminal new_builder (match sfdecl.S.styp with
        A.Void -> L.build_ret_void
      | _ -> L.build_ret const_zero(* L.build_ret (L.const_int (ltype_of_typ t) 0) *)) *)
    match sfdecl.S.styp with
        A.Void -> add_terminal new_builder L.build_ret_void
      | _ -> ()
  in

  List.iter build_function_body functions;
  the_module
