; ModuleID = 'SOL'

%Polygon = type { [2 x i32], double, double, double, [3 x i32], [1 x i32], [1 x i32], [1 x i32], [1 x double], i32*, i32*, i32 }
%Person = type { %Polygon, %Line, %Line, %Line, %Line, %Line, i32, [1 x i32], [1 x i32], [1 x i32], [1 x double], i32*, i32*, i32 }
%Line = type { [2 x i32], [2 x i32], [2 x i32], [1 x i32], [1 x i32], [1 x i32], [1 x double], i32*, i32*, i32 }

@_Running = global i1 false
@fmt = global [4 x i8] c"%s\0A\00"
@int_fmt = global [3 x i8] c"%d\00"
@flt_fmt = global [3 x i8] c"%f\00"
@char_fmt = global [3 x i8] c"%c\00"
@tmp = private unnamed_addr constant [31 x i8] c"The name is Bond. James Bond !\00"

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
  %c1 = alloca %Polygon
  %c2 = alloca %Polygon
  %c3 = alloca %Polygon
  %bond = alloca %Person
  %arr_copy = alloca [3 x i32]
  store [3 x i32] [i32 0, i32 0, i32 150], [3 x i32]* %arr_copy
  %arr_copy1 = alloca [2 x i32]
  store [2 x i32] [i32 -50, i32 100], [2 x i32]* %arr_copy1
  %Polygon_inst_ptr = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy1, i32 40, i32 80, double 3.000000e+01, [3 x i32]* %arr_copy)
  %Polygon_inst = load %Polygon, %Polygon* %Polygon_inst_ptr
  store %Polygon %Polygon_inst, %Polygon* %c1
  %arr_copy2 = alloca [3 x i32]
  store [3 x i32] [i32 0, i32 150, i32 0], [3 x i32]* %arr_copy2
  %arr_copy3 = alloca [2 x i32]
  store [2 x i32] [i32 -50, i32 100], [2 x i32]* %arr_copy3
  %Polygon_inst_ptr4 = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy3, i32 40, i32 80, double 3.000000e+01, [3 x i32]* %arr_copy2)
  %Polygon_inst5 = load %Polygon, %Polygon* %Polygon_inst_ptr4
  store %Polygon %Polygon_inst5, %Polygon* %c2
  %arr_copy6 = alloca [3 x i32]
  store [3 x i32] [i32 150, i32 0, i32 0], [3 x i32]* %arr_copy6
  %arr_copy7 = alloca [2 x i32]
  store [2 x i32] [i32 -50, i32 100], [2 x i32]* %arr_copy7
  %Polygon_inst_ptr8 = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy7, i32 40, i32 80, double 3.000000e+01, [3 x i32]* %arr_copy6)
  %Polygon_inst9 = load %Polygon, %Polygon* %Polygon_inst_ptr8
  store %Polygon %Polygon_inst9, %Polygon* %c3
  %arr_copy10 = alloca [2 x i32]
  store [2 x i32] [i32 -50, i32 80], [2 x i32]* %arr_copy10
  %Person_inst_ptr = call %Person* @Person__construct([2 x i32]* %arr_copy10)
  %Person_inst = load %Person, %Person* %Person_inst_ptr
  store %Person %Person_inst, %Person* %bond
  %tmp = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 0
  %tmp11 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 1
  %tmp12 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 2
  %tmp13 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 3
  %tmp14 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 4
  %tmp15 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 5
  %arr_ptr = alloca [2 x i32]
  store [2 x i32] [i32 400, i32 0], [2 x i32]* %arr_ptr
  %tmp16 = load %Person, %Person* %bond
  %tmp17 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 0
  %tmp18 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 1
  %tmp19 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 2
  %tmp20 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 3
  %tmp21 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 4
  %tmp22 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 5
  %disp_ref_x = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 3
  %disp_x_seq_ref = getelementptr [1 x i32], [1 x i32]* %disp_ref_x, i32 0, i32 0
  %disp_ref_y = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 4
  %disp_y_seq_ref = getelementptr [1 x i32], [1 x i32]* %disp_ref_y, i32 0, i32 0
  %time_ref = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 5
  %disp_time_ref = getelementptr [1 x i32], [1 x i32]* %time_ref, i32 0, i32 0
  %angle_ref = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 6
  %disp_angle_ref = getelementptr [1 x double], [1 x double]* %angle_ref, i32 0, i32 0
  %disp_seq_ref = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x = load i32, i32* %disp_seq_ref
  store i32 %disp_val_x, i32* %disp_x_seq_ref
  %disp_seq_ref23 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y = load i32, i32* %disp_seq_ref23
  store i32 %disp_val_y, i32* %disp_y_seq_ref
  store i32 4, i32* %disp_time_ref
  store double 0.000000e+00, double* %disp_angle_ref
  %disp_ref_x24 = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 3
  %disp_x_seq_ref25 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x24, i32 0, i32 0
  %disp_ref_y26 = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 4
  %disp_y_seq_ref27 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y26, i32 0, i32 0
  %time_ref28 = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 5
  %disp_time_ref29 = getelementptr [1 x i32], [1 x i32]* %time_ref28, i32 0, i32 0
  %angle_ref30 = getelementptr inbounds %Line, %Line* %tmp22, i32 0, i32 6
  %disp_angle_ref31 = getelementptr [1 x double], [1 x double]* %angle_ref30, i32 0, i32 0
  %disp_seq_ref32 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x33 = load i32, i32* %disp_seq_ref32
  store i32 %disp_val_x33, i32* %disp_x_seq_ref25
  %disp_seq_ref34 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y35 = load i32, i32* %disp_seq_ref34
  store i32 %disp_val_y35, i32* %disp_y_seq_ref27
  store i32 4, i32* %disp_time_ref29
  store double 0.000000e+00, double* %disp_angle_ref31
  %disp_ref_x36 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 3
  %disp_x_seq_ref37 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x36, i32 0, i32 0
  %disp_ref_y38 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 4
  %disp_y_seq_ref39 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y38, i32 0, i32 0
  %time_ref40 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 5
  %disp_time_ref41 = getelementptr [1 x i32], [1 x i32]* %time_ref40, i32 0, i32 0
  %angle_ref42 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 6
  %disp_angle_ref43 = getelementptr [1 x double], [1 x double]* %angle_ref42, i32 0, i32 0
  %disp_seq_ref44 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x45 = load i32, i32* %disp_seq_ref44
  store i32 %disp_val_x45, i32* %disp_x_seq_ref37
  %disp_seq_ref46 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y47 = load i32, i32* %disp_seq_ref46
  store i32 %disp_val_y47, i32* %disp_y_seq_ref39
  store i32 4, i32* %disp_time_ref41
  store double 0.000000e+00, double* %disp_angle_ref43
  %disp_ref_x48 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 3
  %disp_x_seq_ref49 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x48, i32 0, i32 0
  %disp_ref_y50 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 4
  %disp_y_seq_ref51 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y50, i32 0, i32 0
  %time_ref52 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 5
  %disp_time_ref53 = getelementptr [1 x i32], [1 x i32]* %time_ref52, i32 0, i32 0
  %angle_ref54 = getelementptr inbounds %Line, %Line* %tmp21, i32 0, i32 6
  %disp_angle_ref55 = getelementptr [1 x double], [1 x double]* %angle_ref54, i32 0, i32 0
  %disp_seq_ref56 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x57 = load i32, i32* %disp_seq_ref56
  store i32 %disp_val_x57, i32* %disp_x_seq_ref49
  %disp_seq_ref58 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y59 = load i32, i32* %disp_seq_ref58
  store i32 %disp_val_y59, i32* %disp_y_seq_ref51
  store i32 4, i32* %disp_time_ref53
  store double 0.000000e+00, double* %disp_angle_ref55
  %disp_ref_x60 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 3
  %disp_x_seq_ref61 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x60, i32 0, i32 0
  %disp_ref_y62 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 4
  %disp_y_seq_ref63 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y62, i32 0, i32 0
  %time_ref64 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 5
  %disp_time_ref65 = getelementptr [1 x i32], [1 x i32]* %time_ref64, i32 0, i32 0
  %angle_ref66 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 6
  %disp_angle_ref67 = getelementptr [1 x double], [1 x double]* %angle_ref66, i32 0, i32 0
  %disp_seq_ref68 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x69 = load i32, i32* %disp_seq_ref68
  store i32 %disp_val_x69, i32* %disp_x_seq_ref61
  %disp_seq_ref70 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y71 = load i32, i32* %disp_seq_ref70
  store i32 %disp_val_y71, i32* %disp_y_seq_ref63
  store i32 4, i32* %disp_time_ref65
  store double 0.000000e+00, double* %disp_angle_ref67
  %disp_ref_x72 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 3
  %disp_x_seq_ref73 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x72, i32 0, i32 0
  %disp_ref_y74 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 4
  %disp_y_seq_ref75 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y74, i32 0, i32 0
  %time_ref76 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 5
  %disp_time_ref77 = getelementptr [1 x i32], [1 x i32]* %time_ref76, i32 0, i32 0
  %angle_ref78 = getelementptr inbounds %Line, %Line* %tmp20, i32 0, i32 6
  %disp_angle_ref79 = getelementptr [1 x double], [1 x double]* %angle_ref78, i32 0, i32 0
  %disp_seq_ref80 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x81 = load i32, i32* %disp_seq_ref80
  store i32 %disp_val_x81, i32* %disp_x_seq_ref73
  %disp_seq_ref82 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y83 = load i32, i32* %disp_seq_ref82
  store i32 %disp_val_y83, i32* %disp_y_seq_ref75
  store i32 4, i32* %disp_time_ref77
  store double 0.000000e+00, double* %disp_angle_ref79
  %disp_ref_x84 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 3
  %disp_x_seq_ref85 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x84, i32 0, i32 0
  %disp_ref_y86 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 4
  %disp_y_seq_ref87 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y86, i32 0, i32 0
  %time_ref88 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 5
  %disp_time_ref89 = getelementptr [1 x i32], [1 x i32]* %time_ref88, i32 0, i32 0
  %angle_ref90 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 6
  %disp_angle_ref91 = getelementptr [1 x double], [1 x double]* %angle_ref90, i32 0, i32 0
  %disp_seq_ref92 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x93 = load i32, i32* %disp_seq_ref92
  store i32 %disp_val_x93, i32* %disp_x_seq_ref85
  %disp_seq_ref94 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y95 = load i32, i32* %disp_seq_ref94
  store i32 %disp_val_y95, i32* %disp_y_seq_ref87
  store i32 4, i32* %disp_time_ref89
  store double 0.000000e+00, double* %disp_angle_ref91
  %disp_ref_x96 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 3
  %disp_x_seq_ref97 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x96, i32 0, i32 0
  %disp_ref_y98 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 4
  %disp_y_seq_ref99 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y98, i32 0, i32 0
  %time_ref100 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 5
  %disp_time_ref101 = getelementptr [1 x i32], [1 x i32]* %time_ref100, i32 0, i32 0
  %angle_ref102 = getelementptr inbounds %Line, %Line* %tmp19, i32 0, i32 6
  %disp_angle_ref103 = getelementptr [1 x double], [1 x double]* %angle_ref102, i32 0, i32 0
  %disp_seq_ref104 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x105 = load i32, i32* %disp_seq_ref104
  store i32 %disp_val_x105, i32* %disp_x_seq_ref97
  %disp_seq_ref106 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y107 = load i32, i32* %disp_seq_ref106
  store i32 %disp_val_y107, i32* %disp_y_seq_ref99
  store i32 4, i32* %disp_time_ref101
  store double 0.000000e+00, double* %disp_angle_ref103
  %disp_ref_x108 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 3
  %disp_x_seq_ref109 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x108, i32 0, i32 0
  %disp_ref_y110 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 4
  %disp_y_seq_ref111 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y110, i32 0, i32 0
  %time_ref112 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 5
  %disp_time_ref113 = getelementptr [1 x i32], [1 x i32]* %time_ref112, i32 0, i32 0
  %angle_ref114 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 6
  %disp_angle_ref115 = getelementptr [1 x double], [1 x double]* %angle_ref114, i32 0, i32 0
  %disp_seq_ref116 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x117 = load i32, i32* %disp_seq_ref116
  store i32 %disp_val_x117, i32* %disp_x_seq_ref109
  %disp_seq_ref118 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y119 = load i32, i32* %disp_seq_ref118
  store i32 %disp_val_y119, i32* %disp_y_seq_ref111
  store i32 4, i32* %disp_time_ref113
  store double 0.000000e+00, double* %disp_angle_ref115
  %disp_ref_x120 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 3
  %disp_x_seq_ref121 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x120, i32 0, i32 0
  %disp_ref_y122 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 4
  %disp_y_seq_ref123 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y122, i32 0, i32 0
  %time_ref124 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 5
  %disp_time_ref125 = getelementptr [1 x i32], [1 x i32]* %time_ref124, i32 0, i32 0
  %angle_ref126 = getelementptr inbounds %Line, %Line* %tmp18, i32 0, i32 6
  %disp_angle_ref127 = getelementptr [1 x double], [1 x double]* %angle_ref126, i32 0, i32 0
  %disp_seq_ref128 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x129 = load i32, i32* %disp_seq_ref128
  store i32 %disp_val_x129, i32* %disp_x_seq_ref121
  %disp_seq_ref130 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y131 = load i32, i32* %disp_seq_ref130
  store i32 %disp_val_y131, i32* %disp_y_seq_ref123
  store i32 4, i32* %disp_time_ref125
  store double 0.000000e+00, double* %disp_angle_ref127
  %disp_ref_x132 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 5
  %disp_x_seq_ref133 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x132, i32 0, i32 0
  %disp_ref_y134 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 6
  %disp_y_seq_ref135 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y134, i32 0, i32 0
  %time_ref136 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 7
  %disp_time_ref137 = getelementptr [1 x i32], [1 x i32]* %time_ref136, i32 0, i32 0
  %angle_ref138 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 8
  %disp_angle_ref139 = getelementptr [1 x double], [1 x double]* %angle_ref138, i32 0, i32 0
  %disp_seq_ref140 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x141 = load i32, i32* %disp_seq_ref140
  store i32 %disp_val_x141, i32* %disp_x_seq_ref133
  %disp_seq_ref142 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y143 = load i32, i32* %disp_seq_ref142
  store i32 %disp_val_y143, i32* %disp_y_seq_ref135
  store i32 4, i32* %disp_time_ref137
  store double 0.000000e+00, double* %disp_angle_ref139
  %disp_ref_x144 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 5
  %disp_x_seq_ref145 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x144, i32 0, i32 0
  %disp_ref_y146 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 6
  %disp_y_seq_ref147 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y146, i32 0, i32 0
  %time_ref148 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 7
  %disp_time_ref149 = getelementptr [1 x i32], [1 x i32]* %time_ref148, i32 0, i32 0
  %angle_ref150 = getelementptr inbounds %Polygon, %Polygon* %tmp17, i32 0, i32 8
  %disp_angle_ref151 = getelementptr [1 x double], [1 x double]* %angle_ref150, i32 0, i32 0
  %disp_seq_ref152 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x153 = load i32, i32* %disp_seq_ref152
  store i32 %disp_val_x153, i32* %disp_x_seq_ref145
  %disp_seq_ref154 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y155 = load i32, i32* %disp_seq_ref154
  store i32 %disp_val_y155, i32* %disp_y_seq_ref147
  store i32 4, i32* %disp_time_ref149
  store double 0.000000e+00, double* %disp_angle_ref151
  %disp_ref_x156 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 7
  %disp_x_seq_ref157 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x156, i32 0, i32 0
  %disp_ref_y158 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 8
  %disp_y_seq_ref159 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y158, i32 0, i32 0
  %time_ref160 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 9
  %disp_time_ref161 = getelementptr [1 x i32], [1 x i32]* %time_ref160, i32 0, i32 0
  %angle_ref162 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 10
  %disp_angle_ref163 = getelementptr [1 x double], [1 x double]* %angle_ref162, i32 0, i32 0
  %disp_seq_ref164 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 0
  %disp_val_x165 = load i32, i32* %disp_seq_ref164
  store i32 %disp_val_x165, i32* %disp_x_seq_ref157
  %disp_seq_ref166 = getelementptr [2 x i32], [2 x i32]* %arr_ptr, i32 0, i32 1
  %disp_val_y167 = load i32, i32* %disp_seq_ref166
  store i32 %disp_val_y167, i32* %disp_y_seq_ref159
  store i32 4, i32* %disp_time_ref161
  store double 0.000000e+00, double* %disp_angle_ref163
  %disp_ref_x168 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 3
  %fst_disp_ref_x = getelementptr [1 x i32], [1 x i32]* %disp_ref_x168, i32 0, i32 0
  %disp_ref_y169 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 4
  %fst_disp_ref_y = getelementptr [1 x i32], [1 x i32]* %disp_ref_y169, i32 0, i32 0
  %time_ref170 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 5
  %fst_time_ref = getelementptr [1 x i32], [1 x i32]* %time_ref170, i32 0, i32 0
  %angle_ref171 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 6
  %fst_angle_ref = getelementptr [1 x double], [1 x double]* %angle_ref171, i32 0, i32 0
  %disp_final_x = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 7
  %disp_final_y = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 8
  %num_frames_ref = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x, i32* %fst_disp_ref_y, i32* %fst_time_ref, double* %fst_angle_ref, i32 1, i32* %num_frames_ref, i32** %disp_final_x, i32** %disp_final_y)
  %disp_ref_x172 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 3
  %fst_disp_ref_x173 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x172, i32 0, i32 0
  %disp_ref_y174 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 4
  %fst_disp_ref_y175 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y174, i32 0, i32 0
  %time_ref176 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 5
  %fst_time_ref177 = getelementptr [1 x i32], [1 x i32]* %time_ref176, i32 0, i32 0
  %angle_ref178 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 6
  %fst_angle_ref179 = getelementptr [1 x double], [1 x double]* %angle_ref178, i32 0, i32 0
  %disp_final_x180 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 7
  %disp_final_y181 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 8
  %num_frames_ref182 = getelementptr inbounds %Line, %Line* %tmp15, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x173, i32* %fst_disp_ref_y175, i32* %fst_time_ref177, double* %fst_angle_ref179, i32 1, i32* %num_frames_ref182, i32** %disp_final_x180, i32** %disp_final_y181)
  %disp_ref_x183 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 3
  %fst_disp_ref_x184 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x183, i32 0, i32 0
  %disp_ref_y185 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 4
  %fst_disp_ref_y186 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y185, i32 0, i32 0
  %time_ref187 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 5
  %fst_time_ref188 = getelementptr [1 x i32], [1 x i32]* %time_ref187, i32 0, i32 0
  %angle_ref189 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 6
  %fst_angle_ref190 = getelementptr [1 x double], [1 x double]* %angle_ref189, i32 0, i32 0
  %disp_final_x191 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 7
  %disp_final_y192 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 8
  %num_frames_ref193 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x184, i32* %fst_disp_ref_y186, i32* %fst_time_ref188, double* %fst_angle_ref190, i32 1, i32* %num_frames_ref193, i32** %disp_final_x191, i32** %disp_final_y192)
  %disp_ref_x194 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 3
  %fst_disp_ref_x195 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x194, i32 0, i32 0
  %disp_ref_y196 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 4
  %fst_disp_ref_y197 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y196, i32 0, i32 0
  %time_ref198 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 5
  %fst_time_ref199 = getelementptr [1 x i32], [1 x i32]* %time_ref198, i32 0, i32 0
  %angle_ref200 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 6
  %fst_angle_ref201 = getelementptr [1 x double], [1 x double]* %angle_ref200, i32 0, i32 0
  %disp_final_x202 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 7
  %disp_final_y203 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 8
  %num_frames_ref204 = getelementptr inbounds %Line, %Line* %tmp14, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x195, i32* %fst_disp_ref_y197, i32* %fst_time_ref199, double* %fst_angle_ref201, i32 1, i32* %num_frames_ref204, i32** %disp_final_x202, i32** %disp_final_y203)
  %disp_ref_x205 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 3
  %fst_disp_ref_x206 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x205, i32 0, i32 0
  %disp_ref_y207 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 4
  %fst_disp_ref_y208 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y207, i32 0, i32 0
  %time_ref209 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 5
  %fst_time_ref210 = getelementptr [1 x i32], [1 x i32]* %time_ref209, i32 0, i32 0
  %angle_ref211 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 6
  %fst_angle_ref212 = getelementptr [1 x double], [1 x double]* %angle_ref211, i32 0, i32 0
  %disp_final_x213 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 7
  %disp_final_y214 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 8
  %num_frames_ref215 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x206, i32* %fst_disp_ref_y208, i32* %fst_time_ref210, double* %fst_angle_ref212, i32 1, i32* %num_frames_ref215, i32** %disp_final_x213, i32** %disp_final_y214)
  %disp_ref_x216 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 3
  %fst_disp_ref_x217 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x216, i32 0, i32 0
  %disp_ref_y218 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 4
  %fst_disp_ref_y219 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y218, i32 0, i32 0
  %time_ref220 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 5
  %fst_time_ref221 = getelementptr [1 x i32], [1 x i32]* %time_ref220, i32 0, i32 0
  %angle_ref222 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 6
  %fst_angle_ref223 = getelementptr [1 x double], [1 x double]* %angle_ref222, i32 0, i32 0
  %disp_final_x224 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 7
  %disp_final_y225 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 8
  %num_frames_ref226 = getelementptr inbounds %Line, %Line* %tmp13, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x217, i32* %fst_disp_ref_y219, i32* %fst_time_ref221, double* %fst_angle_ref223, i32 1, i32* %num_frames_ref226, i32** %disp_final_x224, i32** %disp_final_y225)
  %disp_ref_x227 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 3
  %fst_disp_ref_x228 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x227, i32 0, i32 0
  %disp_ref_y229 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 4
  %fst_disp_ref_y230 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y229, i32 0, i32 0
  %time_ref231 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 5
  %fst_time_ref232 = getelementptr [1 x i32], [1 x i32]* %time_ref231, i32 0, i32 0
  %angle_ref233 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 6
  %fst_angle_ref234 = getelementptr [1 x double], [1 x double]* %angle_ref233, i32 0, i32 0
  %disp_final_x235 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 7
  %disp_final_y236 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 8
  %num_frames_ref237 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x228, i32* %fst_disp_ref_y230, i32* %fst_time_ref232, double* %fst_angle_ref234, i32 1, i32* %num_frames_ref237, i32** %disp_final_x235, i32** %disp_final_y236)
  %disp_ref_x238 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 3
  %fst_disp_ref_x239 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x238, i32 0, i32 0
  %disp_ref_y240 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 4
  %fst_disp_ref_y241 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y240, i32 0, i32 0
  %time_ref242 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 5
  %fst_time_ref243 = getelementptr [1 x i32], [1 x i32]* %time_ref242, i32 0, i32 0
  %angle_ref244 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 6
  %fst_angle_ref245 = getelementptr [1 x double], [1 x double]* %angle_ref244, i32 0, i32 0
  %disp_final_x246 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 7
  %disp_final_y247 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 8
  %num_frames_ref248 = getelementptr inbounds %Line, %Line* %tmp12, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x239, i32* %fst_disp_ref_y241, i32* %fst_time_ref243, double* %fst_angle_ref245, i32 1, i32* %num_frames_ref248, i32** %disp_final_x246, i32** %disp_final_y247)
  %disp_ref_x249 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 3
  %fst_disp_ref_x250 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x249, i32 0, i32 0
  %disp_ref_y251 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 4
  %fst_disp_ref_y252 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y251, i32 0, i32 0
  %time_ref253 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 5
  %fst_time_ref254 = getelementptr [1 x i32], [1 x i32]* %time_ref253, i32 0, i32 0
  %angle_ref255 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 6
  %fst_angle_ref256 = getelementptr [1 x double], [1 x double]* %angle_ref255, i32 0, i32 0
  %disp_final_x257 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 7
  %disp_final_y258 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 8
  %num_frames_ref259 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x250, i32* %fst_disp_ref_y252, i32* %fst_time_ref254, double* %fst_angle_ref256, i32 1, i32* %num_frames_ref259, i32** %disp_final_x257, i32** %disp_final_y258)
  %disp_ref_x260 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 3
  %fst_disp_ref_x261 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x260, i32 0, i32 0
  %disp_ref_y262 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 4
  %fst_disp_ref_y263 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y262, i32 0, i32 0
  %time_ref264 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 5
  %fst_time_ref265 = getelementptr [1 x i32], [1 x i32]* %time_ref264, i32 0, i32 0
  %angle_ref266 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 6
  %fst_angle_ref267 = getelementptr [1 x double], [1 x double]* %angle_ref266, i32 0, i32 0
  %disp_final_x268 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 7
  %disp_final_y269 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 8
  %num_frames_ref270 = getelementptr inbounds %Line, %Line* %tmp11, i32 0, i32 9
  call void @allocDispArray(i32* %fst_disp_ref_x261, i32* %fst_disp_ref_y263, i32* %fst_time_ref265, double* %fst_angle_ref267, i32 1, i32* %num_frames_ref270, i32** %disp_final_x268, i32** %disp_final_y269)
  %disp_ref_x271 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 5
  %fst_disp_ref_x272 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x271, i32 0, i32 0
  %disp_ref_y273 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 6
  %fst_disp_ref_y274 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y273, i32 0, i32 0
  %time_ref275 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 7
  %fst_time_ref276 = getelementptr [1 x i32], [1 x i32]* %time_ref275, i32 0, i32 0
  %angle_ref277 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 8
  %fst_angle_ref278 = getelementptr [1 x double], [1 x double]* %angle_ref277, i32 0, i32 0
  %disp_final_x279 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 9
  %disp_final_y280 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 10
  %num_frames_ref281 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 11
  call void @allocDispArray(i32* %fst_disp_ref_x272, i32* %fst_disp_ref_y274, i32* %fst_time_ref276, double* %fst_angle_ref278, i32 1, i32* %num_frames_ref281, i32** %disp_final_x279, i32** %disp_final_y280)
  %disp_ref_x282 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 5
  %fst_disp_ref_x283 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x282, i32 0, i32 0
  %disp_ref_y284 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 6
  %fst_disp_ref_y285 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y284, i32 0, i32 0
  %time_ref286 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 7
  %fst_time_ref287 = getelementptr [1 x i32], [1 x i32]* %time_ref286, i32 0, i32 0
  %angle_ref288 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 8
  %fst_angle_ref289 = getelementptr [1 x double], [1 x double]* %angle_ref288, i32 0, i32 0
  %disp_final_x290 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 9
  %disp_final_y291 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 10
  %num_frames_ref292 = getelementptr inbounds %Polygon, %Polygon* %tmp, i32 0, i32 11
  call void @allocDispArray(i32* %fst_disp_ref_x283, i32* %fst_disp_ref_y285, i32* %fst_time_ref287, double* %fst_angle_ref289, i32 1, i32* %num_frames_ref292, i32** %disp_final_x290, i32** %disp_final_y291)
  %disp_ref_x293 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 7
  %fst_disp_ref_x294 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x293, i32 0, i32 0
  %disp_ref_y295 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 8
  %fst_disp_ref_y296 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y295, i32 0, i32 0
  %time_ref297 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 9
  %fst_time_ref298 = getelementptr [1 x i32], [1 x i32]* %time_ref297, i32 0, i32 0
  %angle_ref299 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 10
  %fst_angle_ref300 = getelementptr [1 x double], [1 x double]* %angle_ref299, i32 0, i32 0
  %disp_final_x301 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 11
  %disp_final_y302 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 12
  %num_frames_ref303 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 13
  call void @allocDispArray(i32* %fst_disp_ref_x294, i32* %fst_disp_ref_y296, i32* %fst_time_ref298, double* %fst_angle_ref300, i32 1, i32* %num_frames_ref303, i32** %disp_final_x301, i32** %disp_final_y302)
  %arr_ptr304 = alloca [2 x i32]
  store [2 x i32] [i32 400, i32 0], [2 x i32]* %arr_ptr304
  %tmp305 = load %Polygon, %Polygon* %c1
  %disp_ref_x306 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 5
  %disp_x_seq_ref307 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x306, i32 0, i32 0
  %disp_ref_y308 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 6
  %disp_y_seq_ref309 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y308, i32 0, i32 0
  %time_ref310 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 7
  %disp_time_ref311 = getelementptr [1 x i32], [1 x i32]* %time_ref310, i32 0, i32 0
  %angle_ref312 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 8
  %disp_angle_ref313 = getelementptr [1 x double], [1 x double]* %angle_ref312, i32 0, i32 0
  %disp_seq_ref314 = getelementptr [2 x i32], [2 x i32]* %arr_ptr304, i32 0, i32 0
  %disp_val_x315 = load i32, i32* %disp_seq_ref314
  store i32 %disp_val_x315, i32* %disp_x_seq_ref307
  %disp_seq_ref316 = getelementptr [2 x i32], [2 x i32]* %arr_ptr304, i32 0, i32 1
  %disp_val_y317 = load i32, i32* %disp_seq_ref316
  store i32 %disp_val_y317, i32* %disp_y_seq_ref309
  store i32 4, i32* %disp_time_ref311
  store double 0.000000e+00, double* %disp_angle_ref313
  %disp_ref_x318 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 5
  %fst_disp_ref_x319 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x318, i32 0, i32 0
  %disp_ref_y320 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 6
  %fst_disp_ref_y321 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y320, i32 0, i32 0
  %time_ref322 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 7
  %fst_time_ref323 = getelementptr [1 x i32], [1 x i32]* %time_ref322, i32 0, i32 0
  %angle_ref324 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 8
  %fst_angle_ref325 = getelementptr [1 x double], [1 x double]* %angle_ref324, i32 0, i32 0
  %disp_final_x326 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 9
  %disp_final_y327 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 10
  %num_frames_ref328 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 11
  call void @allocDispArray(i32* %fst_disp_ref_x319, i32* %fst_disp_ref_y321, i32* %fst_time_ref323, double* %fst_angle_ref325, i32 1, i32* %num_frames_ref328, i32** %disp_final_x326, i32** %disp_final_y327)
  %arr_ptr329 = alloca [2 x i32]
  store [2 x i32] [i32 200, i32 0], [2 x i32]* %arr_ptr329
  %tmp330 = load %Polygon, %Polygon* %c2
  %disp_ref_x331 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 5
  %disp_x_seq_ref332 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x331, i32 0, i32 0
  %disp_ref_y333 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 6
  %disp_y_seq_ref334 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y333, i32 0, i32 0
  %time_ref335 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 7
  %disp_time_ref336 = getelementptr [1 x i32], [1 x i32]* %time_ref335, i32 0, i32 0
  %angle_ref337 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 8
  %disp_angle_ref338 = getelementptr [1 x double], [1 x double]* %angle_ref337, i32 0, i32 0
  %disp_seq_ref339 = getelementptr [2 x i32], [2 x i32]* %arr_ptr329, i32 0, i32 0
  %disp_val_x340 = load i32, i32* %disp_seq_ref339
  store i32 %disp_val_x340, i32* %disp_x_seq_ref332
  %disp_seq_ref341 = getelementptr [2 x i32], [2 x i32]* %arr_ptr329, i32 0, i32 1
  %disp_val_y342 = load i32, i32* %disp_seq_ref341
  store i32 %disp_val_y342, i32* %disp_y_seq_ref334
  store i32 2, i32* %disp_time_ref336
  store double 0.000000e+00, double* %disp_angle_ref338
  %disp_ref_x343 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 5
  %fst_disp_ref_x344 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x343, i32 0, i32 0
  %disp_ref_y345 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 6
  %fst_disp_ref_y346 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y345, i32 0, i32 0
  %time_ref347 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 7
  %fst_time_ref348 = getelementptr [1 x i32], [1 x i32]* %time_ref347, i32 0, i32 0
  %angle_ref349 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 8
  %fst_angle_ref350 = getelementptr [1 x double], [1 x double]* %angle_ref349, i32 0, i32 0
  %disp_final_x351 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 9
  %disp_final_y352 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 10
  %num_frames_ref353 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 11
  call void @allocDispArray(i32* %fst_disp_ref_x344, i32* %fst_disp_ref_y346, i32* %fst_time_ref348, double* %fst_angle_ref350, i32 1, i32* %num_frames_ref353, i32** %disp_final_x351, i32** %disp_final_y352)
  %arr_ptr354 = alloca [2 x i32]
  store [2 x i32] [i32 100, i32 0], [2 x i32]* %arr_ptr354
  %tmp355 = load %Polygon, %Polygon* %c3
  %disp_ref_x356 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 5
  %disp_x_seq_ref357 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x356, i32 0, i32 0
  %disp_ref_y358 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 6
  %disp_y_seq_ref359 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y358, i32 0, i32 0
  %time_ref360 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 7
  %disp_time_ref361 = getelementptr [1 x i32], [1 x i32]* %time_ref360, i32 0, i32 0
  %angle_ref362 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 8
  %disp_angle_ref363 = getelementptr [1 x double], [1 x double]* %angle_ref362, i32 0, i32 0
  %disp_seq_ref364 = getelementptr [2 x i32], [2 x i32]* %arr_ptr354, i32 0, i32 0
  %disp_val_x365 = load i32, i32* %disp_seq_ref364
  store i32 %disp_val_x365, i32* %disp_x_seq_ref357
  %disp_seq_ref366 = getelementptr [2 x i32], [2 x i32]* %arr_ptr354, i32 0, i32 1
  %disp_val_y367 = load i32, i32* %disp_seq_ref366
  store i32 %disp_val_y367, i32* %disp_y_seq_ref359
  store i32 1, i32* %disp_time_ref361
  store double 0.000000e+00, double* %disp_angle_ref363
  %disp_ref_x368 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 5
  %fst_disp_ref_x369 = getelementptr [1 x i32], [1 x i32]* %disp_ref_x368, i32 0, i32 0
  %disp_ref_y370 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 6
  %fst_disp_ref_y371 = getelementptr [1 x i32], [1 x i32]* %disp_ref_y370, i32 0, i32 0
  %time_ref372 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 7
  %fst_time_ref373 = getelementptr [1 x i32], [1 x i32]* %time_ref372, i32 0, i32 0
  %angle_ref374 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 8
  %fst_angle_ref375 = getelementptr [1 x double], [1 x double]* %angle_ref374, i32 0, i32 0
  %disp_final_x376 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 9
  %disp_final_y377 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 10
  %num_frames_ref378 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 11
  call void @allocDispArray(i32* %fst_disp_ref_x369, i32* %fst_disp_ref_y371, i32* %fst_time_ref373, double* %fst_angle_ref375, i32 1, i32* %num_frames_ref378, i32** %disp_final_x376, i32** %disp_final_y377)
  %tmp379 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 0
  %tmp380 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 1
  %tmp381 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 2
  %tmp382 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 3
  %tmp383 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 4
  %tmp384 = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 5
  br label %while

