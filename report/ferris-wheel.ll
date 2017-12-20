; ModuleID = 'SOL'

%FerrisWheel = type { i32, double, i32, [2 x i32], %Polygon, %Spokes, [10 x %Square], [0 x i32], [0 x i32], [0 x i32], [0 x double], i32*, i32*, i32 }
%Polygon = type { [2 x i32], double, double, double, [3 x i32], [0 x i32], [0 x i32], [0 x i32], [0 x double], i32*, i32*, i32 }
%Spokes = type { [2 x i32], [3 x i32], double, double, double, [0 x i32], [0 x i32], [0 x i32], [0 x double], i32*, i32*, i32 }
%Square = type { %Polygon, [0 x i32], [0 x i32], [0 x i32], [0 x double], i32*, i32*, i32 }

@_Running = global i1 false
@fmt = global [4 x i8] c"%s\0A\00"
@int_fmt = global [3 x i8] c"%d\00"
@flt_fmt = global [3 x i8] c"%f\00"
@char_fmt = global [3 x i8] c"%c\00"
@tmp = private unnamed_addr constant [27 x i8] c"JAVANGERS Amusement Park !\00"

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
  %p = alloca %FerrisWheel
  %arr_copy = alloca [2 x i32]
  store [2 x i32] [i32 320, i32 240], [2 x i32]* %arr_copy
  %FerrisWheel_inst_ptr = call %FerrisWheel* @FerrisWheel__construct([2 x i32]* %arr_copy, i32 120, i32 10)
  %FerrisWheel_inst = load %FerrisWheel, %FerrisWheel* %FerrisWheel_inst_ptr
  store %FerrisWheel %FerrisWheel_inst, %FerrisWheel* %p
  call void @setFramerate(i32 15)
  %tmp = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 4
  %tmp1 = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 5
  %tmp2 = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 6
  %inst = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 0
  %inst3 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 1
  %inst4 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 2
  %inst5 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 3
  %inst6 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 4
  %inst7 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 5
  %inst8 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 6
  %inst9 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 7
  %inst10 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 8
  %inst11 = getelementptr [10 x %Square], [10 x %Square]* %tmp2, i32 0, i32 9
  %tmp12 = getelementptr inbounds %Square, %Square* %inst, i32 0, i32 0
  %tmp13 = getelementptr inbounds %Square, %Square* %inst3, i32 0, i32 0
  %tmp14 = getelementptr inbounds %Square, %Square* %inst4, i32 0, i32 0
  %tmp15 = getelementptr inbounds %Square, %Square* %inst5, i32 0, i32 0
  %tmp16 = getelementptr inbounds %Square, %Square* %inst6, i32 0, i32 0
  %tmp17 = getelementptr inbounds %Square, %Square* %inst7, i32 0, i32 0
  %tmp18 = getelementptr inbounds %Square, %Square* %inst8, i32 0, i32 0
  %tmp19 = getelementptr inbounds %Square, %Square* %inst9, i32 0, i32 0
  %tmp20 = getelementptr inbounds %Square, %Square* %inst10, i32 0, i32 0
  %tmp21 = getelementptr inbounds %Square, %Square* %inst11, i32 0, i32 0
  br label %while

while:                                            ; preds = %while_body, %entry
  %_Running_val = load i1, i1* @_Running
  br i1 %_Running_val, label %while_body, label %merge

while_body:                                       ; preds = %while
  call void (...) @onRenderStartSDL()
  call void @FerrisWheel__draw(%FerrisWheel* %p)
  call void @Polygon__draw(%Polygon* %tmp)
  call void @Polygon__draw(%Polygon* %tmp)
  call void @Spokes__draw(%Spokes* %tmp1)
  call void @Spokes__draw(%Spokes* %tmp1)
  call void @Square__draw(%Square* %inst)
  call void @Polygon__draw(%Polygon* %tmp12)
  call void @Polygon__draw(%Polygon* %tmp12)
  call void @Square__draw(%Square* %inst3)
  call void @Polygon__draw(%Polygon* %tmp13)
  call void @Polygon__draw(%Polygon* %tmp13)
  call void @Square__draw(%Square* %inst4)
  call void @Polygon__draw(%Polygon* %tmp14)
  call void @Polygon__draw(%Polygon* %tmp14)
  call void @Square__draw(%Square* %inst5)
  call void @Polygon__draw(%Polygon* %tmp15)
  call void @Polygon__draw(%Polygon* %tmp15)
  call void @Square__draw(%Square* %inst6)
  call void @Polygon__draw(%Polygon* %tmp16)
  call void @Polygon__draw(%Polygon* %tmp16)
  call void @Square__draw(%Square* %inst7)
  call void @Polygon__draw(%Polygon* %tmp17)
  call void @Polygon__draw(%Polygon* %tmp17)
  call void @Square__draw(%Square* %inst8)
  call void @Polygon__draw(%Polygon* %tmp18)
  call void @Polygon__draw(%Polygon* %tmp18)
  call void @Square__draw(%Square* %inst9)
  call void @Polygon__draw(%Polygon* %tmp19)
  call void @Polygon__draw(%Polygon* %tmp19)
  call void @Square__draw(%Square* %inst10)
  call void @Polygon__draw(%Polygon* %tmp20)
  call void @Polygon__draw(%Polygon* %tmp20)
  call void @Square__draw(%Square* %inst11)
  call void @Polygon__draw(%Polygon* %tmp21)
  call void @Polygon__draw(%Polygon* %tmp21)
  call void (...) @onRenderFinishSDL()
  br label %while

