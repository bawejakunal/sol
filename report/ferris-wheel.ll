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
  %num_frames = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 13
  %num_frames_load = load i32, i32* %num_frames
  %bool_val = icmp ne i32 %num_frames_load, 0
  br i1 %bool_val, label %then, label %merge22

merge22:                                          ; preds = %merge, %then
  %num_frames23 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 11
  %num_frames_load24 = load i32, i32* %num_frames23
  %bool_val25 = icmp ne i32 %num_frames_load24, 0
  br i1 %bool_val25, label %then27, label %merge26

then:                                             ; preds = %merge
  %disp_x = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 11
  %disp_x_load = load i32*, i32** %disp_x
  %disp_y = getelementptr inbounds %FerrisWheel, %FerrisWheel* %p, i32 0, i32 12
  %disp_y_load = load i32*, i32** %disp_y
  %0 = bitcast i32* %disp_x_load to i8*
  tail call void @free(i8* %0)
  %1 = bitcast i32* %disp_y_load to i8*
  tail call void @free(i8* %1)
  store i32 0, i32* %num_frames
  br label %merge22

merge26:                                          ; preds = %merge22, %then27
  %num_frames32 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 11
  %num_frames_load33 = load i32, i32* %num_frames32
  %bool_val34 = icmp ne i32 %num_frames_load33, 0
  br i1 %bool_val34, label %then36, label %merge35

then27:                                           ; preds = %merge22
  %disp_x28 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 9
  %disp_x_load29 = load i32*, i32** %disp_x28
  %disp_y30 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 10
  %disp_y_load31 = load i32*, i32** %disp_y30
  %2 = bitcast i32* %disp_x_load29 to i8*
  tail call void @free(i8* %2)
  %3 = bitcast i32* %disp_y_load31 to i8*
  tail call void @free(i8* %3)
  store i32 0, i32* %num_frames23
  br label %merge26

merge35:                                          ; preds = %merge26, %then36
  %num_frames41 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 11
  %num_frames_load42 = load i32, i32* %num_frames41
  %bool_val43 = icmp ne i32 %num_frames_load42, 0
  br i1 %bool_val43, label %then45, label %merge44

then36:                                           ; preds = %merge26
  %disp_x37 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 9
  %disp_x_load38 = load i32*, i32** %disp_x37
  %disp_y39 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 10
  %disp_y_load40 = load i32*, i32** %disp_y39
  %4 = bitcast i32* %disp_x_load38 to i8*
  tail call void @free(i8* %4)
  %5 = bitcast i32* %disp_y_load40 to i8*
  tail call void @free(i8* %5)
  store i32 0, i32* %num_frames32
  br label %merge35

merge44:                                          ; preds = %merge35, %then45
  %num_frames50 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 11
  %num_frames_load51 = load i32, i32* %num_frames50
  %bool_val52 = icmp ne i32 %num_frames_load51, 0
  br i1 %bool_val52, label %then54, label %merge53

then45:                                           ; preds = %merge35
  %disp_x46 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 9
  %disp_x_load47 = load i32*, i32** %disp_x46
  %disp_y48 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 10
  %disp_y_load49 = load i32*, i32** %disp_y48
  %6 = bitcast i32* %disp_x_load47 to i8*
  tail call void @free(i8* %6)
  %7 = bitcast i32* %disp_y_load49 to i8*
  tail call void @free(i8* %7)
  store i32 0, i32* %num_frames41
  br label %merge44

merge53:                                          ; preds = %merge44, %then54
  %num_frames59 = getelementptr inbounds %Square, %Square* %inst, i32 0, i32 7
  %num_frames_load60 = load i32, i32* %num_frames59
  %bool_val61 = icmp ne i32 %num_frames_load60, 0
  br i1 %bool_val61, label %then63, label %merge62

then54:                                           ; preds = %merge44
  %disp_x55 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 9
  %disp_x_load56 = load i32*, i32** %disp_x55
  %disp_y57 = getelementptr inbounds %Spokes, %Spokes* %tmp1, i32 0, i32 10
  %disp_y_load58 = load i32*, i32** %disp_y57
  %8 = bitcast i32* %disp_x_load56 to i8*
  tail call void @free(i8* %8)
  %9 = bitcast i32* %disp_y_load58 to i8*
  tail call void @free(i8* %9)
  store i32 0, i32* %num_frames50
  br label %merge53

