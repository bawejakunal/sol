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

module StringMap = Map.Make(String)

let translate (globals, functions) =
  let context = L.global_context () in
  let the_module = L.create_module context "MicroC"
  and i32_t  = L.i32_type   context
  and f32_t  = L.float_type context
  and i8_t   = L.i8_type    context
  and void_t = L.void_type  context in

  let rec ltype_of_typ = function
      A.Int -> i32_t
    | A.Float -> f32_t
    | A.Char -> i8_t
    | A.String -> L.pointer_type i8_t
    | A.Void -> void_t
    | A.Array(_, t) -> L.struct_type context [|L.pointer_type (ltype_of_typ t); i32_t|] in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in

  (* Declare the built-in consolePrint() function *)
  let consolePrint_t = L.function_type void_t [| L.pointer_type i8_t |] in
  let consolePrint_func = L.declare_function "consolePrint" consolePrint_t the_module in

  (* Declare the built-in intToFloat() function *)
  let intToFloat_t = L.function_type f32_t [|i32_t|] in
  let intToFloat_func = L.declare_function "intToFloat" intToFloat_t the_module in

  (* Declare the built-in floatToInt() function *)
  let floatToInt_t = L.function_type i32_t [|f32_t|] in
  let floatToInt_func = L.declare_function "floatToInt" floatToInt_t the_module in

  (* Declare the built-in intToString() function *)
  let intToString_t = L.function_type (L.pointer_type i8_t) [|i32_t|] in
  let intToString_func = L.declare_function "intToString" intToString_t the_module in
  (* Declare the built-in floatToString() function *)
  let floatToString_t = L.function_type (L.pointer_type i8_t) [|f32_t|] in
  let floatToString_func = L.declare_function "floatToString" floatToString_t the_module in
  (* Declare the built-in charToString() function *)
  let charToString_t = L.function_type (L.pointer_type i8_t) [|i8_t|] in
  let charToString_func = L.declare_function "charToString" charToString_t the_module in

  (* Declare the built-in length() function *)
  let length_t = L.function_type i32_t [|L.struct_type context [|L.pointer_type void_t; i32_t|]|] in
  let length_func = L.declare_function "length" length_t the_module in

  (* Declare the built-in setFramerate() function *)
  let setFramerate_t = L.function_type void_t [|f32_t|] in
  let setFramerate_func = L.declare_function "setFramerate" setFramerate_t the_module in

  (* Define each function (arguments and return type) so we can call it *)
  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname
      and formal_types =
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in
  
  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.A.fname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in
    
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

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.A.formals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.A.locals in

    (* Return the value for a variable or formal argument *)
    let lookup n = try StringMap.find n local_vars
                   with Not_found -> StringMap.find n global_vars
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder = function
	      A.Int_literal i -> L.const_int i32_t i
      | A.Float_literal f -> L.const_float f32_t f
      | A.Char_literal c -> L.const_int i8_t (Char.code c)
      | A.String_literal s -> L.const_string context s
      | A.Noexpr -> L.const_int i32_t 0
      | A.Array_literal(_, s) -> L.const_struct context [|L.const_int i32_t (List.length s)|] 
      (* TODO: Check how to allocate a constant pointer to a list of elements *)
      | A.Id s -> L.build_load (lookup s) s builder
      | A.Access(id, idx) -> 
      (* TODO: Check how to access elements pointed to by pointer *)
      (*let id' = lookup id 
      and idx' = expr builder idx in
      if idx' < (expr builder (A.Int_literal 0)) || idx' > id'.(1) then raise(Failure("Attempted access out of array bounds"))
      else L.const_int i32_t idx'*)
      lookup id
      | A.Binop (e1, op, e2) ->
	    let e1' = expr builder e1
	    and e2' = expr builder e2 in
	      (match op with
	        A.Add     -> L.build_add
	      | A.Sub     -> L.build_sub
	      | A.Mult    -> L.build_mul
        | A.Div     -> L.build_sdiv
        | A.Mod     -> L.build_srem
	      | A.And     -> L.build_and
	      | A.Or      -> L.build_or
	      | A.Equal   -> L.build_icmp L.Icmp.Eq
	      | A.Neq     -> L.build_icmp L.Icmp.Ne
	      | A.Less    -> L.build_icmp L.Icmp.Slt
	      | A.Leq     -> L.build_icmp L.Icmp.Sle
	      | A.Greater -> L.build_icmp L.Icmp.Sgt
	      | A.Geq     -> L.build_icmp L.Icmp.Sge
	      ) e1' e2' "tmp" builder
      | A.Unop(op, e) ->
	    let e' = expr builder e in
	      (match op with
	        A.Neg     -> L.build_neg
        | A.Not     -> L.build_not) e' "tmp" builder
      | A.Assign (s, e) -> let e' = expr builder e in
	                   ignore (L.build_store e' (lookup s) builder); e'
      | A.Call ("consolePrint", [e]) ->
	    L.build_call consolePrint_func [| (expr builder e) |] "consolePrint" builder
      | A.Call ("intToFloat", [e]) ->
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
      L.build_call setFramerate_func [| (expr builder e) |] "setFramerate" builder
      | A.Call (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
	 let actuals = List.rev (List.map (expr builder) (List.rev act)) in
	 let result = (match fdecl.A.typ with A.Void -> ""
                                            | _ -> f ^ "_result") in
         L.build_call fdef (Array.of_list actuals) result builder
    in

    (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (f builder) in
	
    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt builder = function
	A.Block sl -> List.fold_left stmt builder sl
      | A.Expr e -> ignore (expr builder e); builder
      | A.Return e -> ignore (match fdecl.A.typ with
	  A.Void -> L.build_ret_void builder
	| _ -> L.build_ret (expr builder e) builder); builder
      | A.If (predicate, then_stmt) ->
         let bool_val = expr builder predicate in
	 let merge_bb = L.append_block context "merge" the_function in

	 let then_bb = L.append_block context "then" the_function in
	 add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
	   (L.build_br merge_bb);

	 ignore (L.build_cond_br bool_val then_bb merge_bb builder);
	 L.builder_at_end context merge_bb

      | A.While (predicate, body) ->
	  let pred_bb = L.append_block context "while" the_function in
	  ignore (L.build_br pred_bb builder);

	  let body_bb = L.append_block context "while_body" the_function in
	  add_terminal (stmt (L.builder_at_end context body_bb) body)
	    (L.build_br pred_bb);

	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder predicate in

	  let merge_bb = L.append_block context "merge" the_function in
	  ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
	  L.builder_at_end context merge_bb

    in

    (* Build the code for each statement in the function *)
    let builder = stmt builder (A.Block fdecl.A.body) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match fdecl.A.typ with
        A.Void -> L.build_ret_void
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in

  List.iter build_function_body functions;
  the_module