merge:                                            ; preds = %while
  %stopSDL_ret = alloca i32
  %stopSDL_ret22 = call i32 (...) @stopSDL()
  store i32 %stopSDL_ret22, i32* %stopSDL_ret
  %stopSDL_ret23 = load i32, i32* %stopSDL_ret
  ret i32 %stopSDL_ret23
}

define %FerrisWheel* @FerrisWheel__construct([2 x i32]* %ctr, i32 %r, i32 %n) {
entry:
  %__FerrisWheel_inst = alloca %FerrisWheel
  %num_frames = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 13
  store i32 0, i32* %num_frames
  %frames = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 0
  %radius = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 1
  %sides = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 2
  %center = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 3
  %plgn = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 4
  %spks = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 5
  %s = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 6
  %disp_vals_x = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 7
  %disp_vals_y = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 8
  %time_vals = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 9
  %time_vals1 = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 10
  %disp_x = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 11
  %disp_y = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 12
  %num_frames2 = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 13
  %r3 = alloca i32
  store i32 %r, i32* %r3
  %n4 = alloca i32
  store i32 %n, i32* %n4
  %i = alloca i32
  %degrees = alloca double
  %strt = alloca [2 x i32]
  %tmp = getelementptr [2 x i32], [2 x i32]* %ctr, i32 0, i32 1
  %tmp5 = load i32, i32* %tmp
  %tmp6 = add i32 %tmp5, 16
  %tmp7 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  store i32 %tmp6, i32* %tmp7
  %tmp8 = getelementptr [2 x i32], [2 x i32]* %ctr, i32 0, i32 0
  %tmp9 = load i32, i32* %tmp8
  %tmp10 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  store i32 %tmp9, i32* %tmp10
  store i32 0, i32* %frames
  %tmp11 = load i32, i32* %r3
  %intToFloat_func = call double @intToFloat(i32 %tmp11)
  store double %intToFloat_func, double* %radius
  %tmp12 = load i32, i32* %n4
  store i32 %tmp12, i32* %sides
  %arr_copy = alloca [3 x i32]
  store [3 x i32] [i32 160, i32 82, i32 45], [3 x i32]* %arr_copy
  %tmp13 = load i32, i32* %n4
  %tmp14 = load i32, i32* %r3
  %tmp15 = load [2 x i32], [2 x i32]* %ctr
  %arr_copy16 = alloca [2 x i32]
  store [2 x i32] %tmp15, [2 x i32]* %arr_copy16
  %Polygon_inst_ptr = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy16, i32 %tmp14, i32 %tmp13, double 0.000000e+00, [3 x i32]* %arr_copy)
  %Polygon_inst = load %Polygon, %Polygon* %Polygon_inst_ptr
  store %Polygon %Polygon_inst, %Polygon* %plgn
  %arr_copy17 = alloca [3 x i32]
  store [3 x i32] [i32 34, i32 139, i32 34], [3 x i32]* %arr_copy17
  %tmp18 = load i32, i32* %n4
  %tmp19 = load i32, i32* %r3
  %tmp20 = load [2 x i32], [2 x i32]* %ctr
  %arr_copy21 = alloca [2 x i32]
  store [2 x i32] %tmp20, [2 x i32]* %arr_copy21
  %Spokes_inst_ptr = call %Spokes* @Spokes__construct([2 x i32]* %arr_copy21, i32 %tmp19, i32 %tmp18, double 0.000000e+00, [3 x i32]* %arr_copy17)
  %Spokes_inst = load %Spokes, %Spokes* %Spokes_inst_ptr
  store %Spokes %Spokes_inst, %Spokes* %spks
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %tmp51 = load i32, i32* %i
  %tmp52 = load i32, i32* %sides
  %tmp53 = icmp slt i32 %tmp51, %tmp52
  br i1 %tmp53, label %while_body, label %merge