merge62:                                          ; preds = %merge53, %then63
  %num_frames68 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 11
  %num_frames_load69 = load i32, i32* %num_frames68
  %bool_val70 = icmp ne i32 %num_frames_load69, 0
  br i1 %bool_val70, label %then72, label %merge71

then63:                                           ; preds = %merge53
  %disp_x64 = getelementptr inbounds %Square, %Square* %inst, i32 0, i32 5
  %disp_x_load65 = load i32*, i32** %disp_x64
  %disp_y66 = getelementptr inbounds %Square, %Square* %inst, i32 0, i32 6
  %disp_y_load67 = load i32*, i32** %disp_y66
  %10 = bitcast i32* %disp_x_load65 to i8*
  tail call void @free(i8* %10)
  %11 = bitcast i32* %disp_y_load67 to i8*
  tail call void @free(i8* %11)
  store i32 0, i32* %num_frames59
  br label %merge62

merge71:                                          ; preds = %merge62, %then72
  %num_frames77 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 11
  %num_frames_load78 = load i32, i32* %num_frames77
  %bool_val79 = icmp ne i32 %num_frames_load78, 0
  br i1 %bool_val79, label %then81, label %merge80

then72:                                           ; preds = %merge62
  %disp_x73 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 9
  %disp_x_load74 = load i32*, i32** %disp_x73
  %disp_y75 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 10
  %disp_y_load76 = load i32*, i32** %disp_y75
  %12 = bitcast i32* %disp_x_load74 to i8*
  tail call void @free(i8* %12)
  %13 = bitcast i32* %disp_y_load76 to i8*
  tail call void @free(i8* %13)
  store i32 0, i32* %num_frames68
  br label %merge71

merge80:                                          ; preds = %merge71, %then81
  %num_frames86 = getelementptr inbounds %Square, %Square* %inst3, i32 0, i32 7
  %num_frames_load87 = load i32, i32* %num_frames86
  %bool_val88 = icmp ne i32 %num_frames_load87, 0
  br i1 %bool_val88, label %then90, label %merge89

then81:                                           ; preds = %merge71
  %disp_x82 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 9
  %disp_x_load83 = load i32*, i32** %disp_x82
  %disp_y84 = getelementptr inbounds %Polygon, %Polygon* %tmp12, i32 0, i32 10
  %disp_y_load85 = load i32*, i32** %disp_y84
  %14 = bitcast i32* %disp_x_load83 to i8*
  tail call void @free(i8* %14)
  %15 = bitcast i32* %disp_y_load85 to i8*
  tail call void @free(i8* %15)
  store i32 0, i32* %num_frames77
  br label %merge80

merge89:                                          ; preds = %merge80, %then90
  %num_frames95 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 11
  %num_frames_load96 = load i32, i32* %num_frames95
  %bool_val97 = icmp ne i32 %num_frames_load96, 0
  br i1 %bool_val97, label %then99, label %merge98

then90:                                           ; preds = %merge80
  %disp_x91 = getelementptr inbounds %Square, %Square* %inst3, i32 0, i32 5
  %disp_x_load92 = load i32*, i32** %disp_x91
  %disp_y93 = getelementptr inbounds %Square, %Square* %inst3, i32 0, i32 6
  %disp_y_load94 = load i32*, i32** %disp_y93
  %16 = bitcast i32* %disp_x_load92 to i8*
  tail call void @free(i8* %16)
  %17 = bitcast i32* %disp_y_load94 to i8*
  tail call void @free(i8* %17)
  store i32 0, i32* %num_frames86
  br label %merge89

merge98:                                          ; preds = %merge89, %then99
  %num_frames104 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 11
  %num_frames_load105 = load i32, i32* %num_frames104
  %bool_val106 = icmp ne i32 %num_frames_load105, 0
  br i1 %bool_val106, label %then108, label %merge107

then99:                                           ; preds = %merge89
  %disp_x100 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 9
  %disp_x_load101 = load i32*, i32** %disp_x100
  %disp_y102 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 10
  %disp_y_load103 = load i32*, i32** %disp_y102
  %18 = bitcast i32* %disp_x_load101 to i8*
  tail call void @free(i8* %18)
  %19 = bitcast i32* %disp_y_load103 to i8*
  tail call void @free(i8* %19)
  store i32 0, i32* %num_frames95
  br label %merge98

