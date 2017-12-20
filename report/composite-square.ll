; ModuleID = 'SOL'

%Rectangle = type { %Line, %Line, %Line, %Line }
%Line = type { [2 x i32], [2 x i32], [2 x i32], [3 x i32] }

@_Running = global i1 false
@fmt = global [4 x i8] c"%s\0A\00"
@int_fmt = global [3 x i8] c"%d\00"
@flt_fmt = global [3 x i8] c"%f\00"
@char_fmt = global [3 x i8] c"%c\00"

declare i32 @printf(i8*, ...)

declare i32 @startSDL(...)

declare void @onRenderStartSDL(...)

declare void @onRenderFinishSDL(...)

declare i32 @stopSDL(...)

declare i32 @sprintf(i8*, i8*, ...)

declare i32 @drawCurve([2 x i32]*, [2 x i32]*, [2 x i32]*, i32, [3 x i32]*)

declare i32 @drawPoint([2 x i32]*, [3 x i32]*)

declare i32 @print([2 x i32]*, i8*, [3 x i32]*)

declare void @setFramerate(i32)

declare i32 @getFramerate()

define i32 @main() {
entry:
  %startSDL = call i32 (...) @startSDL()
  %sq = alloca %Rectangle
  %arr_copy = alloca [2 x i32]
  store [2 x i32] [i32 10, i32 300], [2 x i32]* %arr_copy
  %arr_copy1 = alloca [2 x i32]
  store [2 x i32] [i32 300, i32 300], [2 x i32]* %arr_copy1
  %arr_copy2 = alloca [2 x i32]
  store [2 x i32] [i32 300, i32 10], [2 x i32]* %arr_copy2
  %arr_copy3 = alloca [2 x i32]
  store [2 x i32] [i32 10, i32 10], [2 x i32]* %arr_copy3
  %Rectangle_inst_ptr = call %Rectangle* @Rectangle__construct([2 x i32]* %arr_copy3, [2 x i32]* %arr_copy2, [2 x i32]* %arr_copy1, [2 x i32]* %arr_copy)
  %Rectangle_inst = load %Rectangle, %Rectangle* %Rectangle_inst_ptr
  store %Rectangle %Rectangle_inst, %Rectangle* %sq
  %tmp = getelementptr inbounds %Rectangle, %Rectangle* %sq, i32 0, i32 0
  %tmp4 = getelementptr inbounds %Rectangle, %Rectangle* %sq, i32 0, i32 1
  %tmp5 = getelementptr inbounds %Rectangle, %Rectangle* %sq, i32 0, i32 2
  %tmp6 = getelementptr inbounds %Rectangle, %Rectangle* %sq, i32 0, i32 3
  br label %while

while:                                            ; preds = %while_body, %entry
  %_Running_val = load i1, i1* @_Running
  br i1 %_Running_val, label %while_body, label %merge

while_body:                                       ; preds = %while
  call void (...) @onRenderStartSDL()
  call void @Rectangle__draw(%Rectangle* %sq)
  call void @Line__draw(%Line* %tmp)
  call void @Line__draw(%Line* %tmp)
  call void @Line__draw(%Line* %tmp4)
  call void @Line__draw(%Line* %tmp4)
  call void @Line__draw(%Line* %tmp5)
  call void @Line__draw(%Line* %tmp5)
  call void @Line__draw(%Line* %tmp6)
  call void @Line__draw(%Line* %tmp6)
  call void (...) @onRenderFinishSDL()
  br label %while

merge:                                            ; preds = %while
  %stopSDL_ret = alloca i32
  %stopSDL_ret7 = call i32 (...) @stopSDL()
  store i32 %stopSDL_ret7, i32* %stopSDL_ret
  %stopSDL_ret8 = load i32, i32* %stopSDL_ret
  ret i32 %stopSDL_ret8
}