while_body:                                       ; preds = %while
  %tmp22 = load i32, i32* %i
  %intToFloat_func23 = call double @intToFloat(i32 %tmp22)
  %tmp24 = fmul double 3.600000e+02, %intToFloat_func23
  %tmp25 = load i32, i32* %sides
  %intToFloat_func26 = call double @intToFloat(i32 %tmp25)
  %tmp27 = fdiv double %tmp24, %intToFloat_func26
  store double %tmp27, double* %degrees
  %tmp28 = getelementptr [2 x i32], [2 x i32]* %ctr, i32 0, i32 0
  %tmp29 = load i32, i32* %tmp28
  %tmp30 = load double, double* %radius
  %tmp31 = load double, double* %degrees
  %cosine_func = call double (double, ...) @cosine(double %tmp31)
  %tmp32 = fmul double %tmp30, %cosine_func
  %floatToInt_func = call i32 @floatToInt(double %tmp32)
  %tmp33 = add i32 %tmp29, %floatToInt_func
  %tmp34 = add i32 %tmp33, 2
  %tmp35 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  store i32 %tmp34, i32* %tmp35
  %tmp36 = getelementptr [2 x i32], [2 x i32]* %ctr, i32 0, i32 1
  %tmp37 = load i32, i32* %tmp36
  %tmp38 = load double, double* %radius
  %tmp39 = load double, double* %degrees
  %sine_func = call double (double, ...) @sine(double %tmp39)
  %tmp40 = fmul double %tmp38, %sine_func
  %floatToInt_func41 = call i32 @floatToInt(double %tmp40)
  %tmp42 = add i32 %tmp37, %floatToInt_func41
  %tmp43 = add i32 %tmp42, 15
  %tmp44 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  store i32 %tmp43, i32* %tmp44
  %tmp45 = load [2 x i32], [2 x i32]* %strt
  %arr_copy46 = alloca [2 x i32]
  store [2 x i32] %tmp45, [2 x i32]* %arr_copy46
  %Square_inst_ptr = call %Square* @Square__construct([2 x i32]* %arr_copy46, i32 20)
  %Square_inst = load %Square, %Square* %Square_inst_ptr
  %tmp47 = load i32, i32* %i
  %tmp48 = getelementptr [10 x %Square], [10 x %Square]* %s, i32 0, i32 %tmp47
  store %Square %Square_inst, %Square* %tmp48
  %tmp49 = load i32, i32* %i
  %tmp50 = add i32 %tmp49, 1
  store i32 %tmp50, i32* %i
  br label %while

merge:                                            ; preds = %while
  ret %FerrisWheel* %__FerrisWheel_inst
}