merge107:                                         ; preds = %merge98, %then108
  %num_frames113 = getelementptr inbounds %Square, %Square* %inst4, i32 0, i32 7
  %num_frames_load114 = load i32, i32* %num_frames113
  %bool_val115 = icmp ne i32 %num_frames_load114, 0
  br i1 %bool_val115, label %then117, label %merge116

then108:                                          ; preds = %merge98
  %disp_x109 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 9
  %disp_x_load110 = load i32*, i32** %disp_x109
  %disp_y111 = getelementptr inbounds %Polygon, %Polygon* %tmp13, i32 0, i32 10
  %disp_y_load112 = load i32*, i32** %disp_y111
  %20 = bitcast i32* %disp_x_load110 to i8*
  tail call void @free(i8* %20)
  %21 = bitcast i32* %disp_y_load112 to i8*
  tail call void @free(i8* %21)
  store i32 0, i32* %num_frames104
  br label %merge107

merge116:                                         ; preds = %merge107, %then117
  %num_frames122 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 11
  %num_frames_load123 = load i32, i32* %num_frames122
  %bool_val124 = icmp ne i32 %num_frames_load123, 0
  br i1 %bool_val124, label %then126, label %merge125

then117:                                          ; preds = %merge107
  %disp_x118 = getelementptr inbounds %Square, %Square* %inst4, i32 0, i32 5
  %disp_x_load119 = load i32*, i32** %disp_x118
  %disp_y120 = getelementptr inbounds %Square, %Square* %inst4, i32 0, i32 6
  %disp_y_load121 = load i32*, i32** %disp_y120
  %22 = bitcast i32* %disp_x_load119 to i8*
  tail call void @free(i8* %22)
  %23 = bitcast i32* %disp_y_load121 to i8*
  tail call void @free(i8* %23)
  store i32 0, i32* %num_frames113
  br label %merge116

merge125:                                         ; preds = %merge116, %then126
  %num_frames131 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 11
  %num_frames_load132 = load i32, i32* %num_frames131
  %bool_val133 = icmp ne i32 %num_frames_load132, 0
  br i1 %bool_val133, label %then135, label %merge134

then126:                                          ; preds = %merge116
  %disp_x127 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 9
  %disp_x_load128 = load i32*, i32** %disp_x127
  %disp_y129 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 10
  %disp_y_load130 = load i32*, i32** %disp_y129
  %24 = bitcast i32* %disp_x_load128 to i8*
  tail call void @free(i8* %24)
  %25 = bitcast i32* %disp_y_load130 to i8*
  tail call void @free(i8* %25)
  store i32 0, i32* %num_frames122
  br label %merge125

merge134:                                         ; preds = %merge125, %then135
  %num_frames140 = getelementptr inbounds %Square, %Square* %inst5, i32 0, i32 7
  %num_frames_load141 = load i32, i32* %num_frames140
  %bool_val142 = icmp ne i32 %num_frames_load141, 0
  br i1 %bool_val142, label %then144, label %merge143

then135:                                          ; preds = %merge125
  %disp_x136 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 9
  %disp_x_load137 = load i32*, i32** %disp_x136
  %disp_y138 = getelementptr inbounds %Polygon, %Polygon* %tmp14, i32 0, i32 10
  %disp_y_load139 = load i32*, i32** %disp_y138
  %26 = bitcast i32* %disp_x_load137 to i8*
  tail call void @free(i8* %26)
  %27 = bitcast i32* %disp_y_load139 to i8*
  tail call void @free(i8* %27)
  store i32 0, i32* %num_frames131
  br label %merge134

merge143:                                         ; preds = %merge134, %then144
  %num_frames149 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 11
  %num_frames_load150 = load i32, i32* %num_frames149
  %bool_val151 = icmp ne i32 %num_frames_load150, 0
  br i1 %bool_val151, label %then153, label %merge152

then144:                                          ; preds = %merge134
  %disp_x145 = getelementptr inbounds %Square, %Square* %inst5, i32 0, i32 5
  %disp_x_load146 = load i32*, i32** %disp_x145
  %disp_y147 = getelementptr inbounds %Square, %Square* %inst5, i32 0, i32 6
  %disp_y_load148 = load i32*, i32** %disp_y147
  %28 = bitcast i32* %disp_x_load146 to i8*
  tail call void @free(i8* %28)
  %29 = bitcast i32* %disp_y_load148 to i8*
  tail call void @free(i8* %29)
  store i32 0, i32* %num_frames140
  br label %merge143

