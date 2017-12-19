(* Ocamllex scanner for SOL *)

{ open Parser }

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['      { LSQUARE }
| ']'      { RSQUARE }
| ';'      { SEMI }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '%'      { MODULO }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "&&"     { AND }
| "||"     { OR }
| "!"      { NOT }
| "if"     { IF }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "float"  { FLOAT }
| "char"   { CHAR }
| "string"  { STRING }
| "func"   { FUNC }
| "shape"  { SHAPE }
| "construct"  { CONSTRUCT }
| "draw"   { DRAW }
| '.'      { DOT }
(*| "parent"  { PARENT }
| "extends"  { EXTENDS }
| "main"   { MAIN }  (* Consider moving out when main needs to be a reserved keyword *)
| "consolePrint"  { CONSOLEPRINT }
| "length"  { LENGTH }
| "setFramerate"  { SETFRAMERATE }
| "translate"  { TRANSLATE }
| "rotate"  { ROTATE }
| "render"  { RENDER }
| "wait"  { WAIT }*)
| ['0'-'9']+'.'['0'-'9']+ as lxm { FLOAT_LITERAL(float_of_string lxm) }
| ['0'-'9']+ as lxm { INT_LITERAL(int_of_string lxm) }
| '''[^ '\\' ''' '"']?''' as lxm { CHAR_LITERAL(lxm.[1]) }
| ''''\\'[''' '"' '\\' 't' 'n']''' as lxm { CHAR_LITERAL(lxm.[1]) }
| '"' (('\\'[''' '"' '\\' 't' 'n'])+ | [^ '\\' ''' '"']+)* '"' as lxm 
  { let str = String.sub (lxm) 1 ((String.length lxm) - 2) in
  	let unescaped_str = Scanf.unescaped str in 
  	STRING_LITERAL(unescaped_str) }
| ['A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { SHAPE_ID(lxm) }
| ['a'-'z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