define void @FerrisWheel__draw(%FerrisWheel* %__FerrisWheel_inst) {
entry:
  %frames = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 0
  %radius = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 1
  %sides = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 2
  %center = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 3
  %plgn = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 4
  %spks = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 5
  %s = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 6
  %disp_vals_x = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 7
  %disp_vals_y = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 8
  %time_vals = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 9
  %time_vals1 = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 10
  %disp_x = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 11
  %disp_y = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 12
  %num_frames = getelementptr inbounds %FerrisWheel, %FerrisWheel* %__FerrisWheel_inst, i32 0, i32 13
  %i = alloca i32
  %xn = alloca double
  %yn = alloca double
  %tmp = alloca %Square
  %deg = alloca double
  store double 0.000000e+00, double* %deg
  %tmp2 = load i32, i32* %frames
  %tmp3 = icmp sle i32 %tmp2, 100
  br i1 %tmp3, label %then, label %merge

merge:                                            ; preds = %entry, %then
  %tmp8 = load i32, i32* %frames
  %tmp9 = icmp sgt i32 %tmp8, 100
  %tmp10 = load i32, i32* %frames
  %tmp11 = icmp sle i32 %tmp10, 200
  %tmp12 = and i1 %tmp9, %tmp11
  br i1 %tmp12, label %then14, label %merge13

then:                                             ; preds = %entry
  %tmp4 = load i32, i32* %frames
  %tmp5 = sdiv i32 %tmp4, 10
  %intToFloat_func = call double @intToFloat(i32 %tmp5)
  store double %intToFloat_func, double* %deg
  %tmp6 = load i32, i32* %frames
  %tmp7 = add i32 %tmp6, 2
  store i32 %tmp7, i32* %frames
  br label %merge

merge13:                                          ; preds = %merge, %then14
  %tmp17 = load i32, i32* %frames
  %tmp18 = icmp sgt i32 %tmp17, 200
  %tmp19 = load i32, i32* %frames
  %tmp20 = icmp sle i32 %tmp19, 300
  %tmp21 = and i1 %tmp18, %tmp20
  br i1 %tmp21, label %then23, label %merge22

then14:                                           ; preds = %merge
  %tmp15 = load i32, i32* %frames
  %tmp16 = add i32 %tmp15, 1
  store i32 %tmp16, i32* %frames
  store double 1.000000e+01, double* %deg
  br label %merge13

merge22:                                          ; preds = %merge13, %then23
  %tmp30 = getelementptr inbounds %Polygon, %Polygon* %plgn, i32 0, i32 3
  %tmp31 = load double, double* %tmp30
  %tmp32 = load double, double* %deg
  %tmp33 = fadd double %tmp31, %tmp32
  %tmp34 = frem double %tmp33, 3.600000e+02
  %tmp35 = getelementptr inbounds %Polygon, %Polygon* %plgn, i32 0, i32 3
  store double %tmp34, double* %tmp35
  %tmp36 = getelementptr inbounds %Spokes, %Spokes* %spks, i32 0, i32 4
  %tmp37 = load double, double* %tmp36
  %tmp38 = load double, double* %deg
  %tmp39 = fadd double %tmp37, %tmp38
  %tmp40 = frem double %tmp39, 3.600000e+02
  %tmp41 = getelementptr inbounds %Spokes, %Spokes* %spks, i32 0, i32 4
  store double %tmp40, double* %tmp41
  store i32 0, i32* %i
  br label %while

then23:                                           ; preds = %merge13
  %tmp24 = load i32, i32* %frames
  %tmp25 = add i32 %tmp24, 2
  store i32 %tmp25, i32* %frames
  %tmp26 = load i32, i32* %frames
  %tmp27 = sub i32 300, %tmp26
  %tmp28 = sdiv i32 %tmp27, 10
  %intToFloat_func29 = call double @intToFloat(i32 %tmp28)
  store double %intToFloat_func29, double* %deg
  br label %merge22

while:                                            ; preds = %while_body, %merge22
  %tmp124 = load i32, i32* %i
  %tmp125 = load i32, i32* %sides
  %tmp126 = icmp slt i32 %tmp124, %tmp125
  br i1 %tmp126, label %while_body, label %merge127

while_body:                                       ; preds = %while
  %tmp42 = load i32, i32* %i
  %tmp43 = getelementptr [10 x %Square], [10 x %Square]* %s, i32 0, i32 %tmp42
  %tmp44 = load %Square, %Square* %tmp43
  store %Square %tmp44, %Square* %tmp
  %tmp45 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp46 = getelementptr inbounds %Polygon, %Polygon* %tmp45, i32 0, i32 0
  %tmp47 = getelementptr [2 x i32], [2 x i32]* %tmp46, i32 0, i32 0
  %tmp48 = load i32, i32* %tmp47
  %tmp49 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp50 = load i32, i32* %tmp49
  %tmp51 = sub i32 %tmp48, %tmp50
  %tmp52 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp53 = getelementptr inbounds %Polygon, %Polygon* %tmp52, i32 0, i32 0
  %tmp54 = getelementptr [2 x i32], [2 x i32]* %tmp53, i32 0, i32 0
  store i32 %tmp51, i32* %tmp54
  %tmp55 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp56 = getelementptr inbounds %Polygon, %Polygon* %tmp55, i32 0, i32 0
  %tmp57 = getelementptr [2 x i32], [2 x i32]* %tmp56, i32 0, i32 1
  %tmp58 = load i32, i32* %tmp57
  %tmp59 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp60 = load i32, i32* %tmp59
  %tmp61 = sub i32 %tmp58, %tmp60
  %tmp62 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp63 = getelementptr inbounds %Polygon, %Polygon* %tmp62, i32 0, i32 0
  %tmp64 = getelementptr [2 x i32], [2 x i32]* %tmp63, i32 0, i32 1
  store i32 %tmp61, i32* %tmp64
  %tmp65 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp66 = getelementptr inbounds %Polygon, %Polygon* %tmp65, i32 0, i32 0
  %tmp67 = getelementptr [2 x i32], [2 x i32]* %tmp66, i32 0, i32 0
  %tmp68 = load i32, i32* %tmp67
  %intToFloat_func69 = call double @intToFloat(i32 %tmp68)
  %tmp70 = load double, double* %deg
  %cosine_func = call double (double, ...) @cosine(double %tmp70)
  %tmp71 = fmul double %intToFloat_func69, %cosine_func
  store double %tmp71, double* %xn
  %tmp72 = load double, double* %xn
  %tmp73 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp74 = getelementptr inbounds %Polygon, %Polygon* %tmp73, i32 0, i32 0
  %tmp75 = getelementptr [2 x i32], [2 x i32]* %tmp74, i32 0, i32 1
  %tmp76 = load i32, i32* %tmp75
  %intToFloat_func77 = call double @intToFloat(i32 %tmp76)
  %tmp78 = load double, double* %deg
  %sine_func = call double (double, ...) @sine(double %tmp78)
  %tmp79 = fmul double %intToFloat_func77, %sine_func
  %tmp80 = fsub double %tmp72, %tmp79
  store double %tmp80, double* %xn
  %tmp81 = load double, double* %xn
  %tmp82 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp83 = load i32, i32* %tmp82
  %intToFloat_func84 = call double @intToFloat(i32 %tmp83)
  %tmp85 = fadd double %tmp81, %intToFloat_func84
  %round_func = call double (double, ...) @round(double %tmp85)
  store double %round_func, double* %xn
  %tmp86 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp87 = getelementptr inbounds %Polygon, %Polygon* %tmp86, i32 0, i32 0
  %tmp88 = getelementptr [2 x i32], [2 x i32]* %tmp87, i32 0, i32 0
  %tmp89 = load i32, i32* %tmp88
  %intToFloat_func90 = call double @intToFloat(i32 %tmp89)
  %tmp91 = load double, double* %deg
  %sine_func92 = call double (double, ...) @sine(double %tmp91)
  %tmp93 = fmul double %intToFloat_func90, %sine_func92
  store double %tmp93, double* %yn
  %tmp94 = load double, double* %yn
  %tmp95 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp96 = getelementptr inbounds %Polygon, %Polygon* %tmp95, i32 0, i32 0
  %tmp97 = getelementptr [2 x i32], [2 x i32]* %tmp96, i32 0, i32 1
  %tmp98 = load i32, i32* %tmp97
  %intToFloat_func99 = call double @intToFloat(i32 %tmp98)
  %tmp100 = load double, double* %deg
  %cosine_func101 = call double (double, ...) @cosine(double %tmp100)
  %tmp102 = fmul double %intToFloat_func99, %cosine_func101
  %tmp103 = fadd double %tmp94, %tmp102
  store double %tmp103, double* %yn
  %tmp104 = load double, double* %yn
  %tmp105 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp106 = load i32, i32* %tmp105
  %intToFloat_func107 = call double @intToFloat(i32 %tmp106)
  %tmp108 = fadd double %tmp104, %intToFloat_func107
  %round_func109 = call double (double, ...) @round(double %tmp108)
  store double %round_func109, double* %yn
  %tmp110 = load double, double* %xn
  %floatToInt_func = call i32 @floatToInt(double %tmp110)
  %tmp111 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp112 = getelementptr inbounds %Polygon, %Polygon* %tmp111, i32 0, i32 0
  %tmp113 = getelementptr [2 x i32], [2 x i32]* %tmp112, i32 0, i32 0
  store i32 %floatToInt_func, i32* %tmp113
  %tmp114 = load double, double* %yn
  %floatToInt_func115 = call i32 @floatToInt(double %tmp114)
  %tmp116 = getelementptr inbounds %Square, %Square* %tmp, i32 0, i32 0
  %tmp117 = getelementptr inbounds %Polygon, %Polygon* %tmp116, i32 0, i32 0
  %tmp118 = getelementptr [2 x i32], [2 x i32]* %tmp117, i32 0, i32 1
  store i32 %floatToInt_func115, i32* %tmp118
  %tmp119 = load %Square, %Square* %tmp
  %tmp120 = load i32, i32* %i
  %tmp121 = getelementptr [10 x %Square], [10 x %Square]* %s, i32 0, i32 %tmp120
  store %Square %tmp119, %Square* %tmp121
  %tmp122 = load i32, i32* %i
  %tmp123 = add i32 %tmp122, 1
  store i32 %tmp123, i32* %i
  br label %while

merge127:                                         ; preds = %while
  %arr_ptr = alloca [3 x i32]
  store [3 x i32] [i32 209, i32 125, i32 99], [3 x i32]* %arr_ptr
  %arr_ptr128 = alloca [2 x i32]
  store [2 x i32] [i32 240, i32 420], [2 x i32]* %arr_ptr128
  %load_disp_final_x = load i32*, i32** %disp_x
  %load_disp_final_y = load i32*, i32** %disp_y
  %load_num_frames = load i32, i32* %num_frames
  call void @translatePoint([2 x i32]* %arr_ptr128, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 1)
  %print_result = call i32 @print([2 x i32]* %arr_ptr128, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @tmp, i32 0, i32 0), [3 x i32]* %arr_ptr)
  call void @translatePoint([2 x i32]* %arr_ptr128, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 -1)
  ret void
}