while:                                            ; preds = %while_body, %entry
  %_Running_val = load i1, i1* @_Running
  br i1 %_Running_val, label %while_body, label %merge

while_body:                                       ; preds = %while
  call void (...) @onRenderStartSDL()
  call void @Person__draw(%Person* %bond)
  call void @Polygon__draw(%Polygon* %tmp379)
  call void @Polygon__draw(%Polygon* %tmp379)
  call void @Line__draw(%Line* %tmp380)
  call void @Line__draw(%Line* %tmp380)
  call void @Line__draw(%Line* %tmp381)
  call void @Line__draw(%Line* %tmp381)
  call void @Line__draw(%Line* %tmp382)
  call void @Line__draw(%Line* %tmp382)
  call void @Line__draw(%Line* %tmp383)
  call void @Line__draw(%Line* %tmp383)
  call void @Line__draw(%Line* %tmp384)
  call void @Line__draw(%Line* %tmp384)
  call void @Polygon__draw(%Polygon* %c3)
  call void @Polygon__draw(%Polygon* %c2)
  call void @Polygon__draw(%Polygon* %c1)
  call void (...) @onRenderFinishSDL()
  br label %while

merge:                                            ; preds = %while
  %num_frames = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 13
  %num_frames_load = load i32, i32* %num_frames
  %bool_val = icmp ne i32 %num_frames_load, 0
  br i1 %bool_val, label %then, label %merge385

