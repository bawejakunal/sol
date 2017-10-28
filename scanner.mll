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
| "shape"  { SHAPE }
| "parent"  { PARENT }
| "extends"  { EXTENDS }
| "func"   { FUNC }
| "construct"  { CONSTRUCT }
| "main"   { MAIN }
| "consolePrint"  { CONSOLEPRINT }
| "draw"   { DRAW }
| "drawpoint"  { DRAWPOINT }
| "drawcurve"  { DRAWCURVE }
| "print"  { PRINT }
| "length"  { LENGTH }
| "setFramerate"  { SETFRAMERATE }
| "translate"  { TRANSLATE }
| "rotate"  { ROTATE }
| "render"  { RENDER }
| "wait"  { WAIT }
| ['0'-'9']+'.'['0'-'9']+ as lxm { FLOAT_LITERAL(float_of_string lxm) }
| ['0'-'9']+ as lxm { INT_LITERAL(int_of_string lxm) }
| '.'      { DOT }
| '''[^ '\\' ''' '"']?''' as lxm { CHAR_LITERAL(lxm.[1]) }
| ''''\\'[''' '"' '\\' 't' 'n' '0']''' as lxm { CHAR_LITERAL(lxm.[1]) }
| '"' (('\\'[''' '"' '\\' 't' 'n' '0'])+ | [^ '\\' ''' '"']+) '"' as lxm { STRING_LITERAL(lxm) } (* TODO: Remove double quotes, convert to list of chars*)
| ['a'-'z' 'A'-'Z' '_']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }