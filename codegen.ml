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

(* Define helper function to find index of an element in a list *)
let rec index_of cmp lst idx = match lst with
| [] -> raise(Failure("Element not found!"))
| hd::tl -> if (cmp hd) then idx else index_of cmp tl (idx + 1)

(* Define helper function to create list of integers in a range *)
let range a b =
  let rec aux a b =
    if a > b then [] else a :: aux (a+1) b  in
  if a > b then List.rev (aux b a) else aux a b;;

let translate (globals, shapes, functions) =
  (* ignore(print_string(string_of_int(inst_count) ^ "\n")); *)
  let context = L.global_context () in
  let the_module = L.create_module context "SOL"
  and i32_t  = L.i32_type   context
  and f32_t  = L.double_type context
  and i8_t   = L.i8_type    context
  and void_t = L.void_type  context in

  (* Create map of shape name to its definition, for convenience *)
  let shape_defs = List.fold_left 
    (fun m sshape -> StringMap.add sshape.S.ssname sshape m) 
    StringMap.empty shapes in
  let shape_def s = (try StringMap.find s shape_defs with Not_found -> raise(Failure("shape_def Not_found! " ^ s))) in

  let named_shape_types = List.fold_left 
    (fun m ssdecl -> let name = ssdecl.S.ssname in StringMap.add name (L.named_struct_type context name) m) 
    StringMap.empty shapes in
  let shape_type s = (try StringMap.find s named_shape_types with Not_found -> raise(Failure("shape_type Not_found!"))) in

  let rec ltype_of_typ = function
      A.Int -> i32_t
    | A.Float -> f32_t
    | A.Char -> i8_t
    | A.String -> L.pointer_type i8_t
    | A.Void -> void_t
    | A.Array(l, t) -> L.array_type (ltype_of_typ t) l
    | A.Shape(s) -> shape_type s
    in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in

  let global_vars = StringMap.add "_Running" 
    (L.define_global "_Running" (L.const_int (L.i1_type context) 0) the_module) global_vars in

  (* Instantiate global constants used for printing/comparisons, once *)
  let string_format_str = L.define_global "fmt" (L.const_stringz context "%s\n") the_module in
  let int_format_str = L.define_global "int_fmt" (L.const_stringz context "%d") the_module in
  let float_format_str = L.define_global "flt_fmt" (L.const_stringz context "%f") the_module in
  let char_format_str = L.define_global "char_fmt" (L.const_stringz context "%c") the_module in

  (* Declare printf(), which the consolePrint built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Declare the built-in startSDL(), which initializes the SDL environment *)
  let startSDL_t = L.var_arg_function_type i32_t [| |] in
  let startSDL_func = L.declare_function "startSDL" startSDL_t the_module in

  (* Declare the built-in onRenderStartSDL(), which runs before every render loop in SDL *)
  let onRenderStartSDL_t = L.var_arg_function_type void_t [| |] in
  let onRenderStartSDL_func = L.declare_function "onRenderStartSDL" onRenderStartSDL_t the_module in

  (* Declare the built-in onRenderFinishSDL(), which runs after every render loop in SDL *)
  let onRenderFinishSDL_t = L.var_arg_function_type void_t [| |] in
  let onRenderFinishSDL_func = L.declare_function "onRenderFinishSDL" onRenderFinishSDL_t the_module in

  (* Declare the built-in stopSDL(), which cleans up and exits the SDL environment *)
  let stopSDL_t = L.var_arg_function_type i32_t [| |] in
  let stopSDL_func = L.declare_function "stopSDL" stopSDL_t the_module in

  (* (* Declare the built-in intToFloat() function *)
  let intToFloat_t = L.function_type f32_t [|i32_t|] in
  let intToFloat_func = L.declare_function "intToFloat" intToFloat_t the_module in

  (* Declare the built-in floatToInt() function *)
  let floatToInt_t = L.function_type i32_t [|f32_t|] in
  let floatToInt_func = L.declare_function "floatToInt" floatToInt_t the_module in *)

  (* Declare the built-in sprintf() function, used by the *ToString functions *)
  let sprintf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t; L.pointer_type i8_t |] in
  let sprintf_func = L.declare_function "sprintf" sprintf_t the_module in

  (* Declare the built-in drawCurve(), which draws a curve in SDL *)
  let drawCurve_t = L.var_arg_function_type i32_t 
    [|  L.pointer_type (L.array_type i32_t 2) ;  L.pointer_type (L.array_type i32_t 2) ;  L.pointer_type (L.array_type i32_t 2) ; i32_t ;  L.pointer_type (L.array_type i32_t 3) |] in
  let drawCurve_func = L.declare_function "drawCurve" drawCurve_t the_module in

  (* Declare the built-in drawPoint(), which draws a point in SDL *)
  let drawPoint_t = L.var_arg_function_type i32_t 
    [| L.array_type i32_t 2 ; L.array_type i32_t 3 |] in
  let drawPoint_func = L.declare_function "drawPoint" drawPoint_t the_module in

  (* (* Declare the built-in length() function *)
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
        Array.of_list (List.map 
          (fun (t,_) -> let ltyp = ltype_of_typ t in 
            match t with
              A.Array(_) -> L.pointer_type (ltyp)
            | _ -> ltyp) 
        sfdecl.S.sformals)
      in let ftype = (match name with
          "main" -> L.function_type i32_t formal_types
        | _ -> L.function_type (ltype_of_typ sfdecl.S.styp) formal_types) in
      StringMap.add name (L.define_function name ftype the_module, sfdecl) m in
    List.fold_left function_decl StringMap.empty functions in

  (* Add in member functions for each shape *)
  let function_decls = 
    let shape_function_decl m ssdecl =
    let sname = ssdecl.S.ssname in
      let m = List.fold_left (fun m smember_f -> 
        let f_name = smember_f.S.sfname 
        and formal_types = 
          Array.of_list (L.pointer_type (shape_type sname) :: 
            List.map (fun (t,_) -> let ltyp = ltype_of_typ t in 
              match t with
                A.Array(_) -> L.pointer_type (ltyp)
              | _ -> ltyp) smember_f.S.sformals)
        in let ftype = L.function_type (ltype_of_typ smember_f.S.styp) formal_types in
        StringMap.add f_name (L.define_function f_name ftype the_module, smember_f) m) 
      m ssdecl.S.smember_fs in
      (* Add in each constructor and draw as well *)
      let construct_name = ssdecl.S.sconstruct.S.sfname and
      formal_types = Array.of_list (List.map (fun (t,_) -> let ltyp = ltype_of_typ t in 
            match t with
              A.Array(_) -> L.pointer_type (ltyp)
            | _ -> ltyp)  ssdecl.S.sconstruct.S.sformals) in 
      let ftype = L.function_type (L.pointer_type (shape_type sname)) formal_types in
      let m = StringMap.add construct_name (L.define_function construct_name ftype the_module, ssdecl.S.sconstruct) m in
      let draw_name = ssdecl.S.sdraw.S.sfname and
      formal_types = [| L.pointer_type (shape_type sname) |]
        in let ftype = L.function_type (void_t) formal_types in
      StringMap.add draw_name (L.define_function draw_name ftype the_module, ssdecl.S.sdraw) m in
    List.fold_left shape_function_decl function_decls shapes in

  (* Fill in the body of each shape type *)
  let shape_decl ssdecl =
    let name = ssdecl.S.ssname in 
    let s_type = shape_type name in
    let lmember_vs = List.rev (List.fold_left (fun l (t, _) -> (ltype_of_typ t) :: l ) [] ssdecl.S.smember_vs) in
    let lmember_fs = List.rev (List.fold_left (fun l smember_f -> 
      let formal_types = 
        Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) smember_f.S.sformals) in 
      let ftype = L.function_type (ltype_of_typ smember_f.S.styp) formal_types in
       (L.pointer_type ftype) :: l ) [] ssdecl.S.smember_fs) in
    (L.struct_set_body s_type (Array.of_list(lmember_vs @ lmember_fs)) false) in
    
  ignore(List.iter shape_decl shapes);
  
  (* Fill in the body of the given function *)
  let build_function_body sfdecl member_vars =
    (* ignore(print_string (sfdecl.S.sfname ^ "\n")); *)
    let (the_function, _) = (try StringMap.find sfdecl.S.sfname function_decls with Not_found -> raise(Failure("build_function_body Not_found!"))) in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    (* SPECIAL CASE: For the main(), add in a call to the initalization of the SDL window *)
    let _ = match sfdecl.S.sfname with
        "main" -> ignore(L.build_call startSDL_func [|  |] "startSDL" builder) 
      | _ -> () in
    (* TODO: Consider storing the returned value somewhere, return that as an error *)

    let const_zero = L.const_int i32_t 0 in
    
    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = L.set_value_name n p;
        let local = 
          (match t with
          (* For arrays, use the pointer directly *)
            A.Array(_) -> p
          | _ -> let l = L.build_alloca (ltype_of_typ t) n builder in
              ignore (L.build_store p l builder); l) in
      	StringMap.add n local m in

      let add_local m (t, n) =
      	let local_var = L.build_alloca (ltype_of_typ t) n builder	in 
        StringMap.add n local_var m in

      let formals = try (List.fold_left2 add_formal StringMap.empty sfdecl.S.sformals
          (Array.to_list (L.params the_function)) )
      (* The only case where a mismatch occurs is for shape-member functions, when the first argument is the shape 
      - in this case, ignore the first argument *)
      with Invalid_argument("List.fold_left2") -> List.fold_left2 add_formal StringMap.empty sfdecl.S.sformals
          (List.tl (Array.to_list (L.params the_function))) in
      List.fold_left add_local formals sfdecl.S.slocals in

    (* Return the value for a variable or formal argument *)
    let lookup n = try StringMap.find n local_vars
                   with Not_found -> (try StringMap.find n member_vars
                     with Not_found -> (try StringMap.find n global_vars with Not_found -> raise(Failure("lookup Not_found!"))))
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder loadval = function
	      S.SInt_literal(i), _ -> L.const_int i32_t i
      | S.SFloat_literal(f), _ -> L.const_float f32_t f
      | S.SChar_literal(c), _ -> L.const_int i8_t (Char.code c)
      | S.SString_literal(s), _ -> L.build_global_stringptr s "tmp" builder
      | S.SNoexpr, _ -> const_zero
      | S.SArray_literal(_, s), (A.Array(_, prim_typ) as t) -> 
          let const_array = L.const_array (ltype_of_typ prim_typ) (Array.of_list (List.map (fun e -> expr builder true e) s)) in
          if loadval then const_array
          else (let arr_ref = L.build_alloca (ltype_of_typ t) "arr_ptr" builder in
            ignore(L.build_store const_array arr_ref builder); arr_ref)
      | S.SArray_literal(_, _), _ -> raise(Failure("Invalid Array literal being created!"))
      | S.SBinop (e1, op, e2), _ ->
	    let e1' = expr builder true e1
	    and e2' = expr builder true e2 in
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
          | S.FAdd    -> L.build_fadd
          | S.FSub    -> L.build_fsub
          | S.FMult   -> L.build_fmul
          | S.FDiv    -> L.build_fdiv
          | S.FMod    -> L.build_frem
          | S.FEqual  -> L.build_fcmp L.Fcmp.Oeq
          | S.FNeq    -> L.build_fcmp L.Fcmp.One
          | S.FLess   -> L.build_fcmp L.Fcmp.Olt
          | S.FLeq    -> L.build_fcmp L.Fcmp.Ole
          | S.FGreater-> L.build_fcmp L.Fcmp.Ogt
          | S.FGeq    -> L.build_fcmp L.Fcmp.Oge
          | _ -> raise(Failure("Found some binary operator that isn't handled!"))
          ) e1' e2' "tmp" builder
        )
	      
      | S.SUnop(op, e), _ ->
	    let e' = expr builder true e in
	      (match op with
	        S.INeg    -> L.build_neg e' "tmp" builder
        | S.INot    -> L.build_icmp L.Icmp.Eq e' const_zero "tmp" builder
        | S.FNeg    -> L.build_fneg e' "tmp" builder)
      | S.SAssign (lval, s_e), _ -> let e' = expr builder true s_e in
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
      let actuals = List.rev (List.map 
        (fun (s_e, t) -> 
          (* Send a pointer to array types instead of the actual array *)
          match t with
            A.Array(_) -> expr builder false (s_e, t)
          | _ -> expr builder true (s_e, t)) 
        (List.rev act)) in (* Why reverse twice? *)
      
      (match f_name with
          "consolePrint" -> let fmt_str_ptr = 
              L.build_in_bounds_gep string_format_str [| const_zero ; const_zero |] "tmp" builder in 
            L.build_call printf_func (Array.of_list (fmt_str_ptr :: actuals)) "printf" builder
        | "intToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 12) "intToString" builder in
            let int_fmt_ptr = 
              L.build_in_bounds_gep int_format_str [| const_zero ; const_zero |] "tmp" builder in 
            ignore(L.build_call sprintf_func (Array.of_list (result :: int_fmt_ptr :: actuals)) "intToStringResult" builder);
            result
        | "floatToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 20) "floatToString" builder in
            let flt_fmt_ptr = 
              L.build_in_bounds_gep float_format_str [| const_zero ; const_zero |] "tmp" builder in 
            ignore(L.build_call sprintf_func (Array.of_list (result :: flt_fmt_ptr :: actuals)) "floatToStringResult" builder);
            result
        | "charToString" -> let result = L.build_array_alloca i8_t (L.const_int i32_t 2) "charToString" builder in
            let char_fmt_ptr = 
              L.build_in_bounds_gep char_format_str [| const_zero ; const_zero |] "tmp" builder in 
            ignore(L.build_call sprintf_func (Array.of_list (result :: char_fmt_ptr :: actuals)) "charToStringResult" builder);
            result
        | "drawCurve" -> L.build_call drawCurve_func (Array.of_list(actuals)) "drawCurve" builder
        | _ -> let (fdef, fdecl) = (try StringMap.find f_name function_decls with Not_found -> raise(Failure("SCall Not_found!"))) in
	        let result = (match fdecl.S.styp with A.Void -> ""
                                            | _ -> f_name ^ "_result") in
          L.build_call fdef (Array.of_list actuals) result builder)
      | S.SShape_fn(s, styp, s_f, act), _ -> let obj = lookup s in 
          let f_name = (match styp with
              A.Shape(sname) -> sname
            | _ -> raise(Failure("Non-shape type object in member function call!"))) ^ "__" ^ s_f.S.sfname in
          let actuals = List.rev (List.map 
            (fun (s_e, t) -> 
              (* Send a pointer to array types instead of the actual array *)
              match t with
                A.Array(_) -> expr builder false (s_e, t)
              | _ -> expr builder true (s_e, t)) 
              (List.rev act)) in
          let (fdef, fdecl) = (try StringMap.find f_name function_decls with Not_found -> raise(Failure("SShape_fn Not_found!"))) in
          let result = (match fdecl.S.styp with A.Void -> ""
                                            | _ -> f_name ^ "_result") in
          L.build_call fdef (Array.of_list (obj :: actuals)) result builder
      | S.SLval(l), _ -> let lval = lval_expr builder l in 
          if loadval then L.build_load lval "tmp" builder
          else lval
      | S.SInst_shape(_, sactuals), A.Shape(sname) -> 
          let actuals = 
          List.rev (List.map (fun (s_e, t) -> let ll_expr = expr builder true (s_e, t) in 
            (* Send a pointer to array types instead of the actual array *)
            match t with
              A.Array(_) -> let copy = L.build_alloca (ltype_of_typ t) "arr_copy" builder in 
                ignore(L.build_store ll_expr copy builder); copy
            | _ -> ll_expr) 
            (List.rev sactuals)) in 
          (* Call the constructor *)
          let (constr, _) = (try StringMap.find (sname ^ "__construct") function_decls with Not_found -> raise(Failure("SInst_shape Not_found!"))) in
          let new_inst = L.build_call constr (Array.of_list actuals) (sname ^ "_inst_ptr") builder in
          L.build_load new_inst (sname ^ "_inst") builder
      | S.SInst_shape(_, _), _ -> raise(Failure("Cannot instantiate a shape of non-shape type!"))

    
    and lval_expr builder = function
      S.SId(s), _ -> lookup s
    | S.SAccess(id, idx), _(* el_typ *) -> 
        (* ignore(print_string "access"); *)
        let arr = lookup id in
        let idx' = expr builder true idx in
        (* let arr_len = L.array_length (ltype_of_typ el_typ) in 
        if (idx' < const_zero || idx' >= (L.const_int i32_t arr_len)) 
          then raise(Failure("Attempted access out of array bounds"))
          (* TODO: figure out how to check for access out of array bounds *)
          else  *)L.build_gep arr [| const_zero ; idx' |] "tmp" builder
        (*let id' = lookup id 
        and idx' = expr builder idx in
        if idx' < (expr builder (A.Int_literal 0)) || idx' > id'.(1) then raise(Failure("Attempted access out of array bounds"))
        else L.const_int i32_t idx'*)
    | S.SShape_var(s, v), s_t -> 
        let rec resolve_shape_var obj var obj_type = 
          (* Find index of variable in the shape definition *)
          match obj_type with
              A.Shape(sname) -> let sdef = shape_def sname in
              (match var with
                  S.SId(v_n), _ -> let index = index_of (fun (_, member_var) -> v_n = member_var) sdef.S.smember_vs 0 in
                    L.build_struct_gep obj index "tmp" builder
                | S.SAccess(v_n, idx), _ -> let index = index_of (fun (_, member_var) -> v_n = member_var) sdef.S.smember_vs 0 in
                    let arr = L.build_struct_gep obj index "tmp" builder in
                    let idx' = expr builder true idx in
                    L.build_gep arr [| const_zero ; idx' |] "tmp" builder
                | S.SShape_var(member_n, member_v), member_t -> 
                    let index = index_of (fun (_, member_var) -> member_n = member_var) sdef.S.smember_vs 0 in
                    let id = L.build_struct_gep obj index "tmp" builder in
                    resolve_shape_var id member_v member_t
              )
            | _ -> raise(Failure("Cannot access a shape variable of a non-shape type object!"))
        in 
        resolve_shape_var (lookup s) v s_t
        

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
      | S.SExpr e -> ignore (expr builder true e); builder
      (* | S.SVDecl ((t, n), e) -> let var = L.build_alloca (ltype_of_typ t) n builder in
          let e' = expr builder e in
          ignore(L.build_store e' var builder); builder *)
      | S.SReturn e -> ignore (match sfdecl.S.styp with
	        A.Void -> L.build_ret_void builder
	      | _ -> L.build_ret (expr builder true e) builder); builder
      | S.SIf (predicate, then_stmt) ->
          let pred' = expr builder true predicate in 
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
          let pred' = expr pred_builder true predicate in 
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
    let builder = stmt builder (S.SBlock sfdecl.S.sbody) in

    (* SPECIAL CASE: For the main(), add in a call to the main rendering of the SDL window, return its result *)
    let _ = match sfdecl.S.sfname with
        "main" -> 
        (* Find all shape objects within scope *)
        let final_objs = List.rev (List.fold_left (fun lst (t, n) -> match t with
            A.Shape(sname) -> (sname, lookup n) :: lst
          | _ -> lst) 
        [] (List.rev sfdecl.S.slocals)) in

        (* Create a loop while program is running *)
        let pred_bb = L.append_block context "while" the_function in
        ignore (L.build_br pred_bb builder);

        let body_bb = L.append_block context "while_body" the_function in
        let builder_body = L.builder_at_end context body_bb in
        (* Build call to onRenderStartSDL() *)
        ignore(L.build_call onRenderStartSDL_func [|  |] "" builder_body);
        
        (* Build a call to each shape's draw function *)
        List.iter (fun (n, o) -> 
          let (draw_fn, _) = StringMap.find (n ^ "__draw") function_decls in 
          ignore(L.build_call draw_fn [| o |] "" builder_body) )
        final_objs;
        
        (* Build call to onRenderFinishSDL() *)
        ignore(L.build_call onRenderFinishSDL_func [|  |] "" builder_body);
        ignore(L.build_br pred_bb builder_body);
        
        let pred_builder = L.builder_at_end context pred_bb in
        let merge_bb = L.append_block context "merge" the_function in
        ignore (L.build_cond_br 
          (L.build_load (StringMap.find "_Running" global_vars) "_Running_val" pred_builder) 
        body_bb merge_bb pred_builder);
        let builder = L.builder_at_end context merge_bb in

        let stopSDL_ret = L.build_alloca i32_t "stopSDL_ret" builder in 
          ignore(L.build_store (L.build_call stopSDL_func [|  |] "stopSDL_ret" builder) stopSDL_ret builder); 
          ignore(L.build_ret (L.build_load stopSDL_ret "stopSDL_ret" builder) builder)
      | _ -> () in

    (* Add a return if the last block falls off the end *)
    (* add_terminal builder (match sfdecl.S.styp with
        A.Void -> L.build_ret_void
      | _ -> L.build_ret const_zero(* L.build_ret (L.const_int (ltype_of_typ t) 0) *)) *)
    match sfdecl.S.styp with
        A.Void -> add_terminal builder L.build_ret_void
      | _ -> ()
  in

  let build_object_function_body sfdecl sdecl = 
    let sname = sdecl.S.ssname in 
    let stype = shape_type sname in
    let (the_function, _) = (try StringMap.find sfdecl.S.sfname function_decls with Not_found -> raise(Failure("build_object_function_body Not_found!"))) in
    let builder = L.builder_at_end context (L.entry_block the_function) in 
    let construct_name = sname ^ "__construct" in
    
    let shape_inst = 
      if sfdecl.S.sfname = construct_name 
      (* SPECIAL CASE: For the construct(), add creation of an object of the required type *)
      then L.build_alloca stype (sname ^ "_inst") builder
        (* In all other cases, return the first argument of the function *)
      else Array.get (L.params the_function) 0
    in

    (* Create pointers to all member variables *)
    let member_vars = List.fold_left 
      (fun m ((_, n), i) -> let member_val = L.build_struct_gep shape_inst i n builder in
        StringMap.add n member_val m) 
      StringMap.empty (List.mapi (fun i v -> (v, i)) sdecl.S.smember_vs) in
    
    (* Build rest of the function body *)
    build_function_body sfdecl member_vars;

    (* SPECIAL CASE: For the construct(), return the instantiated object *)
    if sfdecl.S.sfname = construct_name 
    then let bbs = L.basic_blocks the_function in
      let builder = L.builder_at_end context (Array.get bbs ((Array.length bbs) - 1)) in 
      (* build_function_body would have inserted a void return statement at the end; remove this *)
      match L.block_terminator (L.insertion_block builder) with
        Some ins -> (L.delete_instruction ins); 
          ignore(L.build_ret shape_inst builder)
      | None -> ()
    else ()

  in

  List.iter (fun f -> build_function_body f StringMap.empty) functions;
  List.iter (fun s -> 
    build_object_function_body s.S.sconstruct s; 
    build_object_function_body s.S.sdraw s; 
    List.iter (fun f -> build_object_function_body f s) s.S.smember_fs;) 
  shapes; 
  the_module