merge385:                                         ; preds = %merge, %then
  %num_frames386 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 11
  %num_frames_load387 = load i32, i32* %num_frames386
  %bool_val388 = icmp ne i32 %num_frames_load387, 0
  br i1 %bool_val388, label %then390, label %merge389

then:                                             ; preds = %merge
  %disp_x = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 11
  %disp_x_load = load i32*, i32** %disp_x
  %disp_y = getelementptr inbounds %Person, %Person* %bond, i32 0, i32 12
  %disp_y_load = load i32*, i32** %disp_y
  %0 = bitcast i32* %disp_x_load to i8*
  tail call void @free(i8* %0)
  %1 = bitcast i32* %disp_y_load to i8*
  tail call void @free(i8* %1)
  store i32 0, i32* %num_frames
  br label %merge385

merge389:                                         ; preds = %merge385, %then390
  %num_frames395 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 11
  %num_frames_load396 = load i32, i32* %num_frames395
  %bool_val397 = icmp ne i32 %num_frames_load396, 0
  br i1 %bool_val397, label %then399, label %merge398

then390:                                          ; preds = %merge385
  %disp_x391 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 9
  %disp_x_load392 = load i32*, i32** %disp_x391
  %disp_y393 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 10
  %disp_y_load394 = load i32*, i32** %disp_y393
  %2 = bitcast i32* %disp_x_load392 to i8*
  tail call void @free(i8* %2)
  %3 = bitcast i32* %disp_y_load394 to i8*
  tail call void @free(i8* %3)
  store i32 0, i32* %num_frames386
  br label %merge389