merge152:                                         ; preds = %merge143, %then153
  %num_frames158 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 11
  %num_frames_load159 = load i32, i32* %num_frames158
  %bool_val160 = icmp ne i32 %num_frames_load159, 0
  br i1 %bool_val160, label %then162, label %merge161

then153:                                          ; preds = %merge143
  %disp_x154 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 9
  %disp_x_load155 = load i32*, i32** %disp_x154
  %disp_y156 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 10
  %disp_y_load157 = load i32*, i32** %disp_y156
  %30 = bitcast i32* %disp_x_load155 to i8*
  tail call void @free(i8* %30)
  %31 = bitcast i32* %disp_y_load157 to i8*
  tail call void @free(i8* %31)
  store i32 0, i32* %num_frames149
  br label %merge152

merge161:                                         ; preds = %merge152, %then162
  %num_frames167 = getelementptr inbounds %Square, %Square* %inst6, i32 0, i32 7
  %num_frames_load168 = load i32, i32* %num_frames167
  %bool_val169 = icmp ne i32 %num_frames_load168, 0
  br i1 %bool_val169, label %then171, label %merge170

then162:                                          ; preds = %merge152
  %disp_x163 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 9
  %disp_x_load164 = load i32*, i32** %disp_x163
  %disp_y165 = getelementptr inbounds %Polygon, %Polygon* %tmp15, i32 0, i32 10
  %disp_y_load166 = load i32*, i32** %disp_y165
  %32 = bitcast i32* %disp_x_load164 to i8*
  tail call void @free(i8* %32)
  %33 = bitcast i32* %disp_y_load166 to i8*
  tail call void @free(i8* %33)
  store i32 0, i32* %num_frames158
  br label %merge161

merge170:                                         ; preds = %merge161, %then171
  %num_frames176 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 11
  %num_frames_load177 = load i32, i32* %num_frames176
  %bool_val178 = icmp ne i32 %num_frames_load177, 0
  br i1 %bool_val178, label %then180, label %merge179

then171:                                          ; preds = %merge161
  %disp_x172 = getelementptr inbounds %Square, %Square* %inst6, i32 0, i32 5
  %disp_x_load173 = load i32*, i32** %disp_x172
  %disp_y174 = getelementptr inbounds %Square, %Square* %inst6, i32 0, i32 6
  %disp_y_load175 = load i32*, i32** %disp_y174
  %34 = bitcast i32* %disp_x_load173 to i8*
  tail call void @free(i8* %34)
  %35 = bitcast i32* %disp_y_load175 to i8*
  tail call void @free(i8* %35)
  store i32 0, i32* %num_frames167
  br label %merge170

merge179:                                         ; preds = %merge170, %then180
  %num_frames185 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 11
  %num_frames_load186 = load i32, i32* %num_frames185
  %bool_val187 = icmp ne i32 %num_frames_load186, 0
  br i1 %bool_val187, label %then189, label %merge188

then180:                                          ; preds = %merge170
  %disp_x181 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 9
  %disp_x_load182 = load i32*, i32** %disp_x181
  %disp_y183 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 10
  %disp_y_load184 = load i32*, i32** %disp_y183
  %36 = bitcast i32* %disp_x_load182 to i8*
  tail call void @free(i8* %36)
  %37 = bitcast i32* %disp_y_load184 to i8*
  tail call void @free(i8* %37)
  store i32 0, i32* %num_frames176
  br label %merge179

merge188:                                         ; preds = %merge179, %then189
  %num_frames194 = getelementptr inbounds %Square, %Square* %inst7, i32 0, i32 7
  %num_frames_load195 = load i32, i32* %num_frames194
  %bool_val196 = icmp ne i32 %num_frames_load195, 0
  br i1 %bool_val196, label %then198, label %merge197

then189:                                          ; preds = %merge179
  %disp_x190 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 9
  %disp_x_load191 = load i32*, i32** %disp_x190
  %disp_y192 = getelementptr inbounds %Polygon, %Polygon* %tmp16, i32 0, i32 10
  %disp_y_load193 = load i32*, i32** %disp_y192
  %38 = bitcast i32* %disp_x_load191 to i8*
  tail call void @free(i8* %38)
  %39 = bitcast i32* %disp_y_load193 to i8*
  tail call void @free(i8* %39)
  store i32 0, i32* %num_frames185
  br label %merge188

