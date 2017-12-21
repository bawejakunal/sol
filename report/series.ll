; ModuleID = 'SOL'

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

declare double @sine(double, ...)

declare double @cosine(double, ...)

declare double @round(double, ...)

declare double @intToFloat(i32)

declare i32 @floatToInt(double)

declare i32 @sprintf(i8*, i8*, ...)

declare i32 @drawCurve([2 x i32]*, [2 x i32]*, [2 x i32]*, i32, [3 x i32]*)

declare i32 @drawPoint([2 x i32]*, [3 x i32]*)

declare i32 @print([2 x i32]*, i8*, [3 x i32]*)

declare void @setFramerate(i32)

declare i32 @getFramerate()

declare void @allocDispArray(i32*, i32*, i32*, double*, i32, i32*, i32**, i32**)

declare void @translateCurve([2 x i32]*, [2 x i32]*, [2 x i32]*, i32*, i32*, i32, i32)

declare void @translatePoint([2 x i32]*, i32*, i32*, i32, i32)

define i32 @main() {
entry:
  %startSDL = call i32 (...) @startSDL()
  %series_result = call i32 @series(i32 5)
  br label %while

while:                                            ; preds = %while_body, %entry
  %_Running_val = load i1, i1* @_Running
  br i1 %_Running_val, label %while_body, label %merge

while_body:                                       ; preds = %while
  call void (...) @onRenderStartSDL()
  call void (...) @onRenderFinishSDL()
  br label %while

merge:                                            ; preds = %while
  %stopSDL_ret = alloca i32
  %stopSDL_ret1 = call i32 (...) @stopSDL()
  store i32 %stopSDL_ret1, i32* %stopSDL_ret
  %stopSDL_ret2 = load i32, i32* %stopSDL_ret
  ret i32 %stopSDL_ret2
}

define i32 @series(i32 %n) {
entry:
  %n1 = alloca i32
  store i32 %n, i32* %n1
  %x = alloca i32
  %tmp = load i32, i32* %n1
  %tmp2 = icmp slt i32 %tmp, 0
  br i1 %tmp2, label %then, label %merge

merge:                                            ; preds = %entry
  %tmp3 = load i32, i32* %n1
  %tmp4 = icmp slt i32 %tmp3, 2
  br i1 %tmp4, label %then6, label %merge5

then:                                             ; preds = %entry
  %intToString = alloca i8, i32 12
  %intToStringResult = call i32 (i8*, i8*, ...) @sprintf(i8* %intToString, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @int_fmt, i32 0, i32 0), i32 0)
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmt, i32 0, i32 0), i8* %intToString)
  ret i32 0

merge5:                                           ; preds = %merge
  %tmp12 = load i32, i32* %n1
  %tmp13 = load i32, i32* %n1
  %tmp14 = sub i32 %tmp13, 1
  %series_result = call i32 @series(i32 %tmp14)
  %tmp15 = add i32 %tmp12, %series_result
  store i32 %tmp15, i32* %x
  %tmp16 = load i32, i32* %x
  %intToString17 = alloca i8, i32 12
  %intToStringResult18 = call i32 (i8*, i8*, ...) @sprintf(i8* %intToString17, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @int_fmt, i32 0, i32 0), i32 %tmp16)
  %printf19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmt, i32 0, i32 0), i8* %intToString17)
  %tmp20 = load i32, i32* %x
  ret i32 %tmp20

then6:                                            ; preds = %merge
  %tmp7 = load i32, i32* %n1
  %intToString8 = alloca i8, i32 12
  %intToStringResult9 = call i32 (i8*, i8*, ...) @sprintf(i8* %intToString8, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @int_fmt, i32 0, i32 0), i32 %tmp7)
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmt, i32 0, i32 0), i8* %intToString8)
  %tmp11 = load i32, i32* %n1
  ret i32 %tmp11
}