merge398:                                         ; preds = %merge389, %then399
  %num_frames404 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 9
  %num_frames_load405 = load i32, i32* %num_frames404
  %bool_val406 = icmp ne i32 %num_frames_load405, 0
  br i1 %bool_val406, label %then408, label %merge407

then399:                                          ; preds = %merge389
  %disp_x400 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 9
  %disp_x_load401 = load i32*, i32** %disp_x400
  %disp_y402 = getelementptr inbounds %Polygon, %Polygon* %tmp379, i32 0, i32 10
  %disp_y_load403 = load i32*, i32** %disp_y402
  %4 = bitcast i32* %disp_x_load401 to i8*
  tail call void @free(i8* %4)
  %5 = bitcast i32* %disp_y_load403 to i8*
  tail call void @free(i8* %5)
  store i32 0, i32* %num_frames395
  br label %merge398

merge407:                                         ; preds = %merge398, %then408
  %num_frames413 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 9
  %num_frames_load414 = load i32, i32* %num_frames413
  %bool_val415 = icmp ne i32 %num_frames_load414, 0
  br i1 %bool_val415, label %then417, label %merge416

then408:                                          ; preds = %merge398
  %disp_x409 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 7
  %disp_x_load410 = load i32*, i32** %disp_x409
  %disp_y411 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 8
  %disp_y_load412 = load i32*, i32** %disp_y411
  %6 = bitcast i32* %disp_x_load410 to i8*
  tail call void @free(i8* %6)
  %7 = bitcast i32* %disp_y_load412 to i8*
  tail call void @free(i8* %7)
  store i32 0, i32* %num_frames404
  br label %merge407