merge197:                                         ; preds = %merge188, %then198
  %num_frames203 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 11
  %num_frames_load204 = load i32, i32* %num_frames203
  %bool_val205 = icmp ne i32 %num_frames_load204, 0
  br i1 %bool_val205, label %then207, label %merge206

then198:                                          ; preds = %merge188
  %disp_x199 = getelementptr inbounds %Square, %Square* %inst7, i32 0, i32 5
  %disp_x_load200 = load i32*, i32** %disp_x199
  %disp_y201 = getelementptr inbounds %Square, %Square* %inst7, i32 0, i32 6
  %disp_y_load202 = load i32*, i32** %disp_y201
  %40 = bitcast i32* %disp_x_load200 to i8*
  tail call void @free(i8* %40)
  %41 = bitcast i32* %disp_y_load202 to i8*
  tail call void @free(i8* %41)
  store i32 0, i32* %num_frames194
  br label %merge197

merge206:                                         ; preds = %merge197, %then207
  %num_frames212 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 11
  %num_frames_load213 = load i32, i32* %num_frames212
  %bool_val214 = icmp ne i32 %num_frames_load213, 0
  br i1 %bool_val214, label %then216, label %merge215

then207:                                          ; preds = %merge197
  %disp_x208 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 9
  %disp_x_load209 = load i32*, i32** %disp_x208
  %disp_y210 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 10
  %disp_y_load211 = load i32*, i32** %disp_y210
  %42 = bitcast i32* %disp_x_load209 to i8*
  tail call void @free(i8* %42)
  %43 = bitcast i32* %disp_y_load211 to i8*
  tail call void @free(i8* %43)
  store i32 0, i32* %num_frames203
  br label %merge206

merge215:                                         ; preds = %merge206, %then216
  %num_frames221 = getelementptr inbounds %Square, %Square* %inst8, i32 0, i32 7
  %num_frames_load222 = load i32, i32* %num_frames221
  %bool_val223 = icmp ne i32 %num_frames_load222, 0
  br i1 %bool_val223, label %then225, label %merge224

then216:                                          ; preds = %merge206
  %disp_x217 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 9
  %disp_x_load218 = load i32*, i32** %disp_x217
  %disp_y219 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 10
  %disp_y_load220 = load i32*, i32** %disp_y219
  %44 = bitcast i32* %disp_x_load218 to i8*
  tail call void @free(i8* %44)
  %45 = bitcast i32* %disp_y_load220 to i8*
  tail call void @free(i8* %45)
  store i32 0, i32* %num_frames212
  br label %merge215

merge224:                                         ; preds = %merge215, %then225
  %num_frames230 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 11
  %num_frames_load231 = load i32, i32* %num_frames230
  %bool_val232 = icmp ne i32 %num_frames_load231, 0
  br i1 %bool_val232, label %then234, label %merge233

then225:                                          ; preds = %merge215
  %disp_x226 = getelementptr inbounds %Square, %Square* %inst8, i32 0, i32 5
  %disp_x_load227 = load i32*, i32** %disp_x226
  %disp_y228 = getelementptr inbounds %Square, %Square* %inst8, i32 0, i32 6
  %disp_y_load229 = load i32*, i32** %disp_y228
  %46 = bitcast i32* %disp_x_load227 to i8*
  tail call void @free(i8* %46)
  %47 = bitcast i32* %disp_y_load229 to i8*
  tail call void @free(i8* %47)
  store i32 0, i32* %num_frames221
  br label %merge224

merge233:                                         ; preds = %merge224, %then234
  %num_frames239 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 11
  %num_frames_load240 = load i32, i32* %num_frames239
  %bool_val241 = icmp ne i32 %num_frames_load240, 0
  br i1 %bool_val241, label %then243, label %merge242

then234:                                          ; preds = %merge224
  %disp_x235 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 9
  %disp_x_load236 = load i32*, i32** %disp_x235
  %disp_y237 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 10
  %disp_y_load238 = load i32*, i32** %disp_y237
  %48 = bitcast i32* %disp_x_load236 to i8*
  tail call void @free(i8* %48)
  %49 = bitcast i32* %disp_y_load238 to i8*
  tail call void @free(i8* %49)
  store i32 0, i32* %num_frames230
  br label %merge233