define %Square* @Square__construct([2 x i32]* %ctr, i32 %r) {
entry:
  %__Square_inst = alloca %Square
  %num_frames = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 7
  store i32 0, i32* %num_frames
  %plgn = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 0
  %disp_vals_x = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 1
  %disp_vals_y = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 2
  %time_vals = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 3
  %time_vals1 = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 4
  %disp_x = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 5
  %disp_y = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 6
  %num_frames2 = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 7
  %r3 = alloca i32
  store i32 %r, i32* %r3
  %arr_copy = alloca [3 x i32]
  store [3 x i32] [i32 0, i32 0, i32 150], [3 x i32]* %arr_copy
  %tmp = load i32, i32* %r3
  %tmp4 = load [2 x i32], [2 x i32]* %ctr
  %arr_copy5 = alloca [2 x i32]
  store [2 x i32] %tmp4, [2 x i32]* %arr_copy5
  %Polygon_inst_ptr = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy5, i32 %tmp, i32 4, double 4.500000e+01, [3 x i32]* %arr_copy)
  %Polygon_inst = load %Polygon, %Polygon* %Polygon_inst_ptr
  store %Polygon %Polygon_inst, %Polygon* %plgn
  ret %Square* %__Square_inst
}

define void @Square__draw(%Square* %__Square_inst) {
entry:
  %plgn = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 0
  %disp_vals_x = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 1
  %disp_vals_y = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 2
  %time_vals = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 3
  %time_vals1 = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 4
  %disp_x = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 5
  %disp_y = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 6
  %num_frames = getelementptr inbounds %Square, %Square* %__Square_inst, i32 0, i32 7
  ret void
}