merge416:                                         ; preds = %merge407, %then417
  %num_frames422 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 9
  %num_frames_load423 = load i32, i32* %num_frames422
  %bool_val424 = icmp ne i32 %num_frames_load423, 0
  br i1 %bool_val424, label %then426, label %merge425

then417:                                          ; preds = %merge407
  %disp_x418 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 7
  %disp_x_load419 = load i32*, i32** %disp_x418
  %disp_y420 = getelementptr inbounds %Line, %Line* %tmp380, i32 0, i32 8
  %disp_y_load421 = load i32*, i32** %disp_y420
  %8 = bitcast i32* %disp_x_load419 to i8*
  tail call void @free(i8* %8)
  %9 = bitcast i32* %disp_y_load421 to i8*
  tail call void @free(i8* %9)
  store i32 0, i32* %num_frames413
  br label %merge416

merge425:                                         ; preds = %merge416, %then426
  %num_frames431 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 9
  %num_frames_load432 = load i32, i32* %num_frames431
  %bool_val433 = icmp ne i32 %num_frames_load432, 0
  br i1 %bool_val433, label %then435, label %merge434

then426:                                          ; preds = %merge416
  %disp_x427 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 7
  %disp_x_load428 = load i32*, i32** %disp_x427
  %disp_y429 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 8
  %disp_y_load430 = load i32*, i32** %disp_y429
  %10 = bitcast i32* %disp_x_load428 to i8*
  tail call void @free(i8* %10)
  %11 = bitcast i32* %disp_y_load430 to i8*
  tail call void @free(i8* %11)
  store i32 0, i32* %num_frames422
  br label %merge425