merge242:                                         ; preds = %merge233, %then243
  %num_frames248 = getelementptr inbounds %Square, %Square* %inst9, i32 0, i32 7
  %num_frames_load249 = load i32, i32* %num_frames248
  %bool_val250 = icmp ne i32 %num_frames_load249, 0
  br i1 %bool_val250, label %then252, label %merge251

then243:                                          ; preds = %merge233
  %disp_x244 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 9
  %disp_x_load245 = load i32*, i32** %disp_x244
  %disp_y246 = getelementptr inbounds %Polygon, %Polygon* %tmp18, i32 0, i32 10
  %disp_y_load247 = load i32*, i32** %disp_y246
  %50 = bitcast i32* %disp_x_load245 to i8*
  tail call void @free(i8* %50)
  %51 = bitcast i32* %disp_y_load247 to i8*
  tail call void @free(i8* %51)
  store i32 0, i32* %num_frames239
  br label %merge242

merge251:                                         ; preds = %merge242, %then252
  %num_frames257 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 11
  %num_frames_load258 = load i32, i32* %num_frames257
  %bool_val259 = icmp ne i32 %num_frames_load258, 0
  br i1 %bool_val259, label %then261, label %merge260

then252:                                          ; preds = %merge242
  %disp_x253 = getelementptr inbounds %Square, %Square* %inst9, i32 0, i32 5
  %disp_x_load254 = load i32*, i32** %disp_x253
  %disp_y255 = getelementptr inbounds %Square, %Square* %inst9, i32 0, i32 6
  %disp_y_load256 = load i32*, i32** %disp_y255
  %52 = bitcast i32* %disp_x_load254 to i8*
  tail call void @free(i8* %52)
  %53 = bitcast i32* %disp_y_load256 to i8*
  tail call void @free(i8* %53)
  store i32 0, i32* %num_frames248
  br label %merge251

merge260:                                         ; preds = %merge251, %then261
  %num_frames266 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 11
  %num_frames_load267 = load i32, i32* %num_frames266
  %bool_val268 = icmp ne i32 %num_frames_load267, 0
  br i1 %bool_val268, label %then270, label %merge269

then261:                                          ; preds = %merge251
  %disp_x262 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 9
  %disp_x_load263 = load i32*, i32** %disp_x262
  %disp_y264 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 10
  %disp_y_load265 = load i32*, i32** %disp_y264
  %54 = bitcast i32* %disp_x_load263 to i8*
  tail call void @free(i8* %54)
  %55 = bitcast i32* %disp_y_load265 to i8*
  tail call void @free(i8* %55)
  store i32 0, i32* %num_frames257
  br label %merge260

merge269:                                         ; preds = %merge260, %then270
  %num_frames275 = getelementptr inbounds %Square, %Square* %inst10, i32 0, i32 7
  %num_frames_load276 = load i32, i32* %num_frames275
  %bool_val277 = icmp ne i32 %num_frames_load276, 0
  br i1 %bool_val277, label %then279, label %merge278

then270:                                          ; preds = %merge260
  %disp_x271 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 9
  %disp_x_load272 = load i32*, i32** %disp_x271
  %disp_y273 = getelementptr inbounds %Polygon, %Polygon* %tmp19, i32 0, i32 10
  %disp_y_load274 = load i32*, i32** %disp_y273
  %56 = bitcast i32* %disp_x_load272 to i8*
  tail call void @free(i8* %56)
  %57 = bitcast i32* %disp_y_load274 to i8*
  tail call void @free(i8* %57)
  store i32 0, i32* %num_frames266
  br label %merge269

merge278:                                         ; preds = %merge269, %then279
  %num_frames284 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 11
  %num_frames_load285 = load i32, i32* %num_frames284
  %bool_val286 = icmp ne i32 %num_frames_load285, 0
  br i1 %bool_val286, label %then288, label %merge287

then279:                                          ; preds = %merge269
  %disp_x280 = getelementptr inbounds %Square, %Square* %inst10, i32 0, i32 5
  %disp_x_load281 = load i32*, i32** %disp_x280
  %disp_y282 = getelementptr inbounds %Square, %Square* %inst10, i32 0, i32 6
  %disp_y_load283 = load i32*, i32** %disp_y282
  %58 = bitcast i32* %disp_x_load281 to i8*
  tail call void @free(i8* %58)
  %59 = bitcast i32* %disp_y_load283 to i8*
  tail call void @free(i8* %59)
  store i32 0, i32* %num_frames275
  br label %merge278

