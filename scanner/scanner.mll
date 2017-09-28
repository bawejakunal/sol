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
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "float"  { FLOAT }
| "char"   { CHAR }
| "array"  { ARRAY }
| "point"  { POINT }
| "curve"  { CURVE }
| "shape"  { SHAPE }
| "motiongroup"  { MOTIONGROUP }
| "func"   { FUNC }
| "construct"  { CONSTRUCT }
| "main"   { MAIN }
| "print"  { PRINT }
| "draw"   { DRAW }
| "drawpoint"  { DRAWPOINT }
| "drawcurve"  { DRAWCURVE }
| "drawtext"  { DRAWTEXT }
| "framerate"  { FRAMERATE }
| "translate"  { TRANSLATE }
| "rotate"  { ROTATE }
| "render"  { RENDER }
| "wait"  { WAIT }
| ['0'-'9']+ as lxm { INT_LITERAL(int_of_string lxm) }
| ['0'-'9']+'.'['0'-'9']+ as lxm { FLOAT_LITERAL(float_of_string lxm) }
| '''[^ '\' ''' '"']?''' as lxm { CHAR(lxm) }
| ''''\'[''' '"' 'b' 't' 'n']''' as lxm { CHAR(lxm) }
| '"'[_]*'"' as lxm { STRING(lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