merge434:                                         ; preds = %merge425, %then435
  %num_frames440 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 9
  %num_frames_load441 = load i32, i32* %num_frames440
  %bool_val442 = icmp ne i32 %num_frames_load441, 0
  br i1 %bool_val442, label %then444, label %merge443

then435:                                          ; preds = %merge425
  %disp_x436 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 7
  %disp_x_load437 = load i32*, i32** %disp_x436
  %disp_y438 = getelementptr inbounds %Line, %Line* %tmp381, i32 0, i32 8
  %disp_y_load439 = load i32*, i32** %disp_y438
  %12 = bitcast i32* %disp_x_load437 to i8*
  tail call void @free(i8* %12)
  %13 = bitcast i32* %disp_y_load439 to i8*
  tail call void @free(i8* %13)
  store i32 0, i32* %num_frames431
  br label %merge434

merge443:                                         ; preds = %merge434, %then444
  %num_frames449 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 9
  %num_frames_load450 = load i32, i32* %num_frames449
  %bool_val451 = icmp ne i32 %num_frames_load450, 0
  br i1 %bool_val451, label %then453, label %merge452

then444:                                          ; preds = %merge434
  %disp_x445 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 7
  %disp_x_load446 = load i32*, i32** %disp_x445
  %disp_y447 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 8
  %disp_y_load448 = load i32*, i32** %disp_y447
  %14 = bitcast i32* %disp_x_load446 to i8*
  tail call void @free(i8* %14)
  %15 = bitcast i32* %disp_y_load448 to i8*
  tail call void @free(i8* %15)
  store i32 0, i32* %num_frames440
  br label %merge443

merge452:                                         ; preds = %merge443, %then453
  %num_frames458 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 9
  %num_frames_load459 = load i32, i32* %num_frames458
  %bool_val460 = icmp ne i32 %num_frames_load459, 0
  br i1 %bool_val460, label %then462, label %merge461

then453:                                          ; preds = %merge443
  %disp_x454 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 7
  %disp_x_load455 = load i32*, i32** %disp_x454
  %disp_y456 = getelementptr inbounds %Line, %Line* %tmp382, i32 0, i32 8
  %disp_y_load457 = load i32*, i32** %disp_y456
  %16 = bitcast i32* %disp_x_load455 to i8*
  tail call void @free(i8* %16)
  %17 = bitcast i32* %disp_y_load457 to i8*
  tail call void @free(i8* %17)
  store i32 0, i32* %num_frames449
  br label %merge452

merge461:                                         ; preds = %merge452, %then462
  %num_frames467 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 9
  %num_frames_load468 = load i32, i32* %num_frames467
  %bool_val469 = icmp ne i32 %num_frames_load468, 0
  br i1 %bool_val469, label %then471, label %merge470

then462:                                          ; preds = %merge452
  %disp_x463 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 7
  %disp_x_load464 = load i32*, i32** %disp_x463
  %disp_y465 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 8
  %disp_y_load466 = load i32*, i32** %disp_y465
  %18 = bitcast i32* %disp_x_load464 to i8*
  tail call void @free(i8* %18)
  %19 = bitcast i32* %disp_y_load466 to i8*
  tail call void @free(i8* %19)
  store i32 0, i32* %num_frames458
  br label %merge461

merge470:                                         ; preds = %merge461, %then471
  %num_frames476 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 9
  %num_frames_load477 = load i32, i32* %num_frames476
  %bool_val478 = icmp ne i32 %num_frames_load477, 0
  br i1 %bool_val478, label %then480, label %merge479

then471:                                          ; preds = %merge461
  %disp_x472 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 7
  %disp_x_load473 = load i32*, i32** %disp_x472
  %disp_y474 = getelementptr inbounds %Line, %Line* %tmp383, i32 0, i32 8
  %disp_y_load475 = load i32*, i32** %disp_y474
  %20 = bitcast i32* %disp_x_load473 to i8*
  tail call void @free(i8* %20)
  %21 = bitcast i32* %disp_y_load475 to i8*
  tail call void @free(i8* %21)
  store i32 0, i32* %num_frames467
  br label %merge470

merge479:                                         ; preds = %merge470, %then480
  %num_frames485 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 9
  %num_frames_load486 = load i32, i32* %num_frames485
  %bool_val487 = icmp ne i32 %num_frames_load486, 0
  br i1 %bool_val487, label %then489, label %merge488

then480:                                          ; preds = %merge470
  %disp_x481 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 7
  %disp_x_load482 = load i32*, i32** %disp_x481
  %disp_y483 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 8
  %disp_y_load484 = load i32*, i32** %disp_y483
  %22 = bitcast i32* %disp_x_load482 to i8*
  tail call void @free(i8* %22)
  %23 = bitcast i32* %disp_y_load484 to i8*
  tail call void @free(i8* %23)
  store i32 0, i32* %num_frames476
  br label %merge479