merge287:                                         ; preds = %merge278, %then288
  %num_frames293 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 11
  %num_frames_load294 = load i32, i32* %num_frames293
  %bool_val295 = icmp ne i32 %num_frames_load294, 0
  br i1 %bool_val295, label %then297, label %merge296

then288:                                          ; preds = %merge278
  %disp_x289 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 9
  %disp_x_load290 = load i32*, i32** %disp_x289
  %disp_y291 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 10
  %disp_y_load292 = load i32*, i32** %disp_y291
  %60 = bitcast i32* %disp_x_load290 to i8*
  tail call void @free(i8* %60)
  %61 = bitcast i32* %disp_y_load292 to i8*
  tail call void @free(i8* %61)
  store i32 0, i32* %num_frames284
  br label %merge287

merge296:                                         ; preds = %merge287, %then297
  %num_frames302 = getelementptr inbounds %Square, %Square* %inst11, i32 0, i32 7
  %num_frames_load303 = load i32, i32* %num_frames302
  %bool_val304 = icmp ne i32 %num_frames_load303, 0
  br i1 %bool_val304, label %then306, label %merge305

then297:                                          ; preds = %merge287
  %disp_x298 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 9
  %disp_x_load299 = load i32*, i32** %disp_x298
  %disp_y300 = getelementptr inbounds %Polygon, %Polygon* %tmp20, i32 0, i32 10
  %disp_y_load301 = load i32*, i32** %disp_y300
  %62 = bitcast i32* %disp_x_load299 to i8*
  tail call void @free(i8* %62)
  %63 = bitcast i32* %disp_y_load301 to i8*
  tail call void @free(i8* %63)
  store i32 0, i32* %num_frames293
  br label %merge296

merge305:                                         ; preds = %merge296, %then306
  %num_frames311 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 11
  %num_frames_load312 = load i32, i32* %num_frames311
  %bool_val313 = icmp ne i32 %num_frames_load312, 0
  br i1 %bool_val313, label %then315, label %merge314

then306:                                          ; preds = %merge296
  %disp_x307 = getelementptr inbounds %Square, %Square* %inst11, i32 0, i32 5
  %disp_x_load308 = load i32*, i32** %disp_x307
  %disp_y309 = getelementptr inbounds %Square, %Square* %inst11, i32 0, i32 6
  %disp_y_load310 = load i32*, i32** %disp_y309
  %64 = bitcast i32* %disp_x_load308 to i8*
  tail call void @free(i8* %64)
  %65 = bitcast i32* %disp_y_load310 to i8*
  tail call void @free(i8* %65)
  store i32 0, i32* %num_frames302
  br label %merge305

merge314:                                         ; preds = %merge305, %then315
  %num_frames320 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 11
  %num_frames_load321 = load i32, i32* %num_frames320
  %bool_val322 = icmp ne i32 %num_frames_load321, 0
  br i1 %bool_val322, label %then324, label %merge323

then315:                                          ; preds = %merge305
  %disp_x316 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 9
  %disp_x_load317 = load i32*, i32** %disp_x316
  %disp_y318 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 10
  %disp_y_load319 = load i32*, i32** %disp_y318
  %66 = bitcast i32* %disp_x_load317 to i8*
  tail call void @free(i8* %66)
  %67 = bitcast i32* %disp_y_load319 to i8*
  tail call void @free(i8* %67)
  store i32 0, i32* %num_frames311
  br label %merge314

merge323:                                         ; preds = %merge314, %then324
  %stopSDL_ret = alloca i32
  %stopSDL_ret329 = call i32 (...) @stopSDL()
  store i32 %stopSDL_ret329, i32* %stopSDL_ret
  %stopSDL_ret330 = load i32, i32* %stopSDL_ret
  ret i32 %stopSDL_ret330

then324:                                          ; preds = %merge314
  %disp_x325 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 9
  %disp_x_load326 = load i32*, i32** %disp_x325
  %disp_y327 = getelementptr inbounds %Polygon, %Polygon* %tmp21, i32 0, i32 10
  %disp_y_load328 = load i32*, i32** %disp_y327
  %68 = bitcast i32* %disp_x_load326 to i8*
  tail call void @free(i8* %68)
  %69 = bitcast i32* %disp_y_load328 to i8*
  tail call void @free(i8* %69)
  store i32 0, i32* %num_frames320
  br label %merge323
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

declare void @free(i8*)