define %Rectangle* @Rectangle__construct([2 x i32]* %a, [2 x i32]* %b, [2 x i32]* %c, [2 x i32]* %d) {
entry:
  %__Rectangle_inst = alloca %Rectangle
  %top = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 0
  %right = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 1
  %bottom = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 2
  %left = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 3
  %arr_copy = alloca [3 x i32]
  store [3 x i32] [i32 150, i32 0, i32 0], [3 x i32]* %arr_copy
  %tmp = load [2 x i32], [2 x i32]* %b
  %arr_copy1 = alloca [2 x i32]
  store [2 x i32] %tmp, [2 x i32]* %arr_copy1
  %tmp2 = load [2 x i32], [2 x i32]* %a
  %arr_copy3 = alloca [2 x i32]
  store [2 x i32] %tmp2, [2 x i32]* %arr_copy3
  %Line_inst_ptr = call %Line* @Line__construct([2 x i32]* %arr_copy3, [2 x i32]* %arr_copy1, [3 x i32]* %arr_copy)
  %Line_inst = load %Line, %Line* %Line_inst_ptr
  store %Line %Line_inst, %Line* %top
  %arr_copy4 = alloca [3 x i32]
  store [3 x i32] [i32 0, i32 150, i32 0], [3 x i32]* %arr_copy4
  %tmp5 = load [2 x i32], [2 x i32]* %c
  %arr_copy6 = alloca [2 x i32]
  store [2 x i32] %tmp5, [2 x i32]* %arr_copy6
  %tmp7 = load [2 x i32], [2 x i32]* %b
  %arr_copy8 = alloca [2 x i32]
  store [2 x i32] %tmp7, [2 x i32]* %arr_copy8
  %Line_inst_ptr9 = call %Line* @Line__construct([2 x i32]* %arr_copy8, [2 x i32]* %arr_copy6, [3 x i32]* %arr_copy4)
  %Line_inst10 = load %Line, %Line* %Line_inst_ptr9
  store %Line %Line_inst10, %Line* %right
  %arr_copy11 = alloca [3 x i32]
  store [3 x i32] [i32 0, i32 0, i32 150], [3 x i32]* %arr_copy11
  %tmp12 = load [2 x i32], [2 x i32]* %d
  %arr_copy13 = alloca [2 x i32]
  store [2 x i32] %tmp12, [2 x i32]* %arr_copy13
  %tmp14 = load [2 x i32], [2 x i32]* %c
  %arr_copy15 = alloca [2 x i32]
  store [2 x i32] %tmp14, [2 x i32]* %arr_copy15
  %Line_inst_ptr16 = call %Line* @Line__construct([2 x i32]* %arr_copy15, [2 x i32]* %arr_copy13, [3 x i32]* %arr_copy11)
  %Line_inst17 = load %Line, %Line* %Line_inst_ptr16
  store %Line %Line_inst17, %Line* %bottom
  %arr_copy18 = alloca [3 x i32]
  store [3 x i32] [i32 150, i32 150, i32 150], [3 x i32]* %arr_copy18
  %tmp19 = load [2 x i32], [2 x i32]* %a
  %arr_copy20 = alloca [2 x i32]
  store [2 x i32] %tmp19, [2 x i32]* %arr_copy20
  %tmp21 = load [2 x i32], [2 x i32]* %d
  %arr_copy22 = alloca [2 x i32]
  store [2 x i32] %tmp21, [2 x i32]* %arr_copy22
  %Line_inst_ptr23 = call %Line* @Line__construct([2 x i32]* %arr_copy22, [2 x i32]* %arr_copy20, [3 x i32]* %arr_copy18)
  %Line_inst24 = load %Line, %Line* %Line_inst_ptr23
  store %Line %Line_inst24, %Line* %left
  ret %Rectangle* %__Rectangle_inst
}

define void @Rectangle__draw(%Rectangle* %__Rectangle_inst) {
entry:
  %top = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 0
  %right = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 1
  %bottom = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 2
  %left = getelementptr inbounds %Rectangle, %Rectangle* %__Rectangle_inst, i32 0, i32 3
  ret void
}

define %Line* @Line__construct([2 x i32]* %first, [2 x i32]* %second, [3 x i32]* %clr) {
entry:
  %__Line_inst = alloca %Line
  %start = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 0
  %mid = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 1
  %end = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 2
  %color = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 3
  %tmp = load [2 x i32], [2 x i32]* %first
  store [2 x i32] %tmp, [2 x i32]* %start
  %tmp1 = load [2 x i32], [2 x i32]* %second
  store [2 x i32] %tmp1, [2 x i32]* %end
  %tmp2 = load [3 x i32], [3 x i32]* %clr
  store [3 x i32] %tmp2, [3 x i32]* %color
  %tmp3 = getelementptr [2 x i32], [2 x i32]* %start, i32 0, i32 0
  %tmp4 = load i32, i32* %tmp3
  %tmp5 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  %tmp6 = load i32, i32* %tmp5
  %tmp7 = add i32 %tmp4, %tmp6
  %tmp8 = sdiv i32 %tmp7, 2
  %tmp9 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 0
  store i32 %tmp8, i32* %tmp9
  %tmp10 = getelementptr [2 x i32], [2 x i32]* %start, i32 0, i32 1
  %tmp11 = load i32, i32* %tmp10
  %tmp12 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  %tmp13 = load i32, i32* %tmp12
  %tmp14 = add i32 %tmp11, %tmp13
  %tmp15 = sdiv i32 %tmp14, 2
  %tmp16 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 1
  store i32 %tmp15, i32* %tmp16
  ret %Line* %__Line_inst
}

define void @Line__draw(%Line* %__Line_inst) {
entry:
  %start = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 0
  %mid = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 1
  %end = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 2
  %color = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 3
  %drawCurve_result = call i32 @drawCurve([2 x i32]* %start, [2 x i32]* %mid, [2 x i32]* %end, i32 2, [3 x i32]* %color)
  ret void
}