merge488:                                         ; preds = %merge479, %then489
  %num_frames494 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 11
  %num_frames_load495 = load i32, i32* %num_frames494
  %bool_val496 = icmp ne i32 %num_frames_load495, 0
  br i1 %bool_val496, label %then498, label %merge497

then489:                                          ; preds = %merge479
  %disp_x490 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 7
  %disp_x_load491 = load i32*, i32** %disp_x490
  %disp_y492 = getelementptr inbounds %Line, %Line* %tmp384, i32 0, i32 8
  %disp_y_load493 = load i32*, i32** %disp_y492
  %24 = bitcast i32* %disp_x_load491 to i8*
  tail call void @free(i8* %24)
  %25 = bitcast i32* %disp_y_load493 to i8*
  tail call void @free(i8* %25)
  store i32 0, i32* %num_frames485
  br label %merge488

merge497:                                         ; preds = %merge488, %then498
  %num_frames503 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 11
  %num_frames_load504 = load i32, i32* %num_frames503
  %bool_val505 = icmp ne i32 %num_frames_load504, 0
  br i1 %bool_val505, label %then507, label %merge506

then498:                                          ; preds = %merge488
  %disp_x499 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 9
  %disp_x_load500 = load i32*, i32** %disp_x499
  %disp_y501 = getelementptr inbounds %Polygon, %Polygon* %c3, i32 0, i32 10
  %disp_y_load502 = load i32*, i32** %disp_y501
  %26 = bitcast i32* %disp_x_load500 to i8*
  tail call void @free(i8* %26)
  %27 = bitcast i32* %disp_y_load502 to i8*
  tail call void @free(i8* %27)
  store i32 0, i32* %num_frames494
  br label %merge497

merge506:                                         ; preds = %merge497, %then507
  %num_frames512 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 11
  %num_frames_load513 = load i32, i32* %num_frames512
  %bool_val514 = icmp ne i32 %num_frames_load513, 0
  br i1 %bool_val514, label %then516, label %merge515

then507:                                          ; preds = %merge497
  %disp_x508 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 9
  %disp_x_load509 = load i32*, i32** %disp_x508
  %disp_y510 = getelementptr inbounds %Polygon, %Polygon* %c2, i32 0, i32 10
  %disp_y_load511 = load i32*, i32** %disp_y510
  %28 = bitcast i32* %disp_x_load509 to i8*
  tail call void @free(i8* %28)
  %29 = bitcast i32* %disp_y_load511 to i8*
  tail call void @free(i8* %29)
  store i32 0, i32* %num_frames503
  br label %merge506

merge515:                                         ; preds = %merge506, %then516
  %stopSDL_ret = alloca i32
  %stopSDL_ret521 = call i32 (...) @stopSDL()
  store i32 %stopSDL_ret521, i32* %stopSDL_ret
  %stopSDL_ret522 = load i32, i32* %stopSDL_ret
  ret i32 %stopSDL_ret522

then516:                                          ; preds = %merge506
  %disp_x517 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 9
  %disp_x_load518 = load i32*, i32** %disp_x517
  %disp_y519 = getelementptr inbounds %Polygon, %Polygon* %c1, i32 0, i32 10
  %disp_y_load520 = load i32*, i32** %disp_y519
  %30 = bitcast i32* %disp_x_load518 to i8*
  tail call void @free(i8* %30)
  %31 = bitcast i32* %disp_y_load520 to i8*
  tail call void @free(i8* %31)
  store i32 0, i32* %num_frames512
  br label %merge515
}

define %Person* @Person__construct([2 x i32]* %pos) {
entry:
  %__Person_inst = alloca %Person
  %num_frames = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 13
  store i32 0, i32* %num_frames
  %head = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 0
  %body = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 1
  %lleg = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 2
  %rleg = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 3
  %lhand = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 4
  %rhand = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 5
  %frames = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 6
  %disp_vals_x = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 7
  %disp_vals_y = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 8
  %time_vals = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 9
  %time_vals1 = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 10
  %disp_x = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 11
  %disp_y = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 12
  %num_frames2 = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 13
  %strt = alloca [2 x i32]
  %end = alloca [2 x i32]
  store i32 0, i32* %frames
  %arr_copy = alloca [3 x i32]
  store [3 x i32] zeroinitializer, [3 x i32]* %arr_copy
  %tmp = load [2 x i32], [2 x i32]* %pos
  %arr_copy3 = alloca [2 x i32]
  store [2 x i32] %tmp, [2 x i32]* %arr_copy3
  %Polygon_inst_ptr = call %Polygon* @Polygon__construct([2 x i32]* %arr_copy3, i32 12, i32 50, double 0.000000e+00, [3 x i32]* %arr_copy)
  %Polygon_inst = load %Polygon, %Polygon* %Polygon_inst_ptr
  store %Polygon %Polygon_inst, %Polygon* %head
  %tmp4 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 0
  %tmp5 = load i32, i32* %tmp4
  %tmp6 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  store i32 %tmp5, i32* %tmp6
  %tmp7 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 1
  %tmp8 = load i32, i32* %tmp7
  %tmp9 = add i32 %tmp8, 12
  %tmp10 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  store i32 %tmp9, i32* %tmp10
  %tmp11 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 0
  %tmp12 = load i32, i32* %tmp11
  %tmp13 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp12, i32* %tmp13
  %tmp14 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 1
  %tmp15 = load i32, i32* %tmp14
  %tmp16 = add i32 %tmp15, 42
  %tmp17 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  store i32 %tmp16, i32* %tmp17
  %tmp18 = load [2 x i32], [2 x i32]* %end
  %arr_copy19 = alloca [2 x i32]
  store [2 x i32] %tmp18, [2 x i32]* %arr_copy19
  %tmp20 = load [2 x i32], [2 x i32]* %strt
  %arr_copy21 = alloca [2 x i32]
  store [2 x i32] %tmp20, [2 x i32]* %arr_copy21
  %Line_inst_ptr = call %Line* @Line__construct([2 x i32]* %arr_copy21, [2 x i32]* %arr_copy19)
  %Line_inst = load %Line, %Line* %Line_inst_ptr
  store %Line %Line_inst, %Line* %body
  %tmp22 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  %tmp23 = load i32, i32* %tmp22
  %tmp24 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  store i32 %tmp23, i32* %tmp24
  %tmp25 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  %tmp26 = load i32, i32* %tmp25
  %tmp27 = sub i32 %tmp26, 10
  %tmp28 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp27, i32* %tmp28
  %tmp29 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  %tmp30 = load i32, i32* %tmp29
  %tmp31 = add i32 %tmp30, 10
  %tmp32 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  store i32 %tmp31, i32* %tmp32
  %tmp33 = load [2 x i32], [2 x i32]* %end
  %arr_copy34 = alloca [2 x i32]
  store [2 x i32] %tmp33, [2 x i32]* %arr_copy34
  %tmp35 = load [2 x i32], [2 x i32]* %strt
  %arr_copy36 = alloca [2 x i32]
  store [2 x i32] %tmp35, [2 x i32]* %arr_copy36
  %Line_inst_ptr37 = call %Line* @Line__construct([2 x i32]* %arr_copy36, [2 x i32]* %arr_copy34)
  %Line_inst38 = load %Line, %Line* %Line_inst_ptr37
  store %Line %Line_inst38, %Line* %lleg
  %tmp39 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 0
  %tmp40 = load i32, i32* %tmp39
  %tmp41 = add i32 %tmp40, 10
  %tmp42 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp41, i32* %tmp42
  %tmp43 = load [2 x i32], [2 x i32]* %end
  %arr_copy44 = alloca [2 x i32]
  store [2 x i32] %tmp43, [2 x i32]* %arr_copy44
  %tmp45 = load [2 x i32], [2 x i32]* %strt
  %arr_copy46 = alloca [2 x i32]
  store [2 x i32] %tmp45, [2 x i32]* %arr_copy46
  %Line_inst_ptr47 = call %Line* @Line__construct([2 x i32]* %arr_copy46, [2 x i32]* %arr_copy44)
  %Line_inst48 = load %Line, %Line* %Line_inst_ptr47
  store %Line %Line_inst48, %Line* %rleg
  %tmp49 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 1
  %tmp50 = load i32, i32* %tmp49
  %tmp51 = add i32 %tmp50, 22
  %tmp52 = getelementptr [2 x i32], [2 x i32]* %strt, i32 0, i32 1
  store i32 %tmp51, i32* %tmp52
  %tmp53 = getelementptr [2 x i32], [2 x i32]* %pos, i32 0, i32 1
  %tmp54 = load i32, i32* %tmp53
  %tmp55 = add i32 %tmp54, 22
  %tmp56 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  store i32 %tmp55, i32* %tmp56
  %tmp57 = load [2 x i32], [2 x i32]* %end
  %arr_copy58 = alloca [2 x i32]
  store [2 x i32] %tmp57, [2 x i32]* %arr_copy58
  %tmp59 = load [2 x i32], [2 x i32]* %strt
  %arr_copy60 = alloca [2 x i32]
  store [2 x i32] %tmp59, [2 x i32]* %arr_copy60
  %Line_inst_ptr61 = call %Line* @Line__construct([2 x i32]* %arr_copy60, [2 x i32]* %arr_copy58)
  %Line_inst62 = load %Line, %Line* %Line_inst_ptr61
  store %Line %Line_inst62, %Line* %rhand
  %tmp63 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  %tmp64 = load i32, i32* %tmp63
  %tmp65 = sub i32 %tmp64, 20
  %tmp66 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  store i32 %tmp65, i32* %tmp66
  %tmp67 = load [2 x i32], [2 x i32]* %end
  %arr_copy68 = alloca [2 x i32]
  store [2 x i32] %tmp67, [2 x i32]* %arr_copy68
  %tmp69 = load [2 x i32], [2 x i32]* %strt
  %arr_copy70 = alloca [2 x i32]
  store [2 x i32] %tmp69, [2 x i32]* %arr_copy70
  %Line_inst_ptr71 = call %Line* @Line__construct([2 x i32]* %arr_copy70, [2 x i32]* %arr_copy68)
  %Line_inst72 = load %Line, %Line* %Line_inst_ptr71
  store %Line %Line_inst72, %Line* %lhand
  ret %Person* %__Person_inst
}