define %Polygon* @Polygon__construct([2 x i32]* %s, i32 %l, i32 %n, double %t, [3 x i32]* %clr) {
entry:
  %__Polygon_inst = alloca %Polygon
  %num_frames = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 11
  store i32 0, i32* %num_frames
  %center = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 0
  %sides = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 1
  %radius = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 2
  %theta = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 3
  %color = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 4
  %disp_vals_x = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 5
  %disp_vals_y = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 6
  %time_vals = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 7
  %time_vals1 = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 8
  %disp_x = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 9
  %disp_y = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 10
  %num_frames2 = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 11
  %l3 = alloca i32
  store i32 %l, i32* %l3
  %n4 = alloca i32
  store i32 %n, i32* %n4
  %t5 = alloca double
  store double %t, double* %t5
  %tmp = load [2 x i32], [2 x i32]* %s
  store [2 x i32] %tmp, [2 x i32]* %center
  %tmp6 = load [3 x i32], [3 x i32]* %clr
  store [3 x i32] %tmp6, [3 x i32]* %color
  %tmp7 = load double, double* %t5
  store double %tmp7, double* %theta
  %tmp8 = load i32, i32* %n4
  %intToFloat_func = call double @intToFloat(i32 %tmp8)
  store double %intToFloat_func, double* %sides
  %tmp9 = load i32, i32* %l3
  %intToFloat_func10 = call double @intToFloat(i32 %tmp9)
  store double %intToFloat_func10, double* %radius
  ret %Polygon* %__Polygon_inst
}

define void @Polygon__draw(%Polygon* %__Polygon_inst) {
entry:
  %center = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 0
  %sides = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 1
  %radius = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 2
  %theta = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 3
  %color = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 4
  %disp_vals_x = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 5
  %disp_vals_y = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 6
  %time_vals = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 7
  %time_vals1 = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 8
  %disp_x = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 9
  %disp_y = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 10
  %num_frames = getelementptr inbounds %Polygon, %Polygon* %__Polygon_inst, i32 0, i32 11
  %i = alloca double
  %degrees = alloca double
  %strt = alloca [2 x i32]
  %mid = alloca [2 x i32]
  %end = alloca [2 x i32]
  %tmp = load double, double* %theta
  store double %tmp, double* %degrees
  %tmp2 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp3 = load i32, i32* %tmp2
  %tmp4 = load double, double* %radius
  %tmp5 = load double, double* %degrees
  %cosine_func = call double (double, ...) @cosine(double %tmp5)
  %tmp6 = fmul double %tmp4, %cosine_func
  %floatToInt_func = call i32 @floatToInt(double %tmp6)
  %tmp7 = add i32 %tmp3, %floatToInt_func
  %tmp8 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  store i32 %tmp7, i32* %tmp8
  %tmp9 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp10 = load i32, i32* %tmp9
  %tmp11 = load double, double* %radius
  %tmp12 = load double, double* %degrees
  %sine_func = call double (double, ...) @sine(double %tmp12)
  %tmp13 = fmul double %tmp11, %sine_func
  %floatToInt_func14 = call i32 @floatToInt(double %tmp13)
  %tmp15 = add i32 %tmp10, %floatToInt_func14
  %tmp16 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  store i32 %tmp15, i32* %tmp16
  store double 1.000000e+00, double* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %tmp58 = load double, double* %i
  %tmp59 = load double, double* %sides
  %tmp60 = fcmp ole double %tmp58, %tmp59
  br i1 %tmp60, label %while_body, label %merge

while_body:                                       ; preds = %while
  %tmp17 = load double, double* %i
  %tmp18 = fmul double 3.600000e+02, %tmp17
  %tmp19 = load double, double* %sides
  %tmp20 = fdiv double %tmp18, %tmp19
  %tmp21 = load double, double* %theta
  %tmp22 = fadd double %tmp20, %tmp21
  store double %tmp22, double* %degrees
  %tmp23 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp24 = load i32, i32* %tmp23
  %tmp25 = load double, double* %radius
  %tmp26 = load double, double* %degrees
  %cosine_func27 = call double (double, ...) @cosine(double %tmp26)
  %tmp28 = fmul double %tmp25, %cosine_func27
  %floatToInt_func29 = call i32 @floatToInt(double %tmp28)
  %tmp30 = add i32 %tmp24, %floatToInt_func29
  %tmp31 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp30, i32* %tmp31
  %tmp32 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp33 = load i32, i32* %tmp32
  %tmp34 = load double, double* %radius
  %tmp35 = load double, double* %degrees
  %sine_func36 = call double (double, ...) @sine(double %tmp35)
  %tmp37 = fmul double %tmp34, %sine_func36
  %floatToInt_func38 = call i32 @floatToInt(double %tmp37)
  %tmp39 = add i32 %tmp33, %floatToInt_func38
  %tmp40 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  store i32 %tmp39, i32* %tmp40
  %tmp41 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  %tmp42 = load i32, i32* %tmp41
  %tmp43 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  %tmp44 = load i32, i32* %tmp43
  %tmp45 = add i32 %tmp42, %tmp44
  %tmp46 = sdiv i32 %tmp45, 2
  %tmp47 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 0
  store i32 %tmp46, i32* %tmp47
  %tmp48 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  %tmp49 = load i32, i32* %tmp48
  %tmp50 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  %tmp51 = load i32, i32* %tmp50
  %tmp52 = add i32 %tmp49, %tmp51
  %tmp53 = sdiv i32 %tmp52, 2
  %tmp54 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 1
  store i32 %tmp53, i32* %tmp54
  %load_disp_final_x = load i32*, i32** %disp_x
  %load_disp_final_y = load i32*, i32** %disp_y
  %load_num_frames = load i32, i32* %num_frames
  call void @translateCurve([2 x i32]* %strt, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 1)
  %drawCurve_result = call i32 @drawCurve([2 x i32]* %strt, [2 x i32]* %mid, [2 x i32]* %end, i32 2, [3 x i32]* %color)
  call void @translateCurve([2 x i32]* %strt, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 -1)
  %tmp55 = load [2 x i32], [2 x i32]* %end
  store [2 x i32] %tmp55, [2 x i32]* %strt
  %tmp56 = load double, double* %i
  %tmp57 = fadd double %tmp56, 1.000000e+00
  store double %tmp57, double* %i
  br label %while

merge:                                            ; preds = %while
  ret void
}

define %Spokes* @Spokes__construct([2 x i32]* %s, i32 %l, i32 %n, double %t, [3 x i32]* %clr) {
entry:
  %__Spokes_inst = alloca %Spokes
  %num_frames = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 11
  store i32 0, i32* %num_frames
  %center = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 0
  %color = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 1
  %sides = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 2
  %radius = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 3
  %theta = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 4
  %disp_vals_x = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 5
  %disp_vals_y = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 6
  %time_vals = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 7
  %time_vals1 = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 8
  %disp_x = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 9
  %disp_y = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 10
  %num_frames2 = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 11
  %l3 = alloca i32
  store i32 %l, i32* %l3
  %n4 = alloca i32
  store i32 %n, i32* %n4
  %t5 = alloca double
  store double %t, double* %t5
  %tmp = load [2 x i32], [2 x i32]* %s
  store [2 x i32] %tmp, [2 x i32]* %center
  %tmp6 = load [3 x i32], [3 x i32]* %clr
  store [3 x i32] %tmp6, [3 x i32]* %color
  %tmp7 = load double, double* %t5
  store double %tmp7, double* %theta
  %tmp8 = load i32, i32* %n4
  %intToFloat_func = call double @intToFloat(i32 %tmp8)
  store double %intToFloat_func, double* %sides
  %tmp9 = load i32, i32* %l3
  %intToFloat_func10 = call double @intToFloat(i32 %tmp9)
  store double %intToFloat_func10, double* %radius
  ret %Spokes* %__Spokes_inst
}