define void @Person__draw(%Person* %__Person_inst) {
entry:
  %head = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 0
  %body = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 1
  %lleg = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 2
  %rleg = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 3
  %lhand = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 4
  %rhand = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 5
  %frames = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 6
  %disp_vals_x = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 7
  %disp_vals_y = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 8
  %time_vals = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 9
  %time_vals1 = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 10
  %disp_x = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 11
  %disp_y = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 12
  %num_frames = getelementptr inbounds %Person, %Person* %__Person_inst, i32 0, i32 13
  %tmp = load i32, i32* %frames
  %tmp2 = icmp slt i32 %tmp, 120
  br i1 %tmp2, label %then, label %merge

merge:                                            ; preds = %entry, %then
  %tmp5 = load i32, i32* %frames
  %tmp6 = icmp sge i32 %tmp5, 120
  br i1 %tmp6, label %then8, label %merge7

then:                                             ; preds = %entry
  %tmp3 = load i32, i32* %frames
  %tmp4 = add i32 %tmp3, 1
  store i32 %tmp4, i32* %frames
  br label %merge

merge7:                                           ; preds = %merge, %then8
  ret void

then8:                                            ; preds = %merge
  %arr_ptr = alloca [3 x i32]
  store [3 x i32] [i32 102, i32 102, i32 255], [3 x i32]* %arr_ptr
  %arr_ptr9 = alloca [2 x i32]
  store [2 x i32] [i32 -200, i32 200], [2 x i32]* %arr_ptr9
  %load_disp_final_x = load i32*, i32** %disp_x
  %load_disp_final_y = load i32*, i32** %disp_y
  %load_num_frames = load i32, i32* %num_frames
  call void @translatePoint([2 x i32]* %arr_ptr9, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 1)
  %print_result = call i32 @print([2 x i32]* %arr_ptr9, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @tmp, i32 0, i32 0), [3 x i32]* %arr_ptr)
  call void @translatePoint([2 x i32]* %arr_ptr9, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 -1)
  br label %merge7
}

define %Line* @Line__construct([2 x i32]* %s, [2 x i32]* %e) {
entry:
  %__Line_inst = alloca %Line
  %num_frames = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 9
  store i32 0, i32* %num_frames
  %start = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 0
  %mid = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 1
  %end = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 2
  %disp_vals_x = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 3
  %disp_vals_y = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 4
  %time_vals = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 5
  %time_vals1 = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 6
  %disp_x = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 7
  %disp_y = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 8
  %num_frames2 = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 9
  %tmp = load [2 x i32], [2 x i32]* %s
  store [2 x i32] %tmp, [2 x i32]* %start
  %tmp3 = load [2 x i32], [2 x i32]* %e
  store [2 x i32] %tmp3, [2 x i32]* %end
  %tmp4 = getelementptr [2 x i32], [2 x i32]* %start, i32 0, i32 0
  %tmp5 = load i32, i32* %tmp4
  %tmp6 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 0
  %tmp7 = load i32, i32* %tmp6
  %tmp8 = add i32 %tmp5, %tmp7
  %tmp9 = sdiv i32 %tmp8, 2
  %tmp10 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 0
  store i32 %tmp9, i32* %tmp10
  %tmp11 = getelementptr [2 x i32], [2 x i32]* %start, i32 0, i32 1
  %tmp12 = load i32, i32* %tmp11
  %tmp13 = getelementptr [2 x i32], [2 x i32]* %end, i32 0, i32 1
  %tmp14 = load i32, i32* %tmp13
  %tmp15 = add i32 %tmp12, %tmp14
  %tmp16 = sdiv i32 %tmp15, 2
  %tmp17 = getelementptr [2 x i32], [2 x i32]* %mid, i32 0, i32 1
  store i32 %tmp16, i32* %tmp17
  ret %Line* %__Line_inst
}

define void @Line__draw(%Line* %__Line_inst) {
entry:
  %start = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 0
  %mid = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 1
  %end = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 2
  %disp_vals_x = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 3
  %disp_vals_y = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 4
  %time_vals = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 5
  %time_vals1 = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 6
  %disp_x = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 7
  %disp_y = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 8
  %num_frames = getelementptr inbounds %Line, %Line* %__Line_inst, i32 0, i32 9
  %arr_ptr = alloca [3 x i32]
  store [3 x i32] zeroinitializer, [3 x i32]* %arr_ptr
  %load_disp_final_x = load i32*, i32** %disp_x
  %load_disp_final_y = load i32*, i32** %disp_y
  %load_num_frames = load i32, i32* %num_frames
  call void @translateCurve([2 x i32]* %start, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 1)
  %drawCurve_result = call i32 @drawCurve([2 x i32]* %start, [2 x i32]* %mid, [2 x i32]* %end, i32 2, [3 x i32]* %arr_ptr)
  call void @translateCurve([2 x i32]* %start, [2 x i32]* %mid, [2 x i32]* %end, i32* %load_disp_final_x, i32* %load_disp_final_y, i32 %load_num_frames, i32 -1)
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

declare void @free(i8*)