define void @Spokes__draw(%Spokes* %__Spokes_inst) {
entry:
  %center = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 0
  %color = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 1
  %sides = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 2
  %radius = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 3
  %theta = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 4
  %disp_vals_x = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 5
  %disp_vals_y = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 6
  %time_vals = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 7
  %time_vals1 = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 8
  %disp_x = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 9
  %disp_y = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 10
  %num_frames = getelementptr inbounds %Spokes, %Spokes* %__Spokes_inst, i32 0, i32 11
  %i = alloca double
  %x = alloca i32
  %y = alloca i32
  %degrees = alloca double
  %mid = alloca [2 x i32]
  %end = alloca [2 x i32]
  store double 0.000000e+00, double* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %tmp40 = load double, double* %i
  %tmp41 = load double, double* %sides
  %tmp42 = fcmp olt double %tmp40, %tmp41
  br i1 %tmp42, label %while_body, label %merge

while_body:                                       ; preds = %while
  %tmp = load double, double* %i
  %tmp2 = fmul double 3.600000e+02, %tmp
  %tmp3 = load double, double* %sides
  %tmp4 = fdiv double %tmp2, %tmp3
  %tmp5 = load double, double* %theta
  %tmp6 = fadd double %tmp4, %tmp5
  store double %tmp6, double* %degrees
  %tmp7 = load double, double* %radius
  %tmp8 = load double, double* %degrees
  %cosine_func = call double (double, ...) @cosine(double %tmp8)
  %tmp9 = fmul double %tmp7, %cosine_func
  %floatToInt_func = call i32 @floatToInt(double %tmp9)
  store i32 %floatToInt_func, i32* %x
  %tmp10 = load double, double* %radius
  %tmp11 = load double, double* %degrees
  %sine_func = call double (double, ...) @sine(double %tmp11)
  %tmp12 = fmul double %tmp10, %sine_func
  %floatToInt_func13 = call i32 @floatToInt(double %tmp12)
  store i32 %floatToInt_func13, i32* %y
  %tmp14 = load i32, i32* %x
  %tmp15 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp16 = load i32, i32* %tmp15
  %tmp17 = add i32 %tmp14, %tmp16
  %tmp18 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp17, i32* %tmp18
  %tmp19 = load i32, i32* %y
  %tmp20 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp21 = load i32, i32* %tmp20
  %tmp22 = add i32 %tmp19, %tmp21
  %tmp23 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  store i32 %tmp22, i32* %tmp23
  %tmp24 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 0
  %tmp25 = load i32, i32* %tmp24
  %tmp26 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  %tmp27 = load i32, i32* %tmp26
  %tmp28 = add i32 %tmp25, %tmp27
  %tmp29 = sdiv i32 %tmp28, 2
  %tmp30 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 0
  store i32 %tmp29, i32* %tmp30
  %tmp31 = getelementptr [2 x i32], [2 x i32]* %center, i32 0, i32 1
  %tmp32 = load i32, i32* %tmp31
  %tmp33 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  %tmp34 = load i32, i32* %tmp33
  %tmp35 = add i32 %tmp32, %tmp34
  %tmp36 = sdiv i32 %tmp35, 2
  %tmp37 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 1
  store i32 %tmp36, i32* %tmp37
  %load_disp_final_x = load i32*, i32** %disp_x
  %load_disp_final_y = load i32*, i32** %disp_y
  %load_num_frames = load i32, i32* %num_frames
  call void @translateCurve([2 x i32]* %center, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 1)
  %drawCurve_result = call i32 @drawCurve([2 x i32]* %center, [2 x i32]* %mid, [2 x i32]* %end, i32 2, [3 x i32]* %color)
  call void @translateCurve([2 x i32]* %center, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 -1)
  %tmp38 = load double, double* %i
  %tmp39 = fadd double %tmp38, 1.000000e+00
  store double %tmp39, double* %i
  br label %while

merge:                                            ; preds = %while
  ret void
}
